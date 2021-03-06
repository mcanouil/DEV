#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param from PARAM_DESCRIPTION
#' @param subject PARAM_DESCRIPTION
#' @param to PARAM_DESCRIPTION
#' @param body PARAM_DESCRIPTION
#' @param attachment PARAM_DESCRIPTION
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @rdname mail
#' @export 
mail <- function (from, subject, to, body, attachment) {
  if (missing(subject)) {
    eMailSubject <- '-s "(no subject)"'
  } else {
    eMailSubject <- paste0('-s "', subject, '"')
  }
  if (missing(to)) {
    stop('"to" is missing!')
  }
  if (missing(body)) {
    eMailBody <- 'echo "" |'
  } else {
    eMailBody <-  paste0('echo "', body, '" |')
  }
  if (missing(attachment)) {
    eMailJoint <- ""
  } else {
    toAttach <- sapply(seq_along(attachment), function(attach) {
      return(!system(paste("test -f", attachment[attach])))
    })
    if (any(toAttach)) {
      eMailJoint <- paste(paste0("-a", attachment[toAttach]), collapse = " ")
    } else {
      eMailJoint <- ""
    }
  }
  if (missing(from)) {
    eMailFrom <- ""
  } else {
    eMailFrom <- paste("-r", from)
  }
  
  system(paste(eMailBody, 'mail', eMailFrom, eMailSubject, eMailJoint, to))
}
