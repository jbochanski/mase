PRO mage_sensfunc, mage, stdfile, fluxtable,sensfile $
                   ,illumflatfile=illumflatfile
  
  istd=WHERE(mage.FITSFILE EQ fileandpath(stdfile))
  mage_pipe,mage[istd],illumflatfile=illumflatfile, /sensfunc
  tmp = strsplit(fileandpath(stdfile), 'mage', /extract)
  objfile = 'Object/ObjStr'+strtrim(tmp[0])
  obj_strct=xmrdfits(objfile,1)
  mage_fitstd, fluxtable, obj_strct, sensfile
  RETURN
END
