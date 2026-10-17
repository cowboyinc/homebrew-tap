class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.43"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cowboy-darwin-arm64"
      sha256 "07615b4f54ffd837dad5ae40c119adcdd50f48ed1557cdefadc62ef4a0c39b8c"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cowboy-darwin-x64"
      sha256 "04eaf4f245f94fd67d92914d98301f79252dfc0bde122392b44fdde62ee76f36"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cowboy-linux-arm64"
      sha256 "cf9ba562ffc726ef6ab3e77fb24861620dd443caebc206d731c6c575bc8d0820"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cowboy-linux-x64"
      sha256 "2d8afc261620a17f64e417d2ec3e16d87880c5aaefa4d86a8639c585048f1ac0"
    end
  end

  resource "dev-runner" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cowboy-dev-runner-darwin-arm64"
        sha256 "9e63f1427ee429f096759d2eeefcb4ef918cff9cb0c37b41ad4990c15141af89"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cowboy-dev-runner-darwin-x64"
        sha256 "783bbd21531ecbf447ce8b79125e33a20d1ef4d3ddfb782d1c24875369dafe8e"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cowboy-dev-runner-linux-arm64"
        sha256 "1cc7afa80d8bc287a6acd4497e9ed336b8cb584b52e3f72c1eadeb25633aab35"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cowboy-dev-runner-linux-x64"
        sha256 "763076bef2815be112423b8a4332e4ce482b437fd877b807b014cc44fec780a4"
      end
    end
  end

  resource "cbfs" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cbfs-darwin-arm64"
        sha256 "7316cf238b793e6e4416ba70f1454bc673ab5e9d4ed688c1a39b861795f6edd8"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cbfs-darwin-x64"
        sha256 "d3ecff7fc292a809bf0ebea42dea6be0ff2d3c4646404716e02d25cae9f30793"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cbfs-linux-arm64"
        sha256 "c5c7aa3df937aff2b700ef1b502b5e29df44d06caf21d9a97aa17dd3829dc011"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/cbfs-linux-x64"
        sha256 "916caec09e0a3d04a74b22ada24e445559e6c5194f4763eef50f9378e71cecae"
      end
    end
  end

  resource "lasso" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/lasso-darwin-arm64"
        sha256 "d90ac2ccfb664212432b341eefaa4f66cc61316ba676e76560c98d75993e5ec1"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/lasso-darwin-x64"
        sha256 "69d6eac6bee39f90d63a57534b48e555d481da5a54a2a79847179e4077484b01"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/lasso-linux-arm64"
        sha256 "8b38d81b1e2d0826eefd81ca62d4328bd2eb05ec41a5b66e52a4303a97af8a55"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.43/lasso-linux-x64"
        sha256 "ebd2c596b9eaf8dbab60c4e3604a7ae49472482951b8dc5c00329a5271554967"
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
    resource("lasso").stage do
      bin.install Dir["lasso-*"].first => "lasso"
    end
    chmod 0755, %w[cowboy cowboy-dev-runner cbfs lasso].map { |name| bin/name }
    generate_completions_from_executable(bin/"cowboy", "completions")
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
    assert_match version.to_s, shell_output("#{bin}/cowboy-dev-runner --version")
    assert_predicate bin/"cbfs", :executable?
    assert_match "cbfs", shell_output("#{bin}/cbfs --version")
    assert_predicate bin/"cowboy-dev-runner", :executable?
    assert_match version.to_s, shell_output("#{bin}/lasso --version")
    assert_match "_cowboy", shell_output("#{bin}/cowboy completions bash")
  end
end
