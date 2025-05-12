-- Enable seamless navigation between tmux and nvim
return {
	"alexghergh/nvim-tmux-navigation",
	config = function()
		require("nvim-tmux-navigation").setup({
			disable_when_zoomed = true, -- defaults to false
			keybindings = {
				left = "<C-h>",
				down = "<C-j>",
				up = "<C-k>",
				right = "<C-l>",
				last_active = "<C-\\>",
				next = "<C-Space>",
			},
		})
	end,
}
-- # Smart pane switching with awareness of Vim splits.
-- # See: https://github.com/christoomey/vim-tmux-navigator
--
-- # decide whether we're in a Vim process
-- is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
--     | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
--
-- bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
-- bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
-- bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
-- bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
--
-- tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
--
-- if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
--     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
-- if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
--     "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
--
-- bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'
--
-- bind-key -T copy-mode-vi 'C-h' select-pane -L
-- bind-key -T copy-mode-vi 'C-j' select-pane -D
-- bind-key -T copy-mode-vi 'C-k' select-pane -U
-- bind-key -T copy-mode-vi 'C-l' select-pane -R
-- bind-key -T copy-mode-vi 'C-\' select-pane -l
-- bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+

-- return {
--    "aserowy/tmux.nvim",
--    opt = {},
--}
-- REQUIRES FOLLOWING IN tmux.conf:
-- Navigation:
-- is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"
--
-- bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
-- bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
-- bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
-- bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
-- bind-key -n 'C-n' if-shell "$is_vim" 'send-keys C-n' 'select-window -n'
-- bind-key -n 'C-p' if-shell "$is_vim" 'send-keys C-p' 'select-window -p'
--
-- bind-key -T copy-mode-vi 'C-h' select-pane -L
-- bind-key -T copy-mode-vi 'C-j' select-pane -D
-- bind-key -T copy-mode-vi 'C-k' select-pane -U
-- bind-key -T copy-mode-vi 'C-l' select-pane -R
-- bind-key -T copy-mode-vi 'C-n' select-window -n
-- bind-key -T copy-mode-vi 'C-p' select-window -p
--
-- Resizing:
-- is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
--
-- bind -n 'M-h' if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 1'
-- bind -n 'M-j' if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 1'
-- bind -n 'M-k' if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 1'
-- bind -n 'M-l' if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 1'
--
-- bind-key -T copy-mode-vi M-h resize-pane -L 1
-- bind-key -T copy-mode-vi M-j resize-pane -D 1
-- bind-key -T copy-mode-vi M-k resize-pane -U 1
-- bind-key -T copy-mode-vi M-l resize-pane -R 1
