class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  # Each platform's certified archive holds cowboy, cowboy-dev-runner and lasso.
  # macOS is Apple Silicon only; Intel Macs are not supported.
  url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.48/cowboy-darwin-arm64.tar.xz"
  version "0.0.48"
  sha256 "fc0efb7a51e7902c47b4f967ebd40dc401721e017faa960a0ad4a45d002c46eb"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.48/cowboy-linux-arm64.tar.xz"
      sha256 "304befea19828728008492180317d5b291903b3c60ddb82ede62e5cd75cd3aeb"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.48/cowboy-linux-x64.tar.xz"
      sha256 "b8be1be8158def7a4c6d18fec4ec00eaa9312c375f72806e1658821ae759b075"
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
