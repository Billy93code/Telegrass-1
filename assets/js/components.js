/**
 * Component Loader - Load reusable components
 * Optimized to prevent navbar flickering by loading synchronously
 */

// Synchronous component loader using XMLHttpRequest for immediate loading
function loadComponentSync(elementId, componentPath) {
    const element = document.getElementById(elementId);
    if (!element) return false;

    try {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', componentPath, false); // false = synchronous
        xhr.send();
        
        if (xhr.status === 200) {
            let html = xhr.responseText;
            
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
            throw new Error(`HTTP ${xhr.status}`);
        }
    } catch (error) {
        console.warn(`Failed to load ${componentPath}:`, error);
        return false;
    }
}

// Asynchronous component loader for non-critical components
function loadComponentAsync(containerId, componentPath) {
    const container = document.getElementById(containerId);
    if (!container) return;
    
    fetch(componentPath)
        .then(response => {
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            return response.text();
        })
        .then(html => {
            // If we're in cities folder and loading navbar, adjust paths
            if (containerId === 'navbar-container' && window.location.pathname.includes('/cities/')) {
                html = adjustNavbarPaths(html);
            }
            container.innerHTML = html;
        })
        .catch(error => {
            console.error(`Error loading ${componentPath}:`, error);
            container.innerHTML = '<div class="alert alert-danger">Failed to load component</div>';
        });
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

// Load navbar IMMEDIATELY (synchronously) to prevent flickering
const inCities = window.location.pathname.includes('/cities/');
const basePath = inCities ? '../components/' : 'components/';

// Critical: Load navbar synchronously before page renders
// This runs as soon as the script is loaded, not after DOM ready
(function() {
    const navbarContainer = document.getElementById('navbar-container');
    if (navbarContainer) {
        const success = loadComponentSync('navbar-container', basePath + 'navbar.html');
        
        // Fallback if sync loading fails
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
})();

// Load footer when DOM is ready (can be asynchronous)
document.addEventListener('DOMContentLoaded', function() {
    const footerContainer = document.getElementById('footer-container') || document.getElementById('footer-placeholder');
    if (footerContainer && !footerContainer.innerHTML.trim()) {
        loadComponentAsync(footerContainer.id, basePath + 'footer.html');
    }
});
