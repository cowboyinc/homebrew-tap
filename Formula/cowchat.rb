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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.3/cowchat-v0.9.3-aarch64-apple-darwin.tar.gz"
      sha256 "b078f814f5274932df791698b9b92b68ba70c64cf99ba010576b6e777310c084"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.3/cowchat-v0.9.3-x86_64-apple-darwin.tar.gz"
      sha256 "f7a78f6e57c74fbd9ff2770597959a521b14f5cf741541089f2b4f17d263c0c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.3/cowchat-v0.9.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "319a61d90956dd153838738e2620aa49f0dba64502f6054415a2adc30c9203cf"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.3/cowchat-v0.9.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "60077e848f8d2fbbab21ed05b818e21de862b5d59b71496cd880ab8eaff598f2"
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
