
#' @include S4-documentation.R
NULL


# Generics ----------------------------------------------------------------

#' @title Generics to extract a slots content
#'
#' @param object A valid spata-object.
#' @param of_sample The sample from which to extract the content.
#' @param trajectory_name The trajectory specified as a character value.
#'
#' @return The respective slots content.
#' @export
#'

setGeneric(name = "image", def = function(object, of_sample){

  standardGeneric(f = "image")

})

#' @rdname image
#' @export
setGeneric(name = "exprMtr", def = function(object, of_sample = NULL){

  standardGeneric(f = "exprMtr")

})

#' @rdname image
#' @export
setGeneric(name = "coordinates", valueClass = "data.frame", def = function(object, of_sample = "all"){

  standardGeneric("coordinates")

})

#' @rdname image
#' @export
setGeneric(name = "coordinates<-", def = function(object, value){

  standardGeneric(f = "coordinates<-")

})

#' @rdname image
#' @export
setGeneric(name = "featureData", valueClass = "data.frame", def = function(object, of_sample = "all"){

  standardGeneric(f = "featureData")

})

#' @rdname image
#' @export
setGeneric(name = "featureData<-", def = function(object, value){

  standardGeneric(f = "featureData<-")

})

#' @rdname image
#' @export
setGeneric(name = "samples", valueClass = "character", def = function(object){

  standardGeneric(f = "samples")

})

#' @rdname image
#' @export
setGeneric(name = "trajectory", def = function(object, trajectory_name, of_sample){

  standardGeneric(f = "trajectory")

})

#' @rdname image
#' @export
setGeneric(name = "ctdf", def = function(t_obj){

  standardGeneric(f = "ctdf")

})

#' @rdname image
#' @export
setGeneric(name = "getTrajectoryComment", def = function(object, ...){

  standardGeneric(f = "getTrajectoryComment")

})



# Methods -----------------------------------------------------------------

#' @title Methods

#' @param object A valid spata-object.
#' @param of_sample The sample from which to extract the content.
#' @param trajectory_name The trajectory specified as a character value.
#'
#' @export
#'

setMethod(f = "image", signature = "spata", definition = function(object, of_sample){

  return(object@image[[of_sample]])

})

#' @rdname image
#' @export
setMethod(f = "exprMtr", signature = "spata", definition = function(object, of_sample = "all"){

  of_sample <- check_sample(object = object, of_sample = of_sample)

  bc_in_sample <-
    object@fdata %>%
    dplyr::filter(sample %in% of_sample) %>%
    dplyr::pull(barcodes)

  exprMtr <- object@data@norm_exp[,bc_in_sample]

  return(exprMtr)

})

#' @rdname image
#' @export
setMethod(f = "coordinates", signature = "spata", def = function(object, of_sample = "all"){

  of_sample <- check_sample(object, of_sample = of_sample)

  ##----- filter for bc in sample
  coords_df <-
    object@coordinates %>%
    dplyr::filter(sample %in% of_sample)

  return(coords_df)

})

#' @rdname image
#' @export
setMethod(f = "coordinates<-", signature = "spata", def = function(object, value){

  object@coordinates <- value

  #validObject(object)

  return(object)

})

#' @rdname image
#' @export
setMethod(f = "featureData", signature = "spata", definition = function(object, of_sample = "all"){


  of_sample <- check_sample(object = object, of_sample = of_sample)

  fdata <-
    as.data.frame(object@fdata) %>%
    dplyr::filter(sample %in% of_sample)


  return(fdata)

})

#' @rdname image
setMethod(f = "featureData<-", signature = "spata", definition = function(object, value){


  object@fdata <- value

  return(object)

})

#' @rdname image
#' @export
setMethod(f = "samples", signature = "spata", definition = function(object){

  return(object@samples)

})

#' @rdname image
#' @export
setMethod(f = "trajectory", signature = "spata", definition = function(object, trajectory_name, of_sample){

  of_sample <- check_sample(object = object, of_sample = of_sample, desired_length = 1)

  if(!is.character(trajectory_name) | length(trajectory_name) != 1){

    stop("Argument 'trajectory_name' needs to be a character vector of length 1.")

  }

  t_names <- base::names(object@trajectories[[of_sample]])

  if(trajectory_name %in% t_names){

    trajectory_object <- object@trajectories[[of_sample]][[trajectory_name]]

    return(trajectory_object)

  } else {

    stop(stringr::str_c("Could not find trajectory '", trajectory_name, "' in sample: '", of_sample, "'.", sep = ""))

  }

})

#' @rdname image
#' @export
setMethod(f = "ctdf", signature = "spatialTrajectory", definition = function(t_obj){

  t_obj@compiled_trajectory_df

})

#' @rdname image
#' @export
setMethod(f = "getTrajectoryComment", signature = "spata", definition = function(object, trajectory_name, of_sample){


  if(!is.character(trajectory_name) | length(trajectory_name) != 1){

    stop("Argument 'trajectory_name' needs to be a character vector of length 1.")

  }

  t_names <- base::names(object@trajectories[[of_sample]])

  if(trajectory_name %in% t_names){

    trajectory_object <- object@trajectories[[of_sample]][[trajectory_name]]

    return(trajectory_object@comment)

  } else {

    stop(stringr::str_c("Could not find trajectory '", trajectory_name, "' in sample '", of_sample, "'.", sep = ""))

  }

})

#' @rdname image
#' @export
setMethod(f = "getTrajectoryComment", signature = "spatialTrajectory", definition = function(object){


  return(stringr::str_c("Comment: ", object@comment))


})