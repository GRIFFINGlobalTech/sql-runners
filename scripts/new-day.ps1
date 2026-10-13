<#
.SYNOPSIS
  Scaffolds a day of SQL practice: a dated folder, 6 question files (2 easy, 2 medium, 2 hard)
  and a git branch named after the date.

.EXAMPLE
  .\scripts\new-day.ps1                    # today
  .\scripts\new-day.ps1 -Date 2026-10-14   # a specific day
  .\scripts\new-day.ps1 -NoBranch          # folder only, stay on current branch
#>
param(
    [string]$Date = (Get-Date -Format 'yyyy-MM-dd'),
    [switch]$NoBranch
)

$ErrorActionPreference = 'Stop'

if ($Date -notmatch '^\d{4}-\d{2}-\d{2}$') { throw "Date must be yyyy-MM-dd, got '$Date'" }

$root     = Split-Path -Parent $PSScriptRoot
$template = Get-Content (Join-Path $root 'templates\question.md') -Raw
$dayDir   = Join-Path $root "days\$Date"

if (-not $NoBranch) {
    Push-Location $root
    try {
        git rev-parse --verify --quiet "refs/heads/$Date" | Out-Null
        if ($LASTEXITCODE -eq 0) { git checkout $Date } else { git checkout -b $Date main }
    } finally { Pop-Location }
}

if (Test-Path $dayDir) {
    Write-Host "Folder already exists: $dayDir (leaving it untouched)"
    return
}
New-Item -ItemType Directory -Force $dayDir | Out-Null

$slots = @(
    @{ N = '01'; D = 'Easy'   }, @{ N = '02'; D = 'Easy'   },
    @{ N = '03'; D = 'Medium' }, @{ N = '04'; D = 'Medium' },
    @{ N = '05'; D = 'Hard'   }, @{ N = '06'; D = 'Hard'   }
)

$rows = foreach ($s in $slots) {
    $file = "$($s.N)-$($s.D.ToLower())-question.md"
    $body = $template.Replace('{{TITLE}}', "Question $($s.N)")
    $body = $body.Replace('{{DATE}}', $Date).Replace('{{DIFFICULTY}}', $s.D)
    $body = $body.Replace('{{LINK}}', 'https://www.hackerrank.com/domains/sql')
    Set-Content -Path (Join-Path $dayDir $file) -Value $body -Encoding utf8
    "| $($s.N) | $($s.D) | [Question $($s.N)]($file) | [HackerRank](https://www.hackerrank.com/domains/sql) | [ ] |"
}

$readme = @"
# SQL Runner - $Date

| # | Difficulty | Question | Link | Solved |
|---|------------|----------|------|--------|
$($rows -join "`n")
"@
Set-Content -Path (Join-Path $dayDir 'README.md') -Value $readme -Encoding utf8

Write-Host "Created $dayDir"
Write-Host "Rename each NN-<difficulty>-question.md to the real slug once you pick the question."
