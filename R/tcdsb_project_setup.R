#' TCDSB Project Setup / Update
#'
#' Create a new TCDSB project or update an existing one.
#'
#' This function can safely be re-run:
#' - _extensions/ and _brand.yml are always updated
#' - All other files are only updated if unchanged since last run
#' - Modified or deleted files are skipped unless destructive = TRUE
#'
#' Tool state and checksums are stored in _tcdsb.yml.
#'
#' @param destructive Logical; force overwrite of modified files.
#' @export
#'

tcdsb_project_setup <- function(destructive = FALSE) {
  check_package_version()
  check_project_version()
  path <- "."

  src <- system.file(
    "quarto/tcdsb_project",
    package = "tcdsb",
    mustWork = TRUE
  )

  state_file <- fs::path(path, "_tcdsb.yml")

  checksum <- function(x) unname(tools::md5sum(x))

  # ------------------------------------------------------------------
  # provenance
  # ------------------------------------------------------------------
  pkg_path <- system.file(package = "tcdsb")
  installed_at <- file.info(pkg_path)$mtime

  desc_path <- system.file("DESCRIPTION", package = "tcdsb")
  desc <- if (nzchar(desc_path)) read.dcf(desc_path) else NULL

  desc_version <- if (!is.null(desc) && "Version" %in% colnames(desc)) {
    desc[1, "Version"]
  } else {
    NA_character_
  }

  desc_pubdate <- if (
    !is.null(desc) && "Date/Publication" %in% colnames(desc)
  ) {
    desc[1, "Date/Publication"]
  } else {
    NA_character_
  }

  # ------------------------------------------------------------------
  # load or initialize state
  # ------------------------------------------------------------------
  if (fs::file_exists(state_file)) {
    state <- yaml::read_yaml(state_file)
  } else {
    state <- list(
      schema = 1,
      tool = "tcdsb",
      files = list()
    )
  }

  state$installed_at <- format(installed_at, "%Y-%m-%dT%H:%M:%S")
  state$package_version <- desc_version
  state$published_at <- desc_pubdate
  state$last_updated <- as.character(Sys.Date())

  # ------------------------------------------------------------------
  # Force-updated infrastructure
  # Branding (_brand.yml) is now inside _extensions/tcdsb_brand/
  # and is updated as part of _extensions.
  # ------------------------------------------------------------------
  force_overwrite <- c("_extensions")

  for (item in force_overwrite) {
    from <- fs::path(src, item)
    to <- fs::path(path, item)

    if (fs::dir_exists(to)) fs::dir_delete(to)
    if (fs::file_exists(to)) fs::file_delete(to)

    if (fs::dir_exists(from)) {
      fs::dir_copy(from, to)
    } else if (fs::file_exists(from)) {
      fs::file_copy(from, to)
    }

    message("updated ", item)
  }

  # ------------------------------------------------------------------
  # All remaining files: checksum-governed
  # ------------------------------------------------------------------
  templ_files <- fs::dir_ls(src, recurse = TRUE, type = "file")
  rel_paths <- fs::path_rel(templ_files, start = src)

  keep <- !(rel_paths %in%
    c("_brand.yml", "_tcdsb.yml") |
    startsWith(rel_paths, "_extensions"))

  templ_files <- templ_files[keep]
  rel_paths <- rel_paths[keep]

  for (i in seq_along(templ_files)) {
    file <- templ_files[i]
    rel <- rel_paths[i]
    dest <- fs::path(path, rel)

    new_sum <- checksum(file)
    old_sum <- state$files[[rel]]$checksum %||% NA_character_

    # -------------------------------
    # DELETED == CHANGED (new logic)
    # -------------------------------
    if (!fs::file_exists(dest)) {
      # previously tracked -> user deleted -> treat as modified
      if (!is.na(old_sum) && !destructive) {
        warning(
          "skipped deleted file: ",
          rel,
          " (use destructive = TRUE to recreate)",
          call. = FALSE
        )
        next
      }

      # new file OR destructive overwrite
      fs::dir_create(fs::path_dir(dest))
      fs::file_copy(file, dest)

      state$files[[rel]] <- list(
        checksum = new_sum,
        source = "template"
      )

      message("added ", rel)
      next
    }

    current_sum <- checksum(dest)

    if (identical(current_sum, old_sum) || destructive) {
      fs::file_copy(file, dest, overwrite = TRUE)

      state$files[[rel]] <- list(
        checksum = new_sum,
        source = "template"
      )

      if (destructive && !identical(current_sum, old_sum)) {
        warning(
          "overwritten modified file (destructive): ",
          rel,
          call. = FALSE
        )
      } else {
        message("updated ", rel)
      }
    } else {
      warning(
        "skipped modified file: ",
        rel,
        " (use destructive = TRUE to overwrite)",
        call. = FALSE
      )
    }
  }

  yaml::write_yaml(state, state_file)
  message("TCDSB project setup complete")
  invisible(TRUE)
}
