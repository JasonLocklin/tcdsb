#' Create a RevealJS Presentation from the TCDSB Template
#'
#' Copy the example RevealJS presentation into the current project,
#' optionally renaming it. Existing files are overwritten.
#'
#' @param name Optional file name (without extension). Defaults to
#'   "presentation".
#' @export
tcdsb_presentation_template_quarto <- function(name = "_example_presentation") {
  src <- system.file(
    "quarto/tcdsb_project/_example_presentation.qmd",
    package = "tcdsb",
    mustWork = TRUE
  )

  dest <- paste0(name, ".qmd")

  fs::file_copy(src, dest, overwrite = TRUE)

  message("created ", dest)
  invisible(dest)
}
