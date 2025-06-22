# Enhanced Internal Linking Script for SEO - UTF8 Version
# This script adds comprehensive internal links to all city pages

# Define common nearby cities (avoiding Hebrew encoding issues)
$defaultNearbyCities = @("tel-aviv", "jerusalem", "haifa", "beer-sheva")

# Get all city HTML files
$cityFiles = Get-ChildItem -Path "cities" -Filter "*-*.html"

Write-Host "Processing $($cityFiles.Count) city files for enhanced internal linking..." -ForegroundColor Green

foreach ($file in $cityFiles) {
    $filePath = $file.FullName
    
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    
    try {
        $content = Get-Content -Path $filePath -Encoding UTF8 -Raw
        
        # Check if regional navigation already exists
        if ($content -match "כיוונים לערים בקרבת מקום") {
            Write-Host "  → Regional navigation already exists, skipping..." -ForegroundColor Gray
            continue
        }
        
        # Create regional navigation section (using existing Hebrew in template)
        $regionalNav = @"

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
"@
        
        # Enhanced CTA section with more internal links
        $enhancedCTA = @"
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
"@
        
        # Find insertion points and add the content
        $modifiedContent = $content
        
        # Insert regional navigation after main content, before existing CTA or footer
        if ($content -match "(</section>\s*(?=\s*<!-- Call to Action|<section[^>]*bg-light-green|<!-- Footer|<div[^>]*footer-container))") {
            $modifiedContent = $content -replace "(</section>\s*(?=\s*<!-- Call to Action|<section[^>]*bg-light-green|<!-- Footer|<div[^>]*footer-container))", "`$1$regionalNav"
        }
        
        # Replace existing simple CTA with enhanced CTA if it exists
        if ($content -match '<!-- Call to Action -->\s*<section[^>]*py-5[^>]*>.*?</section>') {
            $modifiedContent = $modifiedContent -replace '<!-- Call to Action -->\s*<section[^>]*py-5[^>]*>.*?</section>', $enhancedCTA
        } elseif ($content -match '<section[^>]*bg-light-green[^>]*>.*?</section>') {
            # If there's an existing bg-light-green section, replace it
            $modifiedContent = $modifiedContent -replace '<section[^>]*bg-light-green[^>]*>.*?</section>', $enhancedCTA
        } else {
            # If no CTA exists, add it before footer
            $modifiedContent = $modifiedContent -replace '(\s*<!-- Footer|\s*<div[^>]*footer-container)', "$enhancedCTA`$1"
        }
        
        # Save the modified content
        [System.IO.File]::WriteAllText($filePath, $modifiedContent, [System.Text.Encoding]::UTF8)
        
        Write-Host "  ✓ Enhanced internal linking added successfully" -ForegroundColor Green
        
    } catch {
        Write-Host "  ✗ Error processing $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nCompleted enhancing internal links for all city pages!" -ForegroundColor Green
Write-Host "Enhanced features added:" -ForegroundColor Cyan
Write-Host "  - Regional navigation with top cities" -ForegroundColor White
Write-Host "  - Links to major cities (Tel Aviv, Jerusalem, Haifa, Beer Sheva)" -ForegroundColor White
Write-Host "  - Links to useful guides (Telegram, Safety, FAQ)" -ForegroundColor White
Write-Host "  - Enhanced CTA with multiple internal links" -ForegroundColor White
Write-Host "  - Link to all cities index page" -ForegroundColor White
