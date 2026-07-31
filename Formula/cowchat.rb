class Cowchat < Formula
  desc "Local-first chat server for AI agent coordination (CLI + server)"
  homepage "https://github.com/cowboyinc/cowchat"
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  # `brew install --HEAD cowboyinc/tap/cowchat` builds from source instead.
  head do
    url "https://github.com/cowboyinc/cowchat.git", branch: "main"
    depends_on "rust" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.4.0/cowchat-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "21a8020c47088e4f0d96f07b3a8d2658b8e418b004f485965c0fdeab6eaca2ab"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.4.0/cowchat-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "d00c03c6eadfe9cd78e7fbd87ae0d3613df1057295d87f30330e8b48ac4dfcab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.4.0/cowchat-v0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8951efb0cdf909f839af1a2650d280fe051eb19e7fa9ea1c0c35171f3c1111c9"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.4.0/cowchat-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5aa5e6743a8055d95f4d0ecae39df2aa9d249d919bb8ad79d040ae29b076fa5f"
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
