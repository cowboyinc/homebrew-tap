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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.7/cowchat-v0.9.7-aarch64-apple-darwin.tar.gz"
      sha256 "7b2e22a64e2f8ac4619590682dd85a9034f802bb399b952a300b83b3ca213405"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.7/cowchat-v0.9.7-x86_64-apple-darwin.tar.gz"
      sha256 "90c2382bb409f4370191915cb49dd37920a300cfc81fe71528209760b2484c73"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.7/cowchat-v0.9.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "841809b912d85a2672f08c37a62c80342a653d9811c6b56ab769c48905d70271"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.7/cowchat-v0.9.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "13bcdbb8f0cb1b9c2d5ab8254e4888be76efcd3a9701bd366907a50fb6962487"
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
