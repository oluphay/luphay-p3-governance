[CmdletBinding()]
param(
    [string]$RepoRoot = (Get-Location).Path
)

$ErrorActionPreference = "Stop"

function Convert-FromSimpleYaml {
    param([string]$Text)

    if (Get-Command ConvertFrom-Yaml -ErrorAction SilentlyContinue) {
        return ($Text | ConvertFrom-Yaml)
    }

    $result = @{}
    $currentList = $null

    foreach ($rawLine in ($Text -split "`r?`n")) {
        $line = $rawLine.TrimEnd()

        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        if ($line.TrimStart().StartsWith("#")) { continue }

        if ($line -match '^\s*-\s*(.+)$' -and $null -ne $currentList) {
            $result[$currentList] += @($Matches[1].Trim())
            continue
        }

        if ($line -match '^([A-Za-z0-9_\-]+):\s*(.*)$') {
            $key = $Matches[1]
            $value = $Matches[2]

            if ($value -eq "[]") {
                $result[$key] = @()
                $currentList = $null
                continue
            }

            if ([string]::IsNullOrWhiteSpace($value)) {
                $result[$key] = @()
                $currentList = $key
                continue
            }

            $trimmed = $value.Trim()
            if ($trimmed -match '^(true|false)$') {
                $result[$key] = [bool]::Parse($trimmed)
            } else {
                $result[$key] = $trimmed.Trim("'`"")
            }
            $currentList = $null
        }
    }

    return [pscustomobject]$result
}

function Read-YamlObject {
    param([string]$PathValue)
    $raw = Get-Content -LiteralPath $PathValue -Raw
    return Convert-FromSimpleYaml -Text $raw
}

function Write-JsonFile {
    param(
        [string]$PathValue,
        [object]$Data
    )
    $json = $Data | ConvertTo-Json -Depth 100
    Set-Content -LiteralPath $PathValue -Value $json -Encoding UTF8
}

function Read-MarkdownFrontMatter {
    param([string]$PathValue)

    $raw = Get-Content -LiteralPath $PathValue -Raw
    if ($raw -notmatch '(?s)^---\s*(.*?)\s*---') {
        return $null
    }

    $frontMatter = $Matches[1]
    return Convert-FromSimpleYaml -Text $frontMatter
}

Set-Location -LiteralPath $RepoRoot

$stateRoot = Join-Path $RepoRoot "06_state"
$registersRoot = Join-Path $stateRoot "registers"
$graphRoot = Join-Path $stateRoot "graph"

$entityFiles = Get-ChildItem -LiteralPath $RepoRoot -Recurse -Filter "entity.yaml" -File
$packetFiles = Get-ChildItem -LiteralPath $RepoRoot -Recurse -Filter "packet.yaml" -File
$decisionFiles = Get-ChildItem -LiteralPath $RepoRoot -Recurse -Include "ADR-ARCH-*.md","ADR-DECN-*.md" -File

$portfolios = @()
$programs = @()
$projects = @()
$tasks = @()
$nodes = @()
$edges = @()
$decisions = @()

foreach ($file in $entityFiles) {
    $entity = Read-YamlObject -PathValue $file.FullName
    $relativePath = Resolve-Path -LiteralPath $file.Directory.FullName -Relative
    $node = [ordered]@{
        id = $entity.id
        type = $entity.object_type
        path = $relativePath.TrimStart('.','\','/')
    }
    $nodes += [pscustomobject]$node

    switch ($entity.object_type) {
        "portfolio" { $portfolios += $entity }
        "program" {
            $programs += $entity
            if ($entity.parent_id) {
                $edges += [pscustomobject]@{ source = $entity.parent_id; target = $entity.id; relation = "contains" }
            }
        }
        "project" {
            $projects += $entity
            if ($entity.parent_id) {
                $edges += [pscustomobject]@{ source = $entity.parent_id; target = $entity.id; relation = "contains" }
            }
        }
    }
}

foreach ($file in $packetFiles) {
    $packet = Read-YamlObject -PathValue $file.FullName
    $relativePath = Resolve-Path -LiteralPath $file.Directory.FullName -Relative
    $tasks += $packet
    $nodes += [pscustomobject]@{
        id = $packet.id
        type = $packet.object_type
        path = $relativePath.TrimStart('.','\','/')
    }
    if ($packet.parent_id) {
        $edges += [pscustomobject]@{ source = $packet.parent_id; target = $packet.id; relation = "contains" }
    }
}

foreach ($file in $decisionFiles) {
    $meta = Read-MarkdownFrontMatter -PathValue $file.FullName
    if ($null -eq $meta) { continue }
    $decisions += [pscustomobject]@{
        id = $meta.id
        family = $meta.family
        version = $meta.version
        scope_level = $meta.scope_level
        status = $meta.status
        title = ($file.BaseName -replace '^[A-Z0-9\-]+__','' -replace '__v\d+\.\d+$','' -replace '-',' ')
        path = (Resolve-Path -LiteralPath $file.FullName -Relative).TrimStart('.','\','/')
    }
}

Write-JsonFile -PathValue (Join-Path $registersRoot "portfolio-register.json") -Data ([ordered]@{
    register = "portfolio-register"
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    items = $portfolios
})

Write-JsonFile -PathValue (Join-Path $registersRoot "program-register.json") -Data ([ordered]@{
    register = "program-register"
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    items = $programs
})

Write-JsonFile -PathValue (Join-Path $registersRoot "project-register.json") -Data ([ordered]@{
    register = "project-register"
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    items = $projects
})

Write-JsonFile -PathValue (Join-Path $registersRoot "task-register.json") -Data ([ordered]@{
    register = "task-register"
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    items = $tasks
})

Write-JsonFile -PathValue (Join-Path $registersRoot "decision-register.json") -Data ([ordered]@{
    register = "decision-register"
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    items = $decisions | Sort-Object id
})

$artifactInputPath = Join-Path $stateRoot "inputs/artifact-register.yaml"
$artifactInput = Read-YamlObject -PathValue $artifactInputPath
$artifactItems = @()
if ($artifactInput.items) {
    $artifactItems = $artifactInput.items
}
Write-JsonFile -PathValue (Join-Path $registersRoot "artifact-register.json") -Data ([ordered]@{
    register = "artifact-register"
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    items = $artifactItems
})

Write-JsonFile -PathValue (Join-Path $graphRoot "dependency-graph.json") -Data ([ordered]@{
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    nodes = $nodes
    edges = $edges
})

$auditPath = Join-Path $stateRoot "audit/.gitkeep"
if (-not (Test-Path -LiteralPath $auditPath)) {
    New-Item -ItemType File -Path $auditPath | Out-Null
}

Write-Host "State rebuild complete."
