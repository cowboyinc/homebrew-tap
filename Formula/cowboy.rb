class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.37"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.37/cowboy-darwin-arm64"
      sha256 "aa3f0924be7ea106d63ae844a4e466a6f87143eb367f2a7d983778fddd688f12"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.37/cowboy-darwin-x64"
      sha256 "8b584202229e5b64869c907ccb348b3cd0148c4eb6cd9c90bc24f463bceedf83"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.37/cowboy-linux-arm64"
      sha256 "a8c24904e9e4917e7e1d2b1b07d51cad59ac2235c17aeac229027dc2b51dd2dc"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.37/cowboy-linux-x64"
      sha256 "f2079d74284de332f00987a1f87db9bfb474285adeca5a8ea020c1c3b070d25c"
    end
  end

  def install
    bin.install Dir["cowboy-*"].first => "cowboy"
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
  end
end
