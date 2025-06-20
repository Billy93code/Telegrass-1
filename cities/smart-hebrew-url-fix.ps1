# Smart Hebrew URL Auto-Fix Script
# This script automatically detects the Hebrew filename and replaces English URLs with it

Write-Host "Starting Smart Hebrew URL Auto-Fix..." -ForegroundColor Cyan

$fixedFiles = 0
$totalReplacements = 0

Get-ChildItem "*-כיוונים.html" | ForEach-Object {
    $filePath = $_.FullName
    $fileName = $_.Name
    $hebrewFileName = $fileName  # The current Hebrew filename
    
    Write-Host "Processing: $fileName" -ForegroundColor White
    
    try {
        $content = Get-Content -Path $filePath -Raw -Encoding UTF8
        $originalContent = $content
        $fileReplacements = 0
        
        # Find all URLs that end with English city names followed by -kivanim.html
        # Pattern: cities/[english-name]-kivanim.html
        $pattern = 'cities/([a-zA-Z-]+)-kivanim\.html'
        
        if ($content -match $pattern) {
            # Replace with Hebrew filename
            $content = $content -replace $pattern, "cities/$hebrewFileName"
            $fileReplacements++
        }
          # Also check for URLs without the cities/ prefix
        $pattern2 = '([a-zA-Z-]+)-kivanim\.html'
        $urlMatches = [regex]::Matches($content, $pattern2)
        
        foreach ($match in $urlMatches) {
            $englishUrl = $match.Value
            # Only replace if it's not already Hebrew and not in a different context
            if ($englishUrl -notmatch '[\u0590-\u05FF]' -and $content -match [regex]::Escape($englishUrl)) {
                $content = $content -replace [regex]::Escape($englishUrl), $hebrewFileName
                $fileReplacements++
            }
        }
        
        # Save if any changes were made
        if ($content -ne $originalContent) {
            Set-Content -Path $filePath -Value $content -Encoding UTF8
            $fixedFiles++
            $totalReplacements += $fileReplacements
            Write-Host "✓ Fixed $fileReplacements URLs in: $fileName" -ForegroundColor Green
        } else {
            Write-Host "- No URLs to fix in: $fileName" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "✗ Error processing $fileName : $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n=== SMART URL FIX COMPLETE ===" -ForegroundColor Magenta
Write-Host "Files processed: $fixedFiles" -ForegroundColor Green
Write-Host "Total URL replacements: $totalReplacements" -ForegroundColor Green
Write-Host "All English URLs have been automatically converted to Hebrew!" -ForegroundColor Cyan
