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
    $oldFile = Join-Path $citiesDir "$englishName-kivanim.html"
    $newFile = Join-Path $citiesDir "$hebrewName-כיוונים.html"
    
    if (Test-Path $oldFile) {
        try {
            Move-Item -Path $oldFile -Destination $newFile -Force
            Write-Host "  Renamed: $englishName-kivanim.html -> $hebrewName-כיוונים.html" -ForegroundColor Cyan
        } catch {
            Write-Host "  Error renaming $englishName-kivanim.html: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

Write-Host "Hebrew URL conversion completed!" -ForegroundColor Green
