#!/bin/bash

echo "=== Diagnostic Info ==="
echo "Date: $(date)"
echo "User: $(whoami)"
echo "Shell: $SHELL"
echo "TTY: $(tty)"
echo "Login shell: $(shopt -q login_shell && echo yes || echo no)"
echo

echo "--- Sourced files ---"
echo "This script is: $0"
echo "PWD: $PWD"

# Try to see if key files were sourced
[ -n "$__SOURCED_ALIASES" ] && echo "✔ aliases sourced" || echo "✖ aliases not sourced"
[ -n "$__SOURCED_EXPORTS" ] && echo "✔ exports sourced" || echo "✖ exports not sourced"

echo
echo "--- PATH ---"
echo "$PATH" | tr ':' '\n'

echo
echo "--- Aliases ---"
alias

echo
echo "=== End of diagnostic ==="
