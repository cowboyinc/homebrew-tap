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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.3/cowchat-v0.8.3-aarch64-apple-darwin.tar.gz"
      sha256 "469272e345ca9818aba2815d5af481ccb46753d84d5db570eae7641b69a95777"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.3/cowchat-v0.8.3-x86_64-apple-darwin.tar.gz"
      sha256 "261bdcd73c85f0a423b50fff5a16df48553410f8a90728781f4cba6bc31659fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.3/cowchat-v0.8.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "00d4de2a1e8278526ead9b89dd5d785f52565c16a3de0e623f9410284caf2372"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.8.3/cowchat-v0.8.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a89f83f42ff999ae5cdc2b822a05f8b08f158f6a1d09f00f6ca4a05990127874"
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
