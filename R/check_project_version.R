#' Check if the current project's tcdsb structure is up to date
#'
#' Reads `_tcdsb.yml` in the current directory and warns if the project
#' structure is more than one year old or if the installed package has a newer
#' minor version (the third component of `0.0.X.0000`), indicating that
#' extensions or visual identity have changed.
#'
#' The version scheme: `0.0.X.0000`. X is incremented whenever project
#' structure (extensions, branding) changes. The fourth component covers
#' non-structural updates and does not require a project refresh.
#'
#' Called automatically by key tcdsb functions.
#'
#' @return Invisibly returns `NULL`.
#' @keywords internal
check_project_version <- function() {
  state_file <- "_tcdsb.yml"
  if (!file.exists(state_file)) return(invisible(NULL))

  state <- tryCatch(yaml::read_yaml(state_file), error = function(e) NULL)
  if (is.null(state)) return(invisible(NULL))

  installed_ver <- tryCatch(
    utils::packageVersion("tcdsb"),
    error = function(e) NULL
  )

  # -- Age check -----------------------------------------------------------
  last_updated <- tryCatch(
    as.Date(state$last_updated),
    error = function(e) NULL
  )

  if (!is.null(last_updated) && !is.na(last_updated)) {
    age_days <- as.numeric(Sys.Date() - last_updated)
    if (age_days > 365) {
      warning(
        "This project's tcdsb structure is ", floor(age_days / 365),
        " year(s) old (last updated: ", last_updated, ").\n",
        "  Refresh with: tcdsb_project_setup()",
        call. = FALSE
      )
      return(invisible(NULL))
    }
  }

  # -- Version check -------------------------------------------------------
  if (is.null(installed_ver)) return(invisible(NULL))

  project_ver_str <- state$package_version
  if (is.null(project_ver_str) || is.na(project_ver_str)) {
    return(invisible(NULL))
  }

  project_ver <- tryCatch(
    numeric_version(project_ver_str),
    error = function(e) NULL
  )
  if (is.null(project_ver)) return(invisible(NULL))

  # Compare only the third component (structural version X in 0.0.X.0000).
  installed_parts <- unclass(installed_ver)[[1]]
  project_parts   <- unclass(project_ver)[[1]]

  # Pad to four components if needed
  pad <- function(v) c(v, rep(0L, max(0L, 4L - length(v))))
  inst_x    <- pad(installed_parts)[3]
  project_x <- pad(project_parts)[3]

  if (inst_x > project_x) {
    warning(
      "Installed tcdsb (", installed_ver, ") has a newer project structure ",
      "than this project (built with ", project_ver, ").\n",
      "  Update this project with: tcdsb_project_setup()",
      call. = FALSE
    )
  }

  invisible(NULL)
}
