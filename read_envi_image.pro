; PURPOSE:
; IDL program, which reads standard ENVI image files (*.img).
;
; CALLING SEQUENCE:
; read_envi_file, infile, img, xs, ys, type,offset
;
; INPUTS:
; infile - 传入数据文件名
;
; OPTIONAL INPUTS:
; None
;
; KEYWORD PARAMETERS:
; None
;
; OUTPUTS:--这些均是返回值，注意是位置参数
; img - ENVI的图像文件；
; xs - 列号；
; ys - 行号；
; type - 数据类型代码
; offset - 头文件偏移量；
; mapinfo - map及地理坐标信息；
;
; EXAMPLE:read_envi_image, 'C:Program FilesITTIDL708productsenvi46dataddd', data;;;data即读取的数据值
;
; MODIFICATION HISTORY:
; Written by: Carsten Pathe, cp@ipf.tuwien.ac.at
; Date: 25.08.2003
;
; Modified By DYQ
; 2009-8-18 修正：数据无扩展名会读取错误
; 简化数组创建代码
; 2009-12-22 修正：添加BIP、BIL多波段数据支持
;-
PRO Read_envi_image, infile, img, bandsnum,xs, ys, type, offset, mapinfo
  COMPILE_OPT idl2
  image = infile
  ;Add by DYQ-for数据文件无扩展名的bug
  header=strmid(image,0,strlen(image)-3)+'hdr'
;  pointExist = STRPOS(infile,'.')
;  IF pointExist[0] NE -1 THEN BEGIN
;    header = Strsplit(infile,'.',/extract)
;    header = header[N_ELEMENTS(header)-2]+'.hdr'
;  END ELSE header = infile + '.hdr'
  ;打开解析头文件
  OPENR, unit, header, /get_lun
  header_line = ''
  ;文件未读取完之前一直循环
  WHILE NOT EOF(unit) DO BEGIN
    READF, unit, header_line
    tmp = Strsplit(header_line[0], '=', /extract)
    header_keyword = Strsplit(tmp[0], ' ', /extract)
    ;解析头文件中的信息
    IF header_keyword[0] EQ 'samples' THEN xs = LONG(tmp[1])
    IF header_keyword[0] EQ 'lines' THEN ys = LONG(tmp[1])
    IF header_keyword[0] EQ 'header' THEN offset = LONG(tmp[1])
    IF header_keyword[0] EQ 'bands' THEN bandsnum = LONG(tmp[1])
    IF header_keyword[0] EQ 'interleave' THEN dataInter = STRUPCASE(STRTRIM(tmp[1],2))
    IF header_keyword[0] EQ 'data' THEN type = LONG(tmp[1])
    ;如读取map信息则解析map信息
    IF header_keyword[0] EQ 'map' THEN BEGIN
      mapinfo_tmp=Strsplit(tmp[1],'{',/extract)
      mapinfo_tmp=Strsplit(mapinfo_tmp[1],',',/extract)
      mapinfo={ulx:0.,uly:0.,spacing:0.}
      mapinfo.ulx=mapinfo_tmp[3]
      mapinfo.uly=mapinfo_tmp[4]
      mapinfo.spacing=mapinfo_tmp[5]
    ENDIF
  ENDWHILE
  ;关闭头文件
  CLOSE,unit & FREE_LUN, unit
  ;modified by dyq
  ;打开数据文件定位到数据位置
  OPENR, unit,image, /get_lun
  POINT_LUN, unit, offset
  ;判断数据存储类型
  ;完全按照ENVI的数据存储格式定义
  CASE dataInter OF
    'BSQ': BEGIN
      img = MAKE_ARRAY(xs,ys,bandsnum,type = type)
      ;读取数据文件中的数据
      READU,unit,img
    END
    ;按行保存
    'BIL': BEGIN
      img = MAKE_ARRAY(xs,bandsnum, ys,type = type)
      ;读取数据文件中的数据
      READU,unit,img
      ;转换为BSQ
      img= Transpose(img,[0,2,1])
    END
    'BIP': BEGIN
      ; IF bandsnum GT 1 THENimg = MAKE_ARRAY(bandsnum,xs,ys,type = type) $
      ; ELSE img = MAKE_ARRAY(xs,ys,type = type)
      img = MAKE_ARRAY(bandsnum,xs,ys,type = type)
      ;读取数据文件中的数据
      READU,unit,img
      ;转换为BSQ
      img= Transpose(img,[1,2,0])
    END
    ELSE:
  ENDCASE
  FREE_LUN, unit
  img = Reform(img)
end