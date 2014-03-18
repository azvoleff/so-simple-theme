knit2post <- function(input, base.url="/_posts", fig.path="/_images") {
    require(knitr)
    require(tools)
    opts_knit$set(base.url = base.url)
    opts_chunk$set(fig.path=file.path(fig.path, sub(".Rmd$", "", basename(input))))
    opts_chunk$set(fig.cap = "center")
    render_jekyll()
    output <- file.path(base.url, paste0(file_path_sans_ext(basename(input)), '.md'))
    knit(file.path(cur_dir, input), envir = parent.frame(), encoding="UTF-8")
}
