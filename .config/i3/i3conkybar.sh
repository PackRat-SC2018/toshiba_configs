################################################
# Pass colors to i3 status bar conky with JSON #
################################################
 
## Create a script in ~/bin and name it conky_i3bar.sh.  
 
#!/bin/sh
 
# Send the header so that i3bar knows we want to use JSON:
echo '{ "version": 1 }'
 
# Begin the endless array.
echo '['
 
# We send an empty first array of blocks to make the loop simpler:
echo '[],'
 
# Now send blocks with information forever:
exec conky -c "$HOME/.config/i3/conkyrc"
