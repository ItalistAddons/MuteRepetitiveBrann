# Manual Packaging Script for MuteRepetitiveBrann
# Creates a CurseForge-ready zip file

param(
    [string]$OutputDir = ".\release"
)

$ErrorActionPreference = "Stop"

# Get version from TOC file
$tocFile = ".\MuteRepetitiveBrann.toc"
$version = (Select-String -Path $tocFile -Pattern "^## Version: (.+)$").Matches.Groups[1].Value.Trim()

if (-not $version) {
    Write-Error "Could not find version in $tocFile"
    exit 1
}

Write-Host "Packaging MuteRepetitiveBrann v$version..." -ForegroundColor Cyan

# Create output directory
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$tempDir = Join-Path $OutputDir "temp"
$addonDir = Join-Path $tempDir "MuteRepetitiveBrann"
$zipFile = Join-Path $OutputDir "MuteRepetitiveBrann-$version.zip"

# Clean up old temp and zip
if (Test-Path $tempDir) {
    Remove-Item -Recurse -Force $tempDir
}
if (Test-Path $zipFile) {
    Remove-Item -Force $zipFile
    Write-Host "Removed existing: $zipFile" -ForegroundColor Yellow
}

# Create addon directory structure
New-Item -ItemType Directory -Path $addonDir -Force | Out-Null

# Files to include (only essential addon files)
$filesToCopy = @(
    "MuteRepetitiveBrann.lua",
    "MuteRepetitiveBrann.toc",
    "README.md",
    "LICENSE"
)


# Copy files
foreach ($file in $filesToCopy) {
    if (Test-Path $file) {
        Copy-Item $file -Destination $addonDir
        Write-Host "  + $file" -ForegroundColor Green
    } else {
        Write-Warning "File not found: $file"
    }
}

# Create zip archive
Write-Host "`nCreating archive..." -ForegroundColor Cyan
Compress-Archive -Path $addonDir -DestinationPath $zipFile -CompressionLevel Optimal

# Clean up temp directory
Remove-Item -Recurse -Force $tempDir

# Show result
$zipSize = (Get-Item $zipFile).Length / 1KB
Write-Host "`nPackage created successfully!" -ForegroundColor Green
Write-Host "  File: $zipFile" -ForegroundColor White
Write-Host "  Size: $([math]::Round($zipSize, 2)) KB" -ForegroundColor White
Write-Host "  Version: $version" -ForegroundColor White

Write-Host "`nReady to upload to CurseForge!" -ForegroundColor Cyan
