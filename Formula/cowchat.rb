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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.9/cowchat-v0.9.9-aarch64-apple-darwin.tar.gz"
      sha256 "ddc888d40ad37c2b9a423f26fb6f7018c0229268e8aca5c5e24ce275e3e89268"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.9/cowchat-v0.9.9-x86_64-apple-darwin.tar.gz"
      sha256 "de3959d203829d935f5159b7e6c21c32964797b23fcbdf39a4dae498cd6d0f94"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.9/cowchat-v0.9.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f41f8e107ba315455e071c2b7f45ea61962a1b736d006d0fdfb0b40557303f18"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.9/cowchat-v0.9.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "19ae8b1aaeecd5b62cdc556fe9d271f75b8162161ff5b26efd58f76ac65d45ca"
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
