class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.34"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.34/cowboy-darwin-arm64"
      sha256 "df9cddb7222782bfe0c6cc80d038c3949999f0c91d0f22ef00f6c3370e7c8bfb"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.34/cowboy-darwin-x64"
      sha256 "943adf2c2369c6d8b0ea6310e3a4f349b531a3567549382df8c5d5d23d952e9e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.34/cowboy-linux-arm64"
      sha256 "86329a710ae27e6344b4b57772b587b754711803a5eb833623200ddcbf2d7fcd"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.34/cowboy-linux-x64"
      sha256 "d0e6016792ca212cbf2547d9da55e103c326849b22a8ce6cb2259c0ad865c416"
    end
  end

  def install
    bin.install Dir["cowboy-*"].first => "cowboy"
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
  end
end
