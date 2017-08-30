function loadtxt,file,hdr=hdr,type=type
  ; load data from a plain text
  ; if there are headers in the text, you could
  ; use hdr= number of lines    to skip the headers
  ; specific data type by setting type keyword
  
  str=''
  
  ; obtain the numbers of line and column of the file
  nline=file_lines(file)
  ncol=file_ncol(file,hdr=hdr)
  
  openr,lun,file,/GET_LUN
  
  ; skip the headers
  if keyword_set(hdr) then begin
    nline=nline-hdr
    if nline lt 0 then begin
      print,'!! headers are longer than file, impossible'
      return,0
    endif
    for i=1,hdr do begin
      readf,lun,str
    endfor
  endif
  
  if ~keyword_set(type) then begin
    dtype=4
  endif else begin
    case type of
      'byte'     : dtype=1
      'int'      : dtype=2
      'long'     : dtype=3
      'float'    : dtype=4
      'double'   : dtype=5
      'complex'  : dtype=6
      'string'   : dtype=7
      'struct'   : dtype=8
      'dcomplex' : dtype=9
      'pointer'  : dtype=10
      'objref'   : dtype=11
      'uint'     : dtype=12
      'ulong'    : dtype=13
      'long64'   : dtype=14
      'ulong64'  : dtype=15
    endcase
  endelse
  
  if ncol gt 1 then begin
    ; make arrays
    data=make_array(ncol,nline,type=dtype)
  endif else begin
    ; only one column case
    data=make_array(nline,type=dtype)
  endelse
  ;read data
  readf,lun,data
  ;close the file
  free_lun,lun
  return,data
  
end