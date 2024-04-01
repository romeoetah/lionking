$VerbosePreference = 'Continue'

$ScriptPath = split-path -parent $MyInvocation.MyCommand.Definition
If (Get-ChildItem -Path "$ScriptPath/extensions.txt")
{
    
    Write-Verbose -Message "Using Visual Studio Code extentions list from local Git repository."
    
    Get-Content -Path "$ScriptPath\extensions.txt" | ForEach-Object {
        Invoke-Expression -Command "code --force --install-extension $_"
    }
}
Else
{
    Write-Verbose -Message "Using Visual Studio Code extentions list from remote Git repository."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/fjudith/windows-devops-tools/main/visual-studio-code/extensions.txt" -OutFile "$env:TEMP\extensions.txt"

    Get-Content -Path "$env:TEMP\extensions.txt" | ForEach-Object {
        Invoke-Expression -Command "code --force --install-extension $_"
    }
}