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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.0/cowchat-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "4f06e7e65d3ab057d631a56f8799d85ab249d6ccc73766e2d439bc4464df4a90"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.0/cowchat-v0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "a74bba19388bdb0d03fb47fa0f682f2226acbb432ba209204c02e2a00430a09a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.0/cowchat-v0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2b7e7ee56a5e88805ff3ece89c6647940ca1d95432691461c960b15a236dbdd4"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.0/cowchat-v0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f20dbe6d06256fd056b19671941afa183bbc8ee769116013c85a134bdb7a4124"
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
