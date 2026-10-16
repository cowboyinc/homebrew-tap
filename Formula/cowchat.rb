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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.2/cowchat-v0.9.2-aarch64-apple-darwin.tar.gz"
      sha256 "cb50057acd1b6ae15f296028ff2444210aad2dc1b5664601dbfa6d62af64b7b5"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.2/cowchat-v0.9.2-x86_64-apple-darwin.tar.gz"
      sha256 "6967074edab3ff013ac52870c57e2ea06167de036116f28da377ed8577dcd319"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.2/cowchat-v0.9.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d280c679b1125a6d05d97eb2531d1d9d9c1c7c6963e2aa207798b4e454b1768c"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.2/cowchat-v0.9.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7f96f3d768b3cf56e69ef5c8a5157ecf60ccc95aa8c22dc0a9a2fd47c15f0a2b"
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
