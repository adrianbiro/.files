wmic diskdrive list brief
wsl --mount \\.\PHYSICALDRIVE1
wsl.exe --shoutdown
wsl --unmount \\.\PHYSICALDRIVE1


$modules = @("PSReadLine", "PSFzf", "posh-git")

foreach ($mod in $modules)
{
    Install-Module -Name $mod -Repository PSGallery -Force
}
