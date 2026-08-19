class Cbfs < Formula
  desc "Cowboy file system (CBFS) command-line tool"
  homepage "https://github.com/cowboyinc/cbfs-cli"
  version "0.1.4"
  license "BUSL-1.1"

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cbfs-cli/releases/download/v0.1.4/cbfs-darwin-arm64"
      sha256 "a01888185887aba8d64df574e8ca483840740edb3604fdd223294a279682de58"
    end
    on_intel do
      url "https://github.com/cowboyinc/cbfs-cli/releases/download/v0.1.4/cbfs-darwin-x64"
      sha256 "16bce977539f324b602efc0c02f4a22d6e187dfef2651ca786a069213bcceb7d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cbfs-cli/releases/download/v0.1.4/cbfs-linux-arm64"
      sha256 "b78fa497e2ead09dfa8d17e696fce0f43c87b40e827e319093c70ef4be8ac7eb"
    end
    on_intel do
      url "https://github.com/cowboyinc/cbfs-cli/releases/download/v0.1.4/cbfs-linux-x64"
      sha256 "776525ddebdf20ec1c299b5f12e662eb8915f5248e93a291ad5ead32903f904f"
    end
  end

  def install
    bin.install Dir["cbfs-*"].first => "cbfs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cbfs --version")
  end
end
