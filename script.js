// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Profile image fallback
document.addEventListener('DOMContentLoaded', function() {
    const profileImage = document.getElementById('profile-image');
    if (profileImage) {
        profileImage.onerror = function() {
            this.onerror = null;
            this.src = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" width="200" height="200"%3E%3Crect width="200" height="200" fill="%23ddd"/%3E%3Ctext x="50%25" y="50%25" dominant-baseline="middle" text-anchor="middle" font-family="Arial" font-size="20" fill="%23999"%3EProfile%3C/text%3E%3C/svg%3E';
        };
    }
});

// Google Scholar Publications Loader
document.addEventListener('DOMContentLoaded', function() {
    const scholarIdInput = document.getElementById('scholar-id');
    const loadButton = document.getElementById('load-publications');
    const publicationsContent = document.getElementById('publications-content');
    const publicationsLoading = document.getElementById('publications-loading');
    const scholarLink = document.getElementById('scholar-link');

    // Sanitize Scholar ID to prevent XSS
    function sanitizeScholarId(id) {
        // Only allow alphanumeric characters, hyphens, and underscores
        return id.replace(/[^a-zA-Z0-9_-]/g, '');
    }

    // Load Scholar ID from localStorage if available
    const savedScholarId = localStorage.getItem('scholarId');
    if (savedScholarId) {
        const sanitizedId = sanitizeScholarId(savedScholarId);
        scholarIdInput.value = sanitizedId;
        scholarLink.href = `https://scholar.google.com/citations?user=${sanitizedId}`;
    }

    // Update Scholar link when input changes
    scholarIdInput.addEventListener('input', function() {
        if (this.value) {
            const sanitizedId = sanitizeScholarId(this.value);
            scholarLink.href = `https://scholar.google.com/citations?user=${sanitizedId}`;
        }
    });

    loadButton.addEventListener('click', function() {
        const scholarId = sanitizeScholarId(scholarIdInput.value.trim());
        
        if (!scholarId) {
            alert('Please enter your Google Scholar ID');
            return;
        }

        // Save Scholar ID to localStorage
        localStorage.setItem('scholarId', scholarId);
        scholarLink.href = `https://scholar.google.com/citations?user=${scholarId}`;

        loadPublications(scholarId);
    });

    async function loadPublications(scholarId) {
        publicationsLoading.style.display = 'block';
        publicationsContent.innerHTML = '';

        try {
            // Using SerpApi's Google Scholar API
            // Note: You need to get your own API key from https://serpapi.com/
            // For demo purposes, we'll show how to structure the request
            
            // Option 1: Using a proxy service (recommended for production)
            // const apiKey = 'YOUR_SERPAPI_KEY'; // Get from https://serpapi.com/
            // const response = await fetch(`https://serpapi.com/search.json?engine=google_scholar_author&author_id=${scholarId}&api_key=${apiKey}`);
            
            // Since direct fetching from Google Scholar is restricted, we'll provide
            // a fallback that shows instructions for manual entry or using an API
            
            // For demonstration, let's show a working example with placeholder data
            showPublicationsMessage(scholarId);
            
        } catch (error) {
            console.error('Error loading publications:', error);
            // Create error message safely without innerHTML interpolation
            const errorDiv = document.createElement('div');
            errorDiv.className = 'error-message';
            errorDiv.innerHTML = `
                <p>Unable to automatically fetch publications. This could be due to:</p>
                <ul>
                    <li>CORS restrictions from Google Scholar</li>
                    <li>Missing API key for a proxy service</li>
                </ul>
                <p><strong>Solutions:</strong></p>
                <ol>
                    <li>Sign up for a free API key at <a href="https://serpapi.com/" target="_blank">SerpApi</a> and add it to the script.js file</li>
                    <li>Use the manual entry option below</li>
                    <li>Visit your <a href="#" id="error-scholar-link" target="_blank">Google Scholar profile</a> directly</li>
                </ol>
                <button class="btn" id="error-manual-entry-btn">Add Publications Manually</button>
            `;
            publicationsContent.innerHTML = '';
            publicationsContent.appendChild(errorDiv);
            // Safely set the href after DOM manipulation
            const errorScholarLink = document.getElementById('error-scholar-link');
            errorScholarLink.href = `https://scholar.google.com/citations?user=${scholarId}`;
            // Add event listener for manual entry button
            const errorManualBtn = document.getElementById('error-manual-entry-btn');
            if (errorManualBtn) {
                errorManualBtn.addEventListener('click', showManualEntry);
            }
        } finally {
            publicationsLoading.style.display = 'none';
        }
    }

    function showPublicationsMessage(scholarId) {
        // Create the message safely
        const infoDiv = document.createElement('div');
        infoDiv.className = 'publications-info';
        infoDiv.innerHTML = `
            <h3>Google Scholar Integration Options</h3>
            <p>To display your publications automatically, you have several options:</p>
            
            <div class="option-card">
                <h4>Option 1: Use SerpApi (Recommended)</h4>
                <ol>
                    <li>Sign up for a free account at <a href="https://serpapi.com/" target="_blank">SerpApi</a></li>
                    <li>Get your API key from the dashboard</li>
                    <li>Add your API key to the <code>script.js</code> file (line 73)</li>
                    <li>Reload the page and click "Load Publications"</li>
                </ol>
                <p>SerpApi offers 100 free searches per month.</p>
            </div>

            <div class="option-card">
                <h4>Option 2: Manual Entry</h4>
                <p>You can manually add your publications by editing the HTML file.</p>
                <button class="btn" id="show-manual-entry-btn">Show Manual Entry Format</button>
            </div>

            <div class="option-card">
                <h4>Option 3: Use Google Scholar Embed</h4>
                <p>Visit your profile directly:</p>
                <a href="#" id="scholar-embed-link" target="_blank" class="btn">View on Google Scholar</a>
            </div>

            <div class="example-publications">
                <h4>Example Publication Format</h4>
                <p style="font-style: italic; color: #7f8c8d;">Below is an example of how publications will be displayed:</p>
            </div>
        `;
        
        publicationsContent.innerHTML = '';
        publicationsContent.appendChild(infoDiv);
        
        // Safely set the href after DOM manipulation
        const embedLink = document.getElementById('scholar-embed-link');
        embedLink.href = `https://scholar.google.com/citations?user=${scholarId}`;
        
        // Add event listener for manual entry button
        const manualEntryBtn = document.getElementById('show-manual-entry-btn');
        if (manualEntryBtn) {
            manualEntryBtn.addEventListener('click', showManualEntry);
        }

        // Add example publications
        const examplePubs = [
            {
                title: "Example Publication Title: A Comprehensive Study",
                authors: "J. Delser, A. Collaborator, B. Student",
                venue: "Journal of Example Research, 2024",
                year: "2024",
                citations: "15",
                link: "#"
            },
            {
                title: "Another Research Paper on Important Topic",
                authors: "J. Delser, C. Colleague",
                venue: "Conference on Example Research (CER), 2023",
                year: "2023",
                citations: "42",
                link: "#"
            }
        ];

        examplePubs.forEach(pub => {
            const pubElement = createPublicationElement(pub);
            publicationsContent.appendChild(pubElement);
        });
    }

    function createPublicationElement(publication) {
        const div = document.createElement('div');
        div.className = 'publication-item';
        
        div.innerHTML = `
            <div class="publication-title">${publication.title}</div>
            <div class="publication-authors">${publication.authors}</div>
            <div class="publication-venue">${publication.venue}</div>
            <div class="publication-meta">
                <span>Year: ${publication.year}</span>
                <span>Citations: ${publication.citations}</span>
                ${publication.link ? `<a href="${publication.link}" target="_blank" class="publication-link">View Paper</a>` : ''}
            </div>
        `;
        
        return div;
    }
});

// Manual entry helper
function showManualEntry() {
    const publicationsContent = document.getElementById('publications-content');
    const manualDiv = document.createElement('div');
    manualDiv.className = 'manual-entry-info';
    manualDiv.innerHTML = `
        <h3>Manual Publication Entry</h3>
        <p>To manually add your publications, edit the <code>index.html</code> file and replace the publications section content with your own publications using this format:</p>
        <pre style="background-color: #f4f4f4; padding: 1rem; border-radius: 5px; overflow-x: auto;"><code>&lt;div class="publication-item"&gt;
    &lt;div class="publication-title"&gt;Your Paper Title&lt;/div&gt;
    &lt;div class="publication-authors"&gt;Author1, Author2, Author3&lt;/div&gt;
    &lt;div class="publication-venue"&gt;Journal/Conference Name, Year&lt;/div&gt;
    &lt;div class="publication-meta"&gt;
        &lt;span&gt;Year: 2024&lt;/span&gt;
        &lt;span&gt;Citations: 10&lt;/span&gt;
        &lt;a href="paper-url" target="_blank" class="publication-link"&gt;View Paper&lt;/a&gt;
    &lt;/div&gt;
&lt;/div&gt;</code></pre>
        <button class="btn" id="back-to-publications-btn">Back to Publications</button>
    `;
    publicationsContent.innerHTML = '';
    publicationsContent.appendChild(manualDiv);
    
    // Add event listener for back button
    const backBtn = document.getElementById('back-to-publications-btn');
    if (backBtn) {
        backBtn.addEventListener('click', () => location.reload());
    }
}


// Add CSS for the info cards dynamically
const style = document.createElement('style');
style.textContent = `
    .option-card {
        background-color: white;
        padding: 1.5rem;
        margin: 1rem 0;
        border-radius: 5px;
        border-left: 4px solid #3498db;
    }
    
    .option-card h4 {
        color: #2c3e50;
        margin-top: 0;
    }
    
    .option-card code {
        background-color: #f4f4f4;
        padding: 0.2rem 0.4rem;
        border-radius: 3px;
        font-family: monospace;
    }
    
    .error-message {
        background-color: #fff3cd;
        border: 1px solid #ffc107;
        padding: 1.5rem;
        border-radius: 5px;
    }
    
    .error-message ul, .error-message ol {
        margin: 1rem 0;
        padding-left: 2rem;
    }
    
    .example-publications {
        margin-top: 2rem;
        padding-top: 2rem;
        border-top: 2px solid #eee;
    }
    
    .manual-entry-info pre {
        background-color: #f4f4f4;
        padding: 1rem;
        border-radius: 5px;
        overflow-x: auto;
    }
    
    .publications-info {
        margin-top: 1rem;
    }
`;
document.head.appendChild(style);
