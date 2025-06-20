/**
 * Component Loader - Load reusable components
 */

document.addEventListener('DOMContentLoaded', function() {
    // Detect if we're in a subfolder and adjust component paths
    const pathLevel = window.location.pathname.includes('/cities/') ? '../' : '';
    
    // Load navigation
    loadComponent('navbar-container', pathLevel + 'components/navbar.html');
    
    // Load footer
    loadComponent('footer-container', pathLevel + 'components/footer.html');
    
    // Handle active link highlighting
    setTimeout(highlightActiveLink, 100); // Small delay to ensure component is loaded
});

/**
 * Load component into a container
 * @param {string} containerId - ID of the container element
 * @param {string} componentPath - Path to the component HTML file
 */
function loadComponent(containerId, componentPath) {
    const container = document.getElementById(containerId);
    if (!container) return;
    
    fetch(componentPath)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.text();
        })
        .then(html => {
            container.innerHTML = html;
            // Dispatch an event to signal the component has loaded
            document.dispatchEvent(new CustomEvent('componentLoaded', { detail: { id: containerId } }));
        })
        .catch(error => {
            console.error(`Error loading component from ${componentPath}:`, error);
            container.innerHTML = `<div class="alert alert-danger">Failed to load component</div>`;
        });
}

/**
 * Highlight the active link in the navigation based on current page
 */
function highlightActiveLink() {
    const currentPage = window.location.pathname.split('/').pop();
    const navLinks = document.querySelectorAll('.navbar-nav .nav-link');
    
    navLinks.forEach(link => {
        link.classList.remove('active');
        
        const href = link.getAttribute('href');
        if (href === currentPage || 
            (currentPage === '' && href === 'index.html') || 
            (currentPage === 'index.html' && href === 'index.html')) {
            link.classList.add('active');
        }
    });
}
