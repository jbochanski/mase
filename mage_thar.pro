 tset_slits = mrdfits("Orders.fits",1)
;; ------
;; Expand slit set to get left and right edge
traceset2xy, tset_slits[0], rows, left_edge
traceset2xy, tset_slits[1], rows, right_edge
trace = (left_edge + right_edge)/2.0D

arcimg=xmrdfits('Arcs/Arc1075.fits',hdr)
sz = size(arcimg, /dimen)
nx = sz[0]
ny = sz[1]

waveimg = xmrdfits('Arcs/ArcImg1075.fits')
ordr_str=mrdfits("OStr_mage.fits", 1)
;; read in std tracre
obj_strct=xmrdfits('Object/ObjStr1046.fits',1) 
scihdr=headfits('Raw/mage1075.fits')
dum0=0*arcimg
dum1=dum0 + 1.0d
mage_echextobj,arcimg,dum1,scihdr,dum0,dum1,waveimg,tset_slits,obj_strct $
               ,/BOXCAR,BOX_RAD=2.0,outfil='Final/debug_arc1075.fits' $
               ,/NOVACHELIO
obj_strct.exp=float(sxpar(scihdr,'EXPTIME'))
sensfunc='GD108_std.sav'
mage_flux, sensfunc, obj_strct, rej=0.05

res = 299792.458d/4100.d*float(sxpar(scihdr,'SLITNAME'))
mage_combspec, obj_strct, fspec
outflux = 'FSpec/ThAr_F.fits'
outerr  = 'FSpec/ThAr_E.fits'
combname = 'FSpec/ThAr_comb.fits'
mage_1dspec, fspec, outflux, outerr, combname $
             , hdr=scihdr, resvel=res
END
