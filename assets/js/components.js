/**
 * Component Loader - Load reusable components
 * Optimized to prevent navbar flickering by loading asynchronously with fallback
 */

// Asynchronous component loader with immediate fallback to prevent flickering
async function loadComponentAsync(elementId, componentPath) {
    const element = document.getElementById(elementId);
    if (!element) return false;

    try {
        const response = await fetch(componentPath);
        
        if (response.ok) {
            let html = await response.text();
            
            // If we're in cities folder and loading navbar, adjust paths
            if (elementId === 'navbar-container' && window.location.pathname.includes('/cities/')) {
                html = adjustNavbarPaths(html);
            }
            
            element.innerHTML = html;
            
            // Execute any scripts in the loaded content
            const scripts = element.querySelectorAll('script');
            scripts.forEach(script => {
                const newScript = document.createElement('script');
                newScript.textContent = script.textContent;
                document.head.appendChild(newScript);
            });
            
            return true;
        } else {
            throw new Error(`HTTP ${response.status}`);
        }
    } catch (error) {
        console.warn(`Failed to load ${componentPath}:`, error);
        return false;
    }
}

/**
 * Adjust navbar paths for cities subfolder
 */
function adjustNavbarPaths(html) {
    // Replace all href attributes that don't already start with ../ or http
    return html.replace(/href="([^"]*\.html[^"]*)"/g, (match, url) => {
        if (url.startsWith('../') || url.startsWith('http') || url.startsWith('#')) {
            return match;
        }
        return `href="../${url}"`;
    });
}

// Load navbar and components when DOM is ready
document.addEventListener('DOMContentLoaded', async function() {
    const inCities = window.location.pathname.includes('/cities/');
    const basePath = inCities ? '../components/' : 'components/';
    
    // Load navbar first (critical component)
    const navbarContainer = document.getElementById('navbar-container');
    if (navbarContainer) {
        const success = await loadComponentAsync('navbar-container', basePath + 'navbar.html');
        
        // Fallback if loading fails
        if (!success) {
            navbarContainer.innerHTML = `
                <nav class="navbar navbar-expand-lg navbar-dark bg-dark-green fixed-top" style="background-color: #1a3409 !important;">
                    <div class="container">
                        <a class="navbar-brand fw-bold" href="${inCities ? '../' : ''}index.html" style="color: #fff;">
                            🌿 טלגראס כיוונים
                        </a>
                        <div class="directions-btn-container">
                            <a href="${inCities ? '../' : ''}index.html#directions" class="btn btn-directions" style="background: #d4af37; color: #1a3409; padding: 0.6rem 1.5rem; border-radius: 25px; font-weight: 600; text-decoration: none;">
                                📍 כיוונים
                            </a>
                        </div>
                    </div>
                </nav>`;
        }
    }
    
    // Load footer (non-critical component)
    const footerContainer = document.getElementById('footer-container') || document.getElementById('footer-placeholder');
    if (footerContainer && !footerContainer.innerHTML.trim()) {
        await loadComponentAsync(footerContainer.id, basePath + 'footer.html');
    }
});
