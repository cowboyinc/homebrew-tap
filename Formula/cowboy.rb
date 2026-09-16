class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.39"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.39/cowboy-darwin-arm64"
      sha256 "adcbbd6390e4b46d916d723fe6bdae396157d8ae4de05afba73ac1c6a2d07456"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.39/cowboy-darwin-x64"
      sha256 "987c6bc5e925bd85fa2455bfe007c1bb775a012bde646763a5ac2f330c0f96ae"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.39/cowboy-linux-arm64"
      sha256 "b4bc08993693aea6a0cd1c6be4c2a5cb4876de25764fb8dc3480742557735f44"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.39/cowboy-linux-x64"
      sha256 "13763deda5c93106f3bf47ad7a8699f9b31129e2d1c8dbc987d60c5ba17c17a4"
    end
  end

  def install
    bin.install Dir["cowboy-*"].first => "cowboy"
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
  end
end
