# Cask template: scripts/release.sh fills itskamol/tern (from Cargo.toml's repository), 0.2.0 and
# cc103974455bd178b227905fe79e6492868c5d00a805c4cb3b79864ab9443f5b and writes the result to target/release/bundle/tern.rb. Copy that into the tap
# (<owner>/homebrew-tern, Casks/tern.rb); then `brew install --cask <owner>/tern/tern`.
cask "tern" do
  version "0.2.0"
  sha256 "cc103974455bd178b227905fe79e6492868c5d00a805c4cb3b79864ab9443f5b"

  url "https://github.com/itskamol/tern/releases/download/v#{version}/tern-#{version}-macos-arm64.zip"
  name "tern"
  desc "Fast, low-memory SSH terminal"
  homepage "https://github.com/itskamol/tern"

  livecheck do
    url :url
    strategy :github_latest
  end

  # tern downloads and installs its own updates (signed like the installed app), so Homebrew
  # does not race it.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "tern.app"

  # Built and signed on its maintainer's Mac with a local certificate, not notarised: without
  # this, Gatekeeper refuses to open the downloaded app.
  installed = "#{appdir}/tern.app"
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", installed]
  end

  zap trash: [
    "~/Library/Application Support/tern",
    "~/Library/Logs/tern",
  ]
end
