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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.5/cowchat-v0.9.5-aarch64-apple-darwin.tar.gz"
      sha256 "e5e0c39d85cbace8731940ec8cd31a3abe9009a39084c1b8e2511f4a01be06d0"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.5/cowchat-v0.9.5-x86_64-apple-darwin.tar.gz"
      sha256 "766dc38198fed9e33a0278fd304b71508730aa9c0a8b2dd4d438fdb89a4577ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.5/cowchat-v0.9.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "15a45a67efa795ee503207699d422d1eafedd5094caa5ee802e8ee8bb1323a0d"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.5/cowchat-v0.9.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cb209d8f82f6e77aa3b4694651338ea61c190c5c225c1b4ea7aa47763654f95a"
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
