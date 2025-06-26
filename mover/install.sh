#!/usr/bin/env bash

# Stop on first error
set -e

echo "🚀 Starting Mouse Mover Setup..."

# --- Configuration ---
# The label for the launchd service, must be unique.
PLIST_LABEL="com.mdelgado.mover"
# The final name of our compiled application.
EXECUTABLE_NAME="mover"

# --- Paths ---
# The script determines its own location to correctly reference other files.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# The full path to the final executable.
EXECUTABLE_PATH="$SCRIPT_DIR/$EXECUTABLE_NAME"
# The directory where launchd .plist files for the user are stored.
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
# The full path to the final .plist file.
PLIST_PATH="$LAUNCH_AGENTS_DIR/$PLIST_LABEL.plist"
# The path to the source .plist template.
PLIST_TEMPLATE_PATH="$SCRIPT_DIR/$PLIST_LABEL.plist.template"
# Paths for the log files.
LOG_OUT_PATH="$HOME/Library/Logs/$PLIST_LABEL.log"
LOG_ERR_PATH="$HOME/Library/Logs/$PLIST_LABEL.error.log"


# --- Main Logic ---

echo "   - Building Go application..."
# Navigate to the script's directory to ensure the build happens in the right place.
cd "$SCRIPT_DIR"
# Build the Go binary. The output file will be named "mover" and placed in the current directory.
go build -o "$EXECUTABLE_NAME" main.go
echo "✅ Build successful. Executable is at: $EXECUTABLE_PATH"

echo "   - Unloading any existing old service..."
# Unload the service if it's already running, ignoring errors if it doesn't exist.
launchctl bootout "gui/$(id -u)" "$PLIST_PATH" 2>/dev/null || true
echo "✅ Old service unloaded."

echo "   - Creating launchd .plist file..."
# Check if the template file exists before proceeding.
if [ ! -f "$PLIST_TEMPLATE_PATH" ]; then
    echo "❌ Error: Template file not found at $PLIST_TEMPLATE_PATH"
    exit 1
fi
# Create the LaunchAgents directory if it doesn't exist.
mkdir -p "$LAUNCH_AGENTS_DIR"
# Replace placeholders in the template with the actual paths and create the final .plist file.
sed -e "s|__EXECUTABLE_PATH__|$EXECUTABLE_PATH|g" \
    -e "s|__LOG_OUT_PATH__|$LOG_OUT_PATH|g" \
    -e "s|__LOG_ERR_PATH__|$LOG_ERR_PATH|g" \
    "$PLIST_TEMPLATE_PATH" > "$PLIST_PATH"
echo "✅ .plist file created at: $PLIST_PATH"

echo "   - Loading and starting the new service..."
# Load the .plist file into launchd for the current user.
launchctl bootstrap "gui/$(id -u)" "$PLIST_PATH"
echo "✅ Service loaded successfully."

echo -e "\n🎉 Installation Complete! Now for the final manual step:"
echo "------------------------------------------------------------------"
echo "macOS requires you to manually grant permission for this app to control your computer."
echo ""
echo "1. Go to System Settings > Privacy & Security."
echo "2. Click on 'Accessibility'."
echo "3. Click '+' and add the executable from this path:"
echo "   $EXECUTABLE_PATH"
echo "4. Do the same for 'Input Monitoring'."
echo ""
echo "The service might not work until you have granted these permissions."
echo "------------------------------------------------------------------"
