--background script that can match longest line in input by mrpeachy
--[[
use:
lua_load ~/lua/how_wide.lua

BELOW TEXT
${lua_parse tao {20,0,0,0,0,0x000000,1,"Sans",12,"normal","cat /home/mcdowall/Desktop/txt.txt",0}}

settings
${lua_parse tao {corner_rad,x,y,w,h,col,alpha,"font",font_size,"style","command",add_width}}
style can be: "normal", "bold", "italic", "bold:italic"
w=0 matches width to the length of longest line
h=0 matches height to conky window height
]]
start=1
require 'cairo'
function conky_tao(taotable)
taotable=loadstring("return" .. taotable)()
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
local cr = cairo_create(cs)
--#########################################################################################################
local updates=tonumber(conky_parse("${updates}"))
local timer=(updates %tonumber(taotable[13]))
if timer==0 or start==1 then--###########################
--print ("activate")
start=0
taotext={}--hold output
taowidth={}--holds widths
--get values
local fn=taotable[8]            or "mono"
local fs=tonumber(taotable[9])        or 12
local st=taotable[10]            or "normal"
local wadd=tonumber(taotable[12])     or 50
--setup text
    if st=="normal" then
    cairo_select_font_face (cr, fn, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    elseif
    st=="bold" then
    cairo_select_font_face (cr, fn, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
    elseif
    st=="italic" then
    cairo_select_font_face (cr, fn, CAIRO_FONT_SLANT_ITALIC, CAIRO_FONT_WEIGHT_NORMAL);
    elseif
    st=="bold:italic" then
    cairo_select_font_face (cr, fn, CAIRO_FONT_SLANT_ITALIC, CAIRO_FONT_WEIGHT_BOLD);
    end
local fsl=fs*1.2
cairo_set_font_size (cr, fsl)
local extents=cairo_text_extents_t:create()
tolua.takeownership(extents)
--open file
local f = io.popen(taotable[11])
    for line in f:lines() do
    --measure text
    cairo_text_extents(cr,line,extents)
    local w=extents.x_advance
    table.insert(taowidth,w)
    --put lines in table
    table.insert(taotext,line)
    end
f:close()
f=nil
local line1=taotext[1]
taotext[1]="${font "..fn..":"..st..":size="..fs.."}"..line1
table.sort(taowidth)
max_width=tonumber(taowidth[#taowidth])+wadd
end--timed section
--#########################################################################################################
local function rgb_to_r_g_b(colour,alpha)
return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255.,alpha
end
local r=tonumber(taotable[1])        or 0
local x=tonumber(taotable[2])        or 0
local y=tonumber(taotable[3])        or 0
local w=tonumber(taotable[4])        or 100
local h=tonumber(taotable[5])        or 100
local color=taotable[6]            or 0x000000
local alpha=tonumber(taotable[7])    or 0.3
--function conky_draw_bg(r,x,y,w,h,color,alpha)
if w==0 then w=max_width end--w=tonumber(conky_window.width) end
if h==0 then h=tonumber(conky_window.height) end
cairo_set_source_rgba (cr,rgb_to_r_g_b(color,alpha))
--top left mid circle
 local xtl=x+r
local ytl=y+r
--top right mid circle
local xtr=(x+r)+((w)-(2*r))
local ytr=y+r
--bottom right mid circle
local xbr=(x+r)+((w)-(2*r))
local ybr=(y+r)+((h)-(2*r))
--bottom right mid circle
local xbl=(x+r)
local ybl=(y+r)+((h)-(2*r))
-----------------------------
cairo_move_to (cr,xtl,ytl-r)
cairo_line_to (cr,xtr,ytr-r)
cairo_arc(cr,xtr,ytr,r,((2*math.pi/4)*3),((2*math.pi/4)*4))
cairo_line_to (cr,xbr+r,ybr)
cairo_arc(cr,xbr,ybr,r,((2*math.pi/4)*4),((2*math.pi/4)*1))
cairo_line_to (cr,xbl,ybl+r)
cairo_arc(cr,xbl,ybl,r,((2*math.pi/4)*1),((2*math.pi/4)*2))
cairo_line_to (cr,xtl-r,ytl)
cairo_arc(cr,xtl,ytl,r,((2*math.pi/4)*2),((2*math.pi/4)*3))
cairo_close_path(cr)
cairo_fill (cr)
--#########################################################################################################
cairo_destroy(cr)
cairo_surface_destroy(cs)
cr=nil
return table.concat(taotext,"\n")
end--end main function
