/**
 * Cannabis Blog - Main JavaScript File
 * Modern interactive features for the cannabis blog
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initNavbar();
    initScrollAnimations();
    initSmoothScrolling();
    initImageLazyLoading();
    initParticleBackground();
    initScrollProgress();
    // initTypingEffect(); // Disabled to remove typography delay
    initIconAnimations();
    initIconReplacements();
    initCityCards();
});

/**
 * Navbar functionality
 */
function initNavbar() {
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 100) {
            navbar.style.backgroundColor = 'rgba(45, 80, 22, 0.95)';
            navbar.style.backdropFilter = 'blur(15px)';
        } else {
            navbar.style.backgroundColor = 'rgba(45, 80, 22, 0.8)';
            navbar.style.backdropFilter = 'blur(10px)';
        }
    });

    // Mobile menu close on link click
    const navLinks = document.querySelectorAll('.nav-link');
    const navbarCollapse = document.querySelector('.navbar-collapse');
    
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            if (navbarCollapse.classList.contains('show')) {
                bootstrap.Collapse.getInstance(navbarCollapse).hide();
            }
        });
    });
}

/**
 * Scroll animations
 */
function initScrollAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe cards and sections
    const animatedElements = document.querySelectorAll('.card, .guide-card, section > .container > .row');
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'all 0.6s ease-out';
        observer.observe(el);
    });
}

/**
 * Smooth scrolling for anchor links
 */
function initSmoothScrolling() {
    const anchorLinks = document.querySelectorAll('a[href^="#"]');
    
    anchorLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                const navbarHeight = document.querySelector('.navbar').offsetHeight;
                const targetPosition = targetElement.offsetTop - navbarHeight;
                
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });
}

/**
 * Lazy loading for images
 */
function initImageLazyLoading() {
    const images = document.querySelectorAll('img[data-src]');
    
    const imageObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.remove('loading');
                imageObserver.unobserve(img);
            }
        });
    });
    
    images.forEach(img => {
        img.classList.add('loading');
        imageObserver.observe(img);
    });
}

/**
 * Scroll progress indicator
 */
function initScrollProgress() {
    const progressBar = document.createElement('div');
    progressBar.className = 'scroll-indicator';
    document.body.appendChild(progressBar);
    
    window.addEventListener('scroll', function() {
        const windowHeight = document.documentElement.scrollHeight - window.innerHeight;
        const scrolled = (window.scrollY / windowHeight) * 100;
        progressBar.style.transform = `scaleX(${scrolled / 100})`;
    });
}

/**
 * Typing effect for hero title - DISABLED FOR LCP PERFORMANCE
 */
function initTypingEffect() {
    // Typing effect disabled to improve LCP performance
    // Hero title now displays immediately without letter-by-letter animation
    return;
}

/**
 * Particle background animation
 */
function initParticleBackground() {
    const canvas = document.createElement('canvas');
    canvas.id = 'particle-canvas';
    canvas.style.position = 'fixed';
    canvas.style.top = '0';
    canvas.style.left = '0';
    canvas.style.width = '100%';
    canvas.style.height = '100%';
    canvas.style.pointerEvents = 'none';
    canvas.style.zIndex = '-1';
    canvas.style.opacity = '0.1';
    
    document.body.appendChild(canvas);
    
    const ctx = canvas.getContext('2d');
    let particles = [];
    
    // Resize canvas
    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    
    // Particle class
    class Particle {
        constructor() {
            this.x = Math.random() * canvas.width;
            this.y = Math.random() * canvas.height;
            this.vx = (Math.random() - 0.5) * 0.5;
            this.vy = (Math.random() - 0.5) * 0.5;
            this.radius = Math.random() * 3 + 1;
            this.opacity = Math.random() * 0.5 + 0.3;
        }
        
        update() {
            this.x += this.vx;
            this.y += this.vy;
            
            if (this.x < 0 || this.x > canvas.width) this.vx *= -1;
            if (this.y < 0 || this.y > canvas.height) this.vy *= -1;
        }
        
        draw() {
            ctx.beginPath();
            ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
            ctx.fillStyle = `rgba(74, 124, 89, ${this.opacity})`;
            ctx.fill();
        }
    }
    
    // Initialize particles
    function initParticles() {
        particles = [];
        const particleCount = Math.floor((canvas.width * canvas.height) / 10000);
        
        for (let i = 0; i < particleCount; i++) {
            particles.push(new Particle());
        }
    }
    
    // Animation loop
    function animate() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        
        particles.forEach(particle => {
            particle.update();
            particle.draw();
        });
        
        // Draw connections
        particles.forEach((particle, i) => {
            particles.slice(i + 1).forEach(otherParticle => {
                const dx = particle.x - otherParticle.x;
                const dy = particle.y - otherParticle.y;
                const distance = Math.sqrt(dx * dx + dy * dy);
                
                if (distance < 100) {
                    ctx.beginPath();
                    ctx.moveTo(particle.x, particle.y);
                    ctx.lineTo(otherParticle.x, otherParticle.y);
                    ctx.strokeStyle = `rgba(74, 124, 89, ${0.2 * (1 - distance / 100)})`;
                    ctx.stroke();
                }
            });
        });
        
        requestAnimationFrame(animate);
    }
    
    // Initialize
    resizeCanvas();
    initParticles();
    animate();
    
    // Handle resize
    window.addEventListener('resize', () => {
        resizeCanvas();
        initParticles();
    });
}

/**
 * Newsletter subscription
 */
function initNewsletter() {
    const newsletterForm = document.querySelector('.newsletter-form');
    
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const email = this.querySelector('input[type="email"]').value;
            const submitBtn = this.querySelector('button[type="submit"]');
            
            submitBtn.textContent = 'נרשם...';
            submitBtn.disabled = true;
            
            // Simulate subscription (replace with actual API call)
            setTimeout(() => {
                alert('נרשמת בהצלחה לניוזלטר!');
                this.reset();
                submitBtn.textContent = 'הרשמה';
                submitBtn.disabled = false;
            }, 1500);
        });
    }
}

/**
 * Search functionality
 */
function initSearch() {
    const searchToggle = document.querySelector('.search-toggle');
    const searchForm = document.querySelector('.search-form');
    
    if (searchToggle && searchForm) {
        searchToggle.addEventListener('click', function() {
            searchForm.classList.toggle('active');
            const searchInput = searchForm.querySelector('input');
            if (searchForm.classList.contains('active')) {
                searchInput.focus();
            }
        });
        
        searchForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const query = this.querySelector('input').value;
            // Implement search functionality here
            console.log('חיפוש:', query);
        });
    }
}

/**
 * Cookie consent (GDPR compliance)
 */
function initCookieConsent() {
    const cookieConsent = document.createElement('div');
    cookieConsent.className = 'cookie-consent position-fixed bottom-0 start-0 end-0 bg-dark text-white p-3';
    cookieConsent.style.zIndex = '10000';
    cookieConsent.innerHTML = `
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <p class="mb-0">אנו משתמשים בעוגיות כדי לשפר את החוויה שלך באתר. המשך הגלישה מהווה הסכמה לשימוש בעוגיות.</p>
                </div>
                <div class="col-md-4 text-end">
                    <button class="btn btn-outline-light btn-sm me-2" onclick="acceptCookies()">הסכמה</button>
                    <button class="btn btn-link text-white btn-sm" onclick="declineCookies()">דחיה</button>
                </div>
            </div>
        </div>
    `;
    
    if (!localStorage.getItem('cookieConsent')) {
        document.body.appendChild(cookieConsent);
    }
    
    window.acceptCookies = function() {
        localStorage.setItem('cookieConsent', 'accepted');
        cookieConsent.remove();
    };
    
    window.declineCookies = function() {
        localStorage.setItem('cookieConsent', 'declined');
        cookieConsent.remove();
    };
}

/**
 * Back to top button
 */
function initBackToTop() {
    const backToTopBtn = document.createElement('button');
    backToTopBtn.className = 'btn btn-primary position-fixed rounded-circle';
    backToTopBtn.style.bottom = '80px';
    backToTopBtn.style.right = '20px';
    backToTopBtn.style.width = '50px';
    backToTopBtn.style.height = '50px';
    backToTopBtn.style.zIndex = '9998';
    backToTopBtn.style.display = 'none';
    backToTopBtn.innerHTML = '<i class="bi bi-arrow-up"></i>';
    backToTopBtn.title = 'חזרה למעלה';
    
    document.body.appendChild(backToTopBtn);
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 300) {
            backToTopBtn.style.display = 'block';
        } else {
            backToTopBtn.style.display = 'none';
        }
    });
    
    backToTopBtn.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
}

/**
 * Enhanced Icon Animations
 */
function initIconAnimations() {
    // Add hover effects to icons
    const icons = document.querySelectorAll('.bi');
    
    icons.forEach(icon => {
        // Add random animation delays for organic feel
        const delay = Math.random() * 2;
        icon.style.animationDelay = `${delay}s`;
        
        // Add interactive hover effects
        icon.addEventListener('mouseenter', function() {
            this.style.animationPlayState = 'paused';
            this.style.transform = 'scale(1.1)';
        });
        
        icon.addEventListener('mouseleave', function() {
            this.style.animationPlayState = 'running';
            this.style.transform = 'scale(1)';
        });
    });
    
    // Special effects for cannabis icons
    const cannabisIcons = document.querySelectorAll('.bi-flower1, .bi-flower2, .bi-flower3');
    cannabisIcons.forEach(icon => {
        icon.addEventListener('click', function() {
            this.style.animation = 'iconGrow 0.8s ease-in-out';
            setTimeout(() => {
                this.style.animation = '';
            }, 800);
        });
    });
    
    // Intersection Observer for icons
    const iconObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const icon = entry.target;
                icon.style.animationPlayState = 'running';
                
                // Add special entrance animation
                icon.style.opacity = '0';
                icon.style.transform = 'scale(0) rotate(180deg)';
                
                setTimeout(() => {
                    icon.style.transition = 'all 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
                    icon.style.opacity = '1';
                    icon.style.transform = 'scale(1) rotate(0deg)';
                }, 100);
            }
        });
    }, { threshold: 0.1 });
    
    // Observe all feature icons
    const featureIcons = document.querySelectorAll('.feature-icon, .guide-icon, .blog-icon');
    featureIcons.forEach(icon => iconObserver.observe(icon));
}

/**
 * Icon replacement system
 */
function initIconReplacements() {
    // Replace images with appropriate icons
    const imageReplacements = {
        'cannabis': 'bi-flower1',
        'security': 'bi-shield-check',
        'telegram': 'bi-telegram',
        'medical': 'bi-heart-pulse',
        'guide': 'bi-book',
        'safety': 'bi-shield-lock',
        'community': 'bi-people',
        'strain': 'bi-flower2'
    };
    
    // Find images and replace with icons
    const images = document.querySelectorAll('img');
    images.forEach(img => {
        const alt = img.alt.toLowerCase();
        const src = img.src.toLowerCase();
        
        let iconClass = 'bi-flower1'; // default
        
        // Determine appropriate icon based on alt text or src
        if (alt.includes('security') || alt.includes('safety')) iconClass = 'bi-shield-check';
        else if (alt.includes('telegram')) iconClass = 'bi-telegram';
        else if (alt.includes('medical')) iconClass = 'bi-heart-pulse';
        else if (alt.includes('guide')) iconClass = 'bi-book';
        else if (alt.includes('community')) iconClass = 'bi-people';
        else if (alt.includes('strain') || alt.includes('cannabis')) iconClass = 'bi-flower2';
        
        // Create icon element
        const iconContainer = document.createElement('div');
        iconContainer.className = 'icon-container text-center';
        iconContainer.innerHTML = `<i class="bi ${iconClass} feature-icon glow"></i>`;
        
        // Replace image with icon (optional - user can choose)
        if (img.closest('.hero-section') || img.closest('.card-img-top')) {
            // For hero and card images, create overlay option
            const overlay = document.createElement('div');
            overlay.className = 'icon-overlay position-absolute top-50 start-50 translate-middle';
            overlay.innerHTML = `<i class="bi ${iconClass} hero-icon"></i>`;
            overlay.style.display = 'none';
            
            img.parentNode.style.position = 'relative';
            img.parentNode.appendChild(overlay);
            
            // Toggle on click
            img.addEventListener('click', () => {
                if (overlay.style.display === 'none') {
                    overlay.style.display = 'block';
                    img.style.opacity = '0.3';
                } else {
                    overlay.style.display = 'none';
                    img.style.opacity = '1';
                }
            });
        }
    });
}

/**
 * Initialize City Cards with enhanced interactions
 */
function initCityCards() {
    const cityCards = document.querySelectorAll('.city-card');
    
    cityCards.forEach((card, index) => {
        // Add entrance animation delay
        card.style.animationDelay = `${index * 0.1}s`;
        
        // Add hover sound effect (optional)
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.02)';
            
            // Add ripple effect to Telegram button
            const telegramBtn = this.querySelector('.btn-telegram');
            if (telegramBtn) {
                telegramBtn.style.boxShadow = '0 0 0 0 rgba(0, 136, 204, 0.7)';
                telegramBtn.style.animation = 'telegramPulse 1s ease-out';
            }
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
            
            const telegramBtn = this.querySelector('.btn-telegram');
            if (telegramBtn) {
                telegramBtn.style.animation = '';
            }
        });
        
        // Add click tracking for analytics (optional) - FIXED: Don't prevent default
        const telegramBtn = card.querySelector('.btn-telegram');
        if (telegramBtn) {
            telegramBtn.addEventListener('click', function(e) {
                const cityName = card.querySelector('h5').textContent;
                console.log(`כיוון נלחץ: ${cityName}`);
                
                // Add visual feedback
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 150);
                
                // IMPORTANT: Don't prevent default - let the link work
                // e.preventDefault() was removed to allow normal link behavior
                
                // Optional: Add analytics tracking here
                // gtag('event', 'click_telegram_direction', {
                //     'city': cityName,
                //     'event_category': 'engagement'
                // });
            });
        }
        
        // Add intersection observer for scroll-triggered animations
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animationPlayState = 'running';
                    
                    // Trigger city icon animation
                    const cityIcon = entry.target.querySelector('.city-icon');
                    if (cityIcon) {
                        setTimeout(() => {
                            cityIcon.style.animation = 'iconBounce 0.8s ease-in-out';
                        }, index * 100);
                    }
                }
            });
        }, { threshold: 0.3 });
        
        observer.observe(card);
    });
    
    // Add special effects to safety notice
    const safetyNotice = document.querySelector('.alert-warning');
    if (safetyNotice) {
        const safetyObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animation = 'fadeInUp 0.8s ease-out';
                    
                    const icon = entry.target.querySelector('.bi-shield-exclamation');
                    if (icon) {
                        icon.style.animation = 'iconPulse 2s infinite';
                    }
                }
            });
        }, { threshold: 0.5 });
        
        safetyObserver.observe(safetyNotice);
    }
    
    // Add dynamic time display for city operating hours
    updateCityHours();
    setInterval(updateCityHours, 60000); // Update every minute
}

/**
 * Update city operating hours display
 */
function updateCityHours() {
    const now = new Date();
    const currentHour = now.getHours();
    const cityCards = document.querySelectorAll('.city-card');
    
    cityCards.forEach(card => {
        const cityInfo = card.querySelector('.city-info small');
        if (cityInfo && cityInfo.textContent.includes('זמין')) {
            // Add status indicator for 24/7 services
            if (cityInfo.textContent.includes('24/7')) {
                const statusDot = '<span class="status-dot online me-1"></span>';
                if (!cityInfo.innerHTML.includes('status-dot')) {
                    cityInfo.innerHTML = statusDot + cityInfo.innerHTML;
                }
            } else {
                // Parse operating hours and show status
                const hoursMatch = cityInfo.textContent.match(/(\d+):(\d+)-(\d+):(\d+)/);
                if (hoursMatch) {
                    const openHour = parseInt(hoursMatch[1]);
                    const closeHour = parseInt(hoursMatch[3]);
                    const isOpen = currentHour >= openHour && currentHour < closeHour;
                    
                    const statusDot = `<span class="status-dot ${isOpen ? 'online' : 'offline'} me-1"></span>`;
                    const cleanText = cityInfo.textContent.replace(/^●\s*/, '');
                    cityInfo.innerHTML = statusDot + cleanText;
                }
            }
        }
    });
}

/**
 * Enhanced Image Lazy Loading with WebP support
 */
function initAdvancedImageLazyLoading() {
    // Check for native lazy loading support
    const supportsLazyLoading = 'loading' in HTMLImageElement.prototype;
    
    if (supportsLazyLoading) {
        // Use native lazy loading for supported browsers
        const images = document.querySelectorAll('img[data-src]');
        images.forEach(img => {
            img.loading = 'lazy';
            img.src = img.dataset.src;
            img.removeAttribute('data-src');
        });
    } else {
        // Fallback to Intersection Observer
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    loadImageWithOptimization(img);
                    observer.unobserve(img);
                }
            });
        }, {
            rootMargin: '50px 0px',
            threshold: 0.1
        });

        const lazyImages = document.querySelectorAll('img[data-src]');
        lazyImages.forEach(img => imageObserver.observe(img));
    }
}

// Load image with WebP detection and optimization
function loadImageWithOptimization(img) {
    const src = img.dataset.src;
    if (!src) return;

    // Check for WebP support
    const supportsWebP = checkWebPSupport();
    
    // Try WebP version first if supported
    if (supportsWebP && !src.includes('.webp')) {
        const webpSrc = src.replace(/\.(jpg|jpeg|png)$/i, '.webp');
        tryLoadImage(webpSrc, img, src);
    } else {
        loadImage(src, img);
    }
}

// Check WebP support
function checkWebPSupport() {
    if (window.webpSupported !== undefined) {
        return window.webpSupported;
    }
    
    const canvas = document.createElement('canvas');
    canvas.width = 1;
    canvas.height = 1;
    window.webpSupported = canvas.toDataURL('image/webp').indexOf('data:image/webp') === 0;
    return window.webpSupported;
}

// Try to load WebP image with fallback
function tryLoadImage(webpSrc, img, fallbackSrc) {
    const testImg = new Image();
    testImg.onload = () => loadImage(webpSrc, img);
    testImg.onerror = () => loadImage(fallbackSrc, img);
    testImg.src = webpSrc;
}

// Load image with proper error handling and alt text validation
function loadImage(src, img) {
    // Validate alt attribute
    if (!img.alt || img.alt.trim() === '') {
        img.alt = generateAltText(img, src);
    }
    
    const imageLoader = new Image();
    imageLoader.onload = () => {
        img.src = src;
        img.classList.remove('loading');
        img.classList.add('loaded');
        img.removeAttribute('data-src');
    };
    
    imageLoader.onerror = () => {
        img.classList.remove('loading');
        img.classList.add('error');
        handleImageError(img);
    };
    
    imageLoader.src = src;
}

// Generate meaningful alt text
function generateAltText(img, src) {
    // Extract context from surrounding elements
    const parentSection = img.closest('section, article');
    const parentText = parentSection ? parentSection.textContent.trim() : '';
    
    // Generate alt text based on context
    if (src.includes('cannabis') || src.includes('weed')) {
        return 'תמונה הקשורה לקנאביס רפואי';
    } else if (src.includes('telegram')) {
        return 'לוגו טלגרם וערוצי כיוונים';
    } else if (src.includes('city') || src.includes('location')) {
        return 'תמונה של מיקום או עיר בישראל';
    } else if (src.includes('guide')) {
        return 'תמונה הקשורה למדריך טלגראס';
    } else if (parentText && parentText.length > 10) {
        return parentText.substring(0, 50) + '...';
    }
    
    return 'תמונה - טלגראס כיוונים ישראל';
}

// Handle image loading errors
function handleImageError(img) {
    const fallback = document.createElement('div');
    fallback.className = 'image-fallback';
    fallback.innerHTML = `
        <div class="image-placeholder">
            <i class="bi bi-image-alt"></i>
            <p class="text-muted small mt-2">תמונה לא זמינה</p>
        </div>
    `;
    
    // Replace image with fallback
    if (img.parentNode) {
        img.parentNode.replaceChild(fallback, img);
    }
}

// Preload critical images
function preloadCriticalImages() {
    const criticalImages = document.querySelectorAll('[data-critical="true"], .hero-section img, .navbar img');
    
    criticalImages.forEach(img => {
        const src = img.src || img.dataset.src;
        if (src) {
            const link = document.createElement('link');
            link.rel = 'preload';
            link.as = 'image';
            link.href = src;
            document.head.appendChild(link);
        }
    });
}

// Add responsive image srcset
function addResponsiveImageSrcset() {
    const images = document.querySelectorAll('img[data-responsive]');
    
    images.forEach(img => {
        const baseSrc = img.dataset.responsive;
        const breakpoints = [320, 640, 1024, 1200];
        
        const srcset = breakpoints.map(width => {
            const responsiveSrc = baseSrc.replace(/\.(jpg|jpeg|png)$/i, `_${width}w.$1`);
            return `${responsiveSrc} ${width}w`;
        }).join(', ');
        
        img.srcset = srcset;
        img.sizes = '(max-width: 320px) 320px, (max-width: 640px) 640px, (max-width: 1024px) 1024px, 1200px';
    });
}

// Initialize image optimization on DOM ready
function initImageOptimization() {
    preloadCriticalImages();
    initAdvancedImageLazyLoading();
    addResponsiveImageSrcset();
    validateAllImageAltAttributes();
}

// Validate all image alt attributes
function validateAllImageAltAttributes() {
    const images = document.querySelectorAll('img');
    let missingAltCount = 0;
    
    images.forEach((img, index) => {
        if (!img.alt || img.alt.trim() === '') {
            const altText = generateAltText(img, img.src || img.dataset.src || '');
            img.alt = altText;
            missingAltCount++;
        }
    });
    
    if (missingAltCount > 0) {
        console.warn(`Added alt attributes to ${missingAltCount} images for better SEO`);
    }
}

// Initialize all optimizations when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeOptimizations);
} else {
    initializeOptimizations();
}

function initializeOptimizations() {
    // Initialize image optimizations
    initImageOptimization();
    
    // Initialize other existing functions if they exist
    if (typeof initPreloader === 'function') initPreloader();
    if (typeof initScrollProgress === 'function') initScrollProgress();
    // if (typeof initTypingEffect === 'function') initTypingEffect(); // Disabled for LCP performance
    if (typeof initSmoothScrolling === 'function') initSmoothScrolling();
    if (typeof initAnimations === 'function') initAnimations();
    if (typeof initPerformanceMonitoring === 'function') initPerformanceMonitoring();
    if (typeof initIconAnimations === 'function') initIconAnimations();
    if (typeof initIconReplacements === 'function') initIconReplacements();
    
    // Initialize status updates if exists
    if (typeof updateCityStatuses === 'function') updateCityStatuses();
    
    console.log('All SEO and performance optimizations initialized');
}
