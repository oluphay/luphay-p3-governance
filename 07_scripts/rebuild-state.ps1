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
    $raw = Get-Content -LiteralPath (Resolve-LongPath -PathValue $PathValue) -Raw
    return Convert-FromSimpleYaml -Text $raw
}

function Write-JsonFile {
    param(
        [string]$PathValue,
        [object]$Data
    )
    $json = $Data | ConvertTo-Json -Depth 100
    Set-Content -LiteralPath (Resolve-LongPath -PathValue $PathValue) -Value $json -Encoding UTF8
}

function Resolve-LongPath {
    param([string]$PathValue)

    if ($PathValue -like '\\?\*') {
        return $PathValue
    }

    return "\\?\$PathValue"
}

function Read-MarkdownFrontMatter {
    param([string]$PathValue)

    $raw = Get-Content -LiteralPath (Resolve-LongPath -PathValue $PathValue) -Raw
    if ($raw -notmatch '(?s)^---\s*(.*?)\s*---') {
        return $null
    }

    $frontMatter = $Matches[1]
    return Convert-FromSimpleYaml -Text $frontMatter
}

function Get-DateOnly {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return $null
    }

    if ($Value -match '^\d{4}-\d{2}-\d{2}$') {
        return $Value
    }

    if ($Value -match '^(\d{4}-\d{2}-\d{2})T') {
        return $Matches[1]
    }

    return $Value
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
    $normalizedPath = $relativePath.TrimStart('.','\','/')

    $nodes += [pscustomobject]@{
        id = $entity.id
        type = $entity.object_type
        path = $normalizedPath
    }

    switch ($entity.object_type) {
        "portfolio" {
            $portfolios += $entity
        }
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
    $normalizedPath = $relativePath.TrimStart('.','\','/')
    $folderName = $file.Directory.Name
    $slug = if ($packet.slug) { $packet.slug } elseif ($folderName -match '^[A-Z0-9\-]+__(.+)$') { $Matches[1] } else { $null }
    $primaryDoc = @(Get-ChildItem -LiteralPath $file.Directory.FullName -Filter "TASK-*.md" -File -ErrorAction SilentlyContinue | Select-Object -First 1)
    $outputFiles = [object[]]@()
    $outputsPath = Join-Path $file.Directory.FullName "outputs"
    if (Test-Path -LiteralPath $outputsPath) {
        $outputFiles = [object[]]@(Get-ChildItem -LiteralPath $outputsPath -File -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne "README.md" } | Select-Object -ExpandProperty Name)
    }
    $parentProject = if ($packet.parent_project) { $packet.parent_project } elseif ($packet.parent_id) { $packet.parent_id } else { $null }
    $dependencies = if ($null -ne $packet.depends_on) { [object[]]@($packet.depends_on) } elseif ($null -ne $packet.dependencies) { [object[]]@($packet.dependencies) } else { [object[]]@() }
    $createdOn = if ($packet.created_at) { Get-DateOnly -Value $packet.created_at } elseif ($packet.created_on) { Get-DateOnly -Value $packet.created_on } else { (Get-Date -Format "yyyy-MM-dd") }
    $updatedOn = if ($packet.last_updated) { Get-DateOnly -Value $packet.last_updated } elseif ($packet.completed_at) { Get-DateOnly -Value $packet.completed_at } elseif ($packet.created_at) { Get-DateOnly -Value $packet.created_at } else { $createdOn }

    $taskItem = [ordered]@{
        id = $packet.id
        packet_class = $packet.packet_class
        object_type = if ($packet.object_type) { $packet.object_type } else { "task-packet" }
        title = $packet.title
        slug = $slug
        version = $packet.version
        status = $packet.status
        owner = $packet.owner
        priority = $packet.priority
        active_assignee = $packet.active_assignee
        validation_status = $packet.validation_status
        path = $normalizedPath
        primary_doc = if ($primaryDoc.Count -gt 0) { $primaryDoc[0].Name } else { $null }
        parent_id = $parentProject
        parent_portfolio = $packet.parent_portfolio
        parent_program = $packet.parent_program
        created_on = $createdOn
        updated_on = $updatedOn
        labels = if ($null -ne $packet.labels) { [object[]]@($packet.labels) } else { [object[]]@() }
        assignees = if ([string]::IsNullOrWhiteSpace([string]$packet.active_assignee)) { [object[]]@("unassigned") } else { [object[]]@($packet.active_assignee) }
        dependencies = $dependencies
        deliverables = $outputFiles
    }

    $tasks += [pscustomobject]$taskItem

    $nodes += [pscustomobject]@{
        id = $packet.id
        type = if ($packet.object_type) { $packet.object_type } else { "task-packet" }
        path = $normalizedPath
    }

    if ($parentProject) {
        $edges += [pscustomobject]@{ source = $parentProject; target = $packet.id; relation = "contains" }
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

Write-JsonFile -PathValue (Join-Path $registersRoot "decision-register.json") -Data ([ordered]@{
    register = "decision-register"
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    items = $decisions | Sort-Object id
})

Write-JsonFile -PathValue (Join-Path $graphRoot "dependency-graph.json") -Data ([ordered]@{
    generated_on = (Get-Date -Format "yyyy-MM-dd")
    nodes = $nodes
    edges = $edges
})

$auditPath = Join-Path $stateRoot "audit/.gitkeep"
if (-not (Test-Path -LiteralPath $auditPath)) {
    New-Item -ItemType File -Path (Resolve-LongPath -PathValue $auditPath) | Out-Null
}

Write-Host "State rebuild complete."
