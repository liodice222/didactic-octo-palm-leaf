#!/bin/bash

echo "Content-type: text/html"
echo ""

read QUERY_STRING

# Parse the query string
IFS='=&' read -r -a params <<< "$QUERY_STRING"

declare -A param_map
for ((i=0; i<${#params[@]}; i+=2)); do
    param_map[${params[i]}]=${params[i+1]}
done

action="${param_map[action]}"
username="${param_map[username]}"
shell="${param_map[shell]}"

case "$action" in
    add)
        sudo useradd "$username"
        echo "<p>User $username added.</p>"
        ;;
    modify)
        sudo usermod -s "$shell" "$username"
        echo "<p>User $username modified with shell $shell.</p>"
        ;;
    delete)
        sudo userdel "$username"
        echo "<p>User $username deleted.</p>"
        ;;
    *)
        echo "<p>Usage: {add|modify|delete} username [shell]</p>"
        ;;
esac