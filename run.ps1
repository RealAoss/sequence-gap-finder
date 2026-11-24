[CmdletBinding()]
param(
    [Parameter(Mandatory, Position=0)][string]$InputFile,
    [string]$OutputFile
)
$ErrorActionPreference = 'Stop'
$culture = [Globalization.CultureInfo]::InvariantCulture
try {
    $records = @(Get-Content -LiteralPath $InputFile -Encoding utf8 | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    if (-not $records.Count) { throw 'The input file is empty.' }
    $result = @(& {
        $numbers = @(($records -join ' ').Trim() -split '[,\s]+' | ForEach-Object { [long]::Parse($_, $culture) } | Sort-Object -Unique)
        $found = $false
        for ($i = 1; $i -lt $numbers.Count; $i++) {
            if ([decimal]$numbers[$i] - [decimal]$numbers[$i-1] -le 1) { continue }
            $found = $true
            $first = $numbers[$i-1]+1
            $last = $numbers[$i]-1
            if ($first -eq $last) { "$first" } else { "$first–$last" }
        }
        if (-not $found) { 'No gaps.' }
    })
    if ($OutputFile) {
        $stream = [IO.File]::Open([IO.Path]::GetFullPath($OutputFile), 'CreateNew', 'Write')
        try {
            $bytes = [Text.Encoding]::UTF8.GetBytes(($result -join [Environment]::NewLine) + [Environment]::NewLine)
            $stream.Write($bytes, 0, $bytes.Length)
        } finally { $stream.Dispose() }
    } else { $result }
} catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    exit 1
}
