pro imshow,array,x,y,ct=ct,title=title,xtitle=xtitle,ytitle=ytitle,xrange=xrange,yrange=yrange,hide=hide

  if keyword_set(x) then begin
    x=x
  endif else begin
    x=indgen((size(array,/dim))[0])
  endelse
  if keyword_set(y) then begin
    y=y
  endif else begin
    y=indgen((size(array,/dim))[1])
  endelse
  if keyword_set(title) then begin
    title=title
  endif else begin
    title=''
  endelse
  if keyword_set(xtitle) then begin
    xtitle=xtitle
  endif else begin
    xtitle='x'
  endelse
  if keyword_set(ytitle) then begin
    ytitle=ytitle
  endif else begin
    ytitle='y'
  endelse
  if ~keyword_set(xrange) then begin
    xrange=indgen((size(array,/dim))[0])
  endif else begin
    xrange=xrange
  endelse
  if ~keyword_set(yrange) then begin
    yrange=indgen((size(array,/dim))[1])
  endif else begin
    yrange=yrange
  endelse
  if ~keyword_set(hide) then begin
    hide=0
  endif else begin
    hide=1
  endelse
  
  ;plot the data
  i=image(array,x,y,rgb_table=25,dimensions=[900,700],margin=[0.1,0.1,0.2,0.1],$
    AXIS_STYLE=2,title=title,xtitle=xtitle,ytitle=ytitle,xrange=xrange,yrange=yrange, $
    hide=hide)
  cbar = COLORBAR(TARGET = i, ORIENTATION=1, $
    POSITION=[0.90, 0.2, 0.95, 0.75])
  ;c=colorbar(target=i)
    
  if keyword_set(ct) then begin
    j=contour(array,x,y,rgb_table=0,/overplot)
  endif
  
  
  return
end
