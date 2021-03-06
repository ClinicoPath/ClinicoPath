#' @importFrom R6 R6Class
#' @import jmvcore
#'

reportcatClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "reportcatClass",
    inherit = reportcatBase,
    private = list(
        .run = function() {


            if (length(self$options$vars) == 0) {
                todo <- "
                <br>Welcome to ClinicoPath
                          <br><br>
                          This tool will help you to write a general summary of variables
                              in your data.
                          <br><br>
                          Select the 'Variables' you want to include in the summary. Nominal, Ordinal and Categorical variables are allowed.
                          <br><br>
                          This tool uses report package. Please cite the packages and jamovi using references below.
                          "

                html <- self$results$todo
                html$setContent(todo)
                return()
            } else {

                todo <- ""
                html <- self$results$todo
                html$setContent(todo)



                if (nrow(self$data) == 0)
                    stop('Data contains no (complete) rows')



            mydata <- self$data

            # med <- self$options$med
            # cent <- self$options$cent
            # disp <- self$options$disp
            # ran <- self$options$ran
            # distr <- self$options$distr
            # lev <- self$options$lev
            # n_ch <- self$options$n_ch
            # mis <- self$options$mis

            formula <- jmvcore::constructFormula(terms = self$options$vars)

            myvars <- jmvcore::decomposeFormula(formula = formula)

            myvars <- unlist(myvars)


            myreport <- mydata %>%
                select(myvars) %>%
                report::report(.,
                               median = FALSE,
                               centrality = TRUE,
                               dispersion = TRUE,
                               range = TRUE,
                               distribution = FALSE,
                               levels_percentage = FALSE,
                               n_entries = 3,
                               missing_percentage = FALSE
            #                    median = med,
            #                    centrality = cent,
            #                    dispersion = disp,
            #                    range = ran,
            #                    distribution = distr,
            #                    levels_percentage = lev,
            #                    n_characters = n_ch,
            #                    missing_percentage = mis
                               )

            results1 <- myreport



            # results1 <- mydata %>%
            #     explore::describe(.) %>%
            #     dplyr::filter(na > 0)



            self$results$text$setContent(results1)

            }






        })
)
