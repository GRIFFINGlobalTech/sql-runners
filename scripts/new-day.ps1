<#
.SYNOPSIS
  Scaffolds a day of SQL practice: a dated folder, 6 question files (2 easy, 2 medium, 2 hard)
  and a git branch named after the date. Then rebuilds the READMEs via build-index.ps1.

  Pass -Questions with up to 6 HackerRank links (or slugs) in slot order:
  easy, easy, medium, medium, hard, hard. The files are named and titled from the slug.
  Leave it out to get placeholder files you rename later.
  Slots that already have a file (NN-*.md) are left untouched, so re-running is safe.

.EXAMPLE
  .\scripts\new-day.ps1                    # today, placeholder files
  .\scripts\new-day.ps1 -Date 2026-10-14   # a specific day
  .\scripts\new-day.ps1 -NoBranch          # folder only, stay on current branch
  .\scripts\new-day.ps1 -Questions `
      https://www.hackerrank.com/challenges/revising-the-select-query/problem, `
      japanese-cities-attributes, `
      the-blunder, binary-search-tree-1, `
      challenges, contest-leaderboard
#>
param(
    [string]$Date = (Get-Date -Format 'yyyy-MM-dd'),
    [string[]]$Questions = @(),
    [switch]$NoBranch
)

$ErrorActionPreference = 'Stop'

if ($Date -notmatch '^\d{4}-\d{2}-\d{2}$') { throw "Date must be yyyy-MM-dd, got '$Date'" }
if ($Questions.Count -gt 6) { throw "At most 6 questions (2 easy, 2 medium, 2 hard), got $($Questions.Count)" }

$root     = Split-Path -Parent $PSScriptRoot
$template = Get-Content (Join-Path $root 'templates\question.md') -Raw
$dayDir   = Join-Path $root "days\$Date"
$utf8     = New-Object System.Text.UTF8Encoding($false)
$textInfo = (Get-Culture).TextInfo

if (-not $NoBranch) {
    Push-Location $root
    try {
        git rev-parse --verify --quiet "refs/heads/$Date" | Out-Null
        if ($LASTEXITCODE -eq 0) { git checkout $Date } else { git checkout -b $Date main }
    } finally { Pop-Location }
}

New-Item -ItemType Directory -Force $dayDir | Out-Null

$slots = @(
    @{ N = '01'; D = 'Easy'   }, @{ N = '02'; D = 'Easy'   },
    @{ N = '03'; D = 'Medium' }, @{ N = '04'; D = 'Medium' },
    @{ N = '05'; D = 'Hard'   }, @{ N = '06'; D = 'Hard'   }
)

for ($i = 0; $i -lt $slots.Count; $i++) {
    $s = $slots[$i]
    if (Get-ChildItem $dayDir -Filter "$($s.N)-*.md") {
        Write-Host "  $($s.N) exists, skipping"
        continue
    }

    if ($i -lt $Questions.Count) {
        # Accept a full URL (.../challenges/<slug>/problem) or a bare slug.
        $q    = $Questions[$i].Trim()
        $slug = if ($q -match '/challenges/([^/?#]+)') { $Matches[1] } else { $q.Trim('/') }
        $title = $textInfo.ToTitleCase(($slug -replace '-', ' '))
        $link  = "https://www.hackerrank.com/challenges/$slug/problem"
    } else {
        $slug  = 'question'
        $title = "Question $($s.N)"
        $link  = 'https://www.hackerrank.com/domains/sql'
    }

    $file = "$($s.N)-$($s.D.ToLower())-$slug.md"
    $body = $template.Replace('{{TITLE}}', $title).Replace('{{DATE}}', $Date)
    $body = $body.Replace('{{DIFFICULTY}}', $s.D).Replace('{{LINK}}', $link)
    [IO.File]::WriteAllText((Join-Path $dayDir $file), $body, $utf8)
    Write-Host "  created $file"
}

& (Join-Path $PSScriptRoot 'build-index.ps1')
Write-Host "Ready: $dayDir"
