# Hebrew URL Migration Script for Telegrass Website
# This script converts English city URLs to Hebrew URLs

# Read the city mapping
$mappingPath = "c:\Users\dexte\Desktop\People\Orange\Telegrass\V1\city-name-mapping.json"
$cityMapping = Get-Content $mappingPath | ConvertFrom-Json

# Define paths
$citiesDir = "c:\Users\dexte\Desktop\People\Orange\Telegrass\V1\cities"
$rootDir = "c:\Users\dexte\Desktop\People\Orange\Telegrass\V1"

Write-Host "Starting Hebrew URL migration..." -ForegroundColor Green

# Step 1: Create backup
Write-Host "Creating backup..." -ForegroundColor Yellow
$backupDir = "$rootDir\backup_" + (Get-Date -Format "yyyyMMdd_HHmmss")
Copy-Item -Path $rootDir -Destination $backupDir -Recurse -Force
Write-Host "Backup created at: $backupDir" -ForegroundColor Green

# Step 2: Rename all city files to Hebrew names
Write-Host "Renaming city files to Hebrew..." -ForegroundColor Yellow
foreach ($englishName in $cityMapping.PSObject.Properties.Name) {
    $hebrewName = $cityMapping.$englishName
    $oldPath = Join-Path $citiesDir $englishName
    $newPath = Join-Path $citiesDir $hebrewName
    
    if (Test-Path $oldPath) {
        Rename-Item -Path $oldPath -NewName $hebrewName
        Write-Host "Renamed: $englishName -> $hebrewName" -ForegroundColor Cyan
    }
}

# Step 3: Update all internal links in HTML files
Write-Host "Updating internal links..." -ForegroundColor Yellow

# Get all HTML files
$htmlFiles = Get-ChildItem -Path $rootDir -Recurse -Filter "*.html" | Where-Object { $_.Directory.Name -ne "backup_*" }

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $originalContent = $content
    
    # Update href links to cities
    foreach ($englishName in $cityMapping.PSObject.Properties.Name) {
        $hebrewName = $cityMapping.$englishName
        
        # Update relative links
        $content = $content -replace "cities/$englishName", "cities/$hebrewName"
        
        # Update absolute URLs in meta tags
        $content = $content -replace "https://xn----zhcfoankcogt8ah0h\.xyz/cities/$englishName", "https://xn----zhcfoankcogt8ah0h.xyz/cities/$hebrewName"
        
        # Update canonical URLs
        $content = $content -replace "href=`"https://xn----zhcfoankcogt8ah0h\.xyz/cities/$englishName`"", "href=`"https://xn----zhcfoankcogt8ah0h.xyz/cities/$hebrewName`""
        
        # Update OpenGraph URLs
        $content = $content -replace "content=`"https://xn----zhcfoankcogt8ah0h\.xyz/cities/$englishName`"", "content=`"https://xn----zhcfoankcogt8ah0h.xyz/cities/$hebrewName`""
        
        # Update Twitter meta URLs
        $content = $content -replace "https://xn----zhcfoankcogt8ah0h\.xyz/cities/$englishName", "https://xn----zhcfoankcogt8ah0h.xyz/cities/$hebrewName"
    }
    
    # Save updated content if changes were made
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Updated links in: $($file.Name)" -ForegroundColor Green
    }
}

# Step 4: Update sitemap.xml
Write-Host "Updating sitemap..." -ForegroundColor Yellow
$sitemapPath = "$rootDir\sitemap.xml"
if (Test-Path $sitemapPath) {
    $sitemapContent = Get-Content $sitemapPath -Raw -Encoding UTF8
    
    foreach ($englishName in $cityMapping.PSObject.Properties.Name) {
        $hebrewName = $cityMapping.$englishName
        $sitemapContent = $sitemapContent -replace "cities/$englishName", "cities/$hebrewName"
    }
    
    Set-Content -Path $sitemapPath -Value $sitemapContent -Encoding UTF8
    Write-Host "Sitemap updated successfully" -ForegroundColor Green
}

Write-Host "Hebrew URL migration completed!" -ForegroundColor Green
Write-Host "Backup location: $backupDir" -ForegroundColor Yellow
Write-Host "Please test the website thoroughly before deploying." -ForegroundColor Red
