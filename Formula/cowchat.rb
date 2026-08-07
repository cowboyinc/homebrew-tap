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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.1/cowchat-v0.6.1-aarch64-apple-darwin.tar.gz"
      sha256 "c7a199ef8af040674bdd891a825e442c4cac59fb534cafb3e0948ec4d7f2fb11"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.1/cowchat-v0.6.1-x86_64-apple-darwin.tar.gz"
      sha256 "754f8abfee0af40591c3a27bc0c685471f4dfd42e9b591879e6badc8d2a0b1db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.1/cowchat-v0.6.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cb0dc6c27707ab89a7c78ca48a56682941d0c65419e45e4aaf8dd79fd60271f8"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.6.1/cowchat-v0.6.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a8029399049121b05a8dd9511300d065ba929f22a118751275f5e4aaa8ff197f"
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
