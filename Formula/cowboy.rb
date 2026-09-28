class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.40"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.40/cowboy-darwin-arm64"
      sha256 "036980fdb8bd219e3067002a3aa64ba78bcb982c832026fb1d3c3270754e1f77"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.40/cowboy-darwin-x64"
      sha256 "380bbb8925ddc66b26ee208c1172e92c22caf258676fe2ebd6c840f55a6a54c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.40/cowboy-linux-arm64"
      sha256 "45485e3ee631178cf5a943ca894e1112a32aaeb9f9e227da58a2d8bd22b49668"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.40/cowboy-linux-x64"
      sha256 "35e2f2498469bcf4ca9284adab12915dbdd4072eef8f3dc393710c989a684bed"
    end
  end

  resource "dev-runner" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.40/cowboy-dev-runner-darwin-arm64"
        sha256 "65e9b816ea98d2f50289abf31475e310e5c5e2931dec7f64b7802fcc7fbb16db"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.40/cowboy-dev-runner-darwin-x64"
        sha256 "d1fc756b4dad3788d28e1bd9c650e4997c03e90fb8d43be85819cb42573fe446"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.40/cowboy-dev-runner-linux-arm64"
        sha256 "c0a6bd573c9c39ca6992f653102566804e24832108f507e3ab0a855bf5bcc699"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.40/cowboy-dev-runner-linux-x64"
        sha256 "4e828bf2fcb79f790084824cad5b653af6ef628997f354e02ebf8d61aa308434"
      end
    end
  end

  def install
    bin.install Dir["cowboy-*"].first => "cowboy"
    resource("dev-runner").stage do
      bin.install Dir["cowboy-dev-runner-*"].first => "cowboy-dev-runner"
    end
    generate_completions_from_executable(bin/"cowboy", "completions")
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
    assert_match version.to_s, shell_output("#{bin}/cowboy-dev-runner --version")
    assert_predicate bin/"cowboy-dev-runner", :executable?
    assert_match "_cowboy", shell_output("#{bin}/cowboy completions bash")
  end
end
