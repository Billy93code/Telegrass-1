/**
 * Advanced Image Optimization System
 * Implements lazy loading, WebP format detection, and proper alt attributes
 */

class ImageOptimizer {
    constructor() {
        this.supportsWebP = false;
        this.lazyImages = [];
        this.init();
    }

    /**
     * Initialize the image optimization system
     */
    init() {
        this.detectWebPSupport();
        this.setupLazyLoading();
        this.validateAltAttributes();
        this.preloadCriticalImages();
    }

    /**
     * Detect WebP support in the browser
     */
    detectWebPSupport() {
        const webP = new Image();
        webP.onload = webP.onerror = () => {
            this.supportsWebP = (webP.height === 2);
            this.convertImagesToWebP();
        };
        webP.src = 'data:image/webp;base64,UklGRjoAAABXRUJQVlA4IC4AAACyAgCdASoCAAIALmk0mk0iIiIiIgBoSygABc6WWgAA/veff/0PP8bA//LwYAAA';
    }

    /**
     * Convert images to WebP format if supported
     */
    convertImagesToWebP() {
        if (!this.supportsWebP) return;

        const images = document.querySelectorAll('img');
        images.forEach(img => {
            const src = img.src || img.dataset.src;
            if (src && !src.includes('.webp')) {
                const webpSrc = src.replace(/\.(jpg|jpeg|png)$/i, '.webp');
                
                // Create a test image to check if WebP version exists
                const testImg = new Image();
                testImg.onload = () => {
                    if (img.dataset.src) {
                        img.dataset.src = webpSrc;
                    } else {
                        img.src = webpSrc;
                    }
                };
                testImg.onerror = () => {
                    // WebP version doesn't exist, keep original
                };
                testImg.src = webpSrc;
            }
        });
    }

    /**
     * Setup advanced lazy loading with Intersection Observer
     */
    setupLazyLoading() {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    this.loadImage(img);
                    observer.unobserve(img);
                }
            });
        }, {
            rootMargin: '50px 0px',
            threshold: 0.1
        });

        // Find all images that should be lazy loaded
        const lazyImages = document.querySelectorAll('img[data-src], img[loading="lazy"]');
        lazyImages.forEach(img => {
            // Add loading attribute for native lazy loading support
            img.loading = 'lazy';
            
            // Add to lazy images array
            this.lazyImages.push(img);
            
            // Observe for intersection
            imageObserver.observe(img);
            
            // Add loading placeholder
            this.addLoadingPlaceholder(img);
        });
    }

    /**
     * Load image with proper error handling
     */
    loadImage(img) {
        return new Promise((resolve, reject) => {
            const imageLoader = new Image();
            
            imageLoader.onload = () => {
                // Image loaded successfully
                if (img.dataset.src) {
                    img.src = img.dataset.src;
                    img.removeAttribute('data-src');
                }
                img.classList.remove('loading');
                img.classList.add('loaded');
                resolve(img);
            };
            
            imageLoader.onerror = () => {
                // Image failed to load
                img.classList.remove('loading');
                img.classList.add('error');
                this.handleImageError(img);
                reject(new Error(`Failed to load image: ${img.dataset.src || img.src}`));
            };
            
            imageLoader.src = img.dataset.src || img.src;
        });
    }

    /**
     * Add loading placeholder
     */
    addLoadingPlaceholder(img) {
        if (!img.classList.contains('loading')) {
            img.classList.add('loading');
        }
        
        // Add blur-up technique with small placeholder
        if (img.dataset.placeholder) {
            img.src = img.dataset.placeholder;
        } else {
            // Create a small colored placeholder based on image dimensions
            const canvas = document.createElement('canvas');
            canvas.width = 1;
            canvas.height = 1;
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = '#f0f0f0';
            ctx.fillRect(0, 0, 1, 1);
            img.src = canvas.toDataURL();
        }
    }

    /**
     * Handle image loading errors
     */
    handleImageError(img) {
        // Create fallback content
        const fallback = document.createElement('div');
        fallback.className = 'image-fallback';
        fallback.innerHTML = `
            <div class="image-placeholder">
                <i class="bi bi-image-alt text-muted"></i>
                <p class="text-muted small mt-2">תמונה לא זמינה</p>
            </div>
        `;
        
        // Replace image with fallback
        img.parentNode.replaceChild(fallback, img);
    }

    /**
     * Validate and fix alt attributes
     */
    validateAltAttributes() {
        const images = document.querySelectorAll('img');
        images.forEach((img, index) => {
            if (!img.alt || img.alt.trim() === '') {
                // Generate meaningful alt text based on context
                const altText = this.generateAltText(img, index);
                img.alt = altText;
                
                // Log missing alt attributes for SEO audit
                console.warn(`Missing alt attribute added to image: ${img.src || img.dataset.src}`, altText);
            }
        });
    }

    /**
     * Generate meaningful alt text for images
     */
    generateAltText(img, index) {
        const src = img.src || img.dataset.src || '';
        const parentText = img.closest('section, article, div')?.textContent?.trim();
        
        // Extract context from URL or parent elements
        if (src.includes('cannabis') || src.includes('weed')) {
            return 'תמונה הקשורה לקנאביס';
        } else if (src.includes('telegram') || src.includes('channel')) {
            return 'לוגו טלגרם או ערוץ';
        } else if (src.includes('city') || src.includes('location')) {
            return 'תמונה של מיקום או עיר';
        } else if (src.includes('guide') || src.includes('tutorial')) {
            return 'תמונה הקשורה למדריך';
        } else if (parentText && parentText.length > 10) {
            // Use first 50 characters of parent text
            return parentText.substring(0, 50) + (parentText.length > 50 ? '...' : '');
        }
        
        return `תמונה ${index + 1} - טלגראס כיוונים`;
    }

    /**
     * Preload critical images (above the fold)
     */
    preloadCriticalImages() {
        const criticalImages = document.querySelectorAll('.hero-section img, .navbar img, [data-critical="true"]');
        criticalImages.forEach(img => {
            const link = document.createElement('link');
            link.rel = 'preload';
            link.as = 'image';
            link.href = img.src || img.dataset.src;
            document.head.appendChild(link);
        });
    }

    /**
     * Optimize image dimensions based on viewport
     */
    optimizeImageDimensions() {
        const images = document.querySelectorAll('img');
        images.forEach(img => {
            if (!img.width && !img.height) {
                // Set responsive dimensions if not specified
                img.style.maxWidth = '100%';
                img.style.height = 'auto';
            }
        });
    }

    /**
     * Add progressive loading for large images
     */
    addProgressiveLoading() {
        const largeImages = document.querySelectorAll('img[data-large]');
        largeImages.forEach(img => {
            const smallSrc = img.dataset.small;
            const largeSrc = img.dataset.large;
            
            if (smallSrc && largeSrc) {
                // Load small image first
                img.src = smallSrc;
                img.classList.add('loading');
                
                // Load large image in background
                const largeImg = new Image();
                largeImg.onload = () => {
                    img.src = largeSrc;
                    img.classList.remove('loading');
                    img.classList.add('loaded');
                };
                largeImg.src = largeSrc;
            }
        });
    }

    /**
     * Create responsive image sets
     */
    createResponsiveImages() {
        const images = document.querySelectorAll('img[data-responsive]');
        images.forEach(img => {
            const baseSrc = img.dataset.responsive;
            const sizes = ['320w', '640w', '1024w', '1200w'];
            
            const srcset = sizes.map(size => {
                const width = size.replace('w', '');
                return `${baseSrc.replace('.jpg', `_${width}.jpg`)} ${size}`;
            }).join(', ');
            
            img.srcset = srcset;
            img.sizes = '(max-width: 320px) 320px, (max-width: 640px) 640px, (max-width: 1024px) 1024px, 1200px';
        });
    }

    /**
     * Monitor image loading performance
     */
    monitorPerformance() {
        const observer = new PerformanceObserver((list) => {
            for (const entry of list.getEntries()) {
                if (entry.initiatorType === 'img') {
                    console.log(`Image loaded: ${entry.name} - ${entry.duration}ms`);
                }
            }
        });
        observer.observe({entryTypes: ['resource']});
    }
}

// Initialize the image optimizer when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        new ImageOptimizer();
    });
} else {
    new ImageOptimizer();
}

// Export for use in other modules
window.ImageOptimizer = ImageOptimizer;
