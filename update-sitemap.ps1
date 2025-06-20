# Update Sitemap with Hebrew City Pages
# This script adds all Hebrew city pages to the sitemap.xml file

# Set the base URL and date
$baseUrl = "https://xn----zhcfoankcogt8ah0h.xyz"
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Get all Hebrew city files
$cityFiles = Get-ChildItem "cities" -Filter "*.html" | Where-Object { $_.Name -ne "smart-hebrew-url-fix.ps1" } | Sort-Object Name

# Start building the new sitemap content
$sitemapContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:xhtml="http://www.w3.org/1999/xhtml">
    <!-- Homepage -->
  <url>
    <loc>$baseUrl/</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
    <xhtml:link rel="alternate" hreflang="he" href="$baseUrl/" />
  </url>
  
  <!-- Cities Index Page -->
  <url>
    <loc>$baseUrl/cities-israel.html</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.9</priority>
    <xhtml:link rel="alternate" hreflang="he" href="$baseUrl/cities-israel.html" />
  </url>
  
  <!-- Top Strains Guide -->
  <url>
    <loc>$baseUrl/top-strains-israel.html</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
    <xhtml:link rel="alternate" hreflang="he" href="$baseUrl/top-strains-israel.html" />
  </url>
  
  <!-- Medical Cannabis Guide -->
  <url>
    <loc>$baseUrl/medical-cannabis-guide.html</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="he" href="$baseUrl/medical-cannabis-guide.html" />
  </url>
  
  <!-- Telegram Guide -->
  <url>
    <loc>$baseUrl/telegram-guide.html</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
    <xhtml:link rel="alternate" hreflang="he" href="$baseUrl/telegram-guide.html" />
  </url>
  
  <!-- Safety Security Guide -->
  <url>
    <loc>$baseUrl/safety-security-guide.html</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
    <xhtml:link rel="alternate" hreflang="he" href="$baseUrl/safety-security-guide.html" />
  </url>
  
"@

# Add all Hebrew city pages
foreach ($file in $cityFiles) {
    $encodedFileName = [System.Uri]::EscapeDataString($file.Name)
    $sitemapContent += @"
  <!-- City: $($file.Name) -->
  <url>
    <loc>$baseUrl/cities/$encodedFileName</loc>
    <lastmod>$currentDate</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.6</priority>
    <xhtml:link rel="alternate" hreflang="he" href="$baseUrl/cities/$encodedFileName" />
  </url>
  
"@
}

# Close the sitemap
$sitemapContent += @"
</urlset>
"@

# Write the new sitemap
$sitemapContent | Out-File -FilePath "sitemap.xml" -Encoding UTF8

Write-Host "Sitemap updated successfully!"
Write-Host "Total city pages added: $($cityFiles.Count)"
Write-Host "Sitemap file: sitemap.xml"
