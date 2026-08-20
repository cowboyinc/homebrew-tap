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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.5/cowchat-v0.8.5-aarch64-apple-darwin.tar.gz"
      sha256 "33b1a6d78ab75dc8b13f1abde2a54f8bfadb036a8ba57e1c2233c3ed8bafc370"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.5/cowchat-v0.8.5-x86_64-apple-darwin.tar.gz"
      sha256 "4844c8297a4139ac9d351f5510dc09472ec8c0cb272d3455bd9ffbade3bdda38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.5/cowchat-v0.8.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3dac08b6ca1ef008ed3e61007f1da6083b72884a62cbb12eb5658fa87c099c6e"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.5/cowchat-v0.8.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5ccb1bc65b2b260b17a9bd4697a39b50350e4cd9fbc43f9cd2a7d106e435ceff"
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
