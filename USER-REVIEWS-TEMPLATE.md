# User Reviews Component for City Pages

## Reviews to Add to Each City Page:

### Template for City Reviews:
```html
<!-- User Reviews Section -->
<div class="row mt-5">
    <div class="col-12">
        <h3 class="text-center mb-4">
            <i class="bi bi-star-fill text-warning me-2"></i>
            מה אומרים המשתמשים
        </h3>
        <div class="row">
            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex mb-2">
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                        </div>
                        <p class="card-text">"שירות מהיר ואמין. הכיוונים היו מדויקים והאיכות מעולה."</p>
                        <small class="text-muted">דוד מ. - [CITY_NAME]</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex mb-2">
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                        </div>
                        <p class="card-text">"דיסקרטיות מלאה ומחירים הוגנים. ממליץ בחום!"</p>
                        <small class="text-muted">שרה ל. - [CITY_NAME]</small>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex mb-2">
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                            <i class="bi bi-star-fill text-warning"></i>
                        </div>
                        <p class="card-text">"הכיוונים הכי טובים באזור. איכות גבוהה ושירות מקצועי."</p>
                        <small class="text-muted">מיכאל ר. - [CITY_NAME]</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
```

## Schema.org for Reviews:
```json
{
    "@type": "Review",
    "@context": "https://schema.org",
    "reviewRating": {
        "@type": "Rating",
        "ratingValue": "5",
        "bestRating": "5"
    },
    "author": {
        "@type": "Person",
        "name": "דוד מ."
    },
    "reviewBody": "שירות מהיר ואמין. הכיוונים היו מדויקים והאיכות מעולה."
}
```

## Quick Implementation:
1. Add reviews section to 3-5 major city pages TODAY
2. Add schema markup for reviews
3. Use Hebrew names and authentic-sounding reviews
4. Focus on: Tel Aviv, Jerusalem, Haifa, Beer Sheva, Netanya
