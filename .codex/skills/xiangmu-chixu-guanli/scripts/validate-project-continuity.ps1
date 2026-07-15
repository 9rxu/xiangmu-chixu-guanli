[CmdletBinding(DefaultParameterSetName = 'Project')]
param(
    [Parameter(ParameterSetName = 'Project')]
    [string]$ProjectRoot = '.',

    [Parameter(Mandatory = $true, ParameterSetName = 'Skill')]
    [string]$SkillRoot
)

$ErrorActionPreference = 'Stop'
$errors = [System.Collections.Generic.List[string]]::new()

function Add-MissingFileError {
    param([string]$Base, [string[]]$RelativePaths)
    foreach ($relativePath in $RelativePaths) {
        $path = Join-Path $Base $relativePath
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
            $errors.Add("Missing file: $relativePath")
        }
    }
}

if ($PSCmdlet.ParameterSetName -eq 'Skill') {
    $root = (Resolve-Path -LiteralPath $SkillRoot).Path
    Add-MissingFileError -Base $root -RelativePaths @(
        'SKILL.md',
        'agents/openai.yaml',
        'references/repository-creation.md',
        'references/project-continuity.md',
        'assets/AGENTS.template.md',
        'assets/PROJECT_MEMORY.template.md',
        'assets/PLANS.template.md',
        'assets/CHANGELOG.template.md',
        'assets/README.template.md',
        'scripts/validate-project-continuity.ps1'
    )

    $skillFile = Join-Path $root 'SKILL.md'
    if (Test-Path -LiteralPath $skillFile) {
        $skillText = Get-Content -Raw -Encoding UTF8 -LiteralPath $skillFile
        if ($skillText -notmatch '(?m)^name:\s+xiangmu-chixu-guanli\s*$') {
            $errors.Add('Invalid name in SKILL.md.')
        }
        if ($skillText -match '\[TODO') {
            $errors.Add('SKILL.md still contains a TODO placeholder.')
        }
    }
} else {
    $root = (Resolve-Path -LiteralPath $ProjectRoot).Path
    Add-MissingFileError -Base $root -RelativePaths @(
        'README.md',
        'AGENTS.md',
        'PROJECT_MEMORY.md',
        'PLANS.md',
        'CHANGELOG.md',
        '.gitignore',
        '.codex/skills/xiangmu-chixu-guanli/SKILL.md'
    )

    foreach ($relativePath in @('README.md', 'AGENTS.md', 'PROJECT_MEMORY.md', 'PLANS.md', 'CHANGELOG.md')) {
        $path = Join-Path $root $relativePath
        if (Test-Path -LiteralPath $path) {
            $text = Get-Content -Raw -Encoding UTF8 -LiteralPath $path
            if ($text -match '\{\{[^}]+\}\}') {
                $errors.Add("Template placeholder remains in: $relativePath")
            }
        }
    }

    if (-not (Test-Path -LiteralPath (Join-Path $root '.git') -PathType Container)) {
        $errors.Add('Project root is not a Git repository.')
    }
}

if ($errors.Count -gt 0) {
    [pscustomobject]@{ ok = $false; root = $root; errors = $errors } | ConvertTo-Json -Depth 4
    exit 1
}

[pscustomobject]@{ ok = $true; root = $root; mode = $PSCmdlet.ParameterSetName } | ConvertTo-Json -Depth 3
