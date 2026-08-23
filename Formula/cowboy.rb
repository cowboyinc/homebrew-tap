class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.36"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.36/cowboy-darwin-arm64"
      sha256 "5b2ca43bdcbc81b2520b8480900a0ebf043058ac570ecf2785bc9b6155e71a71"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.36/cowboy-darwin-x64"
      sha256 "f811a04f70e0131c7314b49bfbdda25404fe2089a38f3e588c85e1255e1fb18a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.36/cowboy-linux-arm64"
      sha256 "2b8a75003253434d25aa75ba00a8fd0f5c17c56f7f09ccf4cb1988b9ca32e27f"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.36/cowboy-linux-x64"
      sha256 "28027c5605301ee8fe1c8192a4bfbb0048e4b6fe5fd2bc6903d3d2557dcd98aa"
    end
  end

  def install
    bin.install Dir["cowboy-*"].first => "cowboy"
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
  end
end
