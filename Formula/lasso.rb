class Lasso < Formula
  desc "Interactive terminal console for the Cowboy blockchain"
  homepage "https://github.com/cowboyinc/lasso"
  version "0.4.3"
  license "BUSL-1.1"

  depends_on "cowboyinc/tap/cowboy"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/cowboyinc/lasso/releases/download/v0.4.3/lasso-darwin-arm64"
      sha256 "22141059580c87cdeb8339bcca851db1d049369f83660c2df6f952171e8d4764"
    else
      url "https://github.com/cowboyinc/lasso/releases/download/v0.4.3/lasso-darwin-x64"
      sha256 "e17495da16a9e907e9f34e5f50878fa0e647261c1c51e99727082ed394546f5f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/cowboyinc/lasso/releases/download/v0.4.3/lasso-linux-arm64"
      sha256 "3c412c18e13b8a0c230d988f0c717a3063a097fa0f429c82550711616180ebbe"
    else
      url "https://github.com/cowboyinc/lasso/releases/download/v0.4.3/lasso-linux-x64"
      sha256 "a5b0c252cbd35b8e795f10507246b55cda77574d6ae4d4e286b9ccb7af1451ab"
    end
  end

  def install
    bin.install Dir["lasso-*"].first => "lasso"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lasso --version")
  end
end
