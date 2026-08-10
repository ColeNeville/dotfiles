# Capability: zellij-multiplexer

## Purpose

Define zellij as the default terminal multiplexer with session persistence, stacked panes, floating windows, and shell-based auto-start.

## Requirements

### Requirement: Zellij is the default terminal multiplexer

The system SHALL use zellij as the terminal multiplexer when launching a new shell session, replacing tmux.

#### Scenario: New shell starts zellij

- **WHEN** a user opens a new terminal shell
- **THEN** zellij starts automatically (unless already inside a zellij session or over SSH)

#### Scenario: Existing zellij session is joined

- **WHEN** a user opens a new terminal tab while zellij is already running
- **THEN** the new tab joins the existing zellij session as a new pane

#### Scenario: SSH sessions bypass zellij

- **WHEN** a user connects via SSH
- **THEN** zellij does not start (raw shell is provided)

### Requirement: Session persistence

The system SHALL persist zellij session state so sessions survive terminal crashes and disconnects.

#### Scenario: Session survives terminal crash

- **WHEN** the terminal emulator crashes or is forcefully closed
- **THEN** the zellij session continues running and can be reattached

#### Scenario: Session survives detach

- **WHEN** a user detaches from a zellij session (Ctrl-g, then session mode, then d)
- **THEN** all panes, windows, and running processes remain active

#### Scenario: Session can be reattached

- **WHEN** a user opens a new terminal after a previous zellij session was detached
- **THEN** the previous session is automatically rejoined

### Requirement: Stacked panes

The system SHALL support stacked panes that auto-stack when resized beyond a threshold.

#### Scenario: Manual stacked pane creation

- **WHEN** the user creates a stacked pane (Ctrl-g, then s in locked mode)
- **THEN** the pane appears as a tab within the current pane group

#### Scenario: Auto-stack on resize

- **WHEN** a pane is resized beyond the stacking threshold
- **THEN** the pane automatically stacks into the pane group

### Requirement: Floating windows

The system SHALL support floating panes that overlay the tiling layout.

#### Scenario: Toggle pane floating

- **WHEN** the user toggles a pane to floating mode (Ctrl-g, then e in locked mode)
- **THEN** the pane floats above the tiling layout

#### Scenario: Toggle floating pane visibility

- **WHEN** the user toggles floating pane visibility (Ctrl-g, then w in locked mode)
- **THEN** all floating panes are shown or hidden

### Requirement: Discoverable keybindings

The system SHALL provide discoverable keybindings through a mode-based UI without requiring external plugins.

#### Scenario: Mode indicator is visible

- **WHEN** the user is in any zellij mode (normal, locked, resize, move, scroll, tab, pane)
- **THEN** the current mode is displayed in the status bar

#### Scenario: Mode switch shows available actions

- **WHEN** the user switches to a mode (e.g., Ctrl-g to enter locked mode, then t for tab mode)
- **THEN** the mode displays the available keybindings for that mode

#### Scenario: Default keybindings are functional

- **WHEN** the user uses default zellij keybindings
- **THEN** all core actions (split, navigate, resize, close, rename) work correctly

### Requirement: Auto-start mechanism

The system SHALL provide shell hooks that auto-start zellij conditionally.

#### Scenario: Auto-start in bash

- **WHEN** a new bash shell starts and ZELLIJ is not set and SSH_CONNECTION is empty
- **THEN** zellij is executed in place of the shell

#### Scenario: Auto-start in zsh

- **WHEN** a new zsh shell starts and ZELLIJ is not set and SSH_CONNECTION is empty
- **THEN** zellij is executed in place of the shell

#### Scenario: No auto-start when already in zellij

- **WHEN** a new shell is opened within an existing zellij session
- **THEN** zellij does not start (ZELLIJ env var is set)
