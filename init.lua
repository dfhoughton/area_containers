--[[
   Copyright (C) 2021  Jude Melton-Houghton

   This file is part of area_containers. It initializes basic stuff and
   calls the code from the other source files.

   area_containers is free software: you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License as published
   by the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   area_containers is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with area_containers. If not, see <https://www.gnu.org/licenses/>.
]]

-- This is a mod-private namespace for functions and stuff.
local AC = {}

local dep_statuses = {init = "loading"}
function AC.depend(dep)
	if dep_statuses[dep] == "loaded" then return end
	assert(dep_statuses[dep] ~= "loading")
	dep_statuses[dep] = "loading"
	local path = minetest.get_modpath("area_containers") .. "/" ..
		dep .. ".lua"
	assert(loadfile(path))(AC)
	dep_statuses[dep] = "loaded"
end

AC.depend("settings")

if AC.settings.enable_crafts then
	AC.depend("crafts")
end
AC.depend("items")
AC.depend("nodes")
AC.depend("protection")

-- No runtime dependency fetching:
AC.depend = nil
