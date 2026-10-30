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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.15/cowchat-v0.9.15-aarch64-apple-darwin.tar.gz"
      sha256 "ec22baff07993fd5fb634d5013bd9af9365d6477c43a18695680b755e7a48832"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.15/cowchat-v0.9.15-x86_64-apple-darwin.tar.gz"
      sha256 "55951565b0333d2bbc3b2edff80f5c7438b0ec53e49d99ac9c46cfc809510e00"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.15/cowchat-v0.9.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "285bf3e53aa594fac4521ba053058f457a4d60d07968a2dea3eeaadc985b837d"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.15/cowchat-v0.9.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "deba087c915154d07b88b69528588d018e6946e406d7ba222139ef094dae92ff"
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
