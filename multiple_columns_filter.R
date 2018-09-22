multiple_filter <- function(data, col_names_pattern, condition) {
    require(dplyr)
    require(tidyr)

    col_nums <- grep(col_names_pattern, names(data))
    filtering_cols <- sapply(col_nums,
        function(x) {
            paste0(deparse(substitute(data)), "[,", x, "]", condition)
        }
    )
    filtering_str <- paste(filtering_cols, collapse = " & ")
    ret_val <- data %>% filter(eval(parse(text = filtering_str)))

    return (ret_val)
}
