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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.2/cowchat-v0.8.2-aarch64-apple-darwin.tar.gz"
      sha256 "f2a3ff0b4b766d66b1a42a8901e1952d2dd4205d945690006ed9bc382b188205"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.2/cowchat-v0.8.2-x86_64-apple-darwin.tar.gz"
      sha256 "54452384b483917477b1323744dfcb2d451e29ee35a15144dba30dbf346b46e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.2/cowchat-v0.8.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a893b6e84897cc3b28e5e65b25ea83554d82bb0ab9717fe9106372266b8f1e4c"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.2/cowchat-v0.8.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a40197be99ea6d3c29b7d9dbfa581b7b86844e69df4f1781cdc7e6c63d7ed9d2"
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
