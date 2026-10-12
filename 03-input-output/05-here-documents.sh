#!/usr/bin/env bash
# 05-here-documents.sh - feeding blocks of text to commands.

name="Ada"

# A here-document sends everything up to the delimiter to the command's stdin.
# The delimiter (EOF here) can be any word; it must stand alone on its line.
echo "--- Basic here-document (variables are expanded) ---"
cat <<EOF
Hello, $name.
Today is $(date +%A).
Your home directory is $HOME.
EOF

# Quote the delimiter to switch off all expansion.
echo "--- Quoted delimiter (everything is literal) ---"
cat <<'EOF'
Hello, $name.
The command $(date) is not run.
EOF

# <<- strips leading TAB characters (not spaces), so the block can be
# indented along with the code. The lines below start with real tabs.
echo "--- Indented with <<- ---"
if true; then
	cat <<-EOF
	This line was indented with a tab in the script.
	So was this one.
	EOF
fi

# Generate a file from a template.
workdir="$(mktemp -d)"
port=8080

cat > "$workdir/app.conf" <<EOF
# Generated on $(date +%Y-%m-%d)
server_name = $(hostname)
port        = $port
owner       = $name
EOF

echo "--- Generated app.conf ---"
cat "$workdir/app.conf"
rm -rf "$workdir"

# Store a multi-line block in a variable.
read -r -d '' usage <<'EOF'
Usage: tool [options] <file>
  -h   show help
  -v   verbose output
EOF
echo "--- Captured usage text ---"
echo "$usage"

# A here-string feeds a single string to stdin. Shorter than echo | command.
echo "--- Here-strings ---"
tr '[:lower:]' '[:upper:]' <<< "shout this"
wc -w <<< "count the words in this sentence"

# Split a string into variables with read and a here-string.
read -r first second rest <<< "alpha beta gamma delta"
echo "first=$first second=$second rest=$rest"
