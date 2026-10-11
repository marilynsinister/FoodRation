#Requires -Version 5.1
<#
.SYNOPSIS
  Tests, release APK, git commit, push to the configured remote.

.PARAMETER SkipTests
  Skip flutter test.

.PARAMETER SkipBuild
  Skip APK build.

.PARAMETER SkipPush
  Commit locally only.

.PARAMETER Message
  Commit message. Default is a dated deploy message.
#>
param(
    [switch]$SkipTests,
    [switch]$SkipBuild,
    [switch]$SkipPush,
    [string]$Message = ''
)

$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $Root

function Step([string]$Title) {
    Write-Host ''
    Write-Host "==> $Title" -ForegroundColor Cyan
}

$flutterCmd = Get-Command flutter -ErrorAction SilentlyContinue
$flutter = if ($flutterCmd) { $flutterCmd.Source } else { 'D:\Android\flutter\bin\flutter.bat' }
if (-not (Test-Path $flutter)) { throw "flutter not found" }

if (-not $SkipTests) {
    Step 'flutter test'
    & $flutter test test/widget_test.dart test/meal_plan_text_parser_test.dart
    if ($LASTEXITCODE -ne 0) { throw "tests failed" }
}

$apkOut = Join-Path $Root 'dist'
New-Item -ItemType Directory -Force -Path $apkOut | Out-Null
$apkDest = Join-Path $apkOut 'food-ration-release.apk'

if (-not $SkipBuild) {
    Step 'flutter build apk --release'
    & $flutter build apk --release
    if ($LASTEXITCODE -ne 0) { throw "apk build failed" }
    $built = Join-Path $Root 'build\app\outputs\flutter-apk\app-release.apk'
    Copy-Item $built $apkDest -Force
    $sizeMb = [math]::Round((Get-Item $apkDest).Length / 1MB, 1)
    Write-Host "APK: $apkDest ($sizeMb MB)"
}

Step 'git'
if (-not (Test-Path (Join-Path $Root '.git'))) {
    git init -b main
}
git add -A
$status = git status --porcelain
if ($status) {
    if (-not $Message) {
        $Message = "Release: visuals, recipe photos, APK deploy $(Get-Date -Format 'yyyy-MM-dd')"
    }
    git commit -m $Message
} else {
    Write-Host 'Nothing to commit'
}

if ($SkipPush) {
    Write-Host 'SkipPush: local commit only'
    exit 0
}

$remote = $null
try { $remote = git remote get-url origin 2>$null } catch { $remote = $null }
if (-not $remote) {
    Write-Host @'
No git remote "origin".
Cursor Origin CLI is not supported on native Windows.
Add a remote and re-run:

  git remote add origin <url>
  powershell -File tool\deploy.ps1 -SkipTests -SkipBuild
'@
    exit 2
}

Step "git push origin HEAD"
git push -u origin HEAD
if ($LASTEXITCODE -ne 0) { throw "git push failed" }
Write-Host "Pushed to $remote"
Write-Host "APK stays local: $apkDest"
