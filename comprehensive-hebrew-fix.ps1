# Comprehensive Hebrew URL Conversion Script
# This script fixes both meta URLs and cross-references in Hebrew city files

# Create comprehensive English to Hebrew URL mapping
$cityMappings = @{
    'abu-ghosh-kivanim.html' = 'אבו-גוש-כיוונים.html'
    'acre-kivanim.html' = 'עכו-כיוונים.html'
    'afula-kivanim.html' = 'עפולה-כיוונים.html'
    'arad-kivanim.html' = 'ערד-כיוונים.html'
    'arara-kivanim.html' = 'עררה-כיוונים.html'
    'ashdod-kivanim.html' = 'אשדוד-כיוונים.html'
    'ashkelon-kivanim.html' = 'אשקלון-כיוונים.html'
    'azor-kivanim.html' = 'אזור-כיוונים.html'
    'baqah-al-gharbiyyeh-kivanim.html' = 'באקה-אל-גרביה-כיוונים.html'
    'bat-yam-kivanim.html' = 'בת-ים-כיוונים.html'
    'beer-sheva-kivanim.html' = 'באר-שבע-כיוונים.html'
    'beit-dagan-kivanim.html' = 'בית-דגן-כיוונים.html'
    'beit-nakofa-kivanim.html' = 'בית-נקופה-כיוונים.html'
    'beit-shean-kivanim.html' = 'בית-שאן-כיוונים.html'
    'beit-shemesh-kivanim.html' = 'בית-שמש-כיוונים.html'
    'binyamina-givat-ada-kivanim.html' = 'בנימינה-גבעת-עדה-כיוונים.html'
    'bnei-brak-kivanim.html' = 'בני-ברק-כיוונים.html'
    'caesarea-kivanim.html' = 'קיסריה-כיוונים.html'
    'carmiel-kivanim.html' = 'כרמיאל-כיוונים.html'
    'deir-al-asad-kivanim.html' = 'דיר-אל-אסד-כיוונים.html'
    'dimona-kivanim.html' = 'דימונה-כיוונים.html'
    'eilat-kivanim.html' = 'אילת-כיוונים.html'
    'ein-kerem-kivanim.html' = 'עין-כרם-כיוונים.html'
    'elad-kivanim.html' = 'אלעד-כיוונים.html'
    'gan-yavne-kivanim.html' = 'גן-יבנה-כיוונים.html'
    'gedera-kivanim.html' = 'גדרה-כיוונים.html'
    'givat-zeev-kivanim.html' = 'גבעת-זאב-כיוונים.html'
    'givatayim-kivanim.html' = 'גבעתיים-כיוונים.html'
    'hadera-kivanim.html' = 'חדרה-כיוונים.html'
    'haifa-kivanim.html' = 'חיפה-כיוונים.html'
    'herzliya-kivanim.html' = 'הרצליה-כיוונים.html'
    'hod-hasharon-kivanim.html' = 'הוד-השרון-כיוונים.html'
    'holon-kivanim.html' = 'חולון-כיוונים.html'
    'jadida-makr-kivanim.html' = 'ג׳דידה-מכר-כיוונים.html'
    'jerusalem-kivanim.html' = 'ירושלים-כיוונים.html'
    'kabul-kivanim.html' = 'כאבול-כיוונים.html'
    'kadima-zoran-kivanim.html' = 'קדימה-צורן-כיוונים.html'
    'kafr-qasim-kivanim.html' = 'כפר-קאסם-כיוונים.html'
    'kassifa-kivanim.html' = 'כסיפה-כיוונים.html'
    'kfar-saba-kivanim.html' = 'כפר-סבא-כיוונים.html'
    'kfar-yavetz-kivanim.html' = 'כפר-יבץ-כיוונים.html'
    'kfar-yona-kivanim.html' = 'כפר-יונה-כיוונים.html'
    'kiryat-bialik-kivanim.html' = 'קריית-ביאליק-כיוונים.html'
    'kiryat-gat-kivanim.html' = 'קריית-גת-כיוונים.html'
    'kiryat-malachi-kivanim.html' = 'קריית-מלאכי-כיוונים.html'
    'kiryat-motzkin-kivanim.html' = 'קריית-מוצקין-כיוונים.html'
    'kiryat-shmona-kivanim.html' = 'קריית-שמונה-כיוונים.html'
    'kiryat-yam-kivanim.html' = 'קריית-ים-כיוונים.html'
    'lakia-kivanim.html' = 'לקיה-כיוונים.html'
    'lod-kivanim.html' = 'לוד-כיוונים.html'
    'maale-adumim-kivanim.html' = 'מעלה-אדומים-כיוונים.html'
    'maalot-tarshiha-kivanim.html' = 'מעלות-תרשיחא-כיוונים.html'
    'maayan-baruch-kivanim.html' = 'מעיין-ברוך-כיוונים.html'
    'mazkeret-batya-kivanim.html' = 'מזכרת-בתיה-כיוונים.html'
    'metula-kivanim.html' = 'מטולה-כיוונים.html'
    'mevaseret-zion-kivanim.html' = 'מבשרת-ציון-כיוונים.html'
    'migdal-haemek-kivanim.html' = 'מגדל-העמק-כיוונים.html'
    'mitzpe-ramon-kivanim.html' = 'מצפה-רמון-כיוונים.html'
    'modiin-kivanim.html' = 'מודיעין-כיוונים.html'
    'nahariya-kivanim.html' = 'נהריה-כיוונים.html'
    'nazareth-illit-kivanim.html' = 'נצרת-עילית-כיוונים.html'
    'nazareth-kivanim.html' = 'נצרת-כיוונים.html'
    'nes-ziona-kivanim.html' = 'נס-ציונה-כיוונים.html'
    'nesher-kivanim.html' = 'נשר-כיוונים.html'
    'netanya-kivanim.html' = 'נתניה-כיוונים.html'
    'netivot-kivanim.html' = 'נתיבות-כיוונים.html'
    'ofakim-kivanim.html' = 'אופקים-כיוונים.html'
    'or-yehuda-kivanim.html' = 'אור-יהודה-כיוונים.html'
    'pardes-hanna-karkur-kivanim.html' = 'פרדס-חנה-כרכור-כיוונים.html'
    'petah-tikva-kivanim.html' = 'פתח-תקוה-כיוונים.html'
    'pekiin-kivanim.html' = 'פקיעין-כיוונים.html'
    'qalansawe-kivanim.html' = 'קלנסווה-כיוונים.html'
    'qatzrin-kivanim.html' = 'קצרין-כיוונים.html'
    'raanana-kivanim.html' = 'רעננה-כיוונים.html'
    'rahat-kivanim.html' = 'רהט-כיוונים.html'
    'ramla-kivanim.html' = 'רמלה-כיוונים.html'
    'ramat-gan-kivanim.html' = 'רמת-גן-כיוונים.html'
    'ramat-hasharon-kivanim.html' = 'רמת-השרון-כיוונים.html'
    'ramat-yishai-kivanim.html' = 'רמת-ישי-כיוונים.html'
    'ramot-hashavim-kivanim.html' = 'רמות-השבים-כיוונים.html'
    'rehovot-kivanim.html' = 'רחובות-כיוונים.html'
    'rishon-lezion-kivanim.html' = 'ראשון-לציון-כיוונים.html'
    'rosh-pina-kivanim.html' = 'ראש-פינה-כיוונים.html'
    'sachnin-kivanim.html' = 'סח׳נין-כיוונים.html'
    'safed-kivanim.html' = 'צפת-כיוונים.html'
    'sderot-kivanim.html' = 'שדרות-כיוונים.html'
    'shfaram-kivanim.html' = 'שפרעם-כיוונים.html'
    'shlomi-kivanim.html' = 'שלומי-כיוונים.html'
    'tayibe-kivanim.html' = 'טייבה-כיוונים.html'
    'tel-aviv-kivanim.html' = 'תל-אביב-כיוונים.html'
    'tel-mond-kivanim.html' = 'תל-מונד-כיוונים.html'
    'tel-sheva-kivanim.html' = 'תל-שבע-כיוונים.html'
    'tiberias-kivanim.html' = 'טבריה-כיוונים.html'
    'tirat-carmel-kivanim.html' = 'טירת-כרמל-כיוונים.html'
    'tamra-kivanim.html' = 'טמרה-כיוונים.html'
    'umm-al-fahm-kivanim.html' = 'אום-אל-פחם-כיוונים.html'
    'yavne-kivanim.html' = 'יבנה-כיוונים.html'
    'yehud-monosson-kivanim.html' = 'יהוד-מונוסון-כיוונים.html'
    'yeruham-kivanim.html' = 'ירוחם-כיוונים.html'
    'zichron-yaakov-kivanim.html' = 'זכרון-יעקב-כיוונים.html'
}

Write-Host "Starting comprehensive Hebrew URL conversion..." -ForegroundColor Cyan
$citiesPath = "c:\Users\dexte\Desktop\People\Orange\Telegrass\V1\cities"
$totalUpdated = 0

# Get only Hebrew city files
$hebrewFiles = Get-ChildItem -Path $citiesPath -Filter "*-כיוונים.html"
Write-Host "Found $($hebrewFiles.Count) Hebrew city files to process" -ForegroundColor Yellow

foreach ($file in $hebrewFiles) {
    $filePath = $file.FullName
    $fileName = $file.Name
    Write-Host "`nProcessing: $fileName" -ForegroundColor White
    
    try {
        $content = Get-Content -Path $filePath -Raw -Encoding UTF8
        $originalContent = $content
        $changesMade = 0
        
        # Fix each English URL in the content
        foreach ($englishUrl in $cityMappings.Keys) {
            $hebrewUrl = $cityMappings[$englishUrl]
            
            # Fix full URLs in meta tags and canonical links
            $beforeCount = ($content | Select-String -Pattern $englishUrl -AllMatches).Matches.Count
            $content = $content -replace [regex]::Escape($englishUrl), $hebrewUrl
            $afterCount = ($content | Select-String -Pattern $englishUrl -AllMatches).Matches.Count
            $replaced = $beforeCount - $afterCount
            
            if ($replaced -gt 0) {
                $changesMade += $replaced
                Write-Host "  → Replaced $replaced instances of: $englishUrl" -ForegroundColor Green
            }
        }
        
        # Save if changes were made
        if ($content -ne $originalContent) {
            Set-Content -Path $filePath -Value $content -Encoding UTF8
            $totalUpdated++
            Write-Host "✓ Updated $fileName with $changesMade changes" -ForegroundColor Green
        } else {
            Write-Host "- No changes needed in: $fileName" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "✗ Error processing $fileName : $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n======== SUMMARY ========" -ForegroundColor Cyan
Write-Host "Total files processed: $($hebrewFiles.Count)" -ForegroundColor White
Write-Host "Files updated: $totalUpdated" -ForegroundColor Green
Write-Host "Conversion complete!" -ForegroundColor Cyan
