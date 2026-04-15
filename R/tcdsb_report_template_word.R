#' Create a Word Report from the TCDSB Template
#'
#' Copy the example Word report template into the current project,
#' optionally renaming it. Existing files are overwritten.
#'
#' @param name Optional file name (without extension). Defaults to "report".
#' @export
tcdsb_report_template_word <- function(name = "_example_report_word") {
  src <- system.file(
    "quarto/tcdsb_project/_example_report_word.qmd",
    package = "tcdsb",
    mustWork = TRUE
  )

  dest <- paste0(name, ".qmd")

  fs::file_copy(src, dest, overwrite = TRUE)

  message("created ", dest)
  invisible(dest)
}
