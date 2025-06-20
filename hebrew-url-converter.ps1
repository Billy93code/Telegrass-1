# Hebrew URL Converter Script
# Converts English city names to Hebrew in filenames and all internal links

$workspaceRoot = "c:\Users\dexte\Desktop\People\Orange\Telegrass\V1"
$citiesDir = "$workspaceRoot\cities"

# English to Hebrew city name mapping
$cityMapping = @{
    "abu-ghosh" = "אבו-גוש"
    "acre" = "עכו"
    "afula" = "עפולה"
    "arad" = "ערד"
    "arara" = "עררה"
    "ashdod" = "אשדוד"
    "ashkelon" = "אשקלון"
    "azor" = "אזור"
    "baqah-al-gharbiyyeh" = "באקה-אל-גרביה"
    "bat-yam" = "בת-ים"
    "beer-sheva" = "באר-שבע"
    "beit-dagan" = "בית-דגן"
    "beit-nakofa" = "בית-נקופה"
    "beit-shean" = "בית-שאן"
    "beit-shemesh" = "בית-שמש"
    "binyamina-givat-ada" = "בנימינה-גבעת-עדה"
    "bnei-brak" = "בני-ברק"
    "caesarea" = "קיסריה"
    "carmiel" = "כרמיאל"
    "deir-al-asad" = "דיר-אל-אסד"
    "dimona" = "דימונה"
    "eilat" = "אילת"
    "ein-kerem" = "עין-כרם"
    "elad" = "אלעד"
    "gan-yavne" = "גן-יבנה"
    "gedera" = "גדרה"
    "givat-zeev" = "גבעת-זאב"
    "givatayim" = "גבעתיים"
    "hadera" = "חדרה"
    "haifa" = "חיפה"
    "herzliya" = "הרצליה"
    "hod-hasharon" = "הוד-השרון"
    "holon" = "חולון"
    "jadida-makr" = "ג'דידה-מכר"
    "jerusalem" = "ירושלים"
    "kabul" = "כאבול"
    "kadima-zoran" = "קדימה-צורן"
    "kafr-qasim" = "כפר-קאסם"
    "kassifa" = "כסיפה"
    "kfar-saba" = "כפר-סבא"
    "kfar-yavetz" = "כפר-יבץ"
    "kfar-yona" = "כפר-יונה"
    "kiryat-bialik" = "קריית-ביאליק"
    "kiryat-gat" = "קריית-גת"
    "kiryat-malachi" = "קריית-מלאכי"
    "kiryat-motzkin" = "קריית-מוצקין"
    "kiryat-shmona" = "קריית-שמונה"
    "kiryat-yam" = "קריית-ים"
    "lakia" = "לקיה"
    "lod" = "לוד"
    "maale-adumim" = "מעלה-אדומים"
    "maalot-tarshiha" = "מעלות-תרשיחא"
    "maayan-baruch" = "מעיין-ברוך"
    "mazkeret-batya" = "מזכרת-בתיה"
    "metula" = "מטולה"
    "mevaseret-zion" = "מבשרת-ציון"
    "migdal-haemek" = "מגדל-העמק"
    "mitzpe-ramon" = "מצפה-רמון"
    "modiin" = "מודיעין"
    "nahariya" = "נהריה"
    "nazareth-illit" = "נצרת-עילית"
    "nazareth" = "נצרת"
    "nes-ziona" = "נס-ציונה"
    "nesher" = "נשר"
    "netanya" = "נתניה"
    "netivot" = "נתיבות"
    "ofakim" = "אופקים"
    "or-yehuda" = "אור-יהודה"
    "pardes-hana-karkur" = "פרדס-חנה-כרכור"
    "pekiin" = "פקיעין"
    "petah-tikva" = "פתח-תקוה"
    "qalansawe" = "קלנסווה"
    "qatzrin" = "קצרין"
    "raanana" = "רעננה"
    "rahat" = "רהט"
    "ramat-gan" = "רמת-גן"
    "ramat-hasharon" = "רמת-השרון"
    "ramat-yishai" = "רמת-ישי"
    "ramla" = "רמלה"
    "ramot-hashavim" = "רמות-השבים"
    "rehovot" = "רחובות"
    "rishon-lezion" = "ראשון-לציון"
    "rosh-pina" = "ראש-פינה"
    "safed" = "צפת"
    "sakhnin" = "סח'נין"
    "sderot" = "שדרות"
    "shfaram" = "שפרעם"
    "shlomi" = "שלומי"
    "tamra" = "טמרה"
    "tayibe" = "טייבה"
    "tel-aviv" = "תל-אביב"
    "tel-mond" = "תל-מונד"
    "tel-sheva" = "תל-שבע"
    "tiberias" = "טבריה"
    "tirat-carmel" = "טירת-כרמל"
    "umm-al-fahm" = "אום-אל-פחם"
    "yavne" = "יבנה"
    "yehud-monosson" = "יהוד-מונוסון"
    "yeruham" = "ירוחם"
    "zichron-yaakov" = "זכרון-יעקב"
}

Write-Host "Starting Hebrew URL conversion..." -ForegroundColor Green

# Step 1: Rename all city files to Hebrew names
Write-Host "Step 1: Renaming city files to Hebrew..." -ForegroundColor Yellow
foreach ($englishName in $cityMapping.Keys) {
    $hebrewName = $cityMapping[$englishName]
    $oldFile = "$citiesDir\$englishName-kivanim.html"
    $newFile = "$citiesDir\$hebrewName-כיוונים.html"
    
    if (Test-Path $oldFile) {
        Move-Item -Path $oldFile -Destination $newFile
        Write-Host "  Renamed: $englishName-kivanim.html → $hebrewName-כיוונים.html" -ForegroundColor Cyan
    }
}

# Step 2: Update links in cities-israel.html
Write-Host "Step 2: Updating links in cities-israel.html..." -ForegroundColor Yellow
$citiesIsraelFile = "$workspaceRoot\cities-israel.html"
if (Test-Path $citiesIsraelFile) {
    $content = Get-Content $citiesIsraelFile -Raw -Encoding UTF8
    
    foreach ($englishName in $cityMapping.Keys) {
        $hebrewName = $cityMapping[$englishName]
        $oldLink = "cities/$englishName-kivanim.html"
        $newLink = "cities/$hebrewName-כיוונים.html"
        $content = $content -replace [regex]::Escape($oldLink), $newLink
    }
    
    Set-Content -Path $citiesIsraelFile -Value $content -Encoding UTF8
    Write-Host "  Updated all city links in cities-israel.html" -ForegroundColor Cyan
}

# Step 3: Update meta tags and canonical URLs in each Hebrew city file
Write-Host "Step 3: Updating meta tags in Hebrew city files..." -ForegroundColor Yellow
foreach ($englishName in $cityMapping.Keys) {
    $hebrewName = $cityMapping[$englishName]
    $cityFile = "$citiesDir\$hebrewName-כיוונים.html"
    
    if (Test-Path $cityFile) {
        $content = Get-Content $cityFile -Raw -Encoding UTF8
        
        # Update canonical URL
        $oldCanonical = "cities/$englishName-kivanim.html"
        $newCanonical = "cities/$hebrewName-כיוונים.html"
        $content = $content -replace [regex]::Escape($oldCanonical), $newCanonical
        
        # Update Open Graph URL
        $content = $content -replace [regex]::Escape($oldCanonical), $newCanonical
        
        # Update Twitter URL
        $content = $content -replace [regex]::Escape($oldCanonical), $newCanonical
        
        # Update Schema.org URL
        $content = $content -replace [regex]::Escape($oldCanonical), $newCanonical
        
        Set-Content -Path $cityFile -Value $content -Encoding UTF8
        Write-Host "  Updated meta tags in $hebrewName-כיוונים.html" -ForegroundColor Cyan
    }
}

# Step 4: Update sitemap.xml
Write-Host "Step 4: Updating sitemap.xml..." -ForegroundColor Yellow
$sitemapFile = "$workspaceRoot\sitemap.xml"
if (Test-Path $sitemapFile) {
    $content = Get-Content $sitemapFile -Raw -Encoding UTF8
    
    foreach ($englishName in $cityMapping.Keys) {
        $hebrewName = $cityMapping[$englishName]
        $oldUrl = "cities/$englishName-kivanim.html"
        $newUrl = "cities/$hebrewName-כיוונים.html"
        $content = $content -replace [regex]::Escape($oldUrl), $newUrl
    }
    
    Set-Content -Path $sitemapFile -Value $content -Encoding UTF8
    Write-Host "  Updated sitemap.xml with Hebrew URLs" -ForegroundColor Cyan
}

# Step 5: Update any remaining references in other files
Write-Host "Step 5: Checking for remaining English city references..." -ForegroundColor Yellow
$allHtmlFiles = Get-ChildItem -Path $workspaceRoot -Filter "*.html" -Recurse

foreach ($file in $allHtmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
    $updated = $false
    
    foreach ($englishName in $cityMapping.Keys) {
        $hebrewName = $cityMapping[$englishName]
        $oldRef = "$englishName-kivanim.html"
        $newRef = "$hebrewName-כיוונים.html"
        
        if ($content -match [regex]::Escape($oldRef)) {
            $content = $content -replace [regex]::Escape($oldRef), $newRef
            $updated = $true
        }
    }
    
    if ($updated) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "  Updated references in $($file.Name)" -ForegroundColor Cyan
    }
}

Write-Host "✅ Hebrew URL conversion completed successfully!" -ForegroundColor Green
Write-Host "All city files now use Hebrew names in URLs:" -ForegroundColor White
Write-Host "  Example: בני-ברק-כיוונים.html instead of bnei-brak-kivanim.html" -ForegroundColor Gray
Write-Host "  All internal links have been updated to match" -ForegroundColor Gray
