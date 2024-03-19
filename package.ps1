$AppsList = "Microsoft.MicrosoftOfficeHub", # Get Office
"Microsoft.SkypeApp", # Get Skype
"microsoft.windowscommunicationsapps", # Mail & Calendar
"Microsoft.People", # People
"Microsoft.CommsPhone", # Phone
"Microsoft.WindowsPhone", # Phone Companion
"Microsoft.XboxApp", # Xbox
"Microsoft.Messaging", # Messaging & Skype
"Microsoft.Reader" # Microsoft Reader
"Microsoft.WindowsCamera" # Camera App
"Microsoft.OneConnect" # Microsoft OneConnect
"Microsoft.Office.OneNote" # Microsoft OneNote
"Microsoft.WindowsStore" # Store App
"Microsoft.XboxGameOverlay" # Microsoft Xbox Game Overlay
"Microsoft.Windows.Photos" # Photos app
"Microsoft.MSPaint" # Microsoft Paint 
"Microsoft.Windows.ContentDeliveryManager" # Windows Spotlight & Dynamic Content
"Microsoft.WindowsSoundRecorder" # Microsoft Sound Recorder
"Microsoft.BingWeather" # Bing Weather App
"Microsoft.Advertising.Xaml" # Microsoft Advertisement App
"Microsoft.ZuneMusic" # Music App
"Microsoft.WindowsCalculator" # Calculator App
"Microsoft.WindowsAlarms" # Alarms App
"Microsoft.Microsoft3DViewer" # Microsoft 3D Viewer
"Microsoft.ZuneVideo" # Video App
"Microsoft.WindowsFeedbackHub" # Feedback App
"Microsoft.StorePurchaseApp" # Microsoft Store Purchase
"Microsoft.MicrosoftStickyNotes" # Microsoft Sticky Notes
"Microsoft.Wallet" # Microsoft Wallet
"Microsoft.MicrosoftEdge" # Microsoft Edge
"Microsoft.Windows.Cortana" # Cortana App

ForEach ($App in $AppsList)
{
$Packages = Get-AppxPackage | Where-Object {$_.Name -eq $App}
if ($Packages -ne $null)
{
"Removing Appx Package: $App"
foreach ($Package in $Packages) { Remove-AppxPackage -package $Package.PackageFullName }
}
else { "Unable to find package: $App" }

$ProvisionedPackage = Get-AppxProvisionedPackage -online | Where-Object {$_.displayName -eq $App}
if ($ProvisionedPackage -ne $null)
{
"Removing Appx Provisioned Package: $App"
remove-AppxProvisionedPackage -online -packagename $ProvisionedPackage.PackageName
}
else { "Unable to find provisioned package: $App" }
}
$progressPreference = 'silentlyContinue'
Write-Information "Downloading WinGet and its dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx -OutFile Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

winget install Microsoft.WindowsTerminal
