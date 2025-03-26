return {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = {
        "rcarriga/nvim-notify",
    },
    opts = {
        notifiers = {
            {
                name = "Default",
                opts = {
                    sticky = false,
                },
            },
        },
        sessions = {
            basic = {
                { name = "Work", duration = "25m" },
                { name = "Break", duration = "5m" },
                { name = "Work", duration = "25m" },
                { name = "Break", duration = "5m" },
                { name = "Work", duration = "25m" },
                { name = "Long Break", duration = "15m" },
            },

        },
    },
}
