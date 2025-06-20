# PowerShell script to fix cross-references between cities in individual city pages
# This fixes href links to other cities within each city page

# Define the mapping from English to Hebrew URLs
$urlMappings = @{
    'abu-ghosh-kivanim.html' = 'אבו-גוש-כיוונים.html'
    'ashdod-kivanim.html' = 'אשדוד-כיוונים.html'
    'ashkelon-kivanim.html' = 'אשקלון-כיוונים.html'
    'beer-sheva-kivanim.html' = 'באר-שבע-כיוונים.html'
    'beit-nakofa-kivanim.html' = 'בית-נקופה-כיוונים.html'
    'beit-dagan-kivanim.html' = 'בית-דגן-כיוונים.html'
    'beit-shemesh-kivanim.html' = 'בית-שמש-כיוונים.html'
    'bnei-brak-kivanim.html' = 'בני-ברק-כיוונים.html'
    'dimona-kivanim.html' = 'דימונה-כיוונים.html'
    'gan-yavne-kivanim.html' = 'גן-יבנה-כיוונים.html'
    'haifa-kivanim.html' = 'חיפה-כיוונים.html'
    'herzliya-kivanim.html' = 'הרצליה-כיוונים.html'
    'holon-kivanim.html' = 'חולון-כיוונים.html'
    'jerusalem-kivanim.html' = 'ירושלים-כיוונים.html'
    'kfar-saba-kivanim.html' = 'כפר-סבא-כיוונים.html'
    'kfar-yavetz-kivanim.html' = 'כפר-יבץ-כיוונים.html'
    'kfar-yona-kivanim.html' = 'כפר-יונה-כיוונים.html'
    'kafr-qasim-kivanim.html' = 'כפר-קאסם-כיוונים.html'
    'kassifa-kivanim.html' = 'כסיפה-כיוונים.html'
    'lod-kivanim.html' = 'לוד-כיוונים.html'
    'maalot-tarshiha-kivanim.html' = 'מעלות-תרשיחא-כיוונים.html'
    'migdal-haemek-kivanim.html' = 'מגדל-העמק-כיוונים.html'
    'mazkeret-batya-kivanim.html' = 'מזכרת-בתיה-כיוונים.html'
    'maayan-baruch-kivanim.html' = 'מעיין-ברוך-כיוונים.html'
    'mitzpe-ramon-kivanim.html' = 'מצפה-רמון-כיוונים.html'
    'nes-ziona-kivanim.html' = 'נס-ציונה-כיוונים.html'
    'nazareth-illit-kivanim.html' = 'נצרת-עילית-כיוונים.html'
    'netanya-kivanim.html' = 'נתניה-כיוונים.html'
    'petah-tikva-kivanim.html' = 'פתח-תקווה-כיוונים.html'
    'raanana-kivanim.html' = 'רעננה-כיוונים.html'
    'ramat-gan-kivanim.html' = 'רמת-גן-כיוונים.html'
    'rehovot-kivanim.html' = 'רחובות-כיוונים.html'
    'rishon-lezion-kivanim.html' = 'ראשון-לציון-כיוונים.html'
    'tayibe-kivanim.html' = 'טייבה-כיוונים.html'
    'tel-aviv-kivanim.html' = 'תל-אביב-כיוונים.html'
    'yavne-kivanim.html' = 'יבנה-כיוונים.html'
}

$citiesPath = "c:\Users\dexte\Desktop\People\Orange\Telegrass\V1\cities"
$updatedFiles = 0

Get-ChildItem -Path $citiesPath -Filter "*-כיוונים.html" | ForEach-Object {
    $filePath = $_.FullName
    $fileName = $_.Name
    Write-Host "Processing: $fileName"
    
    try {
        $content = Get-Content -Path $filePath -Raw -Encoding UTF8
        $originalContent = $content
        
        # Fix href links to other cities
        foreach ($englishUrl in $urlMappings.Keys) {
            $hebrewUrl = $urlMappings[$englishUrl]
            
            # Replace href="english-city.html" with href="hebrew-city.html"
            $content = $content -replace "href=`"$englishUrl`"", "href=`"$hebrewUrl`""
        }
        
        # If content was changed, save it
        if ($content -ne $originalContent) {
            Set-Content -Path $filePath -Value $content -Encoding UTF8
            $updatedFiles++
            Write-Host "✓ Updated city cross-references in: $fileName" -ForegroundColor Green
        } else {
            Write-Host "- No changes needed in: $fileName" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "✗ Error processing $fileName : $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nCompleted! Updated $updatedFiles files." -ForegroundColor Cyan
