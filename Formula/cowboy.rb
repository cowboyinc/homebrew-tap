class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.32"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.32/cowboy-darwin-arm64"
      sha256 "3cfd56bc9a3a22595a78656fd746003d5bad10fd68cf69f2fe62fec3a7edf7da"
    end
  end

  def install
    odie "cowboy is currently packaged for macOS Apple Silicon only" if Dir["cowboy-*"].empty?
    bin.install Dir["cowboy-*"].first => "cowboy"
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
  end
end
