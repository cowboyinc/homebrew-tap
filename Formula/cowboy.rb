class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "TODO(auth-v3 final)"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-darwin-arm64"
      sha256 "TODO(auth-v3 final)"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-darwin-x64"
      sha256 "TODO(auth-v3 final)"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-linux-arm64"
      sha256 "TODO(auth-v3 final)"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-linux-x64"
      sha256 "TODO(auth-v3 final)"
    end
  end

  resource "dev-runner" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-dev-runner-darwin-arm64"
        sha256 "TODO(auth-v3 final)"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-dev-runner-darwin-x64"
        sha256 "TODO(auth-v3 final)"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-dev-runner-linux-arm64"
        sha256 "TODO(auth-v3 final)"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-dev-runner-linux-x64"
        sha256 "TODO(auth-v3 final)"
      end
    end
  end

  resource "cbfs" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cbfs-darwin-arm64"
        sha256 "TODO(auth-v3 final)"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cbfs-darwin-x64"
        sha256 "TODO(auth-v3 final)"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cbfs-linux-arm64"
        sha256 "TODO(auth-v3 final)"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cbfs-linux-x64"
        sha256 "TODO(auth-v3 final)"
      end
    end
  end

  resource "lasso" do
    on_macos do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/lasso-darwin-arm64"
        sha256 "TODO(auth-v3 final)"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/lasso-darwin-x64"
        sha256 "TODO(auth-v3 final)"
      end
    end
    on_linux do
      on_arm do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/lasso-linux-arm64"
        sha256 "TODO(auth-v3 final)"
      end
      on_intel do
        url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/lasso-linux-x64"
        sha256 "TODO(auth-v3 final)"
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
