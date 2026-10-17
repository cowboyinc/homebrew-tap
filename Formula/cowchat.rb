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
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.4/cowchat-v0.9.4-aarch64-apple-darwin.tar.gz"
      sha256 "9b74136cafdd48b05f52c50392d152d01887248347220d6fd02acf8b0fe28b1c"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.4/cowchat-v0.9.4-x86_64-apple-darwin.tar.gz"
      sha256 "b98f7e0e24a428153ab900fd3b3ce3023f5793ca768645baa31648de03eb56e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.4/cowchat-v0.9.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aa2bcd030e871d7240e157697e56d1ff449bfcab6fc4154d5bdb1f359e974e07"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowchat/releases/download/v0.9.4/cowchat-v0.9.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "01b6be9dc6bebc344b45e2c0b54af605256da7c59d4370a3007f19f04299219c"
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
