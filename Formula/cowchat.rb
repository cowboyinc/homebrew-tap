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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.4/cowchat-v0.8.4-aarch64-apple-darwin.tar.gz"
      sha256 "a03ce47dfb18da0d220952f6af908c9a5fb707264b78e88bf0c81312f92886b9"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.4/cowchat-v0.8.4-x86_64-apple-darwin.tar.gz"
      sha256 "4c5346729d2c7586543e67937819a6d44153877e3449779a2fef0162c3b30c58"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.4/cowchat-v0.8.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c5513efebfaf4780f0226fa5c5074b9bd6a66c7bf47ba69ff073e0eee280a0cd"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.4/cowchat-v0.8.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0024cd1c6931f6c5ca5c6e61e55ce94f7a3065f19c066b80e29dd4cd28dab403"
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
