#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2024-03-06 05:14:07 +0000 (Wed, 06 Mar 2024)
#
#  https///github.com/HariSekhon/DevOps-Bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1090,SC1091
. "$srcdir/../lib/utils.sh"

# shellcheck disable=SC2034,SC2154
usage_description="
Finds all locally installed brew packages which are not saved into the adjacent brew*.txt lists
"

# used by usage() in lib/utils.sh
# shellcheck disable=SC2034
usage_args="arg [<options>]"

help_usage "$@"

num_args 0 "$@"

cd "$srcdir"

brew list |
while read -r package; do
    [[ "$package" =~ ^lib ]] && continue
    [[ "$package" =~ ^python- ]] && continue
    #[[ "$package" =~ ^python@ ]] && continue
    [[ "$package" =~ @ ]] && continue
    if ! grep -Eq "^#?$package([[:space:]].+)?$" brew*.txt; then
        echo "$package not found in setup/brew*"
    fi
done
