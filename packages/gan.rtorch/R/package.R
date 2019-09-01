#' gan.rtorch
#' @import methods
#' @importFrom reticulate import dict iterate import_from_path array_reshape np_array py_run_file py_run_string py_iterator py_call py_capture_output py_get_attr py_has_attr py_is_null_xptr py_to_r r_to_py tuple
#' @import reticulate
#' @docType package
#' @name gan.rtorch
NULL


packageStartupMessage("loading gan.rtorch")

.onLoad <- function(libname, pkgname) {
    # delay load PyTorch
    torch <<- import("torch", delay_load = list(
        priority = 5,
        environment = "r-torch"       # this is a user generated environment
    ))

    torchvision <<- import("torchvision", delay_load = list(
        priority = 4,                    # decrease priority so we don't get collision with torch
        environment = "r-torchvision"    # this is a user generated environment
    ))

    np <<- import("numpy", delay_load = list(
        priority = 3,                 # decrease priority so we don't get collision with torch
        environment = "r-np"          # this is a user generated environment
    ))
}
