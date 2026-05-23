================================================================================
                        NEOVIM CONFIG QUICK REFERENCE
                              jcglez | 2026
================================================================================

LEGEND:  <leader> = Space    <localleader> = \    C- = Ctrl+

Press <leader> and wait (0.5s) -- which-key will show all available keybinds.


================================================================================
  CONFIG STRUCTURE
================================================================================

init.lua                   Entry point -- bootstraps lazy.nvim
lua/vim-options.lua        Core settings, keymaps, and options
lua/plugins/              One file per plugin (lazy.nvim auto-imports all)
lua/graveyard/            Disabled plugins (moved here instead of deleted)

To add a plugin: create a new file in lua/plugins/ returning a lazy spec.
To remove one: delete its file (or move to graveyard/). Run :Lazy clean after.


================================================================================
  INSTALLED PLUGINS
================================================================================

Plugin                    Purpose
-----------               ---------------------------------------------------
fzf-lua                   Fuzzy finder (files, grep, buffers)
harpoon                   Pinned-file quick-switching (Prime's plugin)
oil.nvim                  File explorer as an editable buffer
blink.cmp                 Autocompletion (LSP, snippets, paths, buffer words)
nvim-lspconfig            LSP client configuration
mason.nvim                Auto-install LSP servers and tools
mason-lspconfig           Bridge between Mason and lspconfig
mason-tool-installer      Auto-install formatters/linters via Mason
conform.nvim              Auto-formatting and format-on-save
nvim-treesitter           Syntax highlighting, folding, indentation
nvim-surround             Add/change/delete surrounding chars (cs/ds/ys)
mini.pairs                Auto-close brackets and quotes
trouble.nvim              Diagnostics list panel
tiny-inline-diagnostic    Inline diagnostic display (replaces virtual text)
undotree                  Visual undo history browser
which-key.nvim            Shows available keybinds after pressing a prefix
lualine.nvim              Statusline
nvim-lastplace            Reopens files at the last cursor position
gitsigns.nvim             Git hunks in the gutter + stage/reset/blame
nvim-dap                  Debug Adapter Protocol client
nvim-dap-ui               UI panel for nvim-dap (scopes, stacks, watches)
nvim-dap-go               Go integration for nvim-dap (wraps delve)
nvim-nio                  Async I/O library (nvim-dap-ui dependency)
99                        AI selection-replace agent (uses Claude sub)
claudecode.nvim           Claude Code IDE integration (uses Claude sub)
moonfly                   Colorscheme (catppuccin available but commented out)
mini.icons                Icon provider
friendly-snippets         Community snippet collection
cellular-automaton        Make it rain! (just for fun, in graveyard)


================================================================================
  FINDING STUFF (fzf-lua)
================================================================================

<leader>ff    Find files by name
<leader>fg    Live grep across all files
              Tip: add  -- -g '*.go'  to filter by filetype
<leader>fb    Switch between open buffers


================================================================================
  FILE QUICK-SWITCHING (harpoon)
================================================================================

Pin a few files you're actively working on, then jump between them instantly
without going through fzf or :bnext. Way faster when you're bouncing between
2-4 related files.

<leader>H     Add current file to harpoon list
<C-e>         Toggle the harpoon quick menu (reorder/delete entries inside)
<leader>1     Jump to slot 1
<leader>2     Jump to slot 2
<leader>3     Jump to slot 3
<leader>4     Jump to slot 4

The list persists per-project (stored in ~/.local/share/nvim/harpoon/).
Inside the quick menu: edit entries like a normal buffer; :w to save.


================================================================================
  FILE BROWSING (oil.nvim)
================================================================================

-             Open parent directory (replaces current buffer)
:Oil          Open current file's directory
:Oil --float  Open in a floating window (doesn't replace buffer)

Inside Oil:
  - Navigate with normal motions (j/k, /, etc.)
  - Rename files by editing their names
  - Delete files by deleting lines
  - Create files by typing new names
  - Press :w (save) to apply all changes
  - Press - again to go up one directory


================================================================================
  LSP -- READING & UNDERSTANDING CODE (lspconfig)
================================================================================

K              Hover info -- shows type, docs, signature
gd             Go to definition          (C-o to jump back)
gi             Go to implementation
gr             Find all references
<leader>ca     Code actions / quick fixes
<leader>rn     Rename symbol across the project
<leader>e      Show diagnostic detail in a floating window
<leader>xx     Toggle full diagnostics list (Trouble panel)

LSP servers auto-installed via Mason:
  lua_ls, pyright, bashls, gopls, ts_ls

Commands:
  :Mason          Manage LSP servers and tools
  :LspInfo        Check which LSP is attached to current buffer
  :LspRestart     Restart LSP if it gets stuck


================================================================================
  AUTOCOMPLETION (blink.cmp)
================================================================================

While the completion menu is open:
  C-n / Tab       Next item
  C-p / S-Tab     Previous item
  C-y             Accept selected completion
  C-e             Dismiss menu

Sources (in priority order): LSP, file paths, snippets, buffer words
Documentation auto-shows after 200ms delay.
Function signatures show automatically as you type.


================================================================================
  FORMATTING (conform.nvim)
================================================================================

<leader>f     Format current buffer manually

Format-on-save is always active (1s timeout, falls back to LSP).

Configured formatters:
  Lua         stylua
  Shell       shfmt
  Python      ruff (fix + format)
  Go          goimports + gofmt
  JS/TS       prettier
  All files   trailing whitespace is trimmed

Commands:
  :ConformInfo    Shows which formatter is active for the current file


================================================================================
  EDITING KEYMAPS
================================================================================

VISUAL MODE
  J               Move selected lines down (auto re-indents)
  K               Move selected lines up (auto re-indents)
  <leader>p       Paste without overwriting your yank register
  <leader>d       Delete without polluting yank register

NORMAL MODE
  J               Join line below without moving cursor
  <leader>d       Delete to void register (doesn't overwrite yank)
  Q               Disabled (no accidental Ex mode)

CLIPBOARD (system)
  <leader>y       Yank selection to system clipboard
  <leader>Y       Yank whole line to system clipboard
  <leader>cp      Toggle copy mode (hides line numbers, signs, etc.)


================================================================================
  TEXT MANIPULATION (nvim-surround, mini.pairs)
================================================================================

SURROUNDINGS (nvim-surround)
  ys{motion}{char}    Surround motion with {char}      e.g. ysiw"  -> "word"
  yss{char}           Surround entire line             e.g. yss)   -> (line)
  ds{char}            Delete surrounding {char}        e.g. ds"
  cs{old}{new}        Change surrounding {old}->{new}  e.g. cs"'   -> 'word'
  S{char}             (visual mode) Wrap selection in {char}

  Common chars: " ' ` ) ] } > t (HTML tag).
  Brackets with space inside: use ( [ { (open). Without space: use ) ] }.

AUTO-PAIRS (mini.pairs)
  Auto-closes brackets and quotes as you type:  ( -> ()  " -> ""  etc.
  Smart: won't double-close if the next char is already the closing one.
  Press <BS> on an empty pair to delete both halves.


================================================================================
  NAVIGATION
================================================================================

SEARCH
  /pattern        Search forward           ?pattern  Search backward
  n               Next match (auto-centers screen)
  N               Previous match (auto-centers screen)
  *               Search word under cursor forward
  #               Search word under cursor backward
  <leader>h       Toggle search highlighting on/off
                  (hlsearch is off by default)

SPLITS
  C-h             Move to left split
  C-j             Move to split below
  C-k             Move to split above
  C-l             Move to right split
  :vs             Vertical split
  :sp             Horizontal split
  C-w =           Equalize split sizes
  C-w o           Close all splits except current

JUMPS
  C-o             Jump back (previous location)
  C-i             Jump forward
  gd              Go to definition (then C-o to come back)
  gf              Go to file under cursor
  %               Jump to matching bracket


================================================================================
  UNDO & HISTORY
================================================================================

<leader>ut    Toggle Undotree -- visual undo history browser
              Navigate branches of undo history, recover anything.
              Undo history persists across sessions (saved to disk).

u             Undo
C-r           Redo


================================================================================
  FOLDING (Treesitter-based)
================================================================================

za            Toggle fold at cursor
zR            Open ALL folds
zM            Close ALL folds
zo            Open one fold
zc            Close one fold

Folds use Treesitter expressions -- they follow code structure (functions,
blocks, etc.) rather than indentation. All folds start open by default.


================================================================================
  GIT INTEGRATION (gitsigns.nvim)
================================================================================

Gutter shows +/-/~ signs for added, deleted, and changed lines vs. the index.

HUNK NAVIGATION
  ]c              Jump to next hunk
  [c              Jump to previous hunk

HUNK ACTIONS (works in normal mode; <leader>hs/hr also work on visual range)
  <leader>hs      Stage hunk under cursor
  <leader>hr      Reset hunk under cursor (discard changes)
  <leader>hS      Stage entire buffer
  <leader>hu      Undo last stage
  <leader>hR      Reset entire buffer
  <leader>hp      Preview hunk in a floating window
  <leader>hd      Diff buffer against index
  <leader>hD      Diff buffer against last commit

BLAME & INSPECTION
  <leader>hb      Show full blame for current line (popup)
  <leader>tb      Toggle inline virtual-text blame for all lines
  <leader>td      Toggle showing deleted lines

TEXT OBJECT
  ih              Select inside hunk (e.g. dih to delete a hunk's changes,
                  vih to visually select it)


================================================================================
  DEBUGGING (nvim-dap + nvim-dap-go)
================================================================================

Requires delve installed on PATH:
  go install github.com/go-delve/delve/cmd/dlv@latest

BREAKPOINTS
  <leader>b       Toggle breakpoint at cursor
  <leader>B       Set conditional breakpoint (prompts for expression)

STEPPING (function keys match VSCode / most IDEs)
  <F5>            Continue / start debugging
  <F10>           Step over
  <F11>           Step into
  <F12>           Step out

SESSION
  <leader>du      Toggle DAP UI (scopes, stacks, watches, REPL, console)
  <leader>dr      Open DAP REPL only
  <leader>dl      Re-run last debug session
  <leader>dt      Debug the Go test under cursor

The UI panel opens automatically when a session starts and closes when it
exits. Breakpoints render as a red dot in the sign column.

Typical Go workflow:
  1. Place cursor in a test function          (e.g. TestTransferTx)
  2. <leader>b on any line you want to inspect
  3. <leader>dt to launch the test under delve
  4. Use F10/F11 to step, hover variables in the Scopes panel
  5. <leader>du to hide the UI when done


================================================================================
  AI ASSISTANT (99 + claudecode.nvim)
================================================================================

Two complementary AI tools. Both use the `claude` CLI under your existing
Claude subscription -- no extra billing, but they share the same usage limits.

99 (ThePrimeagen/99) -- selection-based edits, pop-up, runs in background
  <leader>9v    (visual) Edit selection -- prompts for instruction
  <leader>9s    Project-wide AI search (results in quickfix)
  <leader>9x    Cancel in-flight 99 requests
  <leader>9o    View the last result

  Workflow: visual-select code, <leader>9v, type "add error handling",
  hit enter. 99 replaces the selection with the edited version.
  Don't like it? Press u to undo.

claudecode.nvim (coder/claudecode.nvim) -- full Claude Code agent in nvim
  <leader>ac    Toggle the Claude Code terminal window
  <leader>af    Focus the Claude window
  <leader>ar    Resume the previous Claude session
  <leader>aC    Continue the last session
  <leader>am    Pick a different Claude model
  <leader>ab    Send current buffer as context to Claude
  <leader>as    (visual) Send selection to Claude
  <leader>as    (in oil)  Add file from explorer
  <leader>aa    Accept the proposed diff
  <leader>ad    Reject the proposed diff

When to use which:
  99           Small surgical edits ("add error handling here")
  claudecode   Larger asks where the agent needs to read other files


================================================================================
  USEFUL VIM DEFAULTS (not from plugins)
================================================================================

TEXT OBJECTS (use with d, c, y, v -- e.g. "diw" = delete inner word)
  iw / aw       inner/around word
  i" / a"       inner/around double quotes (also i' i` i( i[ i{ )
  ip / ap       inner/around paragraph
  it / at       inner/around HTML/XML tag

REGISTERS
  "ay           Yank into register 'a'     "ap  Paste from register 'a'
  "+y           Yank to system clipboard   "+p  Paste from system clipboard
  "0p           Paste last yank (not affected by deletes)
  :reg          Show all registers

MACROS
  qa            Start recording macro into register 'a'
  q             Stop recording
  @a            Play macro 'a'
  @@            Replay last macro

MARKS
  ma            Set mark 'a' at cursor
  'a            Jump to mark 'a' (line)
  `a            Jump to mark 'a' (exact position)
  :marks        List all marks

VISUAL MODES
  v             Character-wise visual
  V             Line-wise visual
  C-v           Block (column) visual -- great for multi-line edits

MISC
  .             Repeat last change
  C-a / C-x     Increment / decrement number under cursor
  gU / gu       Uppercase / lowercase (motion or visual selection)
  :earlier 5m   Undo to state 5 minutes ago
  :later 5m     Redo to state 5 minutes ago


================================================================================
  SETTINGS WORTH KNOWING ABOUT (vim-options.lua)
================================================================================

- Mouse is disabled (vim.opt.mouse = "")
- Relative line numbers are on
- Tabs = 4 spaces, smart indent
- Line wrap is off
- Swap files are off, persistent undo is on
- Search is case-insensitive unless you use uppercase (smartcase)
- Scroll keeps 8 lines of padding above/below cursor
- Color column at column 81
- Spell checking is on (en_us) in markdown/text/gitcommit only
- Whitespace chars are visible: tabs show as >., trailing spaces as blocks


================================================================================
  COMMANDS TO REMEMBER
================================================================================

:Lazy           Plugin manager (update, clean, profile startup time)
:Mason          LSP/tool installer
:LspInfo        Check active LSP for current buffer
:ConformInfo    Check active formatter for current buffer
:checkhealth    Diagnose problems with your setup
:Trouble        Open diagnostics panel
:Oil            Open file explorer
:UndotreeToggle Open undo history
:Gitsigns       Gitsigns subcommands (blame, diff, etc.)
:DapContinue    Start or continue a debug session

================================================================================
  FUN
================================================================================

<leader>mir   Make it rain (cellular automaton)
<leader>gol   Game of life (cellular automaton)

================================================================================
