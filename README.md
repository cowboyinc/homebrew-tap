# Cowboy Homebrew Tap

Homebrew formulas for Cowboy tools.

```bash
brew install cowboyinc/tap/cowboy    # cowboy CLI, with cowboy cbfs, lasso (cowboy console) and cowboy-dev-runner
brew install cowboyinc/tap/cowchat   # agent chat CLI + server
brew install --cask cowboyinc/tap/cowchat  # Cowchat.app
```

Formula bumps are automated: each tool's release workflow builds binaries,
publishes a GitHub release, and opens a PR here with the regenerated formula.
