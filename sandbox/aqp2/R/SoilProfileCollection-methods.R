##
## Accessors for SoilProfile and SoilProfileCollection classes
## 

## IDs column name
##
if (!isGeneric('idname'))
  setGeneric('idname', function(object) 
    standardGeneric('idname'))

setMethod("idname", "SoilProfile",
          function(object) {
            names(object@id)
          }
)

setMethod("idname", "SoilProfileCollection",
          function(object) {
            names(object@profiles[[1]]@id) # assuming all the profile have same ID colname
          }
)

## Get distinct profile IDs

if (!isGeneric("profile_id"))
  setGeneric("profile_id", function(object, ...) standardGeneric("profile_id"))

setMethod("profile_id", "SoilProfile",
          function(object) {
            object@id
          }
)

setMethod("profile_id", "SoilProfileCollection",
          function(object) {
            laply(object@profiles, profile_id)
          }
)

# return a concatenated vector of horizon + site names
# 

setMethod("names", "SoilProfile",
          function(x) {
            res <- c(horizons = horizonNames(object), site = siteNames(object))
            return(res)
          }
)

setMethod("names", "SoilProfileCollection",
          function(x) {
            names(profiles(object, 1))
          }
)

## get horizon column names
##

if (!isGeneric("horizonNames"))
  setGeneric("horizonNames", function(object, ...) standardGeneric("horizonNames"))

setMethod("horizonNames", "SoilProfile",
          function(object)
            return(names(horizons(object)))
)

setMethod("horizonNames", "SoilProfileCollection",
          function(object)
            # unnecessary coutious implementation:
            # unique(unlist(lapply(profiles(object), horizonNames)))
            return(horizonNames(profiles(object, 1)))
)

## get site column names
## 

if (!isGeneric("siteNames"))
  setGeneric("siteNames", function(object, ...) standardGeneric("siteNames"))

setMethod("siteNames", "SoilProfile",
          function(object) names(site(object))
)

setMethod("siteNames", "SoilProfileCollection",
          function(object) siteNames(profiles(object, 1))
)

## Get site data
##

if (!isGeneric('site'))
  setGeneric('site', function(object, ...) 
    standardGeneric('site'))

setMethod("site", "SoilProfile",
  function(object) {
    res <- data.frame(object@id, object@site, stringsAsFactors = FALSE)
    names(res)[1] <- idname(object)
    res
  })

setMethod("site", "SoilProfileCollection",
  function(object, as.list = FALSE) {
    
    if (as.list) {
      res <- lapply(profiles(object), function(x) x@site)
    } else {
      res <- ldply(object@profiles, site, .id = idname(object))
    }
    
    res
  }
)

## Get horizons data
##

if (!isGeneric('horizons'))
  setGeneric('horizons', function(object, ...) 
    standardGeneric('horizons'))

setMethod("horizons", "SoilProfile",
  function(object) {
    res <- data.frame(object@id, object@depths, object@horizons, stringsAsFactors = FALSE)
    names(res)[1] <- idname(object)
    res
  })

setMethod("horizons", "SoilProfileCollection",
  function(object, as.list = FALSE) {
    
    if (as.list) {
      res <- lapply(object@profiles, function(x) x@horizons)
    } else {
      res <- ldply(object@profiles, horizons, .id = idname(object))
    }
    
    res
  })

## Get depths
##

if (!isGeneric('depths'))
  setGeneric('depths', function(object, ...) 
    standardGeneric('depths'))

setMethod("depths", "SoilProfile",
  function(object) {
    res <- data.frame(object@id, object@depths, stringsAsFactors = FALSE)
    names(res)[1] <- idname(object)
    res
  }
)

setMethod("depths", "SoilProfileCollection",
          
  function(object, as.list = FALSE) {
    
    if (as.list) {
      res <- lapply(object@profiles, function(x) x@depths)
    } else {
      res <- ldply(object@profiles, depths, .id = idname(object))
    }
    
    res
  }
)

if (!isGeneric('depthNames'))
  setGeneric('depthNames', function(object, ...) 
    standardGeneric('depthNames'))

setMethod("depthNames", "SoilProfile",
  function(object) {
    colnames(object@depths)
  }
)

setMethod("depthNames", "SoilProfileCollection",
  
  function(object, as.list = FALSE) {
    depthNames(profiles(object, 1))
  }
)

# Depth units
# 

if (!isGeneric('depth_units'))
  setGeneric('depth_units', function(object) 
    standardGeneric('depth_units'))

setMethod("depth_units", "SoilProfile",
          function(object) {
            object@depth_units
          }
)

setMethod("depth_units", "SoilProfileCollection",
          function(object) {
            unique(laply(object@profiles, depth_units))
          }
)

## Get list or unique SoilProfile
##

if (!isGeneric('profiles'))
  setGeneric('profiles', function(object, i = NULL) 
    standardGeneric('profiles'))

setMethod("profiles", "SoilProfileCollection",
          function(object, i = NULL) {
            if (is.null(i)) object@profiles
            else object@profiles[[i]]
          }
)
