knit2post <- function(input, local_base_dir='..', server_base_dir="/") {
    require(knitr)
    require(tools)
    abs_local_base_dir <- file_path_as_absolute(local_base_dir)
    opts_knit$set(local_base_dir=local_base_dir)
    fig.path <- file.path(abs_local_base_dir, 'content', sub(".Rmd$", "", basename(input)))
    if (!file_test('-d', fig.path)) dir.create(fig.path)
    opts_chunk$set(fig.path=paste0(fig.path, '/'))
    opts_chunk$set(fig.cap="center")
    render_jekyll()
    # Only publish in _posts if there is a date in the filename
    if (grepl('[0-9]{4}-[0-9]{2}-[0-9]{2}', input)) {
        posts_dir <- '_posts'
    } else {
        posts_dir <- '_drafts'
    }
    output_md <- file.path(abs_local_base_dir, posts_dir, paste0(file_path_sans_ext(basename(input)), '.md'))
    knit(input, output_md, envir=parent.frame())
    # Substitute local paths in the output_md and with server paths
    # (depending on the server_base_dir, the root folder on the jekyll server)
    con_r <- file(output_md, 'rt', blocking=FALSE)
    md_lines <- readLines(con_r)
    close(con_r)
    regex <- paste0('/*', abs_local_base_dir, '/*')
    md_lines <- gsub(regex, server_base_dir, md_lines)
    con_w <- file(output_md, 'wt')
    writeLines(md_lines, con_w)
    close(con_w)
}
