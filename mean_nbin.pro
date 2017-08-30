function mean_nbin,array,num

  nbins=num
  tmp=array
  tmpcnt=n_elements(tmp)
  if tmpcnt lt nbins then begin
    print,"number of intervals is larger than the elements of array"
    return,0
  endif
  
  lcnt=0
  rcnt=0
  interval=tmpcnt/float(nbins)
  meanvalue=0.d
  for i=1,nbins do begin
    
    rcnt=round(i*interval)-1 gt tmpcnt-1 ? tmpcnt-1 : round(i*interval)-1
    ;print,lcnt,rcnt,round(i*interval)
    meanvalue=[meanvalue,mean(tmp[lcnt:rcnt],/nan,/double)]
    lcnt=round(i*interval)
    
  endfor
  return,meanvalue[1:-1]
  
end