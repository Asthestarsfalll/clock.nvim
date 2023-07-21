# clock.nvim

## Install

```lua
{ "Asthestarsfalll/clock.nvim" }
```

Optionally, install [nvim-notify](https://github.com/rcarriga/nvim-notify) for more prominent notifications.

## Usage

```lua
require("clock").setup()
```

## Options

```lua
require("clock").setup({
    default_inter = 1,
    default_info = ticktack! ticktack! ticktack!",
    restart = false,
    icon = "⏰",
})
```

## Commands

`ClockMe` - Set Clock Event, Format: `ClockMe ['EventInfo' [interval[!]]]`, `all the arguments are optional`. `!` means wether to repeat timing.

example:
```lua
-- this will remind you to eat lunch after 10 minutes repeatly
ClockMe 'Eat Lunch' 10!

-- this will remind you to eat lunch after 10 minutes once
ClockMe 'Eat Lunch' 10

-- this will remind you to eat lunch after default interval repeatly
ClockMe 'Eat Lunch'!

-- this will remind you to do sth after 10 minutes repeatly
ClockMe 10

-- this will remind you to do sth after default interval repeatly
ClockMe
```

`ClockWhen` - Display time remaining until next Clock.

`Gotit` - Dismissing any notifications and restarting the timer, otherwise the timer will be blocked.

`ClockAgain` - Restart last Clock Event.

## TODO
- [ ] Support store clock events
- [ ] Show remaining time on statusline
- [ ] Support multiple clock events
- [ ] Stats of detail data


## Acknowledgment

`clock.nvim` is inspired by and adapted from [stand.vim](https://github.com/mvllow/stand.nvim)
