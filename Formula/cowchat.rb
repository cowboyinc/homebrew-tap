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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.4/cowchat-v0.5.4-aarch64-apple-darwin.tar.gz"
      sha256 "6c1efb5ee403be80fca3af359961dde2cebf514a195cc386ac4f4b7576243098"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.4/cowchat-v0.5.4-x86_64-apple-darwin.tar.gz"
      sha256 "c230d8c257a15226340fc647921f903563fcc53cb94bcbf1e6dc87933515b969"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.4/cowchat-v0.5.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3c5dc9d74dc04801ba043147fc8e285217fdcb354cb125e0daf890eaaa2cf976"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.4/cowchat-v0.5.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e4ef13cf101a64e0199a0e5a822f4b0797dce6156729d42d5d4d1f3b3ee44f23"
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
