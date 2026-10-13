<#
.SYNOPSIS
  Rebuilds every <date>/README.md (date folders sit at the repo root) and the Log table in the root README.md
  from the question files themselves (title, difficulty, link, status).

  Run it any time you add, rename, or change a question's status.
  Status is the value in the question's Status row: Passed, Failed or Pending.
  Anything unrecognised is treated as Pending.

.EXAMPLE
  .\scripts\build-index.ps1
#>
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$utf8 = New-Object System.Text.UTF8Encoding($false)   # no BOM, so GitHub renders cleanly

# Built from code points so the script stays ASCII (Windows PowerShell 5.1 reads BOM-less files as ANSI).
$badge = @{
    Passed  = [char]::ConvertFromUtf32(0x2705) + ' Passed'
    Failed  = [char]::ConvertFromUtf32(0x274C) + ' Failed'
    Pending = [char]::ConvertFromUtf32(0x23F3) + ' Pending'
}

function Read-Question([System.IO.FileInfo]$file) {
    $text   = [IO.File]::ReadAllText($file.FullName)
    $title  = if ($text -match '(?m)^#\s+(.+?)\s*$') { $Matches[1] } else { $file.BaseName }
    $diff   = if ($text -match '(?m)^\|\s*Difficulty\s*\|\s*(.+?)\s*\|') { $Matches[1] } else { '?' }
    $link   = if ($text -match '(?m)^\|\s*Link\s*\|\s*\[[^\]]*\]\(([^)]+)\)') { $Matches[1] } else { '' }
    $raw    = if ($text -match '(?m)^\|\s*Status\s*\|\s*(.+?)\s*\|') { $Matches[1] } else { '' }
    $status = switch -Regex ($raw) {
        'pass|\[[xX]\]' { 'Passed'; break }
        'fail'          { 'Failed'; break }
        default         { 'Pending' }
    }
    [pscustomobject]@{
        N = $file.Name.Substring(0, 2); File = $file.Name; Title = $title
        Difficulty = $diff; Link = $link; Status = $status
    }
}

$logRows = @()
$days = Get-ChildItem $root -Directory |
        Where-Object { $_.Name -match '^\d{4}-\d{2}-\d{2}$' } | Sort-Object Name

foreach ($day in $days) {
    $qs = @(Get-ChildItem $day.FullName -Filter '*.md' |
            Where-Object { $_.Name -match '^\d{2}-' } | Sort-Object Name |
            ForEach-Object { Read-Question $_ })

    $rows = foreach ($q in $qs) {
        "| $($q.N) | $($q.Difficulty) | [$($q.Title)]($($q.File)) | [HackerRank]($($q.Link)) | $($badge[$q.Status]) |"
    }
    $passed = @($qs | Where-Object Status -eq 'Passed').Count
    $failed = @($qs | Where-Object Status -eq 'Failed').Count
    $covers = (@('Easy', 'Medium', 'Hard') | ForEach-Object {
        $n = @($qs | Where-Object Difficulty -eq $_).Count
        if ($n) { "$n $_" }
    }) -join ', '

    $readme = @"
# SQL Runner - $($day.Name)

Covers: **$covers** &nbsp;|&nbsp; Passed: **$passed / $($qs.Count)** &nbsp;|&nbsp; Failed: **$failed**

| # | Difficulty | Question | Link | Status |
|---|------------|----------|------|--------|
$($rows -join "`n")
"@
    [IO.File]::WriteAllText((Join-Path $day.FullName 'README.md'), $readme + "`n", $utf8)

    $byDiff = { param($d) (@($qs | Where-Object Difficulty -eq $d | ForEach-Object Title)) -join ', ' }
    $logRows += "| [$($day.Name)]($($day.Name)) | " +
                "$(& $byDiff 'Easy') | $(& $byDiff 'Medium') | $(& $byDiff 'Hard') | $passed/$($qs.Count) |"
}

# Replace everything between the LOG markers in the root README.
$rootReadme = Join-Path $root 'README.md'
$text = [IO.File]::ReadAllText($rootReadme)
$table = @"
<!-- LOG:START -->
| Date | Easy | Medium | Hard | Passed |
|------|------|--------|------|--------|
$($logRows -join "`n")
<!-- LOG:END -->
"@
if ($text -notmatch '(?s)<!-- LOG:START -->.*<!-- LOG:END -->') {
    throw "Root README.md is missing the <!-- LOG:START --> / <!-- LOG:END --> markers."
}
$text = [regex]::Replace($text, '(?s)<!-- LOG:START -->.*<!-- LOG:END -->', { param($m) $table })
[IO.File]::WriteAllText($rootReadme, $text, $utf8)

Write-Host "Indexed $($days.Count) day(s)."
