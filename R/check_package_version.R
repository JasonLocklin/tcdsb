#' Check if the installed tcdsb package is up to date
#'
#' Queries the GitHub API for the latest version tag and warns if the installed
#' package is behind. The check is fire-and-forget: it times out quickly and
#' prints nothing on any failure, so it never slows down user scripts.
#'
#' Called automatically by key tcdsb functions.
#'
#' @return Invisibly returns `NULL`.
#' @keywords internal
check_package_version <- function() {
  installed <- tryCatch(
    utils::packageVersion("tcdsb"),
    error = function(e) NULL
  )
  if (is.null(installed)) return(invisible(NULL))

  result <- tryCatch({
    req <- httr2::request(
      "https://api.github.com/repos/locklin/tcdsb/releases/latest"
    ) |>
      httr2::req_timeout(3) |>
      httr2::req_headers(Accept = "application/vnd.github+json") |>
      httr2::req_error(is_error = function(resp) FALSE)

    resp <- httr2::req_perform(req)

    if (httr2::resp_status(resp) != 200L) return(invisible(NULL))

    tag <- httr2::resp_body_json(resp)$tag_name
    if (is.null(tag)) return(invisible(NULL))

    latest <- tryCatch(
      numeric_version(sub("^v", "", tag)),
      error = function(e) NULL
    )

    if (!is.null(latest) && installed < latest) {
      warning(
        "tcdsb package is out of date (installed: ", installed,
        ", latest: ", latest, ").\n",
        "  Update with: devtools::install_github(\"locklin/tcdsb\")",
        call. = FALSE
      )
    }
    invisible(NULL)
  }, error = function(e) invisible(NULL))

  invisible(result)
}
