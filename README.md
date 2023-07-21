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
    icon = "⏰",
})
```

## Commands

`ClockMe` - Set Clock Event, Format: `ClockMe 'EventInfo' [interval][!]`, the `!` means wether repeat timing.

`ClockWhen` - Display time remaining until next Clock.

`Gotit` - Dismissing any notifications and restarting the timer

`ClockAgain` - Restart last Clock Event.

## TODO
- [ ] Support store clock events
- [ ] Show remaining time on statusline
- [ ] Support multiple clock events
- [ ] Stats of detail data


## Acknowledgment

`Clock.nvim` is inspired by and adapted from [stand.vim](https://github.com/mvllow/stand.nvim)
