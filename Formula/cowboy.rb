class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  # Each platform's certified archive holds cowboy, cowboy-dev-runner and lasso.
  # macOS is Apple Silicon only; Intel Macs are not supported.
  url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.50/cowboy-darwin-arm64.tar.xz"
  version "0.0.50"
  sha256 "fd019b013199d1413514cb377aca47dd87929c5d63a834f1e67f9a7e43caa1b3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.50/cowboy-linux-arm64.tar.xz"
      sha256 "a3c987076c9027023a9faca2568fefdc588147f4eea5f6962985322d3dab3394"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.50/cowboy-linux-x64.tar.xz"
      sha256 "357a7208eb186d80f6a2d2256b40cdfa1b8c58850769345b71bd63a668050b54"
    end
  end

  def install
    bin.install "cowboy", "cowboy-dev-runner", "lasso"
    generate_completions_from_executable(bin/"cowboy", "completions")
  end

  test do
    assert_match "cowboy", shell_output("#{bin}/cowboy version")
    assert_match version.to_s, shell_output("#{bin}/cowboy-dev-runner --version")
    assert_predicate bin/"cowboy-dev-runner", :executable?
    assert_match version.to_s, shell_output("#{bin}/lasso --version")
    assert_match "_cowboy", shell_output("#{bin}/cowboy completions bash")
  end
end
