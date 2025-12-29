help_modal <- modalDialog(
  title = div(icon("book-open"), " {RIOT} User Guide"),
  size = "l",
  easyClose = TRUE,
  fade = TRUE,
  footer = modalButton("Close"),
  div(
    style = "padding: 10px;",
    p(class = "lead", "Follow these simple steps to extract text from your images:"),
    div(
      class = "list-group",
      div(
        class = "list-group-item",
        h5(class = "mb-1", icon("upload"), " 1. Upload Image"),
        p(class = "mb-1", "Use the 'Browse' button in the sidebar to upload a PNG or JPEG file.")
      ),
      div(
        class = "list-group-item",
        h5(class = "mb-1", icon("crop"), " 2. Select Area"),
        p(class = "mb-1", "Click and drag on the image to draw a box around the text you want to read.")
      ),
      div(
        class = "list-group-item",
        h5(class = "mb-1", icon("file-lines"), " 3. Get Text"),
        p(class = "mb-1", "The app will automatically crop the image and display the extracted text at the bottom of the page.")
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
          "If the text is small, try increasing the ",
          tags$b("Size"), " values in the sidebar (e.g., 2000x1000)."
        ),
        tags$li("Use the Dark/Light theme toggle to adjust visibility for your environment.")
      )
    )
  )
)