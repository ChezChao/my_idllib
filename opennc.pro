pro opennc,filename
  ;-----------------------------------------------------
  ;author: Chao Wang
  ;last modify 13-03-2015
  ;this function can be used for checking the dataset in
  ;a specific nc file (i.e. *.nc)
  ;-----------------------------------------------------
  ;usage:    opennc,'example.nc'
  ;inputs:   the name of the file
  ;outputs:  all the datasets in the nc file
  ;-----------------------------------------------------

  filename=filename
  
  ;open nc file and get the names of the variables
  ncid=ncdf_open(filename,/nowrite)   ;open nc
  info=ncdf_inquire(ncid)
  print,info.nvars
  
  for i=0,info.nvars-1 do begin
    ;
    varinfo = NCDF_VARINQ(ncid, i)
    NCDF_VARGET, ncid, i, vardata
    print,varinfo.name
    ;if (n_elements(vardata) eq 1) or (varinfo.ndims le 1)  then begin
     (scope_varfetch(varinfo.name, /enter,level=1)) = vardata
    ;endif else begin
    ; (scope_varfetch(varinfo.name, /enter,level=1)) = transpose(vardata)
    ;endelse
  endfor
  
  ncdf_close,ncid  ;close nc file
  return

end