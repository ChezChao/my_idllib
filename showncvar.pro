pro showncvar,filename
  ;-----------------------------------------------------
  ;author: Chao Wang
  ;last modify 02-04-2015
  ;this function can be used for displaying the names
  ; and dimentions of the dataset from
  ;  a specific nc file (i.e. *.nc)
  ;-----------------------------------------------------
  ;usage:    showncvar,'example.nc'
  ;inputs:   the name of the netcdf file
  ;outputs:  all the names and dimention information 
  ;          will be printed in the console window
  ;-----------------------------------------------------
  compile_opt idl2

  filename=filename
  
  log=file_test(filename,/read)
  if log eq 0 then begin
    print,filename+' doesn''t exist'
    return
  endif
  
  ncid=ncdf_open(filename,/nowrite)
  ;NCDF_DIMINQ: Retrieve the names and sizes of dimensions in the file.
  ;NCDF_VARINQ: Retrieve the names, types, and sizes of variables in the file.
  
  info=NCDF_INQUIRE(ncid)
  ;print,info
  
  ;for dimensions
  dimname=strarr(info.ndims)
  dimsize=lonarr(info.ndims)
  for i=0,info.ndims -1 do begin
    NCDF_DIMINQ, ncid, i, tname, tsize
    dimname[i]=tname
    dimsize[i]=tsize
    print,'Dimension: ',tname, tsize
  endfor
  
  for j=0,info.nvars-1 do begin
    varinq_struct=ncdf_varinq(ncid,j)
    print,'Variable: '+varinq_struct.name+' (',varinq_struct.datatype+', ('+STRJOIN(dimname[varinq_struct.dim]+',')+') ('+ STRJOIN(STRCOMPRESS(dimsize[varinq_struct.dim])+',')+'))'
    ;print,'Dimensions:'
    ;for x=0,varinq_struct.ndims-1 do  print,' ',name[x],'(', STRCOMPRESS(dimsize[x],/remove_all),')'
    ;print,'      '
  endfor
  
  ncdf_close,ncid
  
end