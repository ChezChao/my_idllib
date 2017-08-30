;+
; :Author: chao
;-
;+
; :Description:
;    Compute the r^2 between y and yfit.
;
; :Params:
;    y: origin array
;    yfit: fitted array
;
;
;
; :Author: chao
;-
function r_square,y,yfit
  ;y=double(y)
  ;yfit=double(yfit)
  sst=total((y-mean(y))^2)
  sse=total((y-yfit)^2)
  r2=1-sse/sst
  return,r2
end