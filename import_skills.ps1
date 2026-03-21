$ErrorActionPreference = "Stop"
$skillsDir = "C:\Users\Priscila\.gemini\antigravity\skills"
$outputFile = "C:\Users\Priscila\IdeaOrganizer\skills_data.js"
$skillsList = New-Object System.Collections.ArrayList

Write-Host "Iniciando varredura em $skillsDir..."
$directories = Get-ChildItem -Path $skillsDir -Directory
foreach ($dir in $directories) {
    $skillMdPath = Join-Path $dir.FullName "SKILL.md"
    if (Test-Path $skillMdPath) {
        $content = [System.IO.File]::ReadAllText($skillMdPath)
        $desc = "Skill: $($dir.Name)"
        
        $snippet = if ($content.Length -gt 1500) { $content.Substring(0, 1500) } else { $content }
        if ($snippet -match '(?m)^description:\s*(.+)$') {
            $desc = $matches[1].Trim()
            $desc = $desc -replace '^"|"$', ''
            $desc = $desc -replace "^'|'$", ''
        }
        
        # Build hashtable
        $obj = @{
            id = [guid]::NewGuid().ToString()
            nome = $dir.Name
            desc = $desc
            prompt = $content
        }
        [void]$skillsList.Add($obj)
    }
}

Write-Host "Convertendo $($skillsList.Count) skills para JSON..."
# Using .NET JavaScriptSerializer to avoid PowerShell ConvertTo-Json limits on large strings
Add-Type -AssemblyName System.Web.Extensions
$serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$serializer.MaxJsonLength = 2147483647
$json = $serializer.Serialize($skillsList)

$finalContent = "window.IMPORTED_SKILLS = $json;"
[System.IO.File]::WriteAllText($outputFile, $finalContent, [System.Text.Encoding]::UTF8)
Write-Host "Sucesso: $($skillsList.Count) skills salvas em $outputFile"
