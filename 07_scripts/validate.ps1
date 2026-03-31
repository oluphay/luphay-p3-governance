[CmdletBinding()]
param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

function Test-RequiredPath {
    param([string]$PathValue)
    if (-not (Test-Path -LiteralPath $PathValue)) {
        throw "Missing required path: $PathValue"
    }
}

function Get-ChildDirectoriesSafe {
    param([string]$PathValue)
    if (Test-Path -LiteralPath $PathValue) {
        return Get-ChildItem -LiteralPath $PathValue -Directory -ErrorAction SilentlyContinue
    }
    return @()
}

Set-Location -LiteralPath $RepoRoot

$requiredPaths = @(
    "README.md",
    "START_HERE.md",
    "AGENTS.md",
    "CLAUDE.md",
    "01_governance",
    "02_templates",
    "03_portfolios",
    "04_docs",
    "05_hub",
    "06_state",
    "07_scripts",
    "08_command",
    "09_runs",
    "06_state/inputs",
    "06_state/registers",
    "06_state/graph",
    "06_state/audit"
)

foreach ($pathItem in $requiredPaths) {
    Test-RequiredPath -PathValue $pathItem
}

$portfolioHomes = Get-ChildDirectoriesSafe -PathValue "03_portfolios" | Where-Object { $_.Name -like "P3-PORT-*" }
foreach ($portfolioHome in $portfolioHomes) {
    Test-RequiredPath -PathValue (Join-Path $portfolioHome.FullName "entity.yaml")
    $programsRoot = Join-Path $portfolioHome.FullName "programs"
    Test-RequiredPath -PathValue $programsRoot

    $programHomes = Get-ChildDirectoriesSafe -PathValue $programsRoot | Where-Object { $_.Name -like "P3-PROG-*" }
    foreach ($programHome in $programHomes) {
        Test-RequiredPath -PathValue (Join-Path $programHome.FullName "entity.yaml")
        $projectsRoot = Join-Path $programHome.FullName "projects"
        Test-RequiredPath -PathValue $projectsRoot

        $projectHomes = Get-ChildDirectoriesSafe -PathValue $projectsRoot | Where-Object { $_.Name -like "P3-PROJ-*" }
        foreach ($projectHome in $projectHomes) {
            Test-RequiredPath -PathValue (Join-Path $projectHome.FullName "entity.yaml")
            $taskRoot = Join-Path $projectHome.FullName "task-packets"
            Test-RequiredPath -PathValue $taskRoot

            $taskHomes = Get-ChildDirectoriesSafe -PathValue $taskRoot | Where-Object { $_.Name -like "TASK-*" }
            foreach ($taskHome in $taskHomes) {
                Test-RequiredPath -PathValue (Join-Path $taskHome.FullName "packet.yaml")
            }
        }
    }
}

Write-Host "Validation passed."
