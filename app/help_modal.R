help_modal <- modalDialog(
  title = div(icon("book-open"), " {RIOT} User Guide"),
  size = "l",
  easyClose = TRUE,
  fade = TRUE,
  footer = modalButton("Close"),
  div(
    style = "padding: 10px;",
    p(
      class = "lead",
      "Follow these steps to extract text from your images:"
    ),
    div(
      class = "list-group",
      div(
        class = "list-group-item",
        h5(class = "mb-1", icon("upload"), " 1. Upload Image"),
        p(
          class = "mb-1",
          "Use the 'Browse' button in the sidebar to upload",
          "an image file. On mobile, tap 'Take Photo' to use",
          "your camera directly."
        )
      ),
      div(
        class = "list-group-item",
        h5(class = "mb-1", icon("crop"), " 2. Select Area"),
        p(
          class = "mb-1",
          "Click and drag on the source image to draw a box",
          "around the text you want to extract.",
          "The cropped region and extracted text appear in",
          "the results panel."
        )
      ),
      div(
        class = "list-group-item",
        h5(class = "mb-1", icon("file-lines"), " 3. Get Text"),
        p(
          class = "mb-1",
          "The app automatically extracts text from your",
          "selection. Use the Copy button to copy it to your",
          "clipboard instantly."
        )
      ),
      div(
        class = "list-group-item",
        h5(
          class = "mb-1",
          icon("download"), " 4. Export Results"
        ),
        p(
          class = "mb-1",
          "Download your results as TXT (plain text),",
          "CSV (spreadsheet-friendly), or save the cropped",
          "image as a PNG file."
        )
      )
    ),
    hr(),
    h5(icon("lightbulb"), " Tips for best results:"),
    div(
      class = "alert alert-secondary",
      tags$ul(
        style = "margin-bottom: 0;",
        tags$li("Ensure the image is not too blurry."),
        tags$li(
          "Use ", tags$b("Image Adjustments"),
          " in the sidebar to tweak zoom, brightness,",
          " and contrast for better OCR accuracy."
        ),
        tags$li(
          "Enable ", tags$b("Grayscale"),
          " mode for images with colored backgrounds",
          " \u2014 it often improves text recognition."
        ),
        tags$li(
          "Use the ", tags$b("Zoom"),
          " slider to enlarge small text before selecting."
        ),
        tags$li(
          "Use the Dark/Light theme toggle to adjust",
          " visibility for your environment."
        )
      )
    )
  )
)
