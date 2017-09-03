local screenful = require('screenful')
local naughty = require('naughty')
local awful = require("awful")

dev = '/sys/class/drm/'
card = 'card0'

local connectedoutputs = connectedOutputs(dev .. card, card)
outs = ""
for out in pairs(connectedoutputs) do
   outs = outs .. getXrandrOutput(out, card) .. "\n"
end

local gears = require("gears")

local function dmenu_call(text)
   local handle = io.popen("echo -e \"" .. text .. "\" | rofi -dmenu")
   local ret = handle:read("*a")
   ret = ret:sub(1, #ret -1)
   handle:close()
   return ret
end

function screenManager()
   local screen = dmenu_call(outs .. "\nStart arandr")
   if screen == "Start arandr" then
      awful.spawn('arandr')
      return
   elseif screen == "" then
      return
   end
   naughty.notify({text=screen})
   local command = dmenu_call("Mirror..\nPosition..\nTurn off\nStart arandr\n")
   naughty.notify({text=command})
   if command == "Mirror.." then
      local ref_screen = dmenu_call(outs)
      os.execute('xrandr --output ' .. screen .. ' --auto --same-as ' .. ref_screen)
   elseif command == "Position.." then
      local pos = dmenu_call("above\nbelow\nright-of\nleft-of")
      local ref_screen = dmenu_call(outs)
      os.execute('xrandr --output ' .. screen .. ' --auto --' .. pos .. ' ' .. ref_screen)
   elseif command == "Turn off" then
      os.execute('xrandr --output ' .. screen .. ' --off')
   end
end
