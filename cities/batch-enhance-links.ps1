# Enhanced Internal Linking - Batch Update Script
# This script adds enhanced internal linking to remaining city pages

$processedFiles = 0
$skippedFiles = 0

# Define the enhanced CTA template
$enhancedCTATemplate = @'
    <!-- Regional Navigation for SEO -->
    <section class="py-4 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h3 class="h5 mb-3 text-center">
                        <i class="bi bi-geo-alt me-2"></i>כיוונים לערים בקרבת מקום
                    </h3>
                    <div class="row g-2 justify-content-center">
                        <div class="col-auto">
                            <a href="תל-אביב-כיוונים.html" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-map me-1"></i>תל אביב
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="ירושלים-כיוונים.html" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-map me-1"></i>ירושלים
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="חיפה-כיוונים.html" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-map me-1"></i>חיפה
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="באר-שבע-כיוונים.html" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-map me-1"></i>באר שבע
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Enhanced CTA with Internal Links -->
    <section class="py-5 bg-light-green">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="mb-4">מחפש כיוונים נוספים?</h2>
                    <p class="lead mb-4">גלה כיוונים מעודכנים לכל ערי ישראל ומידע שימושי נוסף</p>
                    
                    <!-- Regional Categories -->
                    <div class="row g-3 justify-content-center mb-4">
                        <div class="col-12">
                            <h5 class="mb-3">כיוונים לערים מובילות</h5>
                        </div>
                        <div class="col-auto">
                            <a href="תל-אביב-כיוונים.html" class="btn btn-outline-primary">
                                <i class="bi bi-building me-1"></i>תל אביב
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="ירושלים-כיוונים.html" class="btn btn-outline-primary">
                                <i class="bi bi-star me-1"></i>ירושלים
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="חיפה-כיוונים.html" class="btn btn-outline-primary">
                                <i class="bi bi-water me-1"></i>חיפה
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="באר-שבע-כיוונים.html" class="btn btn-outline-primary">
                                <i class="bi bi-geo me-1"></i>באר שבע
                            </a>
                        </div>
                    </div>

                    <!-- Useful Links -->
                    <div class="row g-2 justify-content-center mb-4">
                        <div class="col-12">
                            <h6 class="mb-3">מידע שימושי נוסף</h6>
                        </div>
                        <div class="col-auto">
                            <a href="../מדריך-טלגרם.html" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-info-circle me-1"></i>מדריך טלגרם
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="../מדריך-בטיחות-ואבטחה.html" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-shield-check me-1"></i>מדריך בטיחות
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="../שאלות-נפוצות.html" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-question-circle me-1"></i>שאלות נפוצות
                            </a>
                        </div>
                    </div>

                    <!-- Main CTA -->
                    <div class="row g-2 justify-content-center">
                        <div class="col-auto">
                            <a href="../ערים-בישראל.html" class="btn btn-primary">
                                <i class="bi bi-list me-1"></i>כל הערים בישראל
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="../index.html" class="btn btn-success">
                                <i class="bi bi-house me-1"></i>חזרה לעמוד הבית
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
'@

# Get all city HTML files
$cityFiles = Get-ChildItem -Path "cities" -Filter "*-כיוונים.html" | Where-Object { 
    $_.Name -notlike "*תל-אביב*" -and 
    $_.Name -notlike "*ירושלים*" -and 
    $_.Name -notlike "*רמת-גן*" 
}

Write-Host "Processing $($cityFiles.Count) city files for enhanced internal linking..." -ForegroundColor Green

foreach ($file in $cityFiles) {
    $filePath = $file.FullName
    
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    
    try {
        $content = Get-Content -Path $filePath -Encoding UTF8 -Raw
        
        # Check if already has enhanced navigation
        if ($content -match "כיוונים לערים בקרבת מקום") {
            Write-Host "  → Already enhanced, skipping..." -ForegroundColor Gray
            $skippedFiles++
            continue
        }
        
        # Replace existing CTA sections with enhanced version
        $patterns = @(
            '<!-- Call to Action -->\s*<section[^>]*py-5[^>]*bg-light-green[^>]*>.*?</section>',
            '<section[^>]*py-5[^>]*bg-light-green[^>]*>.*?</section>',
            '<!-- Call to Action -->\s*<section[^>]*bg-light-green[^>]*>.*?</section>',
            '<section[^>]*bg-light-green[^>]*>.*?</section>'
        )
        
        $replaced = $false
        foreach ($pattern in $patterns) {
            if ($content -match $pattern) {
                $content = $content -replace $pattern, $enhancedCTATemplate
                $replaced = $true
                break
            }
        }
        
        # If no CTA found, add before footer
        if (-not $replaced) {
            $content = $content -replace '(\s*<!-- Footer|\s*<div[^>]*footer-container)', "$enhancedCTATemplate`$1"
        }
        
        # Save the modified content
        [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
        
        Write-Host "  ✓ Enhanced internal linking added successfully" -ForegroundColor Green
        $processedFiles++
        
    } catch {
        Write-Host "  ✗ Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=== SUMMARY ===" -ForegroundColor Cyan
Write-Host "Files processed: $processedFiles" -ForegroundColor Green
Write-Host "Files skipped: $skippedFiles" -ForegroundColor Yellow
Write-Host ""
Write-Host "Enhanced features added to all city pages:" -ForegroundColor Cyan
Write-Host "  - Regional navigation with nearby cities" -ForegroundColor White
Write-Host "  - Links to top cities (Tel Aviv, Jerusalem, Haifa, Beer Sheva)" -ForegroundColor White
Write-Host "  - Links to useful guides (Telegram, Safety, FAQ)" -ForegroundColor White
Write-Host "  - Enhanced CTA with multiple internal links" -ForegroundColor White
Write-Host "  - Link to all cities index page and homepage" -ForegroundColor White
