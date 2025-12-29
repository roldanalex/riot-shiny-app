# {RIOT} User Manual

**R/Shiny Image OCR Technology**

## 1. Introduction
{RIOT} is an interactive application designed to extract text from images using Optical Character Recognition (OCR). It leverages the Tesseract engine to convert static images (like screenshots, scans, or photos) into editable text data.

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
   install.packages(c("shiny", "magick", "tesseract", "bslib"))
   ```
3. Run the app via RStudio or `shiny::runApp("app")`.

## 3. How to Use

### Step 1: Upload an Image
- Navigate to the sidebar on the left.
- Click **Browse** under "Upload image".
- Select a `.png` or `.jpeg` file from your device.

### Step 2: Adjust Settings (Optional)
- **Size**: The default processing resolution is `1200x600`. You can adjust this in the "Size" text box if your image requires higher resolution for better accuracy.
- **Theme**: Toggle between "Light" and "Dark" modes using the radio buttons in the sidebar.

### Step 3: Select Text Area
- On the main image display, click and drag your mouse (or finger on mobile) to draw a box around the text you want to extract.
- The coordinates of your selection will appear in the sidebar.

### Step 4: View Results
- **Area Selected**: A cropped view of your selection will appear below the main image.
- **Text Output**: The extracted text will be displayed in the "Text Output" card at the bottom.

## 4. Troubleshooting

**Issue: No text is extracted.**
- *Solution*: Ensure the image is clear and the text is legible. Try increasing the "Size" parameter (e.g., `2000x1000`) to improve OCR resolution.

**Issue: The app crashes on upload.**
- *Solution*: Verify that the file is a valid PNG or JPEG and not corrupted. Check if the `magick` package is correctly installed.

**Issue: Mobile selection is difficult.**
- *Solution*: The app is optimized for desktop, but mobile selection works best with a stylus or careful touch. Ensure you are not scrolling while trying to select.

## 5. Support
For additional support or feature requests, please contact the developer:
- **Email**: alexis.m.roldan.ds@gmail.com
- **Copyright**: © Alexis Roldan - 2024