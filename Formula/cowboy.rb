class Cowboy < Formula
  desc "Cowboy blockchain command-line tool"
  homepage "https://github.com/cowboyinc/cowboy-cli"
  # Each platform's certified archive holds cowboy, cowboy-dev-runner and lasso.
  # macOS is Apple Silicon only; Intel Macs are not supported.
  url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.55/cowboy-darwin-arm64.tar.xz"
  version "0.0.55"
  sha256 "1671fbc311824da8b980afdd4555298de30e87a23ba5084e7ebc911277b765df"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
  end

  on_linux do
    on_arm do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.55/cowboy-linux-arm64.tar.xz"
      sha256 "cd3af9ed1521bb3bb3e4e4fc455cff3a9942d122bc3d8612b43ad01240c7da8d"
    end
    on_intel do
      url "https://github.com/cowboyinc/cowboy-cli/releases/download/v0.0.55/cowboy-linux-x64.tar.xz"
      sha256 "6a50e864aa01125bdc367161679b94b5c56101f65bd35414a004abe149802989"
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
