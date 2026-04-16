#' Create a PDF Report from the TCDSB Template
#'
#' Copy the example PDF report QMD into the current project, optionally
#' renaming it. Existing files are overwritten.
#'
#' This is a convenience wrapper around the example file included with the
#' package. For a full project setup (extensions, branding, assets), use
#' [tcdsb_project_setup()] instead.
#'
#' @param name File name without extension. Defaults to "report".
#' @return Invisibly returns the destination path.
#' @export
tcdsb_report_template_quarto <- function(name = "report") {
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
