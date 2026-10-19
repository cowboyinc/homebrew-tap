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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.10/cowchat-v0.9.10-aarch64-apple-darwin.tar.gz"
      sha256 "22ad26cf0f97f87fb439ffd7bf1db98e7b2dd3a6b6c39fc4dbd9f5f47ee7af39"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.10/cowchat-v0.9.10-x86_64-apple-darwin.tar.gz"
      sha256 "09ac208db432f34a14f1ddedc7c729b7d17d85b968da13ad498e7a1104c7174d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.10/cowchat-v0.9.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a4e8f30c0225837c273621445d54cfbec80a694b2fe80b03365c30a5a715d352"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.10/cowchat-v0.9.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d4cac5ffdff0c7281188e5e4ced7c34ab68bca16d51d8d80cd897964abeed432"
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
