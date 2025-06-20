# Internal Linking Strategy for City Pages

## Add to EVERY city page:

### Related Cities Section (Add before footer):
```html
<!-- Related Cities Section -->
<section class="py-5 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h3 class="text-center mb-4">
                    <i class="bi bi-map me-2"></i>
                    כיוונים בערים קרובות
                </h3>
                <div class="row g-3">
                    <!-- Add 4-6 nearby cities with Hebrew links -->
                    <div class="col-6 col-md-3">
                        <a href="[NEARBY_CITY]-כיוונים.html" class="btn btn-outline-primary w-100">
                            <i class="bi bi-geo-alt me-1"></i>
                            [CITY_NAME]
                        </a>
                    </div>
                    <!-- Repeat for nearby cities -->
                </div>
            </div>
        </div>
    </div>
</section>
```

## Priority Cities to Link First:
1. Tel Aviv ↔ Jerusalem, Haifa, Netanya, Petah Tikva
2. Jerusalem ↔ Tel Aviv, Beer Sheva, Bet Shemesh
3. Haifa ↔ Tel Aviv, Netanya, Nazareth
4. Beer Sheva ↔ Jerusalem, Ashkelon, Ashdod

## SEO Benefits:
- Distributes page authority across city pages
- Increases time on site
- Helps Google understand site structure
- Improves user experience

## Implementation Plan:
1. Add to 10 major cities TODAY
2. Add to all 100 cities over next 2 weeks
3. Monitor internal linking in Search Console
