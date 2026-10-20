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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.11/cowchat-v0.9.11-aarch64-apple-darwin.tar.gz"
      sha256 "fd2c06bc3e1ee9d91e52d05ef939aef657aac986033d5101581e7b79e21d6f1e"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.11/cowchat-v0.9.11-x86_64-apple-darwin.tar.gz"
      sha256 "7c133a676ce7f8eed4baa81e530771aa5e4593bd772b55c803309bfc49e40000"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.11/cowchat-v0.9.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "41e6ce9e1c30a8e81955b4aa27751ab4f78804153bf6649826546707f9178280"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.11/cowchat-v0.9.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5ec89c5ef513517e0b805d73f81aeae9c98c95bb8cfb3eb5d625ac07ef89f197"
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
