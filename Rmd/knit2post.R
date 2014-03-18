knit2post <- function(input, local_base_dir='..', base.url="/") {
    require(knitr)
    require(tools)
    opts_knit$set(base.url=base.url)
    fig.path <- file.path(local_base_dir, 'images', sub(".Rmd$", "", basename(input)))
    if (!file_test('-d', fig.path)) dir.create(fig.path)
    opts_chunk$set(fig.path=paste0(fig.path, '/'))
    opts_chunk$set(fig.cap="center")
    render_jekyll()
    output_md <- file.path(local_base_dir, '_posts', paste0(file_path_sans_ext(basename(input)), '.md'))
    knit(input, output_md, envir=parent.frame())
}
