class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  version "0.0.45"
  license any_of: ["MIT", "Apache-2.0"]

  # Each platform's certified archive holds cowboy, cowboy-dev-runner and lasso.
  on_macos do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.45/cowboy-darwin-arm64.tar.xz"
      sha256 "747c344410aeea5c550aeb2f240719d04c1daaf67f0066b6a56501259c940f61"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.45/cowboy-darwin-x64.tar.xz"
      sha256 "401076d2330b8027e24f48a82463cc30676854781a98d3e5765a479635b6d734"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.45/cowboy-linux-arm64.tar.xz"
      sha256 "74059f48344e1f1d746bf55210b61f6f960e05402cf745c994f4e463506d6821"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.45/cowboy-linux-x64.tar.xz"
      sha256 "d25d42a957892146e5aa97e6567f0d0a248201d04be89afb62e0fb68f18a7257"
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
