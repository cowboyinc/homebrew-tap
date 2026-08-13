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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.7.0/cowchat-v0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "59ca33b81184d172005a4673a2e09369391295886acaaf86f5afee04a6276798"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.7.0/cowchat-v0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "373699deffd61e52051990c729b4151d8a5f71aa7b11ceeb934f4147666654ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.7.0/cowchat-v0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "90afc990bcbd4768183dc281a831a1ead148e0b22bab1bb018e664a79e03b7f7"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.7.0/cowchat-v0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cce45f08cdcf61ed5b6d9fc361cea916414b02b991e3dc3cecc7ca4990fed0e3"
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
