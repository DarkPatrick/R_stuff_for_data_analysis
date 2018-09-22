####################################################
### применяет условие <condition> ко всем столбцам
### таблицы <data>, попадающим
### под регулярное выражение <col_names_pattern>
### или заданным через вектор <strict_col_names>
### или через вектор номеров <strict_col_nums>
###
### пример:
### my_data <- data.frame(
###     row1 = c(1, 8, 3, 4), 
###     row2 = c(5, 2, 6, 7))
### my_data %>% multiple_filter(
### col_names_pattern = "row", condition = " > 2")
### вывод:
###   row1 row2
### 1    3    6
### 2    4    7
####################################################

multiple_filter <- function(
        data,
        strict_col_nums = c(),
        strict_col_names = c(),
        col_names_pattern = "",
        condition) {
    require(dplyr)
    require(tidyr)

    if (length(strict_col_nums) > 0) {
        col_nums <- strict_col_nums
    } else {
        if (length(strict_col_names) > 0) {
            col_nums <- which(names(data) %in% strict_col_names)
        } else {
            col_nums <- grep(col_names_pattern, names(data))
        }
    }

    filtering_cols <- sapply(col_nums,
        function(x) {
            if ((x > 0) && (x <= dim(data)[2])) {
                paste0(deparse(substitute(data)), "[,", x, "]", condition)
            }
        }
    )
    filtering_cols <- Filter(Negate(is.null), filtering_cols)
    filtering_str <- paste(filtering_cols, collapse = " & ")
    if (filtering_str != "") {
        ret_val <- data %>% filter(eval(parse(text = filtering_str)))
    } else {
        ret_val <- data
    }

    return (ret_val)
}
