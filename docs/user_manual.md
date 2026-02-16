# {RIOT} User Manual

**R/Shiny Image OCR Technology** — v2.0.0

## 1. Introduction
{RIOT} is an interactive application designed to extract text from images using Optical Character Recognition (OCR). It leverages the Tesseract engine to convert static images (like screenshots, scans, or photos) into editable, exportable text data.

## 2. Getting Started

### Prerequisites
Before running the app, ensure you have the following installed:
- **R** (version 4.0 or higher)
- **Tesseract OCR Engine** (v4.0+)
  - macOS: `brew install tesseract`
  - Windows: Tesseract Installer
  - Linux: `sudo apt-get install tesseract-ocr`

### Installation
1. Clone the repository.
2. Install R packages:
   ```r
   install.packages(c(
     "shiny", "magick", "tesseract", "bslib",
     "shinyWidgets", "shinycssloaders", "base64enc"
   ))
   ```
3. Run the app via RStudio or `shiny::runApp("app")`.

## 3. How to Use

### Step 1: Upload an Image
- Navigate to the sidebar on the left (tap the hamburger menu on mobile).
- Click **Browse** under "Upload Image" and select an image file.
- Supported formats: PNG, JPEG, and any format your browser supports.
- **On mobile**: Tap the **Take Photo** button (camera icon) to capture an image directly with your rear camera.
- Maximum file size: 10 MB. Images larger than 4000px are automatically scaled down for performance.

### Step 2: Adjust Image (Optional)
Open the **Image Adjustments** accordion in the sidebar to fine-tune the image before OCR:

- **Zoom** (50%–200%): Enlarge or shrink the image. Useful for small text.
- **Brightness** (50%–200%): Lighten or darken the image.
- **Contrast** (50%–200%): Increase or decrease contrast to make text stand out.
- **Rotation** (0°/90°/180°/270°): Rotate the image to the correct orientation.
- **Grayscale**: Convert to grayscale — often improves OCR accuracy on images with colored backgrounds.
- **Reset**: Click the Reset button to restore all adjustments to their defaults.

### Step 3: Select Text Area
- On the **Source Image** panel, click and drag (or tap and drag on mobile) to draw a box around the text you want to extract.
- A hint below the header reminds you: *"Click and drag to select a text region."*

### Step 4: View Results
The results panel (right side on desktop, below on mobile) shows:

- **Cropped Region**: A preview of your selected area.
- **Extracted Text**: The OCR-extracted text from your selection. A progress indicator appears while processing.

### Step 5: Copy & Export
- **Copy**: Click the **Copy** button next to the "Extracted Text" header to copy the text to your clipboard. The button briefly turns green with a "Copied!" confirmation.
- **TXT**: Download the extracted text as a plain text file.
- **CSV**: Download the text as a CSV file (one line per row), useful for spreadsheet applications.
- **Image**: Download the cropped region as a PNG file.

### Theme
Toggle between **Light** and **Dark** modes using the radio buttons in the sidebar.

## 4. Troubleshooting

**Issue: No text is extracted.**
- *Solution*: Ensure the image is clear and the text is legible. Try increasing the **Zoom** slider to enlarge small text. Enable **Grayscale** mode for images with colored backgrounds. Adjust **Brightness** and **Contrast** to improve text visibility.

**Issue: The app shows an error on upload.**
- *Solution*: Verify that the file is a valid image and not corrupted. The maximum upload size is 10 MB. If the file is very large, the app will automatically scale it down, but extremely large files may still cause issues.

**Issue: Mobile selection is difficult.**
- *Solution*: The app uses touch-friendly controls with a minimum 44px touch target size. For best results, zoom into the relevant area first using the **Zoom** slider, then select. Using a stylus can also help with precision.

**Issue: Copy button does not work.**
- *Solution*: The clipboard API requires a secure context (HTTPS). If running locally over HTTP, some browsers may block clipboard access. The app includes a fallback method, but if it still fails, manually select and copy the text from the "Extracted Text" panel.

## 5. Support
For additional support or feature requests, please contact the developer:
- **Email**: alexis.m.roldan.ds@gmail.com
