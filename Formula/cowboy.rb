class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.42"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cowboy-darwin-arm64"
      sha256 "0e24e530d4c5f8905052ce4bc8b5fa1f88e700d6c569fc009524196bd4e788a3"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cowboy-darwin-x64"
      sha256 "c313906e18b78cefa8253141ecffeadc19a4203b46937d095f4f24e1e52bdf98"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cowboy-linux-arm64"
      sha256 "25ab4f85d33eaf4b03259d9121c710ef94bb5a92a57565f71457f49acacc1b90"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cowboy-linux-x64"
      sha256 "1fd3c92982611820de17972e5d959bd209cfb9df6c51664bfca1196de39f8266"
    end
  end

  resource "dev-runner" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cowboy-dev-runner-darwin-arm64"
        sha256 "1c570b9022c266f8b486afeeb42f4c0ebb2830451b8fa1834504f4461fbe9d75"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cowboy-dev-runner-darwin-x64"
        sha256 "19aca75c7cd3c92675532560d14b1eb19f5b9a362afb8520bf71775797a88893"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cowboy-dev-runner-linux-arm64"
        sha256 "b1d06b9dc16cb91b3905e87e2ac13f48ebc0f8d12abec3ca5a3bbd8549ab5eba"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cowboy-dev-runner-linux-x64"
        sha256 "2ba0291f393c04c72d7b2d94d12a9b1a9cdfbd3357f656fd4f9acda02ee8a1d3"
      end
    end
  end

  resource "cbfs" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cbfs-darwin-arm64"
        sha256 "cd9191952ffd6d35b89fdc7611268447e19b4eeb2de82f2c534305d1fdacc786"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cbfs-darwin-x64"
        sha256 "446a4845c92927fefb8e6fda60af0046f1eb023f627ec9e9267e53fe099db8ee"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cbfs-linux-arm64"
        sha256 "94c34b8c2121f4b7560b3a89e3ce780ebbc1b6ff203ce52db00678e7b17a942d"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.42/cbfs-linux-x64"
        sha256 "8d514eb85124bd23f506583eb10c6b375d5ad2941f903d5ed5410a901cdfa2d8"
      end
    end
  end

  def install
    bin.install Dir["cowboy-*"].first => "cowboy"
    resource("dev-runner").stage do
      bin.install Dir["cowboy-dev-runner-*"].first => "cowboy-dev-runner"
    end
    resource("cbfs").stage do
      bin.install Dir["cbfs-*"].first => "cbfs"
    end
    generate_completions_from_executable(bin/"cowboy", "completions")
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
    assert_match version.to_s, shell_output("#{bin}/cowboy-dev-runner --version")
    assert_predicate bin/"cbfs", :executable?
    assert_match "cbfs", shell_output("#{bin}/cbfs --version")
    assert_predicate bin/"cowboy-dev-runner", :executable?
    assert_match "_cowboy", shell_output("#{bin}/cowboy completions bash")
  end
end
