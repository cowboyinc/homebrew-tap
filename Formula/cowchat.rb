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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.1/cowchat-v0.9.1-aarch64-apple-darwin.tar.gz"
      sha256 "ba5f5bf67940ac4982d306ee8c1607e31600b9f2530d9ad0ce446f7b8e8292b3"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.1/cowchat-v0.9.1-x86_64-apple-darwin.tar.gz"
      sha256 "2aa27fd147d057443a552c780893d7073711cf47ec54f5b4f84f2c99b6b681f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.1/cowchat-v0.9.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a0eee6019888f73e8660060da3ae11fa2e1db0b4ed4b1c6dfeeac8d2ec958067"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.1/cowchat-v0.9.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6dccb40be15e247c13a3da937af8c2fc5c8a9afc757532b0602dd2e4a9bf7675"
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
