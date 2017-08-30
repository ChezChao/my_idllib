function dist_map,lon0,lat0,lon1,lat1,radians=radians

  R=3390000.D ;average radius of Mars (m)

  nlon=n_elements(lon1)
  nlat=n_elements(lat1)
  if nlon ne nlat then begin
    print, "the sizes of lon1 and lat1 should be the same"
    return,0

  endif else begin
    if ~Keyword_set(radians) then begin
      lon0=double(lon0)*!pi/180.
      lat0=double(lat0)*!pi/180.
      lon2=double(lon1)*!pi/180.
      lat2=double(lat1)*!pi/180.
    endif
    dis=R*acos( sin(lat0)*sin(lat2)+cos(lat0)*cos(lat2)*cos(lon0-lon2) )
    return,dis
  endelse
end
