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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.0/cowchat-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "0364a6731a6b7d84294396b405818b1b54d07a4dac28d4918896afa7846807f5"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.0/cowchat-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "64429ba66178fbe31efdbc7a424c1a5c434a3393f621c909af4b5eb1177d41a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.0/cowchat-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2d3d18cc289f6ea73bfc37f8264c7d138a39ce4adade29f74ea15a91f79762c3"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.0/cowchat-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "090b852bdf1ccc96baba067ea6051a75497b4004e2244008cafe1e53238bae05"
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
