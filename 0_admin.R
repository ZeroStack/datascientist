
# Dynamically set working directory
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# Set seed for reproducibility
set.seed(1234)

# Packages to load (excluding package dependencies)
packages <- c('devtools', 'rmarkdown')

# Load packages
lapply(packages, require, character.only=TRUE)

# Load custom package for task
devtools::load_all('taskpackage')

# Zip file location
file_location <- 'iconicdatascientist/test_data.zip'

# Keyword that needs to be hashed
keyword <- 'welcometotheiconic'

# Render markdown document, which will have the data object referenced
## The output document is a html file, Google Chrome is advised to open and view this file
render('script.Rmd', output_format = 'html_document')



