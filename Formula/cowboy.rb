class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.35"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.35/cowboy-darwin-arm64"
      sha256 "274a1710d17c1d7be9f4d80d421dafb44ec7f667b1d5929a5f681a34aab2d2b8"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.35/cowboy-darwin-x64"
      sha256 "81381f6c850c08fe817e6fecb84bab1bab2d84ec57d1833aac8aed358f300487"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.35/cowboy-linux-arm64"
      sha256 "12318a266c706154166076880709e49b79a509780473b02adc2ea9ee5a889c53"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.35/cowboy-linux-x64"
      sha256 "ba1d79123ef48f6ef825af9a05282377ba5680242d41db0a2af6ebeb0b1a0cc7"
    end
  end

  def install
    bin.install Dir["cowboy-*"].first => "cowboy"
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
  end
end
