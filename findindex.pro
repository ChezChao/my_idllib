function findindex,var,value
  ;-----------------------------------------------------
  ;author: Chao Wang
  ;last modify 22-04-2015
  ;this function can be used for finding the index of a
  ;specific value in a given array
  ;-----------------------------------------------------
  ;usage: result=findindex(longitude,-55.)
  ;inputs:   array and a specific value
  ;outputs:  index of the value in the given array
  ;-----------------------------------------------------
  compile_opt idl2
  ;default
  id=!values.F_nan
  
  ;remind the usage
  if n_params() ne 2 then begin
    print,' !!!! usage: result=findindex(array,value)'
    return,id
  endif
  
  ;load varibales
  array=var
  val=value
  
  ;search the closest position
  diff=abs(array-val)
  id = where(diff eq min(diff),cnt)
  
  ;warning
  if val gt max(array) then print,'!!the value is larger than the maximum of the array!!'
  if val lt min(array) then print,'!!the value is smaller than the minimum of the array!!'
  if cnt gt 1 then print,'!!more than one values equal the given value in the array!!'
  
  ;return the result
  return,id[0]
  
end
