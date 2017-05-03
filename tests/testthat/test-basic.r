# Copyright 2017 Steven E. Pav. All Rights Reserved.
# Author: Steven E. Pav

# This file is part of zipper.
#
# zipper is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# zipper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with zipper.  If not, see <http://www.gnu.org/licenses/>.

# env var:
# nb: 
# see also:
# todo:
# changelog: 
#
# Created: 2017.05.02
# Copyright: Steven E. Pav, 2017-2017
# Author: Steven E. Pav
# Comments: Steven E. Pav

# helpers#FOLDUP
set.char.seed <- function(str) {
	set.seed(as.integer(charToRaw(str)))
}
THOROUGHNESS <- getOption('test.thoroughness',1.0)
#UNFOLD

test_em <- function(sortx,looky) {
	idx1 <- zip_le(sortx,looky)
	uther <- rep(NA_integer_,length(looky))
	for (iii in 1:length(looky)) {
		uther[iii] <- sum(sortx <= looky[iii])
	}
	expect_true(all.equal(idx1,uther))

	idx2 <- zip_lt(sortx,looky)
	uther <- rep(NA_integer_,length(looky))
	for (iii in 1:length(looky)) {
		uther[iii] <- sum(sortx < looky[iii])
	}
	expect_true(all.equal(idx2,uther))
}

context("code is correct")#FOLDUP
test_that("basic usage double double",{#FOLDUP
	set.char.seed("28da9d35-d83c-49dc-99d0-81ca68567f0b")

	x <- sort(rnorm(100))
	y <- sort(rnorm(100))
	test_em(x,y)

	x <- sort(rnorm(1))
	y <- sort(rnorm(100))
	test_em(x,y)

	x <- sort(rnorm(100))
	y <- sort(rnorm(1))
	test_em(x,y)

	x <- sort(ceiling(rnorm(100)))
	y <- sort(rnorm(100))
	test_em(x,y)

	x <- sort(ceiling(rnorm(100)))
	y <- sort(ceiling(rnorm(100)))
	test_em(x,y)

	# sentinel
	expect_true(TRUE)
})#UNFOLD
test_that("basic usage integer integer",{#FOLDUP
	set.char.seed("aef12c85-961d-4bd3-a58a-e855d1e9ac5e")

	x <- sort(as.integer(ceiling(rnorm(100))))
	y <- sort(as.integer(ceiling(rnorm(100))))
	test_em(x,y)

	x <- sort(as.integer(ceiling(rnorm(1))))
	y <- sort(as.integer(ceiling(rnorm(100))))
	test_em(x,y)

	x <- sort(as.integer(ceiling(rnorm(100))))
	y <- sort(as.integer(ceiling(rnorm(1))))
	test_em(x,y)

	# sentinel
	expect_true(TRUE)
})#UNFOLD
# Copyright 2017 Steven E. Pav. All Rights Reserved.
# Author: Steven E. Pav

# This file is part of zipper.
#
# zipper is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# zipper is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with zipper.  If not, see <http://www.gnu.org/licenses/>.

# env var:
# nb: 
# see also:
# todo:
# changelog: 
#
# Created: 2017.05.02
# Copyright: Steven E. Pav, 2017-2017
# Author: Steven E. Pav
# Comments: Steven E. Pav

# helpers#FOLDUP
set.char.seed <- function(str) {
	set.seed(as.integer(charToRaw(str)))
}
THOROUGHNESS <- getOption('test.thoroughness',1.0)
#UNFOLD

test_em <- function(sortx,looky) {
	idx1 <- zip_le(sortx,looky)
	uther <- rep(NA_integer_,length(looky))
	for (iii in 1:length(looky)) {
		uther[iii] <- sum(sortx <= looky[iii])
	}
	expect_true(all.equal(idx1,uther))

	idx2 <- zip_lt(sortx,looky)
	uther <- rep(NA_integer_,length(looky))
	for (iii in 1:length(looky)) {
		uther[iii] <- sum(sortx < looky[iii])
	}
	expect_true(all.equal(idx2,uther))
}

context("code is correct")#FOLDUP
test_that("basic usage",{#FOLDUP
	set.char.seed("28da9d35-d83c-49dc-99d0-81ca68567f0b")

	x <- sort(rnorm(100))
	y <- sort(rnorm(100))
	test_em(x,y)

	x <- sort(rnorm(1))
	y <- sort(rnorm(100))
	test_em(x,y)

	x <- sort(rnorm(100))
	y <- sort(rnorm(1))
	test_em(x,y)

	x <- sort(ceiling(rnorm(100)))
	y <- sort(rnorm(100))
	test_em(x,y)

	x <- sort(ceiling(rnorm(100)))
	y <- sort(ceiling(rnorm(100)))
	test_em(x,y)

	x <- sort(as.integer(ceiling(rnorm(100))))
	y <- sort(as.integer(ceiling(rnorm(100))))
	test_em(x,y)

	x <- sort(as.integer(ceiling(rnorm(1))))
	y <- sort(as.integer(ceiling(rnorm(100))))
	test_em(x,y)

	x <- sort(as.integer(ceiling(rnorm(100))))
	y <- sort(as.integer(ceiling(rnorm(1))))
	test_em(x,y)

	# sentinel
	expect_true(TRUE)
})#UNFOLD

# 2FIX: check the effects of NA
#UNFOLD

# 2FIX: check the effects of NA
#UNFOLD

#for vim modeline: (do not edit)
# vim:ts=2:sw=2:tw=79:fdm=marker:fmr=FOLDUP,UNFOLD:cms=#%s:syn=r:ft=r:ai:si:cin:nu:fo=croql:cino=p0t0c5(0:
