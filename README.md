# Academic Website - Javier Delser

A modern, responsive academic website featuring biography, CV, news, collaborators, publications, and projects sections. This website is designed to be hosted on GitHub Pages and includes integration with Google Scholar for automatic publication listing.

## 🌟 Features

- **Biography Section**: Professional profile with image and description
- **Curriculum Vitae**: Education, employment, and awards
- **News**: Latest updates and announcements
- **Collaborators & Students**: Current and past students, research collaborators
- **Publications**: Google Scholar integration with three options:
  - SerpApi integration for automatic fetching
  - Manual entry option
  - Direct link to Google Scholar profile
- **Projects**: Research projects with funding information
- **Responsive Design**: Works on desktop, tablet, and mobile devices
- **Secure**: XSS protection and input sanitization

## 🚀 Quick Start

1. **Clone this repository**
   ```bash
   git clone https://github.com/javierdelser/javierdelser.github.io.git
   cd javierdelser.github.io
   ```

2. **Customize your content**
   - Edit `index.html` to add your personal information
   - Update biography, CV, news, collaborators, and projects sections

3. **Add your profile picture**
   - Add a `profile.jpg` file to the root directory (200x200px recommended)

4. **Add your CV**
   - Add a `cv.pdf` file to the root directory

5. **Deploy to GitHub Pages**
   - Push your changes to the `main` branch
   - Enable GitHub Pages in repository settings
   - Your site will be available at `https://yourusername.github.io`

## 📚 Google Scholar Integration

### Option 1: SerpApi (Recommended for Automatic Fetching)

1. Sign up for a free account at [SerpApi](https://serpapi.com/)
2. Get your API key from the dashboard (100 free searches/month)
3. Edit `script.js` at line 73:
   ```javascript
   const apiKey = 'YOUR_SERPAPI_KEY';
   ```
4. Uncomment the fetch code in the `loadPublications` function
5. Enter your Google Scholar ID on the website and click "Load Publications"

### Option 2: Manual Entry

Edit `index.html` and add your publications in the publications section:

```html
<div class="publication-item">
    <div class="publication-title">Your Paper Title</div>
    <div class="publication-authors">Author1, Author2, Author3</div>
    <div class="publication-venue">Journal/Conference Name, Year</div>
    <div class="publication-meta">
        <span>Year: 2024</span>
        <span>Citations: 10</span>
        <a href="paper-url" target="_blank" class="publication-link">View Paper</a>
    </div>
</div>
```

### Option 3: Direct Link

Simply enter your Google Scholar ID in the input field, and users can click the link to view your profile directly on Google Scholar.

## 🎨 Customization

### Colors

Edit `styles.css` to change the color scheme:

- Primary color: `#3498db` (blue)
- Dark background: `#2c3e50`
- Hover states and accents

### Layout

The website uses a single-page design with smooth scrolling navigation. All sections are in `index.html` and can be reordered or removed as needed.

### Fonts

The website uses system fonts for optimal performance:
```css
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
```

## 📝 Content Sections

### Biography
Located in the `#biography` section. Update the text and add your profile image.

### Curriculum Vitae
Located in the `#cv` section. Includes:
- Education
- Employment
- Awards & Honors
- CV download button

### News
Located in the `#news` section. Add news items with dates.

### Collaborators & Students
Located in the `#collaborators` section. Organized into:
- Current Students
- Past Students
- Collaborators

### Publications
Located in the `#publications` section. Configure Google Scholar integration or add publications manually.

### Projects
Located in the `#projects` section. Add project cards with descriptions, funding, and links.

## 🔒 Security

This website implements security best practices:
- Input sanitization for Google Scholar ID (alphanumeric, hyphens, underscores only)
- XSS protection through safe DOM manipulation
- No external dependencies to reduce attack surface
- Passes CodeQL security scans

## 🛠️ Local Development

Test the website locally using Python's built-in HTTP server:

```bash
python3 -m http.server 8000
```

Then visit `http://localhost:8000` in your browser.

## 📦 Files Structure

```
.
├── index.html      # Main HTML file with all content
├── styles.css      # Styling and responsive design
├── script.js       # JavaScript for interactivity and Scholar integration
├── README.md       # This file
├── .gitignore      # Git ignore rules
├── profile.jpg     # Your profile picture (add this)
└── cv.pdf         # Your CV PDF (add this)
```

## 🌐 Browser Support

- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- Mobile browsers (iOS Safari, Chrome)

## 📄 License

This template is free to use for academic purposes. Feel free to customize it for your needs.

## 🤝 Contributing

Found a bug or have a suggestion? Feel free to open an issue or submit a pull request.

## 📧 Contact

Update the contact information in the footer section of `index.html` with your email address.

---

Built with ❤️ for academics by academics