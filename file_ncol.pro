function file_ncol,file,hdr=hdr
  openr,lun,file,/GET_LUN
  str = ''
  
  hdr=hdr
  if keyword_set(hdr) then begin
    for i=1,hdr do readf,lun,str
  endif
  
  readf,lun,str
  data = strsplit(str,/EXTRACT)
  free_lun,lun
  return,n_elements(data)
  
end