local C = {}

local function minute2second(minute)
	return minute * 60 * 1000
end

local function second2minute(second)
	return math.ceil(second / 60 / 1000)
end

function C.setup(opts)
	opts = opts or {}
	opts.default_inter = minute2second(opts.default_inter or 1)
	opts.default_inter = 1
	local restart = false
	local info = nil
	local default_info = opts.default_info or "ticktack! ticktack! ticktack!"
	local icon = opts.icon or "⏰"
	local timer = vim.loop.new_timer()
	local is_timing = false
	local notify_args = {
		title = "clock.nvim",
	}

	local has_notify, notify = pcall(require, "notify")
	if has_notify then
		vim.notify = notify
	end

	local function on_timer()
		vim.notify(icon .. (info or default_info), vim.log.levels.WARN, {
			title = "clock.nvim",
			render = "minimal",
			timeout = false,
			on_open = function()
				is_timing = false
				timer:stop()
				vim.print("stop")
			end,
			on_close = function()
				if restart then
					is_timing = true
					timer:again()
				end
			end,
		})
	end

	vim.api.nvim_create_user_command("ClockWhen", function()
		local minutes_remaining = second2minute(timer:get_due_in())
		if is_timing then
			vim.notify(
				string.format(
					icon .. "Clock in " .. minutes_remaining .. " %s, or sooner",
					minutes_remaining == 1 and "minute" or "minutes"
				),
				vim.log.levels.INFO
			)
		else
			vim.notify(icon .. "No Clock Event! ", vim.log.levels.WARN, notify_args)
		end
	end, {})

	local function set_clock(args)
		-- if args["args"] == "" then
		-- 	vim.notify(icon .. "Empty arguments!", vim.log.levels.WARN, notify_args)
		-- 	return
		-- end
		local str = args["args"]
		local parts = {}
		local user_info = nil
		local m = nil

		for part in str:gmatch("['\"]([^'\"]+)['\"]") do
			table.insert(parts, part)
		end

		local has_info = #parts == 1

		if has_info then
			str = str:sub(string.len(parts[1]) + 3, -1)
			user_info = parts[1]
		end

		for part in str:gmatch("%S+") do
			table.insert(parts, part)
		end

		if #parts > (has_info and 2 or 1) then
			vim.notify(icon .. "Invalid arguments!", vim.log.levels.WARN, notify_args)
			return
		end

		if #parts > (has_info and 2 or 1) and string.len(parts[#parts]) > 1 then
			restart = string.sub(parts[2], -1) == "!"
			if restart then
				m = tonumber(parts[2]:sub(1, -2))
			else
				m = tonumber(parts[2])
			end
			if m == nil then
				vim.notify(
					icon .. "Invalid minute, force to use default: " .. second2minute(opts.default_inter),
					vim.log.levels.WARN,
					notify_args
				)
			else
				m = minute2second(m)
			end
		end

		is_timing = true
		info = user_info
		local timer_minute = m or opts.default_inter
		timer:start(timer_minute, timer_minute, vim.schedule_wrap(on_timer))
	end

	vim.api.nvim_create_user_command("ClockMe", function(args)
		set_clock(args)
	end, { nargs = "?" })

	vim.api.nvim_create_user_command("Gotit", function()
		if has_notify then
			require("notify").dismiss()
		end
		timer:stop()
		if restart then
			timer:again()
		else
			is_timing = false
			info = nil
		end
	end, {})

	vim.api.nvim_create_user_command("ClockAgain", function()
		if is_timing then
			vim.notify(icon .. "Timer is running.", vim.log.levels.WARN, notify)
		else
			timer:again()
		end
	end, {})
end

return C
