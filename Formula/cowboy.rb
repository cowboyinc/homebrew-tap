class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  # Each platform's certified archive holds cowboy, cowboy-dev-runner and lasso.
  # macOS is Apple Silicon only; Intel Macs are not supported.
  url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.47/cowboy-darwin-arm64.tar.xz"
  version "0.0.47"
  sha256 "562c3a7f2bc7fc7c28a0d60667cd642b00a1601dda7f322e04927f0d34663125"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.47/cowboy-linux-arm64.tar.xz"
      sha256 "7d3e89e0c32511b7c15ec150653f5b44f053a799ca5a6a6a071bf974f835aade"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.47/cowboy-linux-x64.tar.xz"
      sha256 "6290e5d7894c7300a34ad671e447ae6baeee02acba790987d301c4ba9a71937f"
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
