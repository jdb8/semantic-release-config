workflow "New workflow" {
  on = "push"
  resolves = ["Release"]
}

action "Install" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  # Set a .cache folder that's shared across actions to make PnP work
  args = ["install", "--cache-folder", ".cache"]
  runs = "yarn"
}

action "Test" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Install"]
  args = "test"
  runs = "yarn"
}

action "Release" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  needs = ["Test"]
  args = "run release"
  runs = "yarn"
  secrets = [
    "NPM_TOKEN",
    "GITHUB_TOKEN",
  ]
}
