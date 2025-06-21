/**
 * Component Loader - Load reusable components
 */

document.addEventListener('DOMContentLoaded', function() {
    // Detect if we're in cities folder
    const inCities = window.location.pathname.includes('/cities/');
    const path = inCities ? '../components/' : 'components/';
    
    // Load navbar and footer
    loadComponent('navbar-container', path + 'navbar.html');
    loadComponent('footer-container', path + 'footer.html');
});

/**
 * Load component into a container
 */
function loadComponent(containerId, componentPath) {
    const container = document.getElementById(containerId);
    if (!container) return;
    
    fetch(componentPath)
        .then(response => response.text())
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
