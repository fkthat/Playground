[CmdletBinding()]
param(
    [Parameter(Position = 0, Mandatory = $true)]
    [ValidateSet('start', 'kill')]
    $Cmd,
    [Parameter(Position = 2, Mandatory = $false)]
    [string]
    $Name
)

Push-Location $PSScriptRoot

try {
    $exeError = "Terminated due to the failure"

    # Dirty files
    $dirty = @()
    $dirty += &{ git ls-files -o --exclude-standard }
    $dirty += &{ git diff-index --name-only HEAD }

    if($dirty) {
        throw "The folder is not clean. Commit, revert, or stash changes first."
    }

    switch($Cmd) {
        'start' {
            if(-not $Name) {
                throw 'The $Name parameter is missing.'
            }

            # create the feature/etc branch and set tracking
            git checkout develop && `
                git checkout -b $Name && `
                git push -u origin $Name || `
                &{ throw $exeError }
        }
        'kill' {
            if(-not $Name) {
                $Name = git branch --show-current && `
                    &{ throw $exeError }
            }

            if($Name -eq 'develop'){
                throw 'Cannot kill develop branch.'
            }

            git checkout develop &&
                git branch -d $Name &&
                git push -d origin $Name ||
                &{ throw $exeError }
        }
    }
}
catch {
    Write-Error $_
}
finally {
    Pop-Location
}
