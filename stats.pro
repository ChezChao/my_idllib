pro stats,var
  compile_opt idl2
  
  ;var=var
  print,'---------info---------'
  print,'Statistics without NaN'
  print,'min:',min(var,/nan,max=vmax)
  print,'max:',vmax
  print,'mean:',mean(var,/nan)
  print,'standard deviation:',stddev(var,/nan)
  print,'variance:',variance(var,/nan)
  print,'---------end----------'
  
end
