pro loadnc,filename,var=var

  ;logvar = keyword_set(var)
  filename=filename
  
  ;a=-1
  
  print,filename
  ;print,logvar
  
  ;open nc file and get the names of the variables
  ncid=ncdf_open(filename,/nowrite)   ;open nc
  info=ncdf_inquire(ncid)
  print,info.nvars
  
  ;if var is not set
  if ~keyword_set(var) then begin
    for i=0,info.nvars-1 do begin
      ;
      varinfo = NCDF_VARINQ(ncid, i)
      NCDF_VARGET, ncid, i, vardata
      print,varinfo.name
;      if (n_elements(vardata) eq 1) or (varinfo.ndims le 1)  then begin
        (scope_varfetch(varinfo.name, /enter,level=1)) = vardata
;      endif else begin
;        (scope_varfetch(varinfo.name, /enter,level=1)) = transpose(vardata)
;      endelse
    endfor
    
  endif else begin
    ;if var is set
    var=var
    
    nvar=n_elements(var)
    for iv=0,nvar-1 do begin
      id=ncdf_varid(ncid,var[iv])
      varinfo = NCDF_VARINQ(ncid, id)
      if id eq -1 then begin
        print,'    !!!!Variable '+dsname+' doesn''t exist!'
        return
      endif else begin
        NCDF_VARGET, ncid, id, vardata
        help,vardata
        print,'data loaded!'
      endelse
      
;      if (n_elements(vardata) eq 1) or (varinfo.ndims le 1)  then begin
        (scope_varfetch(varinfo.name, /enter,level=1)) = vardata
;      endif else begin
;        (scope_varfetch(varinfo.name, /enter,level=1)) = transpose(vardata)
;      endelse
      
    endfor;iv
  endelse
  ;close nc file
  ncdf_close,ncid  ;close nc file
  return
  
end
