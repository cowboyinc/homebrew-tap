# Meta-formula: one install for the Cowboy blockchain toolchain.
# The url is a pinned, content-addressed placeholder (Homebrew requires
# one); the payload is the depends_on list. Bump the version when the
# tool list changes.
class CowboyTools < Formula
  desc "Cowboy blockchain toolchain (cowboy + lasso + cbfs)"
  homepage "https://github.com/cowboyinc/homebrew-tap"
  url "https://raw.githubusercontent.com/cowboyinc/homebrew-tap/1c2b2c50072b0915f59a3f25499fd1fb0c62f5e5/README.md"
  version "1.0.0"
  sha256 "59191d7567ee27b7914587337db7085287fe4061f16597f504aae190d3e05fee"
  license "BUSL-1.1"

  depends_on "cowboyinc/tap/cbfs"
  depends_on "cowboyinc/tap/cowboy"
  depends_on "cowboyinc/tap/lasso"

  def install
    # A root-level README counts as metadata and trips Homebrew's
    # empty-installation check; pkgshare does not.
    pkgshare.install "README.md"
  end

  test do
    assert_predicate pkgshare/"README.md", :exist?
  end
end
