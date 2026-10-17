# Cowboy Homebrew Tap

Homebrew formulas for Cowboy tools.

```bash
brew install cowboyinc/tap/cowboy-tools  # everything below except cowchat
brew install cowboyinc/tap/cowboy    # cowboy blockchain CLI, with lasso (cowboy console)
brew install cowboyinc/tap/cbfs      # CBFS storage CLI
brew install cowboyinc/tap/cowchat   # agent chat CLI + server
brew install --cask cowboyinc/tap/cowchat  # Cowchat.app
```

Formula bumps are automated: each tool's release workflow builds binaries,
publishes a GitHub release, and opens a PR here with the regenerated formula.
