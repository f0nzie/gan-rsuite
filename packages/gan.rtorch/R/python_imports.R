
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
train_gan <- function() {
    python_path <- system.file("python", package = "gan.rtorch")
    gan <- import_from_path("gan", path = python_path)
    gan$gan_pytorch$train()
}
