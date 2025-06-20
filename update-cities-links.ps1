# Update cities-israel.html with Hebrew URLs

$citiesFile = "c:\Users\dexte\Desktop\People\Orange\Telegrass\V1\cities-israel.html"

# Read the file content
$content = Get-Content $citiesFile -Raw -Encoding UTF8

# English to Hebrew city name mapping for URLs
$urlMappings = @{
    "cities/abu-ghosh-kivanim.html" = "cities/אבו-גוש-כיוונים.html"
    "cities/acre-kivanim.html" = "cities/עכו-כיוונים.html"
    "cities/afula-kivanim.html" = "cities/עפולה-כיוונים.html"
    "cities/arad-kivanim.html" = "cities/ערד-כיוונים.html"
    "cities/arara-kivanim.html" = "cities/עררה-כיוונים.html"
    "cities/ashdod-kivanim.html" = "cities/אשדוד-כיוונים.html"
    "cities/ashkelon-kivanim.html" = "cities/אשקלון-כיוונים.html"
    "cities/azor-kivanim.html" = "cities/אזור-כיוונים.html"
    "cities/baqah-al-gharbiyyeh-kivanim.html" = "cities/באקה-אל-גרביה-כיוונים.html"
    "cities/bat-yam-kivanim.html" = "cities/בת-ים-כיוונים.html"
    "cities/beer-sheva-kivanim.html" = "cities/באר-שבע-כיוונים.html"
    "cities/beit-dagan-kivanim.html" = "cities/בית-דגן-כיוונים.html"
    "cities/beit-nakofa-kivanim.html" = "cities/בית-נקופה-כיוונים.html"
    "cities/beit-shean-kivanim.html" = "cities/בית-שאן-כיוונים.html"
    "cities/beit-shemesh-kivanim.html" = "cities/בית-שמש-כיוונים.html"
    "cities/binyamina-givat-ada-kivanim.html" = "cities/בנימינה-גבעת-עדה-כיוונים.html"
    "cities/bnei-brak-kivanim.html" = "cities/בני-ברק-כיוונים.html"
    "cities/caesarea-kivanim.html" = "cities/קיסריה-כיוונים.html"
    "cities/carmiel-kivanim.html" = "cities/כרמיאל-כיוונים.html"
    "cities/deir-al-asad-kivanim.html" = "cities/דיר-אל-אסד-כיוונים.html"
    "cities/dimona-kivanim.html" = "cities/דימונה-כיוונים.html"
    "cities/eilat-kivanim.html" = "cities/אילת-כיוונים.html"
    "cities/ein-kerem-kivanim.html" = "cities/עין-כרם-כיוונים.html"
    "cities/elad-kivanim.html" = "cities/אלעד-כיוונים.html"
    "cities/gan-yavne-kivanim.html" = "cities/גן-יבנה-כיוונים.html"
    "cities/gedera-kivanim.html" = "cities/גדרה-כיוונים.html"
    "cities/givat-zeev-kivanim.html" = "cities/גבעת-זאב-כיוונים.html"
    "cities/givatayim-kivanim.html" = "cities/גבעתיים-כיוונים.html"
    "cities/hadera-kivanim.html" = "cities/חדרה-כיוונים.html"
    "cities/haifa-kivanim.html" = "cities/חיפה-כיוונים.html"
    "cities/herzliya-kivanim.html" = "cities/הרצליה-כיוונים.html"
    "cities/hod-hasharon-kivanim.html" = "cities/הוד-השרון-כיוונים.html"
    "cities/holon-kivanim.html" = "cities/חולון-כיוונים.html"
    "cities/jadida-makr-kivanim.html" = "cities/ג'דידה-מכר-כיוונים.html"
    "cities/jerusalem-kivanim.html" = "cities/ירושלים-כיוונים.html"
    "cities/kabul-kivanim.html" = "cities/כאבול-כיוונים.html"
    "cities/kadima-zoran-kivanim.html" = "cities/קדימה-צורן-כיוונים.html"
    "cities/kafr-qasim-kivanim.html" = "cities/כפר-קאסם-כיוונים.html"
    "cities/kassifa-kivanim.html" = "cities/כסיפה-כיוונים.html"
    "cities/kfar-saba-kivanim.html" = "cities/כפר-סבא-כיוונים.html"
    "cities/kfar-yavetz-kivanim.html" = "cities/כפר-יבץ-כיוונים.html"
    "cities/kfar-yona-kivanim.html" = "cities/כפר-יונה-כיוונים.html"
    "cities/kiryat-bialik-kivanim.html" = "cities/קריית-ביאליק-כיוונים.html"
    "cities/kiryat-gat-kivanim.html" = "cities/קריית-גת-כיוונים.html"
    "cities/kiryat-malachi-kivanim.html" = "cities/קריית-מלאכי-כיוונים.html"
    "cities/kiryat-motzkin-kivanim.html" = "cities/קריית-מוצקין-כיוונים.html"
    "cities/kiryat-shmona-kivanim.html" = "cities/קריית-שמונה-כיוונים.html"
    "cities/kiryat-yam-kivanim.html" = "cities/קריית-ים-כיוונים.html"
    "cities/lakia-kivanim.html" = "cities/לקיה-כיוונים.html"
    "cities/lod-kivanim.html" = "cities/לוד-כיוונים.html"
    "cities/maale-adumim-kivanim.html" = "cities/מעלה-אדומים-כיוונים.html"
    "cities/maalot-tarshiha-kivanim.html" = "cities/מעלות-תרשיחא-כיוונים.html"
    "cities/maayan-baruch-kivanim.html" = "cities/מעיין-ברוך-כיוונים.html"
    "cities/mazkeret-batya-kivanim.html" = "cities/מזכרת-בתיה-כיוונים.html"
    "cities/metula-kivanim.html" = "cities/מטולה-כיוונים.html"
    "cities/mevaseret-zion-kivanim.html" = "cities/מבשרת-ציון-כיוונים.html"
    "cities/migdal-haemek-kivanim.html" = "cities/מגדל-העמק-כיוונים.html"
    "cities/mitzpe-ramon-kivanim.html" = "cities/מצפה-רמון-כיוונים.html"
    "cities/modiin-kivanim.html" = "cities/מודיעין-כיוונים.html"
    "cities/nahariya-kivanim.html" = "cities/נהריה-כיוונים.html"
    "cities/nazareth-illit-kivanim.html" = "cities/נצרת-עילית-כיוונים.html"
    "cities/nazareth-kivanim.html" = "cities/נצרת-כיוונים.html"
    "cities/nes-ziona-kivanim.html" = "cities/נס-ציונה-כיוונים.html"
    "cities/nesher-kivanim.html" = "cities/נשר-כיוונים.html"
    "cities/netanya-kivanim.html" = "cities/נתניה-כיוונים.html"
    "cities/netivot-kivanim.html" = "cities/נתיבות-כיוונים.html"
    "cities/ofakim-kivanim.html" = "cities/אופקים-כיוונים.html"
    "cities/or-yehuda-kivanim.html" = "cities/אור-יהודה-כיוונים.html"
    "cities/pardes-hana-karkur-kivanim.html" = "cities/פרדס-חנה-כרכור-כיוונים.html"
    "cities/pekiin-kivanim.html" = "cities/פקיעין-כיוונים.html"
    "cities/petah-tikva-kivanim.html" = "cities/פתח-תקוה-כיוונים.html"
    "cities/qalansawe-kivanim.html" = "cities/קלנסווה-כיוונים.html"
    "cities/qatzrin-kivanim.html" = "cities/קצרין-כיוונים.html"
    "cities/raanana-kivanim.html" = "cities/רעננה-כיוונים.html"
    "cities/rahat-kivanim.html" = "cities/רהט-כיוונים.html"
    "cities/ramat-gan-kivanim.html" = "cities/רמת-גן-כיוונים.html"
    "cities/ramat-hasharon-kivanim.html" = "cities/רמת-השרון-כיוונים.html"
    "cities/ramat-yishai-kivanim.html" = "cities/רמת-ישי-כיוונים.html"
    "cities/ramla-kivanim.html" = "cities/רמלה-כיוונים.html"
    "cities/ramot-hashavim-kivanim.html" = "cities/רמות-השבים-כיוונים.html"
    "cities/rehovot-kivanim.html" = "cities/רחובות-כיוונים.html"
    "cities/rishon-lezion-kivanim.html" = "cities/ראשון-לציון-כיוונים.html"
    "cities/rosh-pina-kivanim.html" = "cities/ראש-פינה-כיוונים.html"
    "cities/safed-kivanim.html" = "cities/צפת-כיוונים.html"
    "cities/sakhnin-kivanim.html" = "cities/סח'נין-כיוונים.html"
    "cities/sderot-kivanim.html" = "cities/שדרות-כיוונים.html"
    "cities/shfaram-kivanim.html" = "cities/שפרעם-כיוונים.html"
    "cities/shlomi-kivanim.html" = "cities/שלומי-כיוונים.html"
    "cities/tamra-kivanim.html" = "cities/טמרה-כיוונים.html"
    "cities/tayibe-kivanim.html" = "cities/טייבה-כיוונים.html"
    "cities/tel-aviv-kivanim.html" = "cities/תל-אביב-כיוונים.html"
    "cities/tel-mond-kivanim.html" = "cities/תל-מונד-כיוונים.html"
    "cities/tel-sheva-kivanim.html" = "cities/תל-שבע-כיוונים.html"
    "cities/tiberias-kivanim.html" = "cities/טבריה-כיוונים.html"
    "cities/tirat-carmel-kivanim.html" = "cities/טירת-כרמל-כיוונים.html"
    "cities/umm-al-fahm-kivanim.html" = "cities/אום-אל-פחם-כיוונים.html"
    "cities/yavne-kivanim.html" = "cities/יבנה-כיוונים.html"
    "cities/yehud-monosson-kivanim.html" = "cities/יהוד-מונוסון-כיוונים.html"
    "cities/yeruham-kivanim.html" = "cities/ירוחם-כיוונים.html"
    "cities/zichron-yaakov-kivanim.html" = "cities/זכרון-יעקב-כיוונים.html"
}

Write-Host "Updating cities-israel.html with Hebrew URLs..." -ForegroundColor Green

# Replace each English URL with Hebrew URL
foreach ($englishUrl in $urlMappings.Keys) {
    $hebrewUrl = $urlMappings[$englishUrl]
    if ($content -match [regex]::Escape($englishUrl)) {
        $content = $content -replace [regex]::Escape($englishUrl), $hebrewUrl
        Write-Host "  Updated: $englishUrl -> $hebrewUrl" -ForegroundColor Cyan
    }
}

# Save the updated content
Set-Content -Path $citiesFile -Value $content -Encoding UTF8

Write-Host "✅ Updated cities-israel.html with Hebrew URLs!" -ForegroundColor Green
