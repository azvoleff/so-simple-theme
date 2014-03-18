knit2post <- function(input, base.url = "/_posts") {
    cur_dir <- getwd()
    setwd('../_posts')
    require(knitr)
    opts_knit$set(base.url = base.url)
    fig.path <- paste0("figs/", sub(".Rmd$", "", basename(input)), "/")
    opts_chunk$set(fig.path = fig.path)
    opts_chunk$set(fig.cap = "center")
    render_jekyll()
    knit(file.path(cur_dir, input), envir = parent.frame(), encoding="UTF-8")
    setwd(cur_dir)
}
