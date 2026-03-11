# Tab-Based Zellij Workflow

Simple, intuitive tab-based workflow for AI-assisted development.

## Quick Start

### Open a project
```bash
cd ~/projects/myapp
zj          # Opens Zellij with default layout (shell tab)
```

### Add an AI-Dev tab
Once inside Zellij:
```bash
# Option 1: Use alias (from shell)
zjta        # Opens new "ai" tab with copilot pane + shell split

# Option 2: Use Zellij action
zellij action new-tab --layout ai-dev --name ai

# Option 3: Keyboard (from shell)
Ctrl+t n    # Regular new tab (generic shell)
```

### Create a feature branch with worktree and AI tab
```bash
# Create a worktree for a feature, opens ai-dev tab in that worktree
ai myfeature

# Creates:
#   - Worktree at: ../copilot-{project-name}-myfeature
#   - New "ai-myfeature" tab in current Zellij session
#   - Working directory in the worktree (cwd)

# Later, clean up when done:
ai-cleanup myfeature    # Removes the worktree
```

### Switch between tabs
```bash
Ctrl+t h    # Previous tab
Ctrl+t l    # Next tab
Ctrl+t 1    # Jump to tab 1
Ctrl+t 2    # Jump to tab 2
```

## Layouts

### default.kdl
**Single shell tab** - What you get when you open Zellij
```
┌─────────────────────────────┐
│ tab-bar (showing tabs)      │
├─────────────────────────────┤
│                             │
│  Shell pane (ready to use)  │
│                             │
├─────────────────────────────┤
│ status-bar (mode, time)     │
└─────────────────────────────┘
```

### ai-dev.kdl
**Copilot + shell split** - Opened as new tab with `zjta`
```
┌─────────────────────────────┐
│ tab-bar (showing tabs)      │
├─────────────────────────────┤
│ Copilot CLI focused pane    │  70%
├─────────────────────────────┤
│ Shell pane (tests, output)  │  30%
├─────────────────────────────┤
│ status-bar (mode, time)     │
└─────────────────────────────┘
```

## Aliases & Commands

**Zellij session management:**
```bash
zj          # Open Zellij in current directory
zja <name>  # Attach to existing session
zjl         # List sessions
zjk <name>  # Kill session
zjn <name>  # Create named session
```

**Tab management (from shell inside Zellij):**
```bash
zjt         # Open generic new tab
zjta        # Open new AI-dev tab
```

**AI-focused branch development:**
```bash
ai <feature>           # Create worktree + open ai-dev tab
                       # Creates: ../copilot-{project}-{feature}
                       # Opens: ai-{feature} tab in that worktree
ai-cleanup <feature>   # Remove worktree when done
```

## Workflow Examples

### Basic Workflow (Main Project)

```bash
# Morning: Open project
cd ~/projects/backend
zj                    # Zellij opens with shell tab

# Set up
npm install
npm run dev          # Dev server running in tab 1

# Need Copilot?
zjta                 # Opens "ai" tab with split panes
copilot-cli "explain this error"

# Switch between tabs
Ctrl+t h             # Back to shell (dev server)
Ctrl+t l             # Back to AI tab
```

### Feature Branch Workflow (AI-Focused)

```bash
# In main project directory (inside Zellij)
ai auth-feature      # Creates worktree + opens ai-dev tab
                     # Creates: ../copilot-backend-auth-feature
                     # Opens: ai-auth-feature tab (in worktree cwd)

# Now in ai-auth-feature tab:
# Top pane: Copilot for this specific feature
# Bottom pane: Tests, build commands for this feature

# Run tests for the feature
npm test

# Get AI help
Ctrl+p k            # Move to top pane (copilot)
copilot-cli "help me debug this test failure"

# Switch back to main project
Ctrl+t h            # Go to main shell tab
Ctrl+t l            # Back to feature tab

# When done with feature:
ai-cleanup auth-feature    # Removes worktree
# Tab still exists but is detached (can close with Ctrl+t x)
```

### Quick AI Tab (No Branch)

```bash
# If you just need copilot interaction in main project
cd ~/projects/backend
zj
# Option 1: Use alias
zjta                # Opens "ai" tab with copilot ready

# Option 2: Use keyboard shortcut
Ctrl+Alt+a          # Opens "ai" tab with ai-dev layout (same as zjta)
```

## Layout & Pane Management

### Creating Tabs with Layouts

**From shell (inside Zellij):**
```bash
zjta                  # Open ai-dev tab (alias)
Ctrl+Alt+a            # Open ai-dev tab (keyboard shortcut)
Ctrl+t n              # Open generic new tab
```

**From shell command:**
```bash
zellij action new-tab --layout ai-dev --name mytab
zellij action new-tab --name work
```

### Swapping Layouts Within a Tab

**Default Zellij swap layout navigation:**
```
Alt+[     Previous swap layout (cycle through pane arrangements)
Alt+]     Next swap layout (cycle through pane arrangements)
```

**When to use:**
- You have multiple `swap_tiled_layout` definitions in your layout file
- Want to rearrange panes without losing content
- Need different pane arrangements for the same tab

**Example:** If ai-dev.kdl had swap layouts defined, you could:
1. Open ai-dev tab: `Ctrl+Alt+a`
2. Rearrange panes: `Alt+]` (cycle to next arrangement)
3. Content stays, but pane layout changes

**Note:** Currently, our layouts (default.kdl, ai-dev.kdl) don't use swap layouts, but you can add them if needed.

## Keyboard Shortcuts (Default Zellij)

### Tab mode (Ctrl+t)
```
Ctrl+t      Enter tab mode
  h/l       Previous/next tab
  1-9       Jump to tab 1-9
  n         New tab
  x         Close tab
  r         Rename tab
  s         Toggle sync panes
```

### Pane mode (Ctrl+p)
```
Ctrl+p      Enter pane mode
  h/j/k/l   Move focus (left/down/up/right)
  n         New pane (down)
  r         New pane (right)
  d         New pane (down - alternative)
  x         Close pane
  f         Fullscreen pane
```

### Custom Shortcuts (Configured)
```
Ctrl+Alt+a  Create new ai-dev tab (in current cwd)
            Quick access to copilot pane without worktree
```

### Swap Layouts (Switch between pane arrangements)
```
Alt+[       Previous swap layout
Alt+]       Next swap layout
            Cycle through predefined layouts in current tab
            Note: Only works if tab has swap layouts defined
```

### Navigation (any mode)
```
Esc         Exit mode (return to normal)
Alt+h/l     Quick tab switching
Alt+j/k     Quick pane navigation
```

### Other
```
Ctrl+g      Enter locked mode (prevents accidental commands)
Ctrl+o      Session mode (manage sessions, quit, etc.)
Ctrl+s      Scroll mode (browse scrollback)
Ctrl+q      Quit Zellij (detaches session if inside)
```

## Why This Approach

✅ **Simple**: Open zellij, get a shell tab. Done.  
✅ **Flexible**: Add tabs as needed with aliases or keyboard  
✅ **Fast**: No session management complexity  
✅ **Familiar**: Tabs are how most terminal users think  
✅ **AI-focused**: Dedicated tab layout for Copilot interaction  

## Tips

### Renaming tabs
Inside a tab:
```bash
Ctrl+t r    # Rename current tab
Type new name
Enter
```

### Synchronizing panes
When you want the same input to go to multiple panes:
```bash
Ctrl+t s    # Toggle sync in current tab
# Now typing goes to all panes
# Press Ctrl+t s again to disable
```

### Making new generic tabs for different tasks
```bash
zjt                 # New generic shell tab
zellij action new-tab --name editor    # Named tab
```

### Persistent sessions
Zellij sessions persist when you detach:
```bash
Ctrl+q      # Quit Zellij (session stays alive)
zja myapp   # Reconnect to same session (same tabs, same state)
```

## Next Steps (Optional)

1. **Keyboard shortcuts**: Customize `~/.config/zellij/config.kdl` for faster tab creation
   ```kdl
   // Example: Ctrl+Alt+a to open ai-dev tab
   keybinds normal {
       bind "Ctrl Alt a" {
           NewTab { layout "ai-dev"; name "ai"; }
           SwitchToMode "normal"
       }
   }
   ```

2. **Layouts**: Create more specialized layouts as needed
   ```bash
   # Example: monitoring layout
   zellij action new-tab --layout monitor --name monitoring
   ```

3. **Project-specific setup**: Create `.zellij` files in project roots
   ```bash
   # ~/.config/zellij/.zellij (example)
   default_layout = "default"
   ```

## Troubleshooting

**Q: I accidentally detached/closed the session**  
A: Sessions stay alive. Reconnect with `zja <name>` or `zellij list-sessions` to see all.

**Q: Tab keyboard shortcuts aren't working**  
A: Make sure you're in tab mode with `Ctrl+t` first.

**Q: I want to run a command in a new pane, not new tab**  
A: You're in the right place—use pane mode with `Ctrl+p` to add panes within the current tab.

**Q: How do I resize panes?**  
A: Use resize mode: `Ctrl+n` then hjkl or arrows to adjust.
