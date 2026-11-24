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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.16/cowchat-v0.9.16-aarch64-apple-darwin.tar.gz"
      sha256 "f9c3f769eae47f47018af7a48a82bf308df706d0dda4ec628982f1c74da3d392"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.16/cowchat-v0.9.16-x86_64-apple-darwin.tar.gz"
      sha256 "2aaf3db62a6c7afd7dacf75b9cf4317b8f35da9e10dee77b3194bba53a759f3b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.16/cowchat-v0.9.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6bc37391919482e91e15368815fe30837e9180547babd7780a63c36e24f3caa6"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.16/cowchat-v0.9.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d172cb295b5b45c5b398088edff9af77571c464ba3e1c662bc87e4a4c745a9a0"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "crates/cowchat-cli")
      system "cargo", "install", *std_cargo_args(path: "crates/cowchat-server")
      system "cargo", "install", *std_cargo_args(path: "crates/cowchat-codex")
    else
      bin.install "cowchat", "cowchat-server", "cowchat-codex"
      prefix.install "LICENSE-MIT", "LICENSE-APACHE", "THIRD-PARTY-NOTICES.md"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cowchat --version")
    assert_match version.to_s, shell_output("#{bin}/cowchat-server --version")
    assert_match version.to_s, shell_output("#{bin}/cowchat-codex --version")
  end
end
