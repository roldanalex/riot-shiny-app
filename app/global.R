library(shiny)
library(magick)
library(tesseract)
library(shinydashboard)
library(shinyWidgets)
library(bslib)

my_theme <- bs_theme(
  bootswatch = "darkly",
  heading_font = font_google("Lobster", wght = 400),
  base_font = font_collection(
    font_google("Merriweather")
  ),
  code_font = font_google("Inconsolata"),
  font_scale = 1
)