.onLoad <- function(libname, pkgname)
{
  # ...
  assign(x = "taskpackage", 
         value = new.env(), 
         envir = .GlobalEnv)
  # ...
}