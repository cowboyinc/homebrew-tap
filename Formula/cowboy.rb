class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  # Each platform's certified archive holds cowboy, cowboy-dev-runner and lasso.
  # macOS is Apple Silicon only; Intel Macs are not supported.
  url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.54/cowboy-darwin-arm64.tar.xz"
  version "0.0.54"
  sha256 "1819ef82767c4e73de721ba76f983570923b53c0466eb8161cda3c36e898efe3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.54/cowboy-linux-arm64.tar.xz"
      sha256 "e8ca724ccd9bcd28bdf6286a97e7e8405b8943062117372b5fd482b8fd9190bd"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.54/cowboy-linux-x64.tar.xz"
      sha256 "5f463c2aac126ed08a0c40647b3021df05ddd7a243cd626aeaa41265d42f33b6"
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
