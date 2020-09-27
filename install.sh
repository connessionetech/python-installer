# #!/usr/bin/env bash

CYAN='\033[0;36m'
BOLD_GREEN="\033[1;32m"
RED="\e[0;31m"
BOLD_RED='\033[1;31m'
BLUE="\e[0;34m"
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BOLD_YELLOW='\033[1;33m'
RESET="\033[0m"

echo ""
echo ""
echo -e ${YELLOW}"***********************************************************"${RESET}

if [ -f /etc/*-release ];
then
    # Get Os details
    OS_NAME=$(cat /etc/*-release | grep -w NAME | cut -d= -f2 | tr -d '"')
    OS_VERSION=$(cat /etc/*-release | grep -w VERSION | cut -d= -f2 | tr -d '"')
    echo -e ${BOLD_YELLOW}"[*] ${GREEN}Found:${BOLD_GREEN}" ${OS_NAME} ${GREEN}"Version: "${BOLD_GREEN}${OS_VERSION}
else
    echo -e ${BOLD_RED}"THIS IS NOT A GNU/LINUX DISTRO"
    echo -e ${YELLOW}"Exiting ! ! !"${RESET}
    exit 1
fi

echo -e ${YELLOW}"[*] ${CYAN}Checking python version installed currently on the system..."${RESET}

if hash python3;
then
    echo -e ${YELLOW}"[*]${BOLD_GREEN}" $(python3 -V) ${CYAN}"Found on the system"

else
    echo -e ${YELLOW}"[!] Warning! ${CYAN} python3 not found on the system..."
    echo -e ${BOLD_GREEN}"[+] ${CYAN}Installing python3 on the system..."

fi

ver=$(python3 -V 2>&1 | sed 's/.* \([0-9]\).\([0-9]\).*/\1\2/')

if [ "$ver" -lt "30" ];
then
    echo -e ${BOLD_RED}"[!] ${RED}python3 not found"
    echo -e ${BOLDGREEN}"[+] ${CYAN}Installing python3"
fi

echo -e ${BOLD_GREEN}"[+] ${CYAN}Creating directory to hold all Python virtual environments"${RESET}
mkdir -p "${HOME}"/virtualenvs
echo -e ${YELLOW}"[*] ${CYAN}Downloading pysetenv"${PURPLE}

curl -# https://raw.githubusercontent.com/connessionetech/python-installer/master/py_setup.sh -o ${HOME}/.py_setup.sh

if [ -e "${HOME}/.zshrc" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.zshrc"${RESET}
    echo "source ~/.py_setup.sh" >> ${HOME}/.zshrc
    # source ${HOME}/.zshrc


elif [ -e "${HOME}/.bashrc" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.bash_profile"${RESET}
    echo -e "source ~/.py_setup.sh" >> ${HOME}/.bashrc
    # source ${HOME}/.bashrc

elif [ -e "${HOME}/.bash_profile" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.bash_profile"${RESET}
    echo -e "source ~/.py_setup.sh" >> ${HOME}/.bash_profile
    # source ${HOME}/.bashrc
fi

# Installation complete
echo -e ${YELLOW}"[*] ${CYAN}Installation Completed Successfully!"
echo -e ${YELLOW}"[*] ${CYAN}Type: ${BOLD_GREEN} pysetenv ${CYAN}to use pysetenv"

# Usage
echo -e ${GREEN} "Usage: ${BOLD_GREEN}pysetenv --new VIRTUAL_ENVIRONMENT_NAME ${CYAN}to create new virtual environment"
echo -e ${GREEN} "Usage: ${BOLD_GREEN}pysetenv VIRTUAL_ENVIRONMENT_NAME ${CYAN}to activate the new virtual environment"
echo -e ${YELLOW}"***********************************************************"${RESET}
echo ""
echo ""