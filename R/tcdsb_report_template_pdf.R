#' Create a PDF Report from the TCDSB Template
#'
#' Copy the example PDF report template into the current project,
#' optionally renaming it. Existing files are overwritten.
#'
#' @param name File name without extension. Defaults to "_example_report_pdf".
#' @export
tcdsb_report_template_pdf <- function(name = "_example_report_pdf") {
  src <- system.file(
    "quarto/tcdsb_project/_example_pdf.qmd",
    package = "tcdsb",
    mustWork = TRUE
  )

  dest <- paste0(name, ".qmd")

  fs::file_copy(src, dest, overwrite = TRUE)

  message("created ", dest)
  invisible(dest)
}
