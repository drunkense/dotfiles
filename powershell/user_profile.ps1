# Configuration Powershell
Import-Module posh-git
Import-Module oh-my-posh
Import-Module -Name Terminal-Icons

# Load prompt config
function Get-ScriptDirectoty { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-path (Get-ScriptDirectoty) 'blake.omp.json'
oh-my-posh --init --shell pwsh --config  $PROMPT_CONFIG | Invoke-Expression

function gitstatuscommand {
  git status
}

# Alias
Set-Alias -Name v -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias gs gitstatuscommand
Set-Alias ll ls
Set-Alias lg lazygit
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
# PSReadLine
Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView


# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
