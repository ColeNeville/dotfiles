## ADDED Requirements

### Requirement: Modular override file loading

Wezterm SHALL load configuration overrides from an `overrides.d/` directory, applying them in sorted filename order before loading `local_config.lua`.

#### Scenario: Override files load in sorted order

- **WHEN** the `overrides.d/` directory contains multiple `.lua` files
- **THEN** they are loaded alphabetically by filename (e.g., `01-*.lua` before `02-*.lua`)

#### Scenario: Later overrides take precedence

- **WHEN** multiple override files set the same configuration key
- **THEN** the value from the file with the higher filename sort order is used

#### Scenario: Missing overrides directory is handled gracefully

- **WHEN** the `overrides.d/` directory does not exist
- **THEN** wezterm starts normally without errors

#### Scenario: Non-lua files are ignored

- **WHEN** the `overrides.d/` directory contains non-`.lua` files
- **THEN** only `.lua` files are loaded as overrides

### Requirement: Override file contract

Each override file in `overrides.d/` SHALL return a Lua table of key-value pairs that are merged into the wezterm configuration.

#### Scenario: Override table is applied

- **WHEN** an override file returns a Lua table with configuration keys
- **THEN** each key-value pair is applied to the wezterm configuration

#### Scenario: Empty override is valid

- **WHEN** an override file returns an empty table
- **THEN** wezterm continues without error

### Requirement: Local config retains highest priority

The `local_config.lua` file SHALL continue to work and take precedence over all `overrides.d/` files.

#### Scenario: Local config overrides package settings

- **WHEN** `local_config.lua` sets a key that is also set by an `overrides.d/` file
- **THEN** the value from `local_config.lua` is used

#### Scenario: Local config is optional

- **WHEN** `local_config.lua` does not exist
- **THEN** wezterm starts normally using only package overrides and defaults

### Requirement: Backward compatibility

The wezterm configuration SHALL remain backward compatible with existing setups that only use `local_config.lua`.

#### Scenario: Existing local_config.lua continues to work

- **WHEN** a host has only `local_config.lua` without `overrides.d/`
- **THEN** all existing configuration (font_size, color_scheme, etc.) continues to apply

#### Scenario: No breaking changes to base configuration

- **WHEN** the wezterm.lua is updated to support `overrides.d/`
- **THEN** existing key bindings, font settings, and other base configuration remain unchanged
