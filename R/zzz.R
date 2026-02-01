# Avoid R CMD check global variable notes
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c(".state"))
}
