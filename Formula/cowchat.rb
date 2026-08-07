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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.2/cowchat-v0.6.2-aarch64-apple-darwin.tar.gz"
      sha256 "21c0d475bc1d32ac9c6ac2b57aeebefce5b08ef6dce012c082114cda045e450b"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.2/cowchat-v0.6.2-x86_64-apple-darwin.tar.gz"
      sha256 "178a48ebaa23f454b99a5d292f3ae765c1b47136222729d7338950bf6ce51e4a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.2/cowchat-v0.6.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "66e0945051045baca491596b48b0980c9c1ba5a7af6735c71f4fa219d680148c"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.2/cowchat-v0.6.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "67b554c4a50653fc6afb8c69f1afa7e319cba89e168515f0a8c9006faf91941f"
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
