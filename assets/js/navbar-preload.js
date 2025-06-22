// Navbar Preload Script - Add this to the <head> of each page
// This creates an instant skeleton navbar and smoothly transitions to the real one

document.addEventListener('DOMContentLoaded', function() {
    // Create navbar skeleton immediately
    const skeleton = document.createElement('div');
    skeleton.id = 'navbar-skeleton';
    skeleton.innerHTML = `
        <div class="brand">🌿 טלגראס כיוונים</div>
        <div class="directions-placeholder">📍 כיוונים</div>
    `;
    document.body.insertBefore(skeleton, document.body.firstChild);
    
    // Load the real navbar
    const navbarContainer = document.getElementById('navbar-container');
    if (navbarContainer) {
        fetch('components/navbar.html')
            .then(response => response.text())
            .then(html => {
                navbarContainer.innerHTML = html;
                
                // Mark as loaded to hide skeleton and show real navbar
                document.body.classList.add('navbar-loaded');
                
                // Initialize Bootstrap collapse functionality
                if (typeof bootstrap !== 'undefined' && bootstrap.Collapse) {
                    // Bootstrap is loaded, initialize collapse
                    const navbarToggler = document.querySelector('.navbar-toggler');
                    if (navbarToggler) {
                        new bootstrap.Collapse(document.querySelector('#navbarNav'), {
                            toggle: false
                        });
                    }
                }
            })
            .catch(error => {
                console.error('Error loading navbar:', error);
                // Keep skeleton visible if navbar fails to load
            });
    }
});
