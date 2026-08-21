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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.0/cowchat-v0.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "34653077ebb041ae22afb41ad7bf648039ff43b4c844c529982a5db0fc529e1a"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.0/cowchat-v0.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "3b9d8b61e36df27ae15706aa9224b03d519c9aeb66a59499d96a2ccc486382f8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.0/cowchat-v0.9.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a5f6383668e570abeae3d562987eeb4d794b50d42aa195f4ed26c15767acb64e"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.0/cowchat-v0.9.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e777741997243d603107249fb90f22ee654e829c869d496133e12da8dd6a9132"
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
