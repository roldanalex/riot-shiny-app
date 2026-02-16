page_sidebar(
  title = h3("{RIOT} - R/Shiny Image OCR Technology", class = "text-body"),
  theme = my_theme,
  tags$head(
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
    tags$script(src = "custom.js")
  ),
  sidebar = sidebar(
    open = "desktop",
    h5("Extract text from images."),
    fileInput(
      "upload",
      "Upload Image",
      accept = "image/*",
      buttonLabel = "BROWSE",
      placeholder = "No Image"
    ),
    div(
      class = "camera-btn-wrapper d-md-none",
      tags$label(
        class = "btn btn-outline-primary w-100",
        icon("camera"),
        "Take Photo",
        tags$input(
          type = "file",
          accept = "image/*",
          capture = "environment",
          id = "camera_input"
        )
      )
    ),
    accordion(
      id = "sidebar_accordion",
      open = FALSE,
      accordion_panel(
        title = "Image Adjustments",
        icon = icon("sliders"),
        sliderInput("zoom", "Zoom", min = 50, max = 200, value = 100, step = 10, post = "%"),
        sliderInput("brightness", "Brightness", min = 50, max = 200, value = 100, step = 5, post = "%"),
        sliderInput("contrast", "Contrast", min = 50, max = 200, value = 100, step = 5, post = "%"),
        sliderInput("rotation", "Rotation", min = 0, max = 270, value = 0, step = 90, post = "\u00B0"),
        checkboxInput("grayscale", "Grayscale (can improve OCR)", value = FALSE),
        actionButton("reset_adjustments", "Reset", icon = icon("rotate-left"), class = "btn-outline-warning btn-sm w-100")
      )
    ),
    actionButton("help", "User Guide", icon = icon("circle-info"), class = "btn-danger w-100"),
    radioButtons(
      "current_theme", "App Theme:",
      c("Light" = "zephyr", "Dark" = "darkly"),
      selected = "darkly",
      inline = TRUE
    )
  ),
  div(
    class = "main-content-area",
    layout_columns(
      col_widths = breakpoints(sm = 12, md = c(8, 4)),
      # Left column: Source image
      card(
        card_header(
          class = "d-flex align-items-center justify-content-between",
          tags$h5("Source Image", class = "mb-0"),
          tags$small(class = "workflow-hint mb-0", "Click and drag to select a text region")
        ),
        div(
          class = "source-image-card",
          imageOutput(
            "image",
            click = "image_click",
            hover = hoverOpts(
              id = "image_hover",
              delay = 500,
              delayType = "throttle"
            ),
            brush = brushOpts(
              id = "image_brush",
              fill = "#F5A623",
              stroke = "#F5A623",
              clip = FALSE
            ),
            height = "auto"
          )
        )
      ),
      # Right column: Results panel
      div(
        class = "results-panel",
        card(
          card_header(tags$h5("Cropped Region", class = "mb-0")),
          uiOutput("cropped_placeholder")
        ),
        card(
          card_header(
            class = "text-output-header",
            tags$h5("Extracted Text", class = "mb-0"),
            actionButton(
              "copy_btn",
              label = tagList(icon("copy"), "Copy"),
              class = "btn-outline-secondary btn-sm"
            )
          ),
          uiOutput("text_placeholder")
        ),
        card(
          card_header(tags$h5("Export", class = "mb-0")),
          div(
            class = "export-buttons",
            downloadButton("download_txt", "TXT", class = "btn-outline-primary btn-sm"),
            downloadButton("download_csv", "CSV", class = "btn-outline-primary btn-sm"),
            downloadButton("download_img", "Image", class = "btn-outline-primary btn-sm")
          )
        )
      )
    )
  ),
  tags$footer(
    class = "app-footer",
    fluidRow(
      column(4, class = "col-12 col-md-4", paste0("\u00A9 Alexis Roldan - ", format(Sys.Date(), "%Y"))),
      column(4, class = "col-12 col-md-4", "{RIOT} v2.0.0"),
      column(
        4,
        class = "col-12 col-md-4",
        tags$a(
          href = "mailto:alexis.m.roldan.ds@gmail.com",
          tags$b("Email me")
        )
      )
    )
  )
)
