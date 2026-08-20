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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.7/cowchat-v0.8.7-aarch64-apple-darwin.tar.gz"
      sha256 "5e4e012b04faceb57db218e20b0d2e3b1b0633bd5483c0dc95ec1a8d73d5fa11"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.7/cowchat-v0.8.7-x86_64-apple-darwin.tar.gz"
      sha256 "313b44c54601407164424efc13a5d0b03d6f57759925cfde83026a17c3f3c1bf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.7/cowchat-v0.8.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "78c7286bca4e935d257323f8cf4b220bf34cea1fa26c3c760eb8288141cb40b9"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.7/cowchat-v0.8.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac94cffe6b0420db93b33ee2dfb4a0e0364e1aaef49e46c68f51ca54c265228a"
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
