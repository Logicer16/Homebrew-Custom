cask "microsoft-edge-canary" do
  version "93.0.932.0"

  if Hardware::CPU.intel?
    sha256 "69230e9def175e774887f90ae6b61950f7b4c6ca3116b54ea51fb40b6c9d4274"

    url "https://officecdn-microsoft-com.akamaized.net/pr/C1297A47-86C4-4C1F-97FA-950631F94777/MacAutoupdate/MicrosoftEdgeCanary-#{version}.pkg",
        verified: "officecdn-microsoft-com.akamaized.net/"
  else
    sha256 "575c2e74581ca81dc93c1b467c3d934107c631f8cdba76747ebc03bada7515a8"

    url "https://officecdn-microsoft-com.akamaized.net/pr/03adf619-38c6-4249-95ff-4a01c0ffc962/MacAutoupdate/MicrosoftEdgeCanary-#{version}.pkg",
        verified: "officecdn-microsoft-com.akamaized.net/"
  end

  name "Microsoft Edge Canary"
  desc "Multi-platform web browser"
  homepage "https://www.microsoftedgeinsider.com/"

  livecheck do
    url "https://go.microsoft.com/fwlink/?linkid=2069147"
    strategy :header_match
  end

  auto_updates true
  depends_on cask: "microsoft-auto-update"

  pkg "MicrosoftEdgeCanary-#{version}.pkg",
      choices: [
        {
          "choiceIdentifier" => "com.microsoft.package.Microsoft_AutoUpdate.app", # Office16_all_autoupdate.pkg
          "choiceAttribute"  => "selected",
          "attributeSetting" => 0,
        },
      ]

  uninstall pkgutil: "com.microsoft.edgemac.Canary"

  zap trash: [
    "~/Library/Application Support/Microsoft Edge Canary",
    "~/Library/Caches/Microsoft Edge Canary",
    "~/Library/Preferences/com.microsoft.edgemac.Canary.plist",
    "~/Library/Saved Application State/com.microsoft.edgemac.Canary.savedState",
  ],
      rmdir: "/Library/Application Support/Microsoft"

end
