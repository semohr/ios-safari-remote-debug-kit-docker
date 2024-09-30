#!/bin/bash



# Function to check the exit status of the last command and exit if it failed
check_exit_status() {
    if [ $? -ne 0 ]; then
        echo "Command failed: $1"
        exit 1
    fi
}

# Start ios_webkit_debug_proxy with --no-frontend option
ios_webkit_debug_proxy --no-frontend &
check_exit_status "ios_webkit_debug_proxy"


# Start http-server on port 9322 serving the WebInspectorUI directory
http-server -p 9322 WebKit/Source/WebInspectorUI/UserInterface/ &
check_exit_status "http-server"

# Wait for all background jobs to finish
echo "Server started. Visit http://localhost:9322 to start debugging."
wait