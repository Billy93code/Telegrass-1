/**
 * Critical CSS Inlining System
 * Extracts and inlines critical above-the-fold CSS for faster rendering
 */

class CriticalCSSInliner {
    constructor() {
        this.criticalCSS = '';
        this.nonCriticalCSS = '';
        this.init();
    }

    /**
     * Initialize critical CSS extraction and inlining
     */
    init() {
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => {
                this.extractCriticalCSS();
                this.inlineCriticalCSS();
                this.loadNonCriticalCSS();
            });
        } else {
            this.extractCriticalCSS();
            this.inlineCriticalCSS();
            this.loadNonCriticalCSS();
        }
    }

    /**
     * Extract critical CSS rules for above-the-fold content
     */
    extractCriticalCSS() {
        // Define critical selectors for above-the-fold content
        const criticalSelectors = [
            'body',
            'html',
            '.navbar',
            '.hero-section',
            '.container',
            '.row',
            '.col-*',
            '.d-none',
            '.d-block',
            '.text-center',
            '.text-white',
            '.bg-dark-green',
            '.btn-primary',
            '.btn-telegram',
            '.hero-title',
            '.hero-description',
            '.display-3',
            '.lead',
            '.mb-*',
            '.mt-*',
            '.p-*',
            '.m-*',
            '.fade-in',
            '.animate-*'
        ];

        this.criticalCSS = this.generateCriticalCSS(criticalSelectors);
    }

    /**
     * Generate critical CSS content
     */
    generateCriticalCSS(selectors) {
        return `
/* Critical CSS - Above the fold styles */
:root {
    --primary-green: #2d5016;
    --secondary-green: #4a7c59;
    --light-green: #e8f5e8;
    --accent-green: #7cb342;
    --dark-green: #1a3409;
    --cannabis-gold: #d4af37;
    --text-dark: #2c3e50;
    --text-light: #6c757d;
    --gradient-green: linear-gradient(135deg, #2d5016 0%, #4a7c59 100%);
    --gradient-light: linear-gradient(135deg, #e8f5e8 0%, #f8f9fa 100%);
}

* {
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: 'Heebo', sans-serif;
    line-height: 1.6;
    color: var(--text-dark);
    margin: 0;
    padding: 0;
    overflow-x: hidden;
}

.container {
    width: 100%;
    padding-right: 15px;
    padding-left: 15px;
    margin-right: auto;
    margin-left: auto;
}

@media (min-width: 576px) {
    .container { max-width: 540px; }
}

@media (min-width: 768px) {
    .container { max-width: 720px; }
}

@media (min-width: 992px) {
    .container { max-width: 960px; }
}

@media (min-width: 1200px) {
    .container { max-width: 1140px; }
}

.row {
    display: flex;
    flex-wrap: wrap;
    margin-right: -15px;
    margin-left: -15px;
}

[class*="col-"] {
    position: relative;
    width: 100%;
    padding-right: 15px;
    padding-left: 15px;
}

.col-12 { flex: 0 0 100%; max-width: 100%; }
.col-lg-6 { flex: 0 0 50%; max-width: 50%; }
.col-lg-12 { flex: 0 0 100%; max-width: 100%; }

.navbar {
    position: relative;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    padding: 1rem 0;
    backdrop-filter: blur(10px);
    box-shadow: 0 2px 20px rgba(45, 80, 22, 0.1);
    transition: all 0.3s ease;
    background: var(--gradient-green);
}

.hero-section {
    min-height: 100vh;
    background: linear-gradient(135deg, rgba(45, 80, 22, 0.8), rgba(74, 124, 89, 0.8));
    display: flex;
    align-items: center;
    position: relative;
    overflow: hidden;
}

.hero-section::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%234a7c59' fill-opacity='0.05'%3E%3Cpath d='M30 30c0-11.046-8.954-20-20-20s-20 8.954-20 20 8.954 20 20 20 20-8.954 20-20z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    opacity: 0.3;
    z-index: -1;
}

.hero-title {
    font-size: 3.5rem;
    font-weight: 700;
    line-height: 1.2;
    margin-bottom: 1.5rem;
}

.hero-description {
    font-size: 1.3rem;
    font-weight: 400;
    margin-bottom: 2rem;
}

.text-center { text-align: center !important; }
.text-white { color: #fff !important; }

.bg-dark-green {
    background: var(--gradient-green) !important;
}

.btn {
    display: inline-block;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    text-align: center;
    text-decoration: none;
    vertical-align: middle;
    cursor: pointer;
    user-select: none;
    background-color: transparent;
    border: 1px solid transparent;
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    border-radius: 0.25rem;
    transition: all 0.15s ease-in-out;
}

.btn-primary {
    color: #fff;
    background-color: var(--accent-green);
    border-color: var(--accent-green);
}

.btn-telegram {
    background: linear-gradient(45deg, #0088cc, #00acc1);
    color: white;
    border: none;
    padding: 1rem 2rem;
    font-size: 1.1rem;
    font-weight: 600;
    border-radius: 50px;
    box-shadow: 0 4px 15px rgba(0, 136, 204, 0.3);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.btn-telegram:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 136, 204, 0.4);
    color: white;
}

.display-3 {
    font-size: 2.5rem;
    font-weight: 700;
    line-height: 1.2;
}

.lead {
    font-size: 1.3rem;
    font-weight: 400;
}

.mb-4 { margin-bottom: 1.5rem !important; }
.mb-5 { margin-bottom: 3rem !important; }
.mt-4 { margin-top: 1.5rem !important; }
.p-0 { padding: 0 !important; }
.min-vh-100 { min-height: 100vh !important; }

.align-items-center { align-items: center !important; }

.d-none { display: none !important; }
.d-block { display: block !important; }

.fade-in {
    opacity: 0;
    transform: translateY(30px);
    animation: fadeInUp 0.8s ease forwards;
}

@keyframes fadeInUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.animate-fade-in {
    animation: fadeInUp 1s ease forwards;
}

.animate-fade-in-delay {
    animation: fadeInUp 1s ease 0.3s forwards;
    opacity: 0;
}

/* Loading states */
.loading {
    background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
    background-size: 200% 100%;
    animation: loading 1.5s infinite;
    opacity: 0.7;
}

@keyframes loading {
    0% { background-position: 200% 0; }
    100% { background-position: -200% 0; }
}

/* Font loading optimization */
@font-face {
    font-family: 'Heebo';
    font-style: normal;
    font-weight: 300;
    font-display: swap;
    src: url('/fonts/heebo-300.woff2') format('woff2');
}

@font-face {
    font-family: 'Heebo';
    font-style: normal;
    font-weight: 400;
    font-display: swap;
    src: url('/fonts/heebo-400.woff2') format('woff2');
}

@font-face {
    font-family: 'Heebo';
    font-style: normal;
    font-weight: 700;
    font-display: swap;
    src: url('/fonts/heebo-700.woff2') format('woff2');
}

/* Mobile first responsive design */
@media (max-width: 768px) {
    .hero-title {
        font-size: 2.5rem;
    }
    
    .hero-description {
        font-size: 1.1rem;
    }
    
    .btn-telegram {
        padding: 0.75rem 1.5rem;
        font-size: 1rem;
    }
    
    .display-3 {
        font-size: 2rem;
    }
}

@media (max-width: 576px) {
    .hero-title {
        font-size: 2rem;
    }
    
    .container {
        padding-right: 10px;
        padding-left: 10px;
    }
    
    .row {
        margin-right: -10px;
        margin-left: -10px;
    }
    
    [class*="col-"] {
        padding-right: 10px;
        padding-left: 10px;
    }
}
`;
    }

    /**
     * Inline critical CSS in the document head
     */
    inlineCriticalCSS() {
        // Remove existing critical CSS if any
        const existingCritical = document.querySelector('#critical-css');
        if (existingCritical) {
            existingCritical.remove();
        }

        // Create and inject critical CSS
        const style = document.createElement('style');
        style.id = 'critical-css';
        style.innerHTML = this.criticalCSS;
        
        // Insert before any existing stylesheets
        const firstLink = document.querySelector('link[rel="stylesheet"]');
        if (firstLink) {
            firstLink.parentNode.insertBefore(style, firstLink);
        } else {
            document.head.appendChild(style);
        }

        console.log('Critical CSS inlined successfully');
    }

    /**
     * Load non-critical CSS asynchronously
     */
    loadNonCriticalCSS() {
        const stylesheets = document.querySelectorAll('link[rel="stylesheet"]');
        
        stylesheets.forEach(link => {
            // Skip critical stylesheets
            if (link.href.includes('bootstrap') || link.href.includes('style.css')) {
                this.loadStylesheetAsync(link);
            }
        });
    }

    /**
     * Load stylesheet asynchronously
     */
    loadStylesheetAsync(link) {
        // Create new link element for async loading
        const asyncLink = document.createElement('link');
        asyncLink.rel = 'preload';
        asyncLink.as = 'style';
        asyncLink.href = link.href;
        asyncLink.onload = function() {
            this.onload = null;
            this.rel = 'stylesheet';
        };
        
        // Insert async link
        link.parentNode.insertBefore(asyncLink, link);
        
        // Add fallback for browsers that don't support preload
        const noscript = document.createElement('noscript');
        const fallbackLink = link.cloneNode();
        noscript.appendChild(fallbackLink);
        link.parentNode.insertBefore(noscript, link.nextSibling);
        
        // Remove original link to avoid render blocking
        link.remove();
    }

    /**
     * Optimize font loading
     */
    optimizeFontLoading() {
        // Add font preload links
        const fontPreloads = [
            '/fonts/heebo-400.woff2',
            '/fonts/heebo-700.woff2'
        ];

        fontPreloads.forEach(fontUrl => {
            const link = document.createElement('link');
            link.rel = 'preload';
            link.as = 'font';
            link.type = 'font/woff2';
            link.crossOrigin = 'anonymous';
            link.href = fontUrl;
            document.head.appendChild(link);
        });
    }

    /**
     * Monitor CSS loading performance
     */
    monitorCSSPerformance() {
        // Measure CSS loading times
        const observer = new PerformanceObserver((list) => {
            for (const entry of list.getEntries()) {
                if (entry.initiatorType === 'css' || entry.name.includes('.css')) {
                    console.log(`CSS loaded: ${entry.name} - ${entry.duration}ms`);
                }
            }
        });
        observer.observe({entryTypes: ['resource']});

        // Measure First Contentful Paint
        new PerformanceObserver((entryList) => {
            const entries = entryList.getEntries();
            const firstContentfulPaint = entries.find(entry => entry.name === 'first-contentful-paint');
            if (firstContentfulPaint) {
                console.log(`First Contentful Paint: ${firstContentfulPaint.startTime}ms`);
            }
        }).observe({entryTypes: ['paint']});
    }

    /**
     * Remove unused CSS (basic implementation)
     */
    removeUnusedCSS() {
        // This would require a more sophisticated implementation
        // For now, we'll just log what could be optimized
        const stylesheets = document.styleSheets;
        let totalRules = 0;
        let usedRules = 0;

        for (let stylesheet of stylesheets) {
            try {
                for (let rule of stylesheet.cssRules) {
                    totalRules++;
                    if (rule.selectorText) {
                        const element = document.querySelector(rule.selectorText);
                        if (element) {
                            usedRules++;
                        }
                    }
                }
            } catch (e) {
                // Cross-origin stylesheet, skip
            }
        }

        const unusedPercentage = ((totalRules - usedRules) / totalRules * 100).toFixed(2);
        console.log(`CSS Usage: ${usedRules}/${totalRules} rules used (${unusedPercentage}% unused)`);
    }
}

// Auto-initialize critical CSS inliner
new CriticalCSSInliner();
