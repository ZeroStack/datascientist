#' CLEAN: Unzip the file and load data using keyword to obtain secret key
#'  
#' @importFrom digest digest
#' @importFrom Hmisc getZip
#' @importFrom jsonlite fromJSON
#' @param filename A character value of the location of the file to open
#' @param keyword A character value to apply a cryptographical hash function to
#' @param hashing_function Cryptographical hash function to apply to keyword, must be one of md5, sha1, crc32, sha256, sha512, xxhash32, xxhash64 and murmur32.
#' @param serialize A logical variable indicating whether the object should be serialized using serialize (in ASCII form). Defaults to FALSE
#' 
#' @export
open_file <- function(filename, keyword, hashing_function, serialize = FALSE) {
  
  # Hash the secret_key with keyword provided
  temp_hashed_secret <- digest::digest(object = keyword,
                                       algo = hashing_function,
                                       serialize = serialize
  )
  
  lookup <- c('TRUE' = 'serialize', 'FALSE' = 'unserialized')
  
  message(paste0('PASSWORD: Hashing the keyword: ', keyword, ' using ', hashing_function, ' in an ', lookup[[paste0(serialize)]], ' fashion.'))
  
  # Create a connection to the file; opening it with the hashed secret key
  temp_connection <- Hmisc::getZip(url = filename,
                                   password = temp_hashed_secret
  )
  
  message(paste0('ATTEMPT: Opening file with secret key from previous step.'))
  # Try to open the data 
  temp_data <- try({expr = jsonlite::fromJSON(txt = temp_connection)},
                   silent = TRUE)
  
  # Boolean for validity of data; check if there is more than 1 row of data
  temp_boolean_validity <- !identical(class(temp_data), 'try-error')
  
  # Check if data is valid
  if(isTRUE(temp_boolean_validity)) {
    message(paste0('SUCCESS: Data obtained by hashing the keyword with ', hashing_function, '.'))
    
    # Remove temporary objects
    rm(temp_connection, temp_boolean_validity)
    return(temp_data)
  } else{
    message(paste0('UNABLE: It appears hashing using ', hashing_function, ' is not the password is encrypted in.'))
  }

  
  return(temp_connection)
}


