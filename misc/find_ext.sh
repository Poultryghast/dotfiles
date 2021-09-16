#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq unzip
# This script was copied from https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/vscode-extensions/update_installed_exts.sh
# but modified to take a single extension from stdin and get the details.

set -eu -o pipefail

# Helper to just fail with a message and non-zero exit code.
function fail() {
    echo "$1" >&2
    exit 1
}

# Helper to clean up after ourselves if we're killed by SIGINT.
function clean_up() {
    TDIR="${TMPDIR:-/tmp}"
    echo "Script killed, cleaning up tmpdirs: $TDIR/vscode_exts_*" >&2
    rm -Rf "$TDIR/vscode_exts_*"
}

function get_vsixpkg() {
    N="$1.$2"

    # Create a tempdir for the extension download.
    EXTTMP=$(mktemp -d -t vscode_exts_XXXXXXXX)

    URL="https://$1.gallery.vsassets.io/_apis/public/gallery/publisher/$1/extension/$2/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"

    # Quietly but delicately curl down the file, blowing up at the first sign of trouble.
    curl --silent --show-error --fail -X GET -o "$EXTTMP/$N.zip" "$URL"
    # Unpack the file we need to stdout then pull out the version
    VER=$(jq -r '.version' <(unzip -qc "$EXTTMP/$N.zip" "extension/package.json"))
    # Calculate the SHA
    SHA=$(nix-hash --flat --base32 --type sha256 "$EXTTMP/$N.zip")

    # Clean up.
    rm -Rf "$EXTTMP"
    # I don't like 'rm -Rf' lurking in my scripts but this seems appropriate.

    cat <<-EOF
{
  name = "$2";
  publisher = "$1";
  version = "$VER";
  sha256 = "$SHA";
}
EOF
}

# Try to be a good citizen and clean up after ourselves if we're killed.
trap clean_up SIGINT

OWNER=$(echo "$1" | cut -d. -f1)
EXT=$(echo "$1" | cut -d. -f2)
get_vsixpkg "$OWNER" "$EXT"
