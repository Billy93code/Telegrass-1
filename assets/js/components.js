/**
 * Component Loader - Load reusable components
 */

document.addEventListener('DOMContentLoaded', function() {
    // Detect if we're in cities folder
    const inCities = window.location.pathname.includes('/cities/');
    const path = inCities ? '../components/' : 'components/';
    
    // Check if we're on the homepage (index.html has inlined navbar for LCP performance)
    const isHomepage = window.location.pathname === '/' || window.location.pathname.endsWith('/index.html') || window.location.pathname.endsWith('/');    // Load navbar component only for non-homepage pages
    if (!isHomepage) {
        loadComponent('navbar-container', path + 'navbar.html');
    }
      // Always load footer component
    if (document.getElementById('footer-container')) {
        loadComponent('footer-container', path + 'footer.html');
    } else if (document.getElementById('footer-placeholder')) {
        loadComponent('footer-placeholder', path + 'footer.html');
    }
});

/**
 * Load component into a container
 */
function loadComponent(containerId, componentPath) {
    const container = document.getElementById(containerId);
    if (!container) return;    // Add loading state with minimal CSS to prevent layout shift
    if (containerId === 'navbar-container') {
        container.innerHTML = '<nav class="navbar" style="height:70px;background:#2d5016;"></nav>';
    }
    
    fetch(componentPath)
        .then(response => {
            if (!response.ok) throw new Error(`HTTP ${response.status}`);
            return response.text();
        })        .then(html => {            // If we're in cities folder and loading navbar, adjust paths
            if (containerId === 'navbar-container' && window.location.pathname.includes('/cities/')) {
                html = adjustNavbarPaths(html);
            }
            container.innerHTML = html;
        })
        .catch(error => {
            console.error(`Error loading ${componentPath}:`, error);            // Fallback navbar for critical navigation
            if (containerId === 'navbar-container' || containerId === 'navbar-placeholder') {
                container.innerHTML = `
                    <nav class="navbar">
                        <div class="container">
                            <a class="navbar-brand fw-bold" href="${window.location.pathname.includes('/cities/') ? '../' : ''}index.html">
                                טלגראס כיוונים
                            </a>
                            <div class="directions-btn-container">
                                <a href="${window.location.pathname.includes('/cities/') ? '../' : ''}#directions" class="btn-directions">
                                    כיוונים
                                </a>
                            </div>
                        </div>
                    </nav>`;
            } else {
                container.innerHTML = '<div class="alert alert-danger">Failed to load component</div>';
            }
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
