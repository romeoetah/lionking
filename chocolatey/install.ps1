
$VerbosePreference = 'Continue'

$ScriptPath = split-path -parent $MyInvocation.MyCommand.Definition
If (Get-ChildItem -Path "$ScriptPath/packages.config")
{
    
    Write-Verbose -Message "Using package configuration from local Git repository."
    Invoke-Expression -Command "choco install -y $ScriptPath/packages.config"
}
Else
{
    Write-Verbose -Message "Using package configuration from remote Git repository."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/fjudith/windows-devops-tools/main/chocolatey/packages.config" -OutFile "$env:TEMP\packages.config"
    Invoke-Expression -Command "choco install -y $env:TEMP\packages.config"
}
