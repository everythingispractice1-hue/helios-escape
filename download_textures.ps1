$dest = "$PSScriptRoot\assets"
if (!(Test-Path $dest)) { New-Item -ItemType Directory -Path $dest | Out-Null }

$textures = @{
    "mercury.jpg"  = "https://www.solarsystemscope.com/textures/download/2k_mercury.jpg"
    "venus.jpg"    = "https://www.solarsystemscope.com/textures/download/2k_venus_surface.jpg"
    "earth.jpg"    = "https://www.solarsystemscope.com/textures/download/2k_earth_daymap.jpg"
    "mars.jpg"     = "https://www.solarsystemscope.com/textures/download/2k_mars.jpg"
    "jupiter.jpg"  = "https://www.solarsystemscope.com/textures/download/2k_jupiter.jpg"
    "saturn.jpg"   = "https://www.solarsystemscope.com/textures/download/2k_saturn.jpg"
    "uranus.jpg"   = "https://www.solarsystemscope.com/textures/download/2k_uranus.jpg"
    "neptune.jpg"  = "https://www.solarsystemscope.com/textures/download/2k_neptune.jpg"
    "space_bg.jpg" = "https://raw.githubusercontent.com/homer-jay/solar-system-textures/master/stars_milky_way.jpg"
}

foreach ($file in $textures.Keys) {
    $path = Join-Path $dest $file
    if (Test-Path $path) {
        Write-Host "SKIP (already exists): $file"
        continue
    }
    Write-Host "Downloading $file ..."
    try {
        Invoke-WebRequest -Uri $textures[$file] -OutFile $path -UseBasicParsing
        Write-Host "  OK: $file ($([math]::Round((Get-Item $path).Length/1KB)) KB)"
    } catch {
        Write-Host "  FAILED: $file - $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "Done. assets/ フォルダを確認してください。"
