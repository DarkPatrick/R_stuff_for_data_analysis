git_source <- function(repo, file = NULL, private_token) {
    if (!require(gitlabr)) {
        install.packages("gitlabr")
        library(gitlabr)
    }

    my_gitlab <- gl_connection(
        "http://gitlab.aic.ru",
        #dream team private token
        private_token = private_token
    )

    if (is.null(file)) {
        file <- gl_list_files(project = repo, gitlab_con = my_gitlab)$name
        file <- file[grepl(".R$", file, ignore.case = TRUE)]
    }

    for (i in 1:length(file)) {
        raw <- gl_get_file(
            project = repo,
            file_path = file[i],
            gitlab_con = my_gitlab,
            to_char = F
        )
        temp_file <- file(file[i], "wb")
        writeBin(raw, temp_file)
        close(temp_file)
    }

    for (i in 1:length(file)) {
        tryCatch(
            {
                source(file[i])
            }, error = function(e) {}
        )
    }
}
