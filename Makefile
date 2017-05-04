######################
# 
# Created: 2017.05.01
# Copyright: Steven E. Pav, 2017
# Author: Steven E. Pav
######################

############### FLAGS ###############

PKG_NAME 					:= zipper
VMAJOR 						 = 0
VMINOR 						 = 1
VPATCH  					 = 0
VDEV 							 = .1000

RPKG_USES_RCPP 		:= 1

include ./rpkg_make/Makefile

#for vim modeline: (do not edit)
# vim:ts=2:sw=2:tw=129:fdm=marker:fmr=FOLDUP,UNFOLD:cms=#%s:tags=.tags;:syn=make:ft=make:ai:si:cin:nu:fo=croqt:cino=p0t0c5(0:
