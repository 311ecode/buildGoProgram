#!/usr/bin/env bash
is_debug_mode_buildGoProgram() {
  [ -n "$DEBUG" ] && [ "${DEBUG,,}" != "0" ] && [ "${DEBUG,,}" != "false" ]
}