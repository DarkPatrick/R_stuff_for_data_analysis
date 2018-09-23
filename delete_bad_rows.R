filter_by_critical_groups <- function(data, key_col, critical_group) {
    require(data.table)

    print(length(unique(eval(parse(text = critical_group)))))
    data[,
         shitty_temporary_column := length(unique(eval(parse(text = critical_group)))),
         by = .(eval(parse(text = key_col)))
    ]
    #data <- data[shitty_temporary_column == 1]
    #data[, shitty_temporary_column := .(NULL)]
}

#df <- data.frame(a = c(1,2,3), b = c(1,1,2), c = c("Rose","Pink","Red"), d = c(2,3,4))
#df <- data.frame(a = c(1,2,1), b = c(1,1,2), c = c("Rose","Pink","Red"), d = c(2,3,4))
#setDT(df)[, c(levels(df$c), "c") := c(lapply(levels(c), function(x) as.integer(x == c)), .(NULL))]
#df1 <- data.table(df)
#setDT(df)[, levels(df$c) := lapply(levels(c), function(x) as.integer(x == c))]
#df1[, .(.N), by = eval(levels(df$c))]
#fread

#dt3 = data.table(sales_ccy = c("USD", "EUR", "GBP", "USD"), sales_amt = c(500,600,700,800), cost_ccy = c("GBP","USD","GBP","USD"), cost_amt = c(-100,-200,-300,-400))
#melt(dt3, measure = patterns("_ccy$", "_amt$"))[, .(tot_amt = sum(value2)), keyby = .(ccy=value1)]
#df1[, shitty_temporary_column := length(unique(c)), by = .(a)]
#df1 <- df1[shitty_temporary_column == 1]
#df1[, shitty_temporary_column := .(NULL)]
