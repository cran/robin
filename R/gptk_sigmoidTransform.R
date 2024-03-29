.sigmoidTransform <-
function (x, transform="atox") {

  eps <- 2.2204e-16

  thre <- 36	## threshold
  y <- array(0, dim(as.array(x)))

  if ( "atox" == transform ) {
    for ( ind in seq_along(as.array(x)) ) {
      if ( x[ind] > thre )
        y[ind] <- 1-eps
      else if ( x[ind] < -thre )
        y[ind]<- eps
      else
        y[ind] <- 1/(1+exp(-x[ind]))
    }
  } else if ( "xtoa" == transform ) {
    for ( ind in seq_along(as.array(x)) ) {
      y[ind] <- .complexLog(x[ind]/(1-x[ind]))
    }
  } else if ( "gradfact" == transform )
    y <- x*(1-x)

  return (y)
}
