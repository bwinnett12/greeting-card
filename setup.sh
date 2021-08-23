#!/bin/sh

# Installs the poem of the day
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
git clone https://github.com/bwinnett12/poem-of-the-day.git
cd poem-of-the-day/
bundle install
cd ../



# Gets variables for the install script
SCRIPTDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

POETRY_SCRIPT="${SCRIPTDIR}/poem-of-the-day/poem.rb"

COMMAND_SCRIPT_LOC="${SCRIPTDIR}/greeter.sh"

# Creates a script that the command calls upon

if [ -f "$COMMAND_SCRIPT_LOC" ] ; then
	rm -f ${COMMAND_SCRIPT_LOC}
fi
touch ${COMMAND_SCRIPT_LOC}

printf "#!/bin/sh\n" >> ${COMMAND_SCRIPT_LOC}
printf "ruby ${POETRY_SCRIPT}\n" >> ${COMMAND_SCRIPT_LOC}


# After making the script to run, now adds to path at /usr/local/bin
ln -sf ${COMMAND_SCRIPT_LOC} /usr/local/bin/greeter

[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
sudo chmod +x /usr/local/bin/greeter

