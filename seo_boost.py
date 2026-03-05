#!/usr/bin/env python3
"""
SEO Mega Boost Script - Adds comprehensive SEO + AI SEO to all pages
- FAQPage Schema for every page (main + cities)
- BreadcrumbList Schema for pages missing it
- SpeakableSpecification for AI SEO
- hreflang tags for all pages
- SiteNavigationElement Schema on index
- Enhanced Article schemas
- Fix news-sitemap.xml
- Update RSS to 2026
- Create llms.txt for AI crawlers
"""

import os, re, json, glob

BASE = os.path.dirname(os.path.abspath(__file__))
DOMAIN = "https://xn----zhcfoankcogt8ah0h.xyz"

# ============================================================
# FAQ DATA - Unique Q&A for each main page
# ============================================================
PAGE_FAQS = {
    "CBD-לעומת-THC.html": [
        ("מה ההבדל בין CBD ל-THC?", "THC (טטרה-הידרו-קנביאל) הוא הרכיב הפסיכואקטיבי בקנאביס שגורם לתחושת ה'היי'. CBD (קנביאידיול) אינו פסיכואקטיבי ומשמש בעיקר למטרות רפואיות כמו הקלה על כאבים, חרדה ודלקות."),
        ("האם CBD חוקי בישראל?", "CBD מופק מצמח הקנאביס ולכן הוא כפוף לחוקי הסמים בישראל. עם זאת, מוצרי CBD עם פחות מ-0.3% THC ניתנים לרכישה בצורה חוקית כתוסף תזונה."),
        ("מה ההשפעות הרפואיות של CBD?", "CBD ידוע ביכולתו להפחית חרדה, להקל על כאבים כרוניים, לסייע בנדודי שינה, להפחית דלקות ואף לסייע בטיפול באפילפסיה. הוא אינו ממכר ואין לו השפעה פסיכואקטיבית."),
        ("האם אפשר לקחת CBD ו-THC ביחד?", "כן, שילוב CBD ו-THC ידוע כ'אפקט הפמליה' (Entourage Effect) ויכול לשפר את ההשפעות הרפואיות. CBD יכול גם למתן את ההשפעות הפסיכואקטיביות של THC.")
    ],
    "גידול-ביתי-חוקי.html": [
        ("האם מותר לגדל קנאביס בבית בישראל?", "נכון ל-2026, גידול ביתי של קנאביס בישראל מותר רק למחזיקי רישיון קנאביס רפואי תקף, ובכפוף לתנאים מסוימים שנקבעו על ידי משרד הבריאות."),
        ("כמה צמחים מותר לגדל בבית?", "מספר הצמחים המותר לגידול ביתי נקבע על פי תנאי הרישיון הרפואי. בדרך כלל מדובר במספר מצומצם של צמחים לשימוש אישי בלבד."),
        ("מה צריך כדי להתחיל גידול ביתי?", "נדרשים: רישיון רפואי תקף, ציוד גידול מתאים (תאורה, אוורור, אדמה), זרעים ממקור מאושר, ומקום מאובטח ומאוורר. חשוב להקפיד על תנאי טמפרטורה ולחות."),
        ("מהם הזנים הטובים ביותר לגידול ביתי?", "זנים אוטופלאוורינג (Auto-Flowering) מתאימים למתחילים כי הם קטנים, מהירי גדילה ואינם דורשים שינוי במחזור התאורה. זנים כמו Northern Lights Auto ו-Blue Dream Auto פופולריים.")
    ],
    "דרכי-צריכה.html": [
        ("מהן דרכי הצריכה הנפוצות של קנאביס?", "דרכי הצריכה העיקריות כוללות: עישון, אידוי (וייפ), שמנים ותמציות, מאכלים (אדיבלס), קרמים ומשחות טופיקליות, וקפסולות. כל שיטה מתאימה לצרכים שונים."),
        ("מה ההבדל בין עישון לאידוי קנאביס?", "אידוי (וייפ) מחמם את הקנאביס לטמפרטורה נמוכה יותר מעישון, מה שמפחית את הנזק לריאות. האידוי מפיק יותר קנביאואידים ופחות רעלים בהשוואה לעישון."),
        ("כמה זמן לוקח להרגיש את ההשפעה?", "עישון ואידוי - השפעה תוך 2-10 דקות. שמנים תת-לשוניים - 15-30 דקות. מאכלים (אדיבלס) - 30-90 דקות. קרמים - 15-45 דקות. משך ההשפעה משתנה בהתאם."),
        ("מהי הדרך הבטוחה ביותר לצרוך קנאביס רפואי?", "אידוי (וייפ) ושמנים תת-לשוניים נחשבים לבטוחים ביותר כי הם מפחיתים נזק לריאות. חשוב להתחיל במינון נמוך ולהגביר בהדרגה בהתאם להמלצת הרופא.")
    ],
    "חוקיות-קנאביס-בישראל.html": [
        ("מה המצב החוקי של קנאביס בישראל ב-2026?", "נכון ל-2026, קנאביס רפואי חוקי בישראל עם רישיון מתאים. שימוש אישי בכמויות קטנות מטופל בקנס מנהלי ולא בהליך פלילי, אך מכירה והפצה עדיין אסורות."),
        ("מה העונש על החזקת קנאביס בישראל?", "החזקת קנאביס לשימוש אישי בפעם הראשונה גוררת קנס מנהלי. בפעם השנייה קנס כפול. בפעם השלישית ייתכן הליך פלילי. החזקת כמויות גדולות או מכירה נחשבות לעבירה פלילית."),
        ("איך מקבלים רישיון קנאביס רפואי?", "יש לפנות לרופא מומחה (כאב, אונקולוגיה, נוירולוגיה וכו') שיגיש בקשה למשרד הבריאות. התהליך כולל תיעוד רפואי, אישור מרופא, ואישור ממשרד הבריאות שנמשך 2-4 שבועות."),
        ("האם ניתן לנהוג תחת השפעת קנאביס רפואי?", "לא. נהיגה תחת השפעת קנאביס אסורה בישראל גם למחזיקי רישיון רפואי. THC נשאר בדם עד 24 שעות ובבדיקת שתן עד 30 יום.")
    ],
    "יתרונות-בריאותיים.html": [
        ("מהם היתרונות הבריאותיים המוכחים של קנאביס?", "מחקרים הוכיחו יתרונות בהקלת כאבים כרוניים, טיפול באפילפסיה (FDA אישר Epidiolex), הפחתת בחילות בכימותרפיה, שיפור שינה, הפחתת חרדה ודיכאון, והקלה בתסמיני PTSD."),
        ("האם קנאביס רפואי בטוח לשימוש?", "קנאביס רפואי בפיקוח רופא נחשב בטוח יחסית. תופעות לוואי אפשריות כוללות יובש בפה, עייפות וסחרחורת. חשוב לא לערבב עם תרופות אחרות ללא ייעוץ רפואי."),
        ("האם קנאביס יכול לעזור בכאבי גב?", "כן, קנאביס רפואי מאושר בישראל לטיפול בכאב כרוני כולל כאבי גב. מחקרים מראים שקנביאואידים פועלים על מערכת האנדוקנביאנואידית בגוף להפחתת כאב ודלקת."),
        ("מהם הסיכונים של שימוש ארוך טווח בקנאביס?", "שימוש ארוך טווח עלול לגרום לתלות פסיכולוגית, ירידה בזיכרון לטווח קצר, ופגיעה אפשרית בריאות הריאות (בעישון). שימוש רפואי מפוקח מפחית סיכונים אלו.")
    ],
    "מדריך-בטיחות-ואבטחה.html": [
        ("איך לשמור על בטיחות בשימוש בטלגראס?", "כללי בטיחות בסיסיים: לפגוש רק במקומות ציבוריים, לא לשלם מראש, לבדוק ביקורות על המוכר, לא לחשוף מידע אישי, לשמור על אנונימיות ולדווח על מוכרים חשודים."),
        ("איך לזהות הונאות בטלגראס?", "סימנים להונאה: דרישת תשלום מראש, מחירים נמוכים מדי, פרופיל חדש ללא ביקורות, לחץ לסגור עסקה מהר, ובקשה לפרטים אישיים. תמיד לבדוק דירוגים וביקורות."),
        ("איך לשמור על פרטיות בטלגרם?", "הפעילו אימות דו-שלבי, השתמשו בשם משתמש ולא במספר טלפון, הפעילו מחיקה אוטומטית של הודעות, אל תשתפו תמונות אישיות, והשתמשו ב-VPN לשכבת הגנה נוספת."),
        ("מה לעשות אם נתקלתם בבעיה?", "אם נפגעתם מהונאה: דווחו מיידית לטלגרם, חסמו את המשתמש, שמרו ראיות (צילומי מסך), ובמקרה חמור פנו למשטרה. אל תנסו להתמודד לבד עם מצבים מסוכנים.")
    ],
    "מדריך-טלגרם.html": [
        ("איך מורידים ומתקינים את טלגרם?", "טלגרם זמין בחינם ב-App Store (אייפון) וב-Google Play (אנדרואיד). הורידו את האפליקציה, הזינו את מספר הטלפון שלכם, ואמתו עם קוד SMS. ההתקנה אורכת פחות מ-2 דקות."),
        ("מהם הגדרות הפרטיות המומלצות בטלגרם?", "הגדרות מומלצות: הפעילו אימות דו-שלבי, הסתירו מספר טלפון (Privacy > Phone Number > Nobody), הפעילו Secret Chats לשיחות רגישות, והגדירו מחיקה אוטומטית של הודעות."),
        ("מה ההבדל בין ערוץ, קבוצה ובוט בטלגרם?", "ערוץ (Channel) - רק המנהל מפרסם, מתאים להודעות. קבוצה (Group) - כולם יכולים לכתוב. בוט (Bot) - תוכנה אוטומטית שנותנת שירות. בטלגראס משתמשים בעיקר בבוטים וערוצים."),
        ("איך מוצאים כיוונים בטלגרם?", "חפשו בטלגרם את השם של העיר שלכם + 'כיוונים'. בדקו שהערוץ אמין עם ביקורות, ומספר מנויים סביר. הימנעו מערוצים חדשים ללא היסטוריה.")
    ],
    "מדריך-קנאביס-רפואי.html": [
        ("מי זכאי לקנאביס רפואי בישראל?", "זכאים מטופלים הסובלים ממצבים כמו: כאב כרוני, מחלות סרטן, PTSD, אפילפסיה, טרשת נפוצה, מחלת קרוהן, פיברומיאלגיה ומצבים רפואיים נוספים. נדרש אישור רופא מומחה."),
        ("כמה עולה רישיון קנאביס רפואי?", "הבקשה למשרד הבריאות אינה כרוכה בתשלום. עלות הקנאביס הרפואי עצמו נעה בין 150-370 ש״ח לחודש בהתאם למינון ולספק. חלק מקופות החולים מסבסדות את העלות."),
        ("כמה זמן לוקח לקבל רישיון?", "התהליך אורך בין 2-8 שבועות: פנייה לרופא מומחה (1-2 שבועות), הגשת בקשה למשרד הבריאות (1-2 שבועות), קבלת אישור (2-4 שבועות). ניתן לזרז עם תיעוד רפואי מלא."),
        ("איפה ניתן לקנות קנאביס רפואי בישראל?", "קנאביס רפואי ניתן לרכוש רק בבתי מרקחת מורשים ובנקודות חלוקה מאושרות של חברות הקנאביס המורשות. אסור לרכוש ממקורות לא מורשים גם עם רישיון.")
    ],
    "זנים-פופולריים-בישראל.html": None,  # Already has FAQ
    "שאלות-נפוצות.html": None,  # Already has FAQ
    "ערים-בישראל.html": [
        ("כמה ערים יש ברשימת הכיוונים?", "ברשימה שלנו יש כיוונים ל-100 ערים ויישובים בכל רחבי ישראל, כולל ערים גדולות כמו תל אביב, ירושלים וחיפה, וגם ערים קטנות ויישובים."),
        ("איך מוצאים כיוונים לעיר שלי?", "חפשו את שם העיר שלכם ברשימה או השתמשו בחיפוש. כל עיר מכילה מידע על השכונות הפעילות, שעות פעילות ודרכי גישה למוכרים מאומתים."),
        ("האם הכיוונים מתעדכנים?", "כן, הכיוונים מתעדכנים באופן שוטף. אנו בודקים ומעדכנים את המידע מדי יום כדי לוודא שהמידע אמין ועדכני. עודכן לאחרונה: מרץ 2026."),
        ("באילו שעות הכיוונים פעילים?", "רוב הכיוונים פעילים 24/7, אך השעות הפעילות ביותר הן בין 10:00-22:00. בערים גדולות כמו תל אביב, חיפה וירושלים יש זמינות גבוהה גם בשעות הלילה.")
    ],
    "מאמרים.html": [
        ("מה סוגי המאמרים שיש באתר?", "האתר מכיל מאמרים מקצועיים על: זנים פופולריים בישראל, חוקיות הקנאביס, יתרונות בריאותיים, דרכי צריכה, מדריך בטיחות, CBD לעומת THC, גידול ביתי ועוד."),
        ("האם המאמרים מבוססים על מחקרים?", "כל המאמרים שלנו מבוססים על מחקרים עדכניים, מקורות רפואיים מוסמכים ומידע מעודכן ל-2026. אנו מקפידים על דיוק ומהימנות המידע."),
        ("כמה פעמים מתעדכנים המאמרים?", "המאמרים מתעדכנים באופן שוטף בהתאם לשינויים בחקיקה, מחקרים חדשים ומידע עדכני. כל מאמר מציג את תאריך העדכון האחרון."),
    ],
    "index.html": None,  # Already has comprehensive schema
}

# ============================================================
# CITY FAQ DATA - Generic template for all cities
# ============================================================
def get_city_faqs(city_name):
    return [
        (f"איך מוצאים כיוונים ב{city_name}?", f"ניתן למצוא כיוונים ב{city_name} דרך טלגראס - פלטפורמת הכיוונים המובילה בישראל. חפשו '{city_name} כיוונים' בטלגרם ובדקו את הדירוגים והביקורות של המוכרים."),
        (f"האם כיוונים ב{city_name} זמינים 24/7?", f"רוב הכיוונים ב{city_name} פעילים בשעות 10:00-22:00, אם כי חלק מהמוכרים פעילים גם בשעות הלילה. הזמינות משתנה לפי שכונה ויום בשבוע."),
        (f"איך לבדוק אמינות כיוונים ב{city_name}?", f"בדקו ביקורות של לקוחות קודמים, ותק המוכר, תגובתיות ואיכות השירות. הימנעו ממוכרים חדשים ללא היסטוריה או כאלה שדורשים תשלום מראש."),
        (f"מהם הסיכונים ברכישת קנאביס ב{city_name}?", f"הסיכונים כוללים: הונאות, איכות ירודה ובעיות חוקיות. חשוב להקפיד על בטיחות אישית, לפגוש במקומות ציבוריים ב{city_name} ולא לשאת כמויות גדולות.")
    ]

# ============================================================
# BREADCRUMB DATA for pages that need it
# ============================================================
BREADCRUMBS = {
    "CBD-לעומת-THC.html": ("CBD לעומת THC", "CBD-לעומת-THC.html"),
    "גידול-ביתי-חוקי.html": ("גידול ביתי חוקי", "גידול-ביתי-חוקי.html"),
    "דרכי-צריכה.html": ("דרכי צריכה", "דרכי-צריכה.html"),
    "חוקיות-קנאביס-בישראל.html": ("חוקיות קנאביס", "חוקיות-קנאביס-בישראל.html"),
    "יתרונות-בריאותיים.html": ("יתרונות בריאותיים", "יתרונות-בריאותיים.html"),
    "מאמרים.html": ("מאמרים", "מאמרים.html"),
    "מדריך-בטיחות-ואבטחה.html": ("מדריך בטיחות", "מדריך-בטיחות-ואבטחה.html"),
    "מדריך-טלגרם.html": ("מדריך טלגרם", "מדריך-טלגרם.html"),
    "מדריך-קנאביס-רפואי.html": ("קנאביס רפואי", "מדריך-קנאביס-רפואי.html"),
    "ערים-בישראל.html": ("ערים בישראל", "ערים-בישראל.html"),
    "שאלות-נפוצות.html": ("שאלות נפוצות", "שאלות-נפוצות.html"),
}

# ============================================================
# HELPER FUNCTIONS
# ============================================================

def make_faq_schema(faqs):
    """Generate FAQPage JSON-LD"""
    return json.dumps({
        "@context": "https://schema.org",
        "@type": "FAQPage",
        "mainEntity": [
            {
                "@type": "Question",
                "name": q,
                "acceptedAnswer": {
                    "@type": "Answer",
                    "text": a
                }
            } for q, a in faqs
        ]
    }, ensure_ascii=False, indent=4)

def make_breadcrumb_schema(name, filename):
    """Generate BreadcrumbList JSON-LD"""
    return json.dumps({
        "@context": "https://schema.org",
        "@type": "BreadcrumbList",
        "itemListElement": [
            {
                "@type": "ListItem",
                "position": 1,
                "name": "טלגראס כיוונים",
                "item": DOMAIN + "/"
            },
            {
                "@type": "ListItem",
                "position": 2,
                "name": name,
                "item": DOMAIN + "/" + filename
            }
        ]
    }, ensure_ascii=False, indent=4)

def make_speakable(css_selectors):
    """Generate SpeakableSpecification"""
    return {
        "@type": "SpeakableSpecification",
        "cssSelector": css_selectors
    }

def make_hreflang_tags(url):
    """Generate hreflang link tags"""
    return f'    <link rel="alternate" hreflang="he" href="{url}">\n    <link rel="alternate" hreflang="x-default" href="{url}">'

# ============================================================
# PROCESS MAIN PAGES
# ============================================================

def process_main_pages():
    count = 0
    for filename, faqs in PAGE_FAQS.items():
        filepath = os.path.join(BASE, filename)
        if not os.path.exists(filepath):
            print(f"  SKIP (not found): {filename}")
            continue
        
        with open(filepath, 'r', encoding='utf-8') as f:
            html = f.read()
        
        original = html
        changes = []
        
        # 1. Add FAQPage Schema if not present and we have FAQs
        if faqs and 'FAQPage' not in html:
            faq_script = f'\n    <!-- FAQ Schema for Rich Results -->\n    <script type="application/ld+json">\n    {make_faq_schema(faqs)}\n    </script>'
            # Insert before </head>
            html = html.replace('</head>', faq_script + '\n</head>', 1)
            changes.append("FAQPage")
        
        # 2. Add BreadcrumbList Schema if not present
        if filename in BREADCRUMBS and 'BreadcrumbList' not in html:
            name, fn = BREADCRUMBS[filename]
            bc_script = f'\n    <!-- Breadcrumb Schema -->\n    <script type="application/ld+json">\n    {make_breadcrumb_schema(name, fn)}\n    </script>'
            html = html.replace('</head>', bc_script + '\n</head>', 1)
            changes.append("BreadcrumbList")
        
        # 3. Add hreflang if not present
        if 'hreflang' not in html:
            url = DOMAIN + "/" + filename if filename != "index.html" else DOMAIN
            hreflang = '\n' + make_hreflang_tags(url)
            # Insert after canonical tag
            canonical_match = re.search(r'<link rel="canonical"[^>]*>', html)
            if canonical_match:
                pos = canonical_match.end()
                html = html[:pos] + hreflang + html[pos:]
                changes.append("hreflang")
        
        # 4. Add SpeakableSpecification to existing Article/WebPage schemas
        if '"@type": "Article"' in html or '"@type": "MedicalWebPage"' in html or '"@type": "HowTo"' in html:
            if '"speakable"' not in html and 'SpeakableSpecification' not in html:
                # Add speakable to existing schema
                speakable_json = ''',
        "speakable": {
            "@type": "SpeakableSpecification",
            "cssSelector": ["h1", ".lead", "h2", ".blog-content p"]
        }'''
                # Insert before the last closing brace of the first schema
                pattern = r'("inLanguage"\s*:\s*"he")'
                match = re.search(pattern, html)
                if match:
                    # Find the appropriate insertion point after inLanguage
                    pos = match.end()
                    # Check if there's more after inLanguage (like medicalAudience)
                    # We'll insert speakable before the closing of the main schema
                    # Find the end of the ld+json block
                    pass
                
                # Simpler approach: insert before the closing </script> of the first ld+json
                first_schema = re.search(r'(<script type="application/ld\+json">\s*\{.*?"inLanguage"\s*:\s*"he")', html, re.DOTALL)
                if first_schema:
                    # Find the next } that closes this schema, then the </script>
                    # Insert speakable after "inLanguage": "he" if it's followed by }
                    html = re.sub(
                        r'("inLanguage"\s*:\s*"he"\s*)([\s\n]*\})',
                        r'\1,' + '\n        "speakable": {\n            "@type": "SpeakableSpecification",\n            "cssSelector": ["h1", ".lead", "h2"]\n        }' + r'\2',
                        html, count=1
                    )
                    changes.append("Speakable")
        
        # 5. Add Twitter cards if missing
        if 'twitter:card' not in html and 'og:title' in html:
            og_title_match = re.search(r'<meta property="og:title" content="([^"]*)"', html)
            og_desc_match = re.search(r'<meta property="og:description"[^>]*content="([^"]*)"', html)
            og_image_match = re.search(r'<meta property="og:image" content="([^"]*)"', html)
            og_url_match = re.search(r'<meta property="og:url" content="([^"]*)"', html)
            
            if og_title_match:
                twitter_tags = f'''
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="{og_title_match.group(1)}">'''
                if og_desc_match:
                    twitter_tags += f'\n    <meta name="twitter:description" content="{og_desc_match.group(1)}">'
                if og_image_match:
                    twitter_tags += f'\n    <meta name="twitter:image" content="{og_image_match.group(1)}">'
                
                # Insert after og:locale
                locale_match = re.search(r'<meta property="og:locale" content="he_IL">', html)
                if locale_match:
                    html = html[:locale_match.end()] + twitter_tags + html[locale_match.end():]
                    changes.append("TwitterCard")
        
        if html != original:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(html)
            count += 1
            print(f"  ✅ {filename}: {', '.join(changes)}")
        else:
            print(f"  ⏭ {filename}: no changes needed")
    
    return count

# ============================================================
# PROCESS CITY PAGES
# ============================================================

def process_city_pages():
    cities_dir = os.path.join(BASE, 'cities')
    count = 0
    errors = 0
    
    for filepath in sorted(glob.glob(os.path.join(cities_dir, '*.html'))):
        filename = os.path.basename(filepath)
        
        with open(filepath, 'r', encoding='utf-8') as f:
            html = f.read()
        
        original = html
        changes = []
        
        # Extract city name from <title>
        title_match = re.search(r'<title>כיוונים\s+(.+?)\s+2026', html)
        if not title_match:
            title_match = re.search(r'<title>(.+?)\s*[\|<]', html)
        
        city_name = title_match.group(1).strip() if title_match else filename.replace('-כיוונים.html', '').replace('-', ' ')
        
        # 1. Add FAQPage Schema if not present
        if 'FAQPage' not in html:
            faqs = get_city_faqs(city_name)
            faq_script = f'\n    <!-- FAQ Schema for Rich Results -->\n    <script type="application/ld+json">\n    {make_faq_schema(faqs)}\n    </script>'
            html = html.replace('</head>', faq_script + '\n</head>', 1)
            changes.append("FAQPage")
        
        # 2. Add hreflang if not present
        if 'hreflang' not in html:
            url = DOMAIN + "/cities/" + filename
            hreflang = '\n' + make_hreflang_tags(url)
            canonical_match = re.search(r'<link rel="canonical"[^>]*>', html)
            if canonical_match:
                pos = canonical_match.end()
                html = html[:pos] + hreflang + html[pos:]
                changes.append("hreflang")
        
        # 3. Add SpeakableSpecification to existing schema
        if 'speakable' not in html.lower() and '"inLanguage": "he"' in html:
            html = re.sub(
                r'("inLanguage"\s*:\s*"he"\s*)([\s\n]*\})',
                r'\1,' + '\n        "speakable": {\n            "@type": "SpeakableSpecification",\n            "cssSelector": ["h1", ".lead", "h2"]\n        }' + r'\2',
                html, count=1
            )
            changes.append("Speakable")
        
        # 4. Add Twitter cards if missing
        if 'twitter:card' not in html and 'og:title' in html:
            og_title_match = re.search(r'<meta property="og:title" content="([^"]*)"', html)
            og_desc_match = re.search(r'<meta property="og:description"[^>]*content="([^"]*)"', html)
            og_image_match = re.search(r'<meta property="og:image" content="([^"]*)"', html)
            
            if og_title_match:
                twitter_tags = f'''
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="{og_title_match.group(1)}">'''
                if og_desc_match:
                    twitter_tags += f'\n    <meta name="twitter:description" content="{og_desc_match.group(1)}">'
                if og_image_match:
                    twitter_tags += f'\n    <meta name="twitter:image" content="{og_image_match.group(1)}">'
                
                locale_match = re.search(r'<meta property="og:locale" content="he_IL">', html)
                if locale_match:
                    html = html[:locale_match.end()] + twitter_tags + html[locale_match.end():]
                    changes.append("TwitterCard")
        
        if html != original:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(html)
            count += 1
            if count <= 5 or count % 20 == 0:
                print(f"  ✅ {filename}: {', '.join(changes)}")
        else:
            print(f"  ⏭ {filename}: no changes")
    
    print(f"  ... processed all city files")
    return count, errors

# ============================================================
# ADD SITE NAVIGATION SCHEMA TO INDEX.HTML
# ============================================================

def add_navigation_schema():
    filepath = os.path.join(BASE, 'index.html')
    with open(filepath, 'r', encoding='utf-8') as f:
        html = f.read()
    
    if 'SiteNavigationElement' in html:
        print("  ⏭ index.html: SiteNavigationElement already exists")
        return False
    
    nav_schema = '''
    <!-- Site Navigation Schema -->
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "SiteNavigationElement",
        "name": "טלגראס כיוונים - ניווט ראשי",
        "hasPart": [
            {
                "@type": "WebPage",
                "name": "כל הערים",
                "url": "''' + DOMAIN + '''/ערים-בישראל.html"
            },
            {
                "@type": "WebPage",
                "name": "מדריך טלגרם",
                "url": "''' + DOMAIN + '''/מדריך-טלגרם.html"
            },
            {
                "@type": "WebPage",
                "name": "קנאביס רפואי",
                "url": "''' + DOMAIN + '''/מדריך-קנאביס-רפואי.html"
            },
            {
                "@type": "WebPage",
                "name": "זנים פופולריים",
                "url": "''' + DOMAIN + '''/זנים-פופולריים-בישראל.html"
            },
            {
                "@type": "WebPage",
                "name": "חוקיות קנאביס",
                "url": "''' + DOMAIN + '''/חוקיות-קנאביס-בישראל.html"
            },
            {
                "@type": "WebPage",
                "name": "מדריך בטיחות",
                "url": "''' + DOMAIN + '''/מדריך-בטיחות-ואבטחה.html"
            },
            {
                "@type": "WebPage",
                "name": "שאלות נפוצות",
                "url": "''' + DOMAIN + '''/שאלות-נפוצות.html"
            }
        ]
    }
    </script>'''
    
    html = html.replace('</head>', nav_schema + '\n</head>', 1)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(html)
    
    print("  ✅ index.html: SiteNavigationElement added")
    return True

# ============================================================
# ADD FAQ SCHEMA + SPEAKABLE TO INDEX.HTML
# ============================================================

def enhance_index():
    filepath = os.path.join(BASE, 'index.html')
    with open(filepath, 'r', encoding='utf-8') as f:
        html = f.read()
    
    changes = []
    
    # Add FAQPage to index if not present
    if 'FAQPage' not in html:
        index_faqs = [
            ("מה זה טלגראס כיוונים?", "טלגראס כיוונים היא פלטפורמת המידע המובילה בישראל למציאת כיוונים לקנאביס. האתר מספק מידע על כיוונים בכל 100 הערים בישראל, מדריכי בטיחות, מידע חוקי ומדריכים מקצועיים."),
            ("איך עובד טלגראס כיוונים?", "טלגראס פועל דרך אפליקציית טלגרם. משתמשים מחפשים כיוונים לפי עיר, בודקים ביקורות ודירוגים של מוכרים, ובוחרים את הכיוון המתאים להם. האתר שלנו מספק מדריכים ומידע על השימוש הבטוח."),
            ("האם טלגראס כיוונים חוקי?", "האתר מספק מידע בלבד ואינו מעורב במכירה או הפצה. קנאביס רפואי הוא חוקי בישראל עם רישיון מתאים. שימוש אישי בכמויות קטנות גורר קנס מנהלי ולא הליך פלילי."),
            ("באילו ערים יש כיוונים?", "יש כיוונים בכל 100 הערים הגדולות בישראל כולל: תל אביב, ירושלים, חיפה, באר שבע, נתניה, ראשון לציון, פתח תקוה, אשדוד ועוד. הרשימה המלאה זמינה בעמוד הערים.")
        ]
        faq_script = f'\n    <!-- FAQ Schema for Rich Results -->\n    <script type="application/ld+json">\n    {make_faq_schema(index_faqs)}\n    </script>'
        html = html.replace('</head>', faq_script + '\n</head>', 1)
        changes.append("FAQPage")
    
    # Add speakable to main schema
    if 'speakable' not in html.lower():
        # Add to the WebSite schema
        html = re.sub(
            r'("sameAs"\s*:\s*\[.*?\])',
            r'\1,' + '\n        "speakable": {\n            "@type": "SpeakableSpecification",\n            "cssSelector": ["h1", ".lead", ".display-5", "h2"]\n        }',
            html, count=1, flags=re.DOTALL
        )
        changes.append("Speakable")
    
    if changes:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(html)
        print(f"  ✅ index.html: {', '.join(changes)}")
    return len(changes) > 0

# ============================================================
# CREATE llms.txt FOR AI CRAWLERS
# ============================================================

def create_llms_txt():
    content = """# טלגראס כיוונים - Telegrass Kivunim
# https://xn----zhcfoankcogt8ah0h.xyz

## About
Telegrass Kivunim (טלגראס כיוונים) is Israel's leading information platform about cannabis directions (kivunim) via Telegram.
We provide comprehensive guides, city-specific information, safety guides, and medical cannabis information for all 100+ cities in Israel.

## Main Pages
- Homepage: https://xn----zhcfoankcogt8ah0h.xyz/
- All Cities: https://xn----zhcfoankcogt8ah0h.xyz/ערים-בישראל.html
- Telegram Guide: https://xn----zhcfoankcogt8ah0h.xyz/מדריך-טלגרם.html
- Medical Cannabis Guide: https://xn----zhcfoankcogt8ah0h.xyz/מדריך-קנאביס-רפואי.html
- Popular Strains: https://xn----zhcfoankcogt8ah0h.xyz/זנים-פופולריים-בישראל.html
- Cannabis Legality in Israel: https://xn----zhcfoankcogt8ah0h.xyz/חוקיות-קנאביס-בישראל.html
- Health Benefits: https://xn----zhcfoankcogt8ah0h.xyz/יתרונות-בריאותיים.html
- Consumption Methods: https://xn----zhcfoankcogt8ah0h.xyz/דרכי-צריכה.html
- CBD vs THC: https://xn----zhcfoankcogt8ah0h.xyz/CBD-לעומת-THC.html
- Safety Guide: https://xn----zhcfoankcogt8ah0h.xyz/מדריך-בטיחות-ואבטחה.html
- Home Growing: https://xn----zhcfoankcogt8ah0h.xyz/גידול-ביתי-חוקי.html
- FAQ: https://xn----zhcfoankcogt8ah0h.xyz/שאלות-נפוצות.html
- Articles: https://xn----zhcfoankcogt8ah0h.xyz/מאמרים.html

## Major City Pages
- Tel Aviv: https://xn----zhcfoankcogt8ah0h.xyz/cities/תל-אביב-כיוונים.html
- Jerusalem: https://xn----zhcfoankcogt8ah0h.xyz/cities/ירושלים-כיוונים.html
- Haifa: https://xn----zhcfoankcogt8ah0h.xyz/cities/חיפה-כיוונים.html
- Beer Sheva: https://xn----zhcfoankcogt8ah0h.xyz/cities/באר-שבע-כיוונים.html
- Netanya: https://xn----zhcfoankcogt8ah0h.xyz/cities/נתניה-כיוונים.html
- Rishon LeZion: https://xn----zhcfoankcogt8ah0h.xyz/cities/ראשון-לציון-כיוונים.html
- Petah Tikva: https://xn----zhcfoankcogt8ah0h.xyz/cities/פתח-תקוה-כיוונים.html
- Ashdod: https://xn----zhcfoankcogt8ah0h.xyz/cities/אשדוד-כיוונים.html
- Ramat Gan: https://xn----zhcfoankcogt8ah0h.xyz/cities/רמת-גן-כיוונים.html
- Eilat: https://xn----zhcfoankcogt8ah0h.xyz/cities/אילת-כיוונים.html

## Topics Covered
- Cannabis directions (kivunim) for 100+ cities in Israel
- Medical cannabis licensing and regulations in Israel
- Cannabis strain reviews and information
- Safety and security guides for Telegram users
- Legal status of cannabis in Israel (updated 2026)
- Health benefits and medical research
- Consumption methods and guides
- CBD vs THC comparison
- Home growing regulations

## Language
Primary language: Hebrew (he)
Content is written in Hebrew with RTL layout.

## Contact
Website: https://xn----zhcfoankcogt8ah0h.xyz
"""
    
    filepath = os.path.join(BASE, 'llms.txt')
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print("  ✅ llms.txt created")
    return True

# ============================================================
# FIX NEWS-SITEMAP.XML
# ============================================================

def fix_news_sitemap():
    filepath = os.path.join(BASE, 'news-sitemap.xml')
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Fix broken URL
    content = content.replace('טלגראס כיוונים-כיוונים.xyz', 'xn----zhcfoankcogt8ah0h.xyz')
    # Fix the loc URL too
    content = content.replace('articles.html', 'מאמרים.html')
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print("  ✅ news-sitemap.xml: fixed broken URL")
    return True

# ============================================================
# UPDATE RSS TO 2026
# ============================================================

def update_rss():
    filepath = os.path.join(BASE, 'rss.xml')
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    changes = []
    
    # Update dates from 2025 to 2026
    content = content.replace('Sat, 21 Jun 2025', 'Thu, 05 Mar 2026')
    content = content.replace('2025 10:00:00', '2026 10:00:00')
    content = content.replace('2025 12:00:00', '2026 12:00:00')
    content = content.replace('2025 09:00:00', '2026 09:00:00')
    content = content.replace('2025 08:00:00', '2026 08:00:00')
    content = content.replace('2025 07:00:00', '2026 07:00:00')
    
    # Update article titles to 2026
    content = content.replace('מדריך קנאביס רפואי בישראל 2025', 'מדריך קנאביס רפואי בישראל 2026')
    content = content.replace('חוקיות קנאביס בישראל 2025', 'חוקיות קנאביס בישראל 2026')
    content = content.replace('זנים פופולריים בישראל 2025', 'זנים פופולריים בישראל 2026')
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print("  ✅ rss.xml: updated to 2026")
    return True

# ============================================================
# UPDATE ROBOTS.TXT WITH AI BOT DIRECTIVES
# ============================================================

def update_robots():
    filepath = os.path.join(BASE, 'robots.txt')
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    if 'llms.txt' in content:
        print("  ⏭ robots.txt: already updated")
        return False
    
    new_content = """User-agent: *
Allow: /

# AI Crawlers Welcome
User-agent: GPTBot
Allow: /

User-agent: Google-Extended
Allow: /

User-agent: ChatGPT-User
Allow: /

User-agent: CCBot
Allow: /

User-agent: anthropic-ai
Allow: /

User-agent: Claude-Web
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Bytespider
Allow: /

Sitemap: https://xn----zhcfoankcogt8ah0h.xyz/sitemap.xml
Sitemap: https://xn----zhcfoankcogt8ah0h.xyz/news-sitemap.xml

# LLMs.txt - AI friendly site description
# https://xn----zhcfoankcogt8ah0h.xyz/llms.txt
"""
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)
    
    print("  ✅ robots.txt: updated with AI bot directives")
    return True

# ============================================================
# FIX ERIIM PAGE YEAR (2025 -> 2026 in schema)
# ============================================================
def fix_erim_schema():
    filepath = os.path.join(BASE, 'ערים-בישראל.html')
    with open(filepath, 'r', encoding='utf-8') as f:
        html = f.read()
    
    if '2025' in html:
        html = html.replace('"name": "טלגראס כיוונים כל הערים בישראל 2025"', '"name": "טלגראס כיוונים כל הערים בישראל 2026"')
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(html)
        print("  ✅ ערים-בישראל.html: fixed schema year to 2026")
        return True
    return False

# ============================================================
# MAIN
# ============================================================

if __name__ == '__main__':
    print("=" * 60)
    print("🚀 SEO MEGA BOOST - Starting...")
    print("=" * 60)
    
    print("\n📝 Step 1: Creating llms.txt for AI crawlers...")
    create_llms_txt()
    
    print("\n🤖 Step 2: Updating robots.txt with AI bot directives...")
    update_robots()
    
    print("\n📰 Step 3: Fixing news-sitemap.xml...")
    fix_news_sitemap()
    
    print("\n📡 Step 4: Updating RSS feed to 2026...")
    update_rss()
    
    print("\n🏠 Step 5: Enhancing index.html (FAQ + Speakable + Navigation)...")
    enhance_index()
    add_navigation_schema()
    
    print("\n🗓 Step 6: Fixing ערים-בישראל.html schema year...")
    fix_erim_schema()
    
    print("\n📄 Step 7: Processing main pages (FAQ, Breadcrumb, hreflang, Speakable, Twitter)...")
    main_count = process_main_pages()
    print(f"   Main pages updated: {main_count}")
    
    print("\n🏙 Step 8: Processing city pages (FAQ, hreflang, Speakable, Twitter)...")
    city_count, city_errors = process_city_pages()
    print(f"   City pages updated: {city_count}, Errors: {city_errors}")
    
    print("\n" + "=" * 60)
    print("✅ SEO MEGA BOOST COMPLETE!")
    print(f"   Main pages: {main_count}")
    print(f"   City pages: {city_count}")
    print(f"   + llms.txt, robots.txt, news-sitemap.xml, rss.xml")
    print("=" * 60)
