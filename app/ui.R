page_sidebar(
  title = h3("{RIOT} - R/Shiny Image OCR Technology"),
  theme = my_theme,
  sidebar = sidebar(
    open = "open",
    div(
      align = "left",
      h5("This app allows you to extract text from images."),
      br()
    ),
    br(),
    tags$div(
      id = "header",
      fileInput(
        "upload",
        "Upload image",
        accept = c("image/png", "image/jpeg"),
        buttonLabel = "BROWSE",
        placeholder = "No Image"
      ),
      tags$div(
        style  = "font-size:18px;",
        textInput("size", "Size", value = "1200x600")
      )
    ),
    tags$h4("Selected Area"),
    verbatimTextOutput("coordstext"),
    br(),
    br(),
    radioButtons(
      "current_theme", "App Theme:",
      c("Light" = "zephyr", "Dark" = "darkly"),
      selected = "darkly",
      inline = TRUE
    )
  ),
  fluidRow(
    column(
      width = 12,
      tags$h4("Click & Drag Over Image"),
      div(
        style = "max-height: 100%;",
        card(
          width = 12,
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
            height = "600px"
          )
        )
      )
    )
  ),
  # div(
  #   style = "margin-bottom: 80px;"
  # ),
  fluidRow(
    column(
      width = 12,
      tags$h4("Area Selected"),
      card(
        width = 12,
        imageOutput(
          "croppedimage",
          height = "auto"
        )
      )
    )
  ),
  fluidRow(
    column(
      width = 12,
      tags$h4("Text Output"),
      card(
        width = 12,
        textOutput("ocr_text"),
        verbatimTextOutput("text_extract")
      )
    )
  ),
  div(
    style = "margin-bottom: 30px;"
  ), # this adds breathing space between content and footer
  tags$footer(
    fluidRow(
      column(4, "© Alexis Roldan - 2024"),
      column(4, "{RIOT} v1.1.2"),
      column(
        4,
        tags$a(
          href = "mailto:alexis.m.roldan.ds@gmail.com",
          tags$b("Email me"),
          class = "externallink",
          style = "color: white; text-decoration: none"
        )
      ),
      style = "
        position:fixed;
        text-align:center;
        left: 0;
        bottom:0;
        width:100%;
        z-index:1000;  
        height:30px; /* Height of the footer */
        color: white;
        padding: 3px;
        font-weight: bold;
        background-color: #333333"
    )
  )
)