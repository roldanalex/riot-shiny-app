function(input, output, session) {

  observeEvent(input$current_theme, {

    # Make sure theme is kept current with desired
    session$setCurrentTheme(
      bs_theme_update(
        my_theme,
        bootswatch = input$current_theme
      )
    )

  })

  image <- image_read("www/ocr-example-2.png")

  observeEvent(input$upload, {

    if (length(input$upload$datapath)) {
      image <<- image_read(input$upload$datapath)
      info   <- image_info(image)
      updateTextInput(
        session,
        "size",
        value = paste(info$width, info$height, sep = "x")
      )
    }

  })

  output$image_brushinfo <- renderPrint({
    cat("Selected:\n")
    str(input$image_brush$coords_css)
  })

  output$image <- renderImage({
    width   <- session$clientData$output_image_width
    height  <- session$clientData$output_image_height
    img <- image |>
      image_resize(input$size) |>
      image_write(
        tempfile(
          fileext = "jpg"
        ),
        format = "jpg"
      )
    list(src = img, contentType = "image/jpeg")
  })


  coords <- reactive({
    w   <- round(input$image_brush$xmax - input$image_brush$xmin, digits = 2)
    h   <- round(input$image_brush$ymax - input$image_brush$ymin, digits = 2)
    dw  <- round(input$image_brush$xmin, digits = 2)
    dy  <- round(input$image_brush$ymin, digits = 2)
    coords <- paste0(w, "x", h, "+", dw, "+", dy)
    return(coords)
  })

  output$coordstext <- renderText({
    if (is.null(input$image_brush$xmin)) {
      "No Area Selected!"
    } else {
      coords()
    }
  })

  output$croppedimage <- renderImage({
    req(input$image_brush)
    width <- session$clientData$output_image_width
    height <- session$clientData$output_image_height
    img <- image |>
      image_resize(input$size) |>
      image_crop(coords(), repage = FALSE) |>
      image_write(
        tempfile(
          fileext = "jpg"
        ),
        format = "jpg"
      )
    list(src = img, contentType = "image/jpeg")
  })

  output$ocr_text <- renderText({
    req(input$image_brush)
    text <- image |>
      image_resize(input$size) |>
      image_crop(coords(), repage = FALSE) |>
      image_ocr()
    output <- text
    return(output)
  })

}