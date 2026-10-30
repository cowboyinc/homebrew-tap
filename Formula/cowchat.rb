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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.14/cowchat-v0.9.14-aarch64-apple-darwin.tar.gz"
      sha256 "e3b9276161571187dad7daf4e18fcada1d8989bb70030c9f853289aaec41c797"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.14/cowchat-v0.9.14-x86_64-apple-darwin.tar.gz"
      sha256 "d0aaeed8df212d97db1cb0ae6b72f6de3e3e9e63297dcef194e95678cbce7f22"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.14/cowchat-v0.9.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dfc3621b616609901139e69311facb88b2522f1d28f695d3452d53079baa4f30"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.14/cowchat-v0.9.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "12ac9cac0d42694ab01cc1b8fce658f52cb57aeb86956b0c5e02ca47d323af7d"
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
