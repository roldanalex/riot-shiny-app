function(input, output, session) {

  source("help_modal.R", local = TRUE)

  # --- Help modal ---
  observeEvent(input$help, {
    showModal(help_modal)
  })

  # --- Theme switching ---
  observeEvent(input$current_theme, {
    session$setCurrentTheme(
      bs_theme_update(my_theme, bootswatch = input$current_theme)
    )
  })

  # --- Reactive values ---
  raw_image <- reactiveVal(image_read("www/ocr-example-2.png"))
  cropped_img <- reactiveVal(NULL)
  ocr_text <- reactiveVal(NULL)

  # --- File upload ---
  observeEvent(input$upload, {
    req(input$upload$datapath)
    tryCatch({
      img <- image_read(input$upload$datapath)
      info <- image_info(img)

      # Auto-scale very large images
      max_dim <- max(info$width, info$height)
      if (max_dim > 4000) {
        img <- image_scale(img, "4000x4000")
        showNotification(
          "Large image auto-scaled for performance.",
          type = "warning", duration = 4
        )
      }

      # Warn for very high resolution
      megapixels <- (info$width * info$height) / 1e6
      if (megapixels > 20) {
        showNotification(
          paste0(
            "Very large image (",
            round(megapixels, 1),
            " MP). Performance may be affected."
          ),
          type = "warning", duration = 5
        )
      }

      raw_image(img)
      cropped_img(NULL)
      ocr_text(NULL)
      showNotification(
        "Image uploaded!", type = "message", duration = 3
      )
    }, error = function(e) {
      showNotification(
        paste("Could not read image:", e$message),
        type = "error", duration = 6
      )
    })
  })

  # --- Camera capture (mobile) ---
  observeEvent(input$camera_capture, {
    req(input$camera_capture$datapath)
    tryCatch({
      data_uri <- input$camera_capture$datapath
      # Decode base64 data URI
      raw_data <- sub("^data:[^;]+;base64,", "", data_uri)
      tmp <- tempfile(fileext = ".jpg")
      writeBin(base64enc::base64decode(raw_data), tmp)
      img <- image_read(tmp)

      info <- image_info(img)
      max_dim <- max(info$width, info$height)
      if (max_dim > 4000) {
        img <- image_scale(img, "4000x4000")
      }

      raw_image(img)
      cropped_img(NULL)
      ocr_text(NULL)
      showNotification(
        "Photo captured!", type = "message", duration = 3
      )
    }, error = function(e) {
      showNotification(
        paste("Could not process photo:", e$message),
        type = "error", duration = 6
      )
    })
  })

  # --- Image adjustments reset ---
  observeEvent(input$reset_adjustments, {
    updateSliderInput(session, "zoom", value = 100)
    updateSliderInput(session, "brightness", value = 100)
    updateSliderInput(session, "contrast", value = 100)
    updateSliderInput(session, "rotation", value = 0)
    updateCheckboxInput(session, "grayscale", value = FALSE)
  })

  # --- Processed image (with adjustments) ---
  processed_image <- reactive({
    req(raw_image())
    img <- raw_image()

    # Rotation
    if (!is.null(input$rotation) && input$rotation > 0) {
      img <- image_rotate(img, input$rotation)
    }

    # Brightness & contrast via image_modulate
    brightness <- if (!is.null(input$brightness)) {
      input$brightness
    } else {
      100
    }
    if (brightness != 100) {
      img <- image_modulate(img, brightness = brightness)
    }

    # Contrast
    contrast_val <- if (!is.null(input$contrast)) {
      input$contrast
    } else {
      100
    }
    if (contrast_val != 100) {
      # Map 50-200% to sigmoidal contrast
      strength <- (contrast_val - 100) / 20
      if (strength > 0) {
        img <- image_contrast(img, sharpen = strength)
      } else if (strength < 0) {
        img <- image_contrast(img, sharpen = strength)
      }
    }

    # Grayscale
    if (!is.null(input$grayscale) && input$grayscale) {
      img <- image_convert(img, colorspace = "Gray")
    }

    img
  })

  # --- Display image (with zoom) ---
  display_image <- reactive({
    req(processed_image())
    img <- processed_image()
    info <- image_info(img)

    zoom <- if (!is.null(input$zoom)) input$zoom else 100
    if (zoom != 100) {
      new_width <- round(info$width * zoom / 100)
      img <- image_resize(
        img, paste0(new_width, "x")
      )
    }

    img
  })

  # --- Brush coordinates ---
  coords <- reactive({
    req(input$image_brush)
    w <- round(
      input$image_brush$xmax - input$image_brush$xmin, 2
    )
    h <- round(
      input$image_brush$ymax - input$image_brush$ymin, 2
    )
    dw <- round(input$image_brush$xmin, 2)
    dy <- round(input$image_brush$ymin, 2)
    paste0(w, "x", h, "+", dw, "+", dy)
  })

  # --- Render source image ---
  output$image <- renderImage({
    img <- display_image()
    tmp <- image_write(
      img, tempfile(fileext = ".jpg"), format = "jpg"
    )
    list(src = tmp, contentType = "image/jpeg")
  }, deleteFile = TRUE)

  # --- Cropped image reactive ---
  observe({
    req(input$image_brush)
    img <- display_image()
    crop <- image_crop(img, coords(), repage = FALSE)
    cropped_img(crop)
  })

  # --- OCR text extraction ---
  observe({
    req(cropped_img())
    withProgress(message = "Extracting text...", {
      text <- image_ocr(cropped_img())
      ocr_text(text)
    })
  })

  # --- Render cropped image with placeholder ---
  output$cropped_placeholder <- renderUI({
    if (is.null(cropped_img())) {
      div(
        class = "empty-state",
        icon("crop"),
        p("Select a region on the image")
      )
    } else {
      withSpinner(
        imageOutput("croppedimage", height = "auto"),
        type = 6, size = 0.5
      )
    }
  })

  output$croppedimage <- renderImage({
    req(cropped_img())
    tmp <- image_write(
      cropped_img(),
      tempfile(fileext = ".jpg"),
      format = "jpg"
    )
    list(src = tmp, contentType = "image/jpeg")
  }, deleteFile = TRUE)

  # --- Render extracted text with placeholder ---
  output$text_placeholder <- renderUI({
    if (is.null(ocr_text()) || ocr_text() == "") {
      div(
        class = "empty-state",
        icon("file-lines"),
        p("Extracted text will appear here")
      )
    } else {
      verbatimTextOutput("text_extract")
    }
  })

  output$text_extract <- renderText({
    req(ocr_text())
    ocr_text()
  })

  # --- Copy to clipboard ---
  observeEvent(input$copy_btn, {
    req(ocr_text())
    session$sendCustomMessage("copyToClipboard", ocr_text())
  })

  # --- Download handlers ---
  output$download_txt <- downloadHandler(
    filename = function() {
      paste0("riot-ocr-", format(Sys.time(), "%Y%m%d-%H%M%S"), ".txt")
    },
    content = function(file) {
      req(ocr_text())
      writeLines(ocr_text(), file)
    }
  )

  output$download_csv <- downloadHandler(
    filename = function() {
      paste0("riot-ocr-", format(Sys.time(), "%Y%m%d-%H%M%S"), ".csv")
    },
    content = function(file) {
      req(ocr_text())
      lines <- unlist(strsplit(ocr_text(), "\n"))
      lines <- lines[lines != ""]
      write.csv(
        data.frame(text = lines),
        file, row.names = FALSE
      )
    }
  )

  output$download_img <- downloadHandler(
    filename = function() {
      paste0("riot-crop-", format(Sys.time(), "%Y%m%d-%H%M%S"), ".png")
    },
    content = function(file) {
      req(cropped_img())
      image_write(cropped_img(), file, format = "png")
    }
  )

}
