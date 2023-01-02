# Configuration Powershell
Import-Module posh-git
Import-Module oh-my-posh

 Set-PSFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
# Load prompt config
function Get-ScriptDirectoty { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-path (Get-ScriptDirectoty) 'blake.omp.json'
oh-my-posh --init --shell pwsh --config  $PROMPT_CONFIG | Invoke-Expression
Import-Module -Name Terminal-Icons

function gitstatuscommand {
  git status
}

# Alias
Set-Alias -Name v -Value nvim
Set-Alias -Name vim -Value nvim
Set-Alias gs gitstatuscommand
Set-Alias ll ls
Set-Alias lg lazygit
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
# PSReadLine
# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History


# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
