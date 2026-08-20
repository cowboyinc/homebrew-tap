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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.6/cowchat-v0.8.6-aarch64-apple-darwin.tar.gz"
      sha256 "19f044da95cd46e286c52d78a93f503870ab4f6007b5dfcf985c92eda83181d2"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.6/cowchat-v0.8.6-x86_64-apple-darwin.tar.gz"
      sha256 "56f99861fa982615c3fea426b419e40f3055a1694d79409b5640d88e5ae51c79"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.6/cowchat-v0.8.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f6ebf442d6bd5b141c4c84db96fe0fafeffbcf43ea4f0f11c825cf2f94aaa366"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.6/cowchat-v0.8.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c92fcd283a1a94d6484f69a651fae01c3dab401f9d189a2ea10d4a55aa0b879f"
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
