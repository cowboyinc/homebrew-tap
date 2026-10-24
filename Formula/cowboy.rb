class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "TODO(auth-v3 final)"
  license any_of: ["MIT", "Apache-2.0"]

  # Each platform's certified archive holds cowboy, cowboy-dev-runner and lasso.
  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-darwin-arm64.tar.xz"
      sha256 "TODO(auth-v3 final)"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-darwin-x64.tar.xz"
      sha256 "TODO(auth-v3 final)"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-linux-arm64.tar.xz"
      sha256 "TODO(auth-v3 final)"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v#{version}/cowboy-linux-x64.tar.xz"
      sha256 "TODO(auth-v3 final)"
    end
  end

  def install
    bin.install "cowboy", "cowboy-dev-runner", "lasso"
    generate_completions_from_executable(bin/"cowboy", "completions")
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
    assert_match "cowboy cbfs", shell_output("#{bin}/cowboy cbfs --help")
    assert_match version.to_s, shell_output("#{bin}/cowboy-dev-runner --version")
    assert_predicate bin/"cowboy-dev-runner", :executable?
    assert_match version.to_s, shell_output("#{bin}/lasso --version")
    assert_match "_cowboy", shell_output("#{bin}/cowboy completions bash")
  end
end
