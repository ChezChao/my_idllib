pro histdata,data
  ;-----------------------------------------------------
  ;author: Chao Wang
  ;last modify 02-04-2015
  ;this function can be used for plotting the histogram
  ; of a specific data array (not well developed yet!!) 
  ;-----------------------------------------------------
  ;usage:    histdata,data
  ;inputs:   the data you want to plot
  ;outputs:  a figure window which will show you the 
  ;           histogram of the input data
  ;-----------------------------------------------------
  compile_opt idl2
  
  datain = data[where(finite(data))]
  help,data,datain
  ;datain = datain[where(datain ne 0.)]
  datain = datain[sort(datain)]
  
  numin = n_elements(datain)
  print,numin
;  nums  = long(numin*0.02)
;  print,nums
;  datas = datain[nums]
;  print,datas
;  nume  = numin-long(numin*0.02)
;  print,nume
;  datae = datain[nume]
;  print,datae
  
  ;yy = histogram(datain,locations=loc,nbins=100,max=datae,min=datas,/nan)
  yy = histogram(datain,locations=loc,nbins=100,/nan)
  plot,loc,yy,psym=4
  for i=0,99 do print,loc[i],yy[i]
  
end