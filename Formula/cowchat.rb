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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.3/cowchat-v0.5.3-aarch64-apple-darwin.tar.gz"
      sha256 "6f61e3006889890a61f9a800591253de07b48aa4e8bb7c35744524cb570b9622"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.3/cowchat-v0.5.3-x86_64-apple-darwin.tar.gz"
      sha256 "efc2af5acff0e99388325ea2d3b7c60409f9b565360f77a2fa206ae6295d16e1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.3/cowchat-v0.5.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74c905009ab2dab532d8192c74803bc2a85ac77b8f991fda234693cf7850e5af"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.3/cowchat-v0.5.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0394c790a80d1668edc25a33097169e8ca4915d651ca5cd4a4d086a199ce6819"
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
