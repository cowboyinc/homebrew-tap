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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.0/cowchat-v0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "716703a0bbc9ef3f166c372b07dc6b6b6b51e0dc93dc32618938ec300a8e2f6c"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.0/cowchat-v0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "c88f3bd038d25c6d1c16df0f31dee63a51b282fbc055ae92184f67b6995283a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.0/cowchat-v0.8.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e28c373608f2b10cf08e7af0284a25848fce7e580a34dbf71bbe907cb972068e"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.0/cowchat-v0.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "728d7e0e8c7e339be4c6c51a22820ecea2bb2f3309742cd8a1db73c633788067"
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
