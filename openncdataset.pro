function openncdataset,filename,datasetname
  ;-----------------------------------------------------
  ;author: Chao Wang
  ;last modify 02-04-2015
  ;this function can be used for reading one datasetname
  ;form a specific nc file (i.e. *.nc)
  ;-----------------------------------------------------
  ;usage: result=openncdataset('example.nc',
  ;                                      'datasetname')
  ;inputs:   the name of the file and dataset
  ;outputs:  the data of the dataset in the nc file
  ;-----------------------------------------------------

  compile_opt idl2
  
  a=-1
  
  if n_params() ne 2 then begin
    print,' !!!! usage: data=openncdataset(ncfilename,datasetname)'
    return,a
  endif
  
  ;load varibales
  fname=filename
  dsname=datasetname
  
  ;Does the file exist?
;  if (~(file_test(fname))) then begin
;    print,' !!!! The file ',fname,'isn''t there !!!!'
;    return
;  endif
  
  ;open nc file and get the names of the variables
  ncid=ncdf_open(fname,/nowrite)   ;open nc
  id=ncdf_varid(ncid,dsname)
  
  if id eq -1 then begin
    ;print,'    !!!!Variable '+dsname+' doesn''t exist!'
    return,a
  endif else begin
    NCDF_VARGET, ncid, id, vardata
  ;print,dsname+ ' loaded:'
  ;help,vardata
  ;print,'data loaded!'
  endelse
  NCDF_CLOSE,ncid
  return,vardata
end