#!/bin/bash

# Set the file path
FILE_PATH="/var/www/html/wordpress/wp-config.php"

# Check if the file exists
if [ -f "$FILE_PATH" ]; then
  # Set the unique key phrase
  KEY_PHRASE="put your unique phrase here"

  # Find all instances of the key phrase in the file
  INSTANCES=$(grep -o "$KEY_PHRASE" "$FILE_PATH")

  # Loop through each instance of the key phrase
  while read -r INSTANCE; do
    # Generate a new 64-character string for each instance
    NEW_STRING=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64 ; echo '')

    # Replace the instance of the key phrase with the new string
    sed -i "s/$INSTANCE/$NEW_STRING/g" "$FILE_PATH"

    # Print the new string for the instance
    echo "New string for instance '$INSTANCE': $NEW_STRING"
  done <<< "$INSTANCES"
else
  echo "File not found at $FILE_PATH."
fi


# Find and replace key phrases in wp-config.php file
if [ -f /var/www/html/wordpress/wp-config.php ]; then
  sed -i "s/<?php/<?php\ndefine('WP_FAIL2BAN_PROXIES','10.1.0.100');\nif (\$_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') \$_SERVER['HTTPS']='on';/" "$FILE_PATH"
else
  echo "wp-config.php file not found in /var/www/html/wordpress directory."
fi
