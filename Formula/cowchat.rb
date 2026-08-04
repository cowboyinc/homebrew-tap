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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.1/cowchat-v0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "aed4b95948ac8501b123fe972d9d017bbaf216c6e130d55ac600825b6f8b4d98"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.1/cowchat-v0.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "4867a337b4083299608bf9397cebcd40ed1261d818fecac4f004724a38d2a811"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.1/cowchat-v0.5.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bbb5c99a54dabcdffd733a264ccda94c3f03c45e8ff3b20f840b236fd3b4ef3f"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.1/cowchat-v0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "505d75872fb62f97eff5db56d9ea839198816dbb5cb49b1f4c759a9dc286378c"
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
