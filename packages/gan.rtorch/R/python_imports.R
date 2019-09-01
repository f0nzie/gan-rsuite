
#' @importFrom reticulate import_from_path
#' @export
gan_dummy <- function() {
    python_path <- system.file("python", package = "gan.rtorch")
    gan <- import_from_path("gan", path = python_path)
    gan$gan_functions$dummy()
}


#' @importFrom reticulate import_from_path
#' @export
py_fivenum <- function(arr) {
    # import fivenum from
    python_path <- system.file("python", package = "gan.rtorch")
    gan <- import_from_path("gan", path = python_path)
    gan$py_functions$fivenum(arr)
}


#' @importFrom reticulate import_from_path
#' @export
gan_train <- function() {
    python_path <- system.file("python", package = "gan.rtorch")
    gan <- import_from_path("gan", path = python_path)
    gan$gan_pytorch$train()
}
