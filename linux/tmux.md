Here's a **tmux tutorial** to help you master terminal multiplexing:

---

### **1. Installation**
```bash
# Ubuntu/Debian
sudo apt install tmux

# macOS (Homebrew)
brew install tmux

# Arch Linux
sudo pacman -S tmux
```

---

### **2. Key Concepts**
- **Sessions**: Independent workspaces for different tasks.
- **Windows**: Tabs within a session.
- **Panes**: Split-screen views within a window.

---

### **3. Basic Commands**
| Action                     | Shortcut              |
|----------------------------|-----------------------|
| **Start tmux**             | `tmux`                |
| **Detach from session**    | `Ctrl-b d`            |
| **List sessions**          | `tmux ls`             |
| **Attach to session**      | `tmux attach -t <ID>` |

---

### **4. Session Management**
- **Create a named session**:
  ```bash
  tmux new -s mysession
  ```
- **Kill a session**:
  ```bash
  tmux kill-session -t mysession
  ```

---

### **5. Window Operations**
| Action                     | Shortcut              |
|----------------------------|-----------------------|
| **New window**             | `Ctrl-b c`            |
| **Next window**            | `Ctrl-b n`            |
| **Previous window**        | `Ctrl-b p`            |
| **Rename window**          | `Ctrl-b ,`            |
| **Close window**           | `Ctrl-b &`            |

---

### **6. Pane Management**
| Action                     | Shortcut              |
|----------------------------|-----------------------|
| **Split vertically**       | `Ctrl-b %`            |
| **Split horizontally**     | `Ctrl-b "`            |
| **Switch panes**           | `Ctrl-b ←→↑↓`         |
| **Kill pane**              | `Ctrl-b x`            |
| **Resize panes**           | `Ctrl-b Alt-←→↑↓`     |

---

### **7. Copy Mode (Scroll & Copy)**
1. Enter copy mode: `Ctrl-b [`  
2. Navigate with arrow keys.  
3. Press `Space` to start selection, `Enter` to copy.  
4. Paste: `Ctrl-b ]`.

---

### **8. Customization**
Edit `~/.tmux.conf` to customize tmux:
```bash
# Change prefix to Ctrl-a
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# Enable mouse support
set -g mouse on

# Reload config after editing
tmux source-file ~/.tmux.conf
```

---

### **9. Plugins (via TPM)**
1. Install [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm):
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```
2. Add plugins to `~/.tmux.conf`:
   ```bash
   set -g @plugin 'tmux-plugins/tmux-resurrect'  # Save/restore sessions
   set -g @plugin 'tmux-plugins/tmux-continuum'  # Auto-save
   ```
3. Reload tmux and install plugins: `Ctrl-b I`.

---

### **10. Workflow Example**
1. Start a session: `tmux new -s dev`.
2. Split panes: `Ctrl-b "` (horizontal) and `Ctrl-b %` (vertical).
3. Run commands in each pane (e.g., code editor, logs, tests).
4. Detach: `Ctrl-b d`.
5. Reattach later: `tmux attach -t dev`.

---

### **Tips**
- Use **`Ctrl-b ?`** to see all shortcuts.
- Save sessions with `tmux-resurrect` (`Ctrl-b Ctrl-s`).
- Use **`tmux kill-server`** to reset everything.

---

Let me know if you want to dive deeper into any specific feature! 😊
