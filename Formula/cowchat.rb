class Cowchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cowboyinc/cowchat"
  license any_of: ["MIT", "Apache-2.0"]

  # `brew install --HEAD cowboyinc/tap/cowchat` builds from source instead.
  head do
    url "https://github.com/cowboyinc/cowchat.git", branch: "main"
    depends_on "rust" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.1/cowchat-v0.8.1-aarch64-apple-darwin.tar.gz"
      sha256 "a9fbb58e2c03ac8d900fb327b767b0a1fd871aa253be78179e86950348b9081c"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.1/cowchat-v0.8.1-x86_64-apple-darwin.tar.gz"
      sha256 "a255e656af9821962fe3a02a42eb89a4de333afda9b997b98178bc12e6e08609"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.1/cowchat-v0.8.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "badae70486d5d3bf86276842bf9b5d43759f26744decddd3c6f5c84b16afb6e2"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.1/cowchat-v0.8.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e5bb4ed9285d1253889e0ec0cad65d25fcaf176bda5ca010022d426a543c5706"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "crates/cowchat-cli")
      system "cargo", "install", *std_cargo_args(path: "crates/cowchat-server")
    else
      bin.install "cowchat", "cowchat-server"
      prefix.install "LICENSE-MIT", "LICENSE-APACHE", "THIRD-PARTY-NOTICES.md"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cowchat --version")
    assert_match version.to_s, shell_output("#{bin}/cowchat-server --version")
  end
end
