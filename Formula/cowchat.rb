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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.7.1/cowchat-v0.7.1-aarch64-apple-darwin.tar.gz"
      sha256 "64d07835085675479c8b8a131e616c32c07bc0dead45f014c59e5fc04979dad3"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.7.1/cowchat-v0.7.1-x86_64-apple-darwin.tar.gz"
      sha256 "a4cf03b135e2e990740c52794f52690b1d6e403ec83ce45394dd12b76e2c89a0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.7.1/cowchat-v0.7.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "132308e2a13d3af4e4384203591ab3fc4b3e920e9200055a2c1394e4ae1d6d37"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.7.1/cowchat-v0.7.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dc8666457d18a86a0d9985b3217c42997b69fa93ed89c1cb780b700627a52586"
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
