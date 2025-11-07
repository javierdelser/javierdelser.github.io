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

// Google Scholar Publications Loader
document.addEventListener('DOMContentLoaded', function() {
    const scholarIdInput = document.getElementById('scholar-id');
    const loadButton = document.getElementById('load-publications');
    const publicationsContent = document.getElementById('publications-content');
    const publicationsLoading = document.getElementById('publications-loading');
    const scholarLink = document.getElementById('scholar-link');

    // Load Scholar ID from localStorage if available
    const savedScholarId = localStorage.getItem('scholarId');
    if (savedScholarId) {
        scholarIdInput.value = savedScholarId;
        scholarLink.href = `https://scholar.google.com/citations?user=${savedScholarId}`;
    }

    // Update Scholar link when input changes
    scholarIdInput.addEventListener('input', function() {
        if (this.value) {
            scholarLink.href = `https://scholar.google.com/citations?user=${this.value}`;
        }
    });

    loadButton.addEventListener('click', function() {
        const scholarId = scholarIdInput.value.trim();
        
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
            // Using Serpapi's Google Scholar API
            // Note: You need to get your own API key from https://serpapi.com/
            // For demo purposes, we'll show how to structure the request
            
            // Option 1: Using a proxy service (recommended for production)
            // const apiKey = 'YOUR_SERPAPI_KEY'; // Get from https://serpapi.com/
            // const response = await fetch(`https://serpapi.com/search.json?engine=google_scholar_author&author_id=${scholarId}&api_key=${apiKey}`);
            
            // Option 2: Using a CORS proxy with Google Scholar (less reliable)
            // Note: This may not work due to CORS and Google's restrictions
            const corsProxy = 'https://api.allorigins.win/raw?url=';
            const scholarUrl = encodeURIComponent(`https://scholar.google.com/citations?user=${scholarId}&hl=en`);
            
            // Since direct fetching from Google Scholar is restricted, we'll provide
            // a fallback that shows instructions for manual entry or using an API
            
            // For demonstration, let's show a working example with placeholder data
            showPublicationsMessage(scholarId);
            
        } catch (error) {
            console.error('Error loading publications:', error);
            publicationsContent.innerHTML = `
                <div class="error-message">
                    <p>Unable to automatically fetch publications. This could be due to:</p>
                    <ul>
                        <li>CORS restrictions from Google Scholar</li>
                        <li>Missing API key for a proxy service</li>
                    </ul>
                    <p><strong>Solutions:</strong></p>
                    <ol>
                        <li>Sign up for a free API key at <a href="https://serpapi.com/" target="_blank">SerpApi</a> and add it to the script.js file</li>
                        <li>Use the manual entry option below</li>
                        <li>Visit your <a href="https://scholar.google.com/citations?user=${scholarId}" target="_blank">Google Scholar profile</a> directly</li>
                    </ol>
                    <button class="btn" onclick="showManualEntry()">Add Publications Manually</button>
                </div>
            `;
        } finally {
            publicationsLoading.style.display = 'none';
        }
    }

    function showPublicationsMessage(scholarId) {
        publicationsContent.innerHTML = `
            <div class="publications-info">
                <h3>Google Scholar Integration Options</h3>
                <p>To display your publications automatically, you have several options:</p>
                
                <div class="option-card">
                    <h4>Option 1: Use SerpApi (Recommended)</h4>
                    <ol>
                        <li>Sign up for a free account at <a href="https://serpapi.com/" target="_blank">SerpApi</a></li>
                        <li>Get your API key from the dashboard</li>
                        <li>Add your API key to the <code>script.js</code> file (line 45)</li>
                        <li>Reload the page and click "Load Publications"</li>
                    </ol>
                    <p>SerpApi offers 100 free searches per month.</p>
                </div>

                <div class="option-card">
                    <h4>Option 2: Manual Entry</h4>
                    <p>You can manually add your publications by editing the HTML file.</p>
                    <button class="btn" onclick="showManualEntry()">Show Manual Entry Format</button>
                </div>

                <div class="option-card">
                    <h4>Option 3: Use Google Scholar Embed</h4>
                    <p>Visit your profile directly:</p>
                    <a href="https://scholar.google.com/citations?user=${scholarId}" target="_blank" class="btn">View on Google Scholar</a>
                </div>

                <div class="example-publications">
                    <h4>Example Publication Format</h4>
                    <p style="font-style: italic; color: #7f8c8d;">Below is an example of how publications will be displayed:</p>
                </div>
            </div>
        `;

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
    publicationsContent.innerHTML = `
        <div class="manual-entry-info">
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
            <button class="btn" onclick="location.reload()">Back to Publications</button>
        </div>
    `;
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
