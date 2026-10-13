<#
.SYNOPSIS
  Rebuilds every days/<date>/README.md and the Log table in the root README.md
  from the question files themselves (title, difficulty, link, status).

  Run it any time you add, rename, or mark a question solved.
  A question counts as solved when its Status row reads "[x] ...".

.EXAMPLE
  .\scripts\build-index.ps1
#>
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)   # no BOM, so GitHub renders cleanly

function Read-Question([System.IO.FileInfo]$file) {
    $text   = [IO.File]::ReadAllText($file.FullName)
    $title  = if ($text -match '(?m)^#\s+(.+?)\s*$') { $Matches[1] } else { $file.BaseName }
    $diff   = if ($text -match '(?m)^\|\s*Difficulty\s*\|\s*(.+?)\s*\|') { $Matches[1] } else { '?' }
    $link   = if ($text -match '(?m)^\|\s*Link\s*\|\s*\[[^\]]*\]\(([^)]+)\)') { $Matches[1] } else { '' }
    $solved = $text -match '(?m)^\|\s*Status\s*\|\s*\[[xX]\]'
    [pscustomobject]@{
        N = $file.Name.Substring(0, 2); File = $file.Name; Title = $title
        Difficulty = $diff; Link = $link; Solved = $solved
    }
}

$logRows = @()
$days = Get-ChildItem (Join-Path $root 'days') -Directory |
        Where-Object { $_.Name -match '^\d{4}-\d{2}-\d{2}$' } | Sort-Object Name

foreach ($day in $days) {
    $qs = @(Get-ChildItem $day.FullName -Filter '*.md' |
            Where-Object { $_.Name -match '^\d{2}-' } | Sort-Object Name |
            ForEach-Object { Read-Question $_ })

    $rows = foreach ($q in $qs) {
        $mark = if ($q.Solved) { '[x]' } else { '[ ]' }
        "| $($q.N) | $($q.Difficulty) | [$($q.Title)]($($q.File)) | [HackerRank]($($q.Link)) | $mark |"
    }
    $solvedCount = @($qs | Where-Object Solved).Count

    $readme = @"
# SQL Runner - $($day.Name)

Solved: **$solvedCount / $($qs.Count)**

| # | Difficulty | Question | Link | Solved |
|---|------------|----------|------|--------|
$($rows -join "`n")
"@
    [IO.File]::WriteAllText((Join-Path $day.FullName 'README.md'), $readme + "`n", $utf8)

    $byDiff = { param($d) (@($qs | Where-Object Difficulty -eq $d | ForEach-Object Title)) -join ', ' }
    $logRows += "| [$($day.Name)](days/$($day.Name)) | [``$($day.Name)``](../../tree/$($day.Name)/days/$($day.Name)) | " +
                "$(& $byDiff 'Easy') | $(& $byDiff 'Medium') | $(& $byDiff 'Hard') | $solvedCount/$($qs.Count) |"
}

# Replace everything between the LOG markers in the root README.
$rootReadme = Join-Path $root 'README.md'
$text = [IO.File]::ReadAllText($rootReadme)
$table = @"
<!-- LOG:START -->
| Date | Branch | Easy | Medium | Hard | Solved |
|------|--------|------|--------|------|--------|
$($logRows -join "`n")
<!-- LOG:END -->
"@
if ($text -notmatch '(?s)<!-- LOG:START -->.*<!-- LOG:END -->') {
    throw "Root README.md is missing the <!-- LOG:START --> / <!-- LOG:END --> markers."
}
$text = [regex]::Replace($text, '(?s)<!-- LOG:START -->.*<!-- LOG:END -->', { param($m) $table })
[IO.File]::WriteAllText($rootReadme, $text, $utf8)

Write-Host "Indexed $($days.Count) day(s)."
