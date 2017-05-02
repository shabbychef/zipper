/*
 
  This file is part of zipper.
  
  zipper is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  zipper is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU Lesser General Public License for more details.
  
  You should have received a copy of the GNU Lesser General Public License
  along with zipper.  If not, see <http://www.gnu.org/licenses/>.

  Created: 2017.05.01
  Copyright: Steven E. Pav, 2017
  Author: Steven E. Pav <shabbychef@gmail.com>
  Comments: Steven E. Pav
*/

#ifndef __DEF_ZIPPER__
#define __DEF_ZIPPER__

#include <math.h>

#define MAX(a,b) ((a>b)? (a):(b))
#define MIN(a,b) ((a<b)? (a):(b))

#endif /* __DEF_ZIPPER__ */


#include <Rcpp.h>
using namespace Rcpp;

// return number of elements in sortx[lo:hi) <= val
// or lo - 1 if none.
// these are C indexed, so you should have
// lo = 0 and hi = length(sortx) to do the
// whole vector.
template <typename T,typename D,bool comp_with_eq>
int bin_search_lstar(T sortx, D val, const int lo, const int hi) {
	int kidx;
	int ilo=lo;
	int ihi=hi;

	if (ilo < 0) { stop("out of bounds"); }

	while (ilo < ihi) {
		kidx = (ilo + ihi) / 2;

		if (comp_with_eq) {
			if (val <= sortx[kidx]) {
				ihi = kidx;
			} else {
				ilo = kidx + 1;
			}
		} else {
			if (val < sortx[kidx]) {
				ihi = kidx;
			} else {
				ilo = kidx + 1;
			}
		}
	}
	return ilo - 1;
}

// for each val in y, 
// return number of elements in sortx[lo:hi) <= val
// or lo - 1 if none.
// these are C indexed, so you should have
// lo = 0 and hi = length(sortx) to do the
// whole vector.
template <typename T,typename D,bool comp_with_eq>
IntegerVector zip_index_lstar(T sortx, T refy, const int lo, const int hi) {
	int kidx;
	int xidx, yidx, lastv;
	int ynel = refy.length();
	IntegerVector retv(ynel);

	if (ynel == 1) {
		retv[0] = bin_search_lstar<T,D,comp_with_eq>(sortx, refy[0], lo, hi);
	} else {
		if (lo < 0) { stop("out of bounds"); }
		xidx = lo;
		yidx = 0;
		if (comp_with_eq) {

			while ((xidx < hi) && (yidx < ynel)) {
				if (sortx[xidx] <= refy[yidx]) {
					xidx++;
				} else {
					retv[yidx] = xidx - 1;
					yidx++;
				}
			}

		} else {

			while ((xidx < hi) && (yidx < ynel)) {
				if (sortx[xidx] < refy[yidx]) {
					xidx++;
				} else {
					retv[yidx] = xidx - 1;
					yidx++;
				}
			}

		} 
		lastv = xidx - 1;
		while (yidx < ynel) {
			retv[yidx] = lastv;
			yidx++;
		}
	}
	return retv;
}

template <typename T,typename D,bool comp_with_eq>
IntegerVector zip_index_lstar_wrap(T sortx, T refy) {
    const int lo=0;
    const int hi=int(sortx.length());
    IntegerVector retv;
    retv = zip_index_lstar<T,D,comp_with_eq>(sortx, refy, lo, hi);
    return retv;
}

//' @title
//' Zip sorted arrays against each other
//' @description
//' Given two sorted arrays, \eqn{x} and \eqn{y}, find indices \eqn{L} that \sQuote{zips}
//' the two together. 
//' 
//' @param sortx a sorted array of \sQuote{reference} values.
//' @param looky a sorted array of values whose place among \code{sortx} is to be found.
//'
//'
//' @details
//'
//' For example, for \code{zip_le}, we find the array \eqn{L} of the
//' same length as \eqn{y} such that there are exactly \eqn{L_i} elements of \eqn{x}
//' less than or equal to \eqn{y_i}.
//'
//' @return a vector, filled out as follows:
//' \describe{
//' \item{zip_le}{Returns the vector \eqn{L} such that there are exactly \eqn{L_i} elements of \eqn{x} less than or equal to \eqn{y_i}.}
//' \item{zip_lt}{Returns the vector \eqn{L} such that there are exactly \eqn{L_i} elements of \eqn{x} less than \eqn{y_i}.}
//' \item{zip_ge}{Returns the vector \eqn{L} such that there are exactly \eqn{L_i} elements of \eqn{x} greater than or equal to \eqn{y_i}.}
//' \item{zip_gt}{Returns the vector \eqn{L} such that there are exactly \eqn{L_i} elements of \eqn{x} greater than \eqn{y_i}.}
//' }
//'
//' @note
//' Returns zero when there are none, as expected.
//'
//' @examples
//' set.seed(1234)
//' x <- sort(rnorm(1e5))
//' y <- sort(rnorm(1e2))
//' idx1 <- zip_le(x,y)
//' # slow way:
//' uther <- rep(NA,length(y))
//' for (iii in 1:length(y)) {
//'   uther[iii] <- sum(x <= y[iii])
//' }
//'
//' @note it would be better if this code supported mixed types of sortx and looky.
//' @template etc
//' @rdname zipsorted
//' @export
// [[Rcpp::export]]
IntegerVector zip_le(SEXP sortx, SEXP looky) {
    IntegerVector retv;
    switch (TYPEOF(sortx)) {
        case  INTSXP: { retv = zip_index_lstar_wrap<IntegerVector,int,TRUE>(sortx, looky); break; }
        case REALSXP: { retv = zip_index_lstar_wrap<NumericVector,double,TRUE>(sortx, looky); break; }
        default: stop("Unsupported input type");
    }
	return retv;
}

//' @rdname zipsorted
//' @export
// [[Rcpp::export]]
IntegerVector zip_lt(SEXP sortx, SEXP looky) {
    IntegerVector retv;
    switch (TYPEOF(sortx)) {
        case  INTSXP: { retv = zip_index_lstar_wrap<IntegerVector,int,FALSE>(sortx, looky); break; }
        case REALSXP: { retv = zip_index_lstar_wrap<NumericVector,double,FALSE>(sortx, looky); break; }
        default: stop("Unsupported input type");
    }
	return retv;
}

//for vim modeline: (do not edit)
// vim:et:nowrap:ts=4:sw=4:tw=129:fdm=marker:fmr=FOLDUP,UNFOLD:cms=//%s:tags=.c_tags;:syn=cpp:ft=cpp:mps+=<\:>:ai:si:cin:nu:fo=croql:cino=p0t0c5(0:
