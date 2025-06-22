// Navbar Preloader - Loads navbar synchronously to prevent flickering
(function() {
    'use strict';
    
    // Function to load navbar synchronously
    function loadNavbarSync() {
        try {
            // Create a synchronous XMLHttpRequest
            const xhr = new XMLHttpRequest();
            xhr.open('GET', 'components/navbar.html', false); // false = synchronous
            xhr.send();
            
            if (xhr.status === 200) {
                return xhr.responseText;
            }
        } catch (error) {
            console.error('Failed to load navbar:', error);
        }
        return null;
    }
    
    // Function to inject navbar into the page
    function injectNavbar() {
        const navbarContainer = document.getElementById('navbar-container');
        if (navbarContainer) {
            const navbarHTML = loadNavbarSync();
            if (navbarHTML) {
                navbarContainer.innerHTML = navbarHTML;
                
                // Initialize Bootstrap navbar collapse functionality
                const navbarToggler = document.querySelector('.navbar-toggler');
                const navbarCollapse = document.querySelector('.navbar-collapse');
                
                if (navbarToggler && navbarCollapse) {
                    navbarToggler.addEventListener('click', function() {
                        navbarCollapse.classList.toggle('show');
                    });
                }
            }
        }
    }
    
    // Load navbar immediately when script runs (before DOMContentLoaded)
    if (document.readyState === 'loading') {
        // Document is still loading, inject as soon as DOM is ready
        document.addEventListener('DOMContentLoaded', injectNavbar);
    } else {
        // Document is already loaded
        injectNavbar();
    }
})();
