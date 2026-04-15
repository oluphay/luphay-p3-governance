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

function Resolve-LongPath {
    param([string]$PathValue)

    if ($PathValue -like '\\?\*') {
        return $PathValue
    }

    return "\\?\$PathValue"
}

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

            $result[$key] = $value.Trim().Trim("'`"")
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

function Get-NormalizedRelativePath {
    param([string]$PathValue)

    $relative = Resolve-Path -LiteralPath $PathValue -Relative
    return ($relative.TrimStart('.','\','/') -replace '\\','/')
}

function Test-PlaceholderText {
    param([string]$TextValue)

    $patterns = @(
        'Human Friendly Title',
        '\[placeholder',
        '\bTBD\b',
        'replace with real'
    )

    foreach ($pattern in $patterns) {
        if ($TextValue -match $pattern) {
            return $true
        }
    }

    return $false
}

function Test-EntityHome {
    param(
        [string]$HomePath,
        [string]$ExpectedObjectType,
        [string]$PrimaryDocPattern,
        [string[]]$RequiredSubdirectories,
        [string[]]$RequiredDocStubs,
        [string[]]$RequiredFields,
        [string[]]$RequiredNonEmptyFields,
        [string[]]$AllowedStatuses
    )

    $entityYamlPath = Join-Path $HomePath "entity.yaml"
    Test-RequiredPath -PathValue $entityYamlPath

    $entity = Read-YamlObject -PathValue $entityYamlPath
    $labels = @()
    if ($entity.labels) { $labels = @($entity.labels) }
    $isExample = $labels -contains "example"

    $primaryDocs = @(Get-ChildItem -LiteralPath $HomePath -Filter $PrimaryDocPattern -File -ErrorAction SilentlyContinue)
    if ($primaryDocs.Count -ne 1) {
        throw "Entity home '$HomePath' must contain exactly one primary document matching '$PrimaryDocPattern'."
    }

    foreach ($subdir in $RequiredSubdirectories) {
        Test-RequiredPath -PathValue (Join-Path $HomePath $subdir)
    }

    foreach ($docStub in $RequiredDocStubs) {
        Test-RequiredPath -PathValue (Join-Path $HomePath ("docs/" + $docStub))
    }

    foreach ($field in $RequiredFields) {
        $property = $entity.PSObject.Properties[$field]
        if ($null -eq $property) {
            throw "Entity home '$HomePath' is missing required field '$field' in entity.yaml."
        }
    }

    foreach ($field in $RequiredNonEmptyFields) {
        $value = [string]$entity.$field
        if ([string]::IsNullOrWhiteSpace($value)) {
            throw "Entity home '$HomePath' has empty required field '$field' in entity.yaml."
        }
    }

    if ([string]$entity.object_type -ne $ExpectedObjectType) {
        throw "Entity home '$HomePath' has object_type '$($entity.object_type)' but expected '$ExpectedObjectType'."
    }

    if (-not $isExample -and $AllowedStatuses -notcontains [string]$entity.status) {
        throw "Entity home '$HomePath' has invalid status '$($entity.status)' for object type '$ExpectedObjectType'."
    }

    $expectedPrimaryDoc = $primaryDocs[0].Name
    if ([string]$entity.primary_doc -ne $expectedPrimaryDoc) {
        throw "Entity home '$HomePath' has primary_doc '$($entity.primary_doc)' but expected '$expectedPrimaryDoc'."
    }

    $expectedPath = Get-NormalizedRelativePath -PathValue $HomePath
    if ([string]$entity.path -ne $expectedPath) {
        throw "Entity home '$HomePath' has path '$($entity.path)' but expected '$expectedPath'."
    }

    if (-not $isExample) {
        $entityYamlRaw = Get-Content -LiteralPath (Resolve-LongPath -PathValue $entityYamlPath) -Raw
        $primaryDocRaw = Get-Content -LiteralPath (Resolve-LongPath -PathValue $primaryDocs[0].FullName) -Raw

        if (Test-PlaceholderText -TextValue $entityYamlRaw) {
            throw "Entity home '$HomePath' contains placeholder text in entity.yaml."
        }

        if (Test-PlaceholderText -TextValue $primaryDocRaw) {
            throw "Entity home '$HomePath' contains placeholder text in the primary governing file."
        }
    }
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

$requiredTemplatePaths = @(
    "02_templates/STD-TEMP-0001__task-packet-template__v0.1.md",
    "02_templates/STD-TEMP-0002__p3-project-template__v0.1.md",
    "02_templates/STD-TEMP-0003__p3-program-template__v0.1.md",
    "02_templates/STD-TEMP-0004__p3-portfolio-template__v0.1.md"
)

foreach ($templatePath in $requiredTemplatePaths) {
    Test-RequiredPath -PathValue $templatePath
}

$legacyTemplatePaths = @(
    "02_templates/entity-template-portfolio.yaml",
    "02_templates/entity-template-program.yaml",
    "02_templates/entity-template-project.yaml",
    "02_templates/packet-template.yaml"
)

foreach ($templatePath in $legacyTemplatePaths) {
    if (Test-Path -LiteralPath $templatePath) {
        throw "Legacy duplicate template file still present: $templatePath"
    }
}

$portfolioHomes = Get-ChildDirectoriesSafe -PathValue "03_portfolios" | Where-Object { $_.Name -like "P3-PORT-*" }
foreach ($portfolioHome in $portfolioHomes) {
    Test-EntityHome `
        -HomePath $portfolioHome.FullName `
        -ExpectedObjectType "portfolio" `
        -PrimaryDocPattern "P3-PORT-*.md" `
        -RequiredSubdirectories @("docs", "programs", "decisions") `
        -RequiredDocStubs @("overview.md", "scope.md", "roadmap.md", "governance.md", "dependencies.md", "risks.md", "notes.md") `
        -RequiredFields @("id", "object_type", "title", "slug", "version", "status", "owner", "path", "primary_doc", "created_on", "updated_on", "labels", "dependencies", "children") `
        -RequiredNonEmptyFields @("id", "object_type", "title", "slug", "version", "status", "owner", "path", "primary_doc", "created_on", "updated_on") `
        -AllowedStatuses @("draft", "active", "closing", "closed", "archived")

    $programsRoot = Join-Path $portfolioHome.FullName "programs"
    Test-RequiredPath -PathValue $programsRoot

    $programHomes = Get-ChildDirectoriesSafe -PathValue $programsRoot | Where-Object { $_.Name -like "P3-PROG-*" }
    foreach ($programHome in $programHomes) {
        Test-EntityHome `
            -HomePath $programHome.FullName `
            -ExpectedObjectType "program" `
            -PrimaryDocPattern "P3-PROG-*.md" `
            -RequiredSubdirectories @("docs", "projects", "decisions") `
            -RequiredDocStubs @("overview.md", "scope.md", "roadmap.md", "dependencies.md", "risks.md", "notes.md") `
            -RequiredFields @("id", "object_type", "title", "slug", "version", "status", "owner", "path", "primary_doc", "parent_id", "created_on", "updated_on", "labels", "dependencies", "children") `
            -RequiredNonEmptyFields @("id", "object_type", "title", "slug", "version", "status", "owner", "path", "primary_doc", "parent_id", "created_on", "updated_on") `
            -AllowedStatuses @("draft", "active", "closing", "closed", "archived")

        $projectsRoot = Join-Path $programHome.FullName "projects"
        Test-RequiredPath -PathValue $projectsRoot

        $projectHomes = Get-ChildDirectoriesSafe -PathValue $projectsRoot | Where-Object { $_.Name -like "P3-PROJ-*" }
        foreach ($projectHome in $projectHomes) {
            Test-EntityHome `
                -HomePath $projectHome.FullName `
                -ExpectedObjectType "project" `
                -PrimaryDocPattern "P3-PROJ-*.md" `
                -RequiredSubdirectories @("docs", "task-packets", "artifacts", "decisions", "links") `
                -RequiredDocStubs @("charter.md", "scope.md", "plan.md", "roadmap.md", "dependencies.md", "risks.md", "assumptions.md", "notes.md") `
                -RequiredFields @("id", "object_type", "title", "slug", "version", "status", "owner", "path", "primary_doc", "parent_id", "created_on", "updated_on", "labels", "dependencies", "children") `
                -RequiredNonEmptyFields @("id", "object_type", "title", "slug", "version", "status", "owner", "path", "primary_doc", "parent_id", "created_on", "updated_on") `
                -AllowedStatuses @("draft", "scoped", "active", "review", "closed", "archived")

            $taskRoot = Join-Path $projectHome.FullName "task-packets"
            Test-RequiredPath -PathValue $taskRoot

            $taskHomes = Get-ChildDirectoriesSafe -PathValue $taskRoot | Where-Object { $_.Name -like "TASK-*" }
            foreach ($taskHome in $taskHomes) {
                $packetYamlPath = Join-Path $taskHome.FullName "packet.yaml"
                Test-RequiredPath -PathValue $packetYamlPath

                $packet = Read-YamlObject -PathValue $packetYamlPath
                $labels = @()
                if ($packet.labels) { $labels = @($packet.labels) }
                $isExample = $labels -contains "example"

                if ($isExample) {
                    continue
                }

                $primaryTaskDocs = @(Get-ChildItem -LiteralPath $taskHome.FullName -Filter "TASK-*.md" -File -ErrorAction SilentlyContinue)
                if ($primaryTaskDocs.Count -ne 1) {
                    throw "Task packet '$($taskHome.FullName)' must contain exactly one primary TASK-*.md file."
                }

                foreach ($subdir in @("inputs", "outputs", "working", "evidence")) {
                    Test-RequiredPath -PathValue (Join-Path $taskHome.FullName $subdir)
                }

                $requiredPacketFields = @(
                    "id",
                    "object_type",
                    "title",
                    "slug",
                    "packet_class",
                    "packet_subtype",
                    "governance_mode",
                    "version",
                    "status",
                    "owner",
                    "priority",
                    "active_assignee",
                    "definition_of_done",
                    "validation_command",
                    "validation_status",
                    "handoff_note",
                    "created_by",
                    "created_at",
                    "last_updated",
                    "started_at",
                    "completed_at",
                    "parent_project",
                    "parent_program",
                    "parent_portfolio",
                    "labels",
                    "depends_on",
                    "blocks",
                    "notes"
                )

                foreach ($field in $requiredPacketFields) {
                    $property = $packet.PSObject.Properties[$field]
                    if ($null -eq $property) {
                        throw "Task packet '$($taskHome.FullName)' is missing required field '$field' in packet.yaml."
                    }
                }

                $requiredNonEmptyFields = @(
                    "id",
                    "title",
                    "slug",
                    "packet_class",
                    "packet_subtype",
                    "governance_mode",
                    "status",
                    "owner",
                    "priority",
                    "definition_of_done",
                    "validation_command",
                    "validation_status",
                    "handoff_note",
                    "parent_project",
                    "parent_program",
                    "parent_portfolio",
                    "created_by",
                    "created_at",
                    "last_updated"
                )

                foreach ($field in $requiredNonEmptyFields) {
                    $value = [string]$packet.$field
                    if ([string]::IsNullOrWhiteSpace($value)) {
                        throw "Task packet '$($taskHome.FullName)' has empty required field '$field' in packet.yaml."
                    }
                }

                if (@("active", "blocked", "in-review", "done") -contains [string]$packet.status) {
                    if ([string]::IsNullOrWhiteSpace([string]$packet.active_assignee)) {
                        throw "Task packet '$($taskHome.FullName)' requires active_assignee when status is '$($packet.status)'."
                    }
                    if ([string]::IsNullOrWhiteSpace([string]$packet.started_at)) {
                        throw "Task packet '$($taskHome.FullName)' requires started_at when status is '$($packet.status)'."
                    }
                }

                if ([string]$packet.status -eq "done" -and [string]::IsNullOrWhiteSpace([string]$packet.completed_at)) {
                    throw "Task packet '$($taskHome.FullName)' requires completed_at when status is 'done'."
                }

                if (@("NOW", "NEXT", "LATER") -notcontains [string]$packet.priority) {
                    throw "Task packet '$($taskHome.FullName)' has invalid priority '$($packet.priority)'."
                }

                if (@("draft", "ready", "active", "blocked", "in-review", "done", "returned") -notcontains [string]$packet.status) {
                    throw "Task packet '$($taskHome.FullName)' has invalid status '$($packet.status)'."
                }

                if (@("pending", "passed", "failed") -notcontains [string]$packet.validation_status) {
                    throw "Task packet '$($taskHome.FullName)' has invalid validation_status '$($packet.validation_status)'."
                }

                if (@("Lean", "Standard", "Assured") -notcontains [string]$packet.governance_mode) {
                    throw "Task packet '$($taskHome.FullName)' has invalid governance_mode '$($packet.governance_mode)'."
                }

                $packetYamlRaw = Get-Content -LiteralPath (Resolve-LongPath -PathValue $packetYamlPath) -Raw
                $primaryTaskDocRaw = Get-Content -LiteralPath (Resolve-LongPath -PathValue $primaryTaskDocs[0].FullName) -Raw

                if (Test-PlaceholderText -TextValue $packetYamlRaw) {
                    throw "Task packet '$($taskHome.FullName)' contains placeholder text in packet.yaml."
                }

                if (Test-PlaceholderText -TextValue $primaryTaskDocRaw) {
                    throw "Task packet '$($taskHome.FullName)' contains placeholder text in the primary task document."
                }

                $requiredSections = @(
                    "## Objective",
                    "## Scope",
                    "## Out of Scope",
                    "## Execution Notes",
                    "## Acceptance Criteria",
                    "## Validation",
                    "## Closeout / Handoff"
                )

                foreach ($section in $requiredSections) {
                    if ($primaryTaskDocRaw -notmatch [regex]::Escape($section)) {
                        throw "Task packet '$($taskHome.FullName)' is missing required section '$section'."
                    }
                }
            }
        }
    }
}

Write-Host "`n[validate] Entity and live task-packet contract checks passed." -ForegroundColor Green
Write-Host "Validation passed."
