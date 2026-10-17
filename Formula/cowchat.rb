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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.6/cowchat-v0.9.6-aarch64-apple-darwin.tar.gz"
      sha256 "d6417329d3a86bc4eeede5c903b495d65b49f79a541fc46b76d88b0889c61fdf"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.6/cowchat-v0.9.6-x86_64-apple-darwin.tar.gz"
      sha256 "deee7736472ecc324cd5bfb91756a137aea5040cf510727175c5a602ed7229d0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.6/cowchat-v0.9.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5c098697dff01f271f7b9496577fd21d0b18f51e939b2cb70c479a9110435ad2"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.6/cowchat-v0.9.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "838ba2a4fab7664bc6bb533d00911012558305a1692b923aa1b1558622919c71"
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
