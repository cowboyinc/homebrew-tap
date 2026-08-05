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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.2/cowchat-v0.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "54cc591fafb25c3335e45f5ffbc9f65b98228383ee02d55668c40062f404c21f"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.2/cowchat-v0.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "2ba23be63db30d36775da091a60af45cb665581a6957da96313f7faf798d2e6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.2/cowchat-v0.5.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e29d538a44a7a46447a2c4795715ca9a12a495b8dae3b1d65cdde3e31282adef"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.5.2/cowchat-v0.5.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "277007e169e90e87787c765b65947fc5c6b6d18b6d7eadef4acf2c72c7f31eaf"
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
