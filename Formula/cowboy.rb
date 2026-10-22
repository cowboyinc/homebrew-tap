class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.44"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cowboy-darwin-arm64"
      sha256 "856c40975b6e6fb3e037a8383c281b9ac78a5704ae2b9b4e3d666fde64250007"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cowboy-darwin-x64"
      sha256 "17821f8956b3082d6df6f027c301fbd65ba69d3344a9e7f0c5232a465411542f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cowboy-linux-arm64"
      sha256 "25ae921cb6c7b30cad57b1737dd8e6cd7d30e8161c94f3949d7b1b5419b46dd5"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cowboy-linux-x64"
      sha256 "83fcbc641bc665b59c3c82e9ee30d4654a5983fe6d52767e1117a328880bb4ff"
    end
  end

  resource "dev-runner" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cowboy-dev-runner-darwin-arm64"
        sha256 "b5f6f9378210842741a151d977f09a3f27a10e35df4406669c84ea5e4c846c2e"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cowboy-dev-runner-darwin-x64"
        sha256 "01b41a441d89b9cca708b3536423f9f924cfa46c5af2c349700edc408ef65b04"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cowboy-dev-runner-linux-arm64"
        sha256 "b6cbca79737c4d11ce0a16ecb78847e3f837ff0c0789bfda8e4929b5b1499eb3"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cowboy-dev-runner-linux-x64"
        sha256 "84a3b4ce69394fa645306f0798c9b871f0130218f59a8f63eebc3e874d1c828e"
      end
    end
  end

  resource "cbfs" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cbfs-darwin-arm64"
        sha256 "5360c65598398c4ea666ef41780a937d5dabd5af74ee454c44b9aa547fc94402"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cbfs-darwin-x64"
        sha256 "9debe291591bdb49e9ed8552cab3949371c301149103f3245c5cb25a2e67f190"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cbfs-linux-arm64"
        sha256 "703cc73b7999eacd23436d68d8ee009dca05e53242310e7f4eb4acaf5e59b2aa"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/cbfs-linux-x64"
        sha256 "cb44743a79cd5a90464c94cf634e83e0de951684b5835261c85990a64772df57"
      end
    end
  end

  resource "lasso" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/lasso-darwin-arm64"
        sha256 "224fe83d8b2aa7d416fa5b2ae900e463c76993e124feb7340b1d419347c77815"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/lasso-darwin-x64"
        sha256 "8f09bd8bdaa9b3a67f1ef77bf664fe4b92e95e946123ec10c882518652c06d79"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/lasso-linux-arm64"
        sha256 "5e103a852a7917724008259e13eb895bd9fa8ff7b759e6951243abe3a69a34c8"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.44/lasso-linux-x64"
        sha256 "767eeb68312b9568926e3225870c96f729e4ad97a61481ef50d2bf8a9a9af7e0"
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
