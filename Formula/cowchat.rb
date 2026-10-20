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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.12/cowchat-v0.9.12-aarch64-apple-darwin.tar.gz"
      sha256 "323304c0c62376b8c929e7542d8465aad045e3d2f8c0c987cef1bbd28b6e2dec"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.12/cowchat-v0.9.12-x86_64-apple-darwin.tar.gz"
      sha256 "48d6846aa66bcd8d3ee8317d197e71f094635159acf4c4aa7d2d8d0d8f00ac46"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.12/cowchat-v0.9.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d0303aae3147ce552bf0911f21d2e500d2e2cdb1fce1783fa7521f5dc9a44d9c"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.12/cowchat-v0.9.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5d3e6466b03bf0b59e67ddaa735475491bfcb371d71a885fba21b9679a1e86f8"
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
