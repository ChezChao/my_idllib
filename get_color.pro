function get_color,number,rgbtable
  compile_opt  idl2
  
  NumOfColor=number
  returncolor=intarr(NumOfColor,3)
  loadct,rgbtable,rgb_table=rgb
  IdxOfColor=intarr(NumOfColor)
  for i=0,NumOfColor-1 do begin
    IdxOfColor[i]=i*floor(256./NumOfColor)
    returncolor[i,*]=rgb[IdxOfColor[i],*]
  ;print,IdxOfColor
  end
  help,rgb
  help,returncolor
  return,returncolor
end