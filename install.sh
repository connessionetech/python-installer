#!/bin/bash

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

# Load config.ini file
. ./config.ini

if [ -f /etc/os-release ];
then
    # Get Os details
    OS_NAME=$(cat /etc/os-release | grep -w NAME | cut -d= -f2 | tr -d '"')
    OS_VERSION=$(cat /etc/os-release | grep -w VERSION_ID | cut -d= -f2 | tr -d '"')
    DISTRO=$(cat /etc/os-release | grep -w ID_LIKE | cut -d= -f2 | tr -d '=')

    echo -e ${YELLOW}"[*] ${GREEN}Operating System:${BOLD_GREEN}" ${OS_NAME} ${GREEN}"Version: "${BOLD_GREEN}${OS_VERSION}${RESET}
    echo -e ${YELLOW}"[*] ${GREEN}Path to virtual environment directory:${BOLD_GREEN}" ${PYSETENV_VIRTUAL_DIR_PATH}${RESET}
    echo -e ${YELLOW}"[*] ${GREEN}Python Version On Config.ini:${BOLD_GREEN}" ${PYSETENV_PYTHON_VERSION}${RESET}

    # Add Python on RedHat 7
    if [[ "$OS_NAME" == *"Red Hat"* ]];
    then
        # check if python is already installed
        if hash python${PYSETENV_PYTHON_VERSION};
        then
            echo -e ${YELLOW}"[*] ${CYAN}Checking python version installed currently on the system..."${RESET}
            echo -e ${YELLOW}"[*] " ${BOLD_GREEN}"$(python${PYSETENV_PYTHON_VERSION} -V) ${GREEN} already installed on the system"
        else
            read -p "install python${PYSETENV_PYTHON_VERSION} on the system (Y/N)" y_n
            case $y_n in
                Y|y)
                    yum install gcc openssl-devel bzip2-devel sqlite-devel -y
                    cd /usr/src
                    case $PYSETENV_PYTHON_VERSION in
                        "3.1")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.1.5/Python-3.1.5.tgz
                            ;;
                        "3.2")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.2.6/Python-3.2.6.tgz
                            ;;
                        "3.3")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.3.7/Python-3.3.7.tgz
                            ;;
                        "3.4")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.4.9/Python-3.4.9.tgz
                            ;;
                        "3.5")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.5.9/Python-3.5.9.tgz
                            ;;
                        "3.6")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
                            ;;
                        "3.7")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
                            ;;
                        "3.8")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
                            ;;
                        "3.9")
                            sudo curl -o python.tgz https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
                            ;;
                        *) echo python version not found
                    esac
                    tar xzf python.tgz
                    cd Python-3*
                    sudo ./configure --enable-optimizations
                    sudo make altinstall
                    sudo rm /usr/src/python.tgz
                    sudo rm -rf /usr/src/Python-3*
                     ;;

                N|n)
                    echo -e ${YELLOW}"[!] ${RED}Aborting"${RESET}
                    exit 1;;

                *)
                    echo -e ${YELLOW}"[*] ${BOLD_YELLOW}Enter either Y|y for yes or N|n for no"
                    exit 1;;

            esac
        fi
    fi

    # Add Python on Debian
    if [[ "${OS_NAME}" == *"Debian"* ]] ;
    then
        add-apt-repository ppa:deadsnakes/ppa
        apt-get update
        apt-get install python${PYSETENV_PYTHON_VERSION}
        apt-get autoremove -y
    fi
    # Add Python PPA on Ubuntu
    if [[ "$OS_NAME" == *"Ubuntu"* ]];
    then     
        if hash python${PYSETENV_PYTHON_VERSION};
        then
            echo -e ${YELLOW}"[*] ${CYAN}Checking python version installed currently on the system..."${RESET}
            echo -e ${YELLOW}"[*] "${BOLD_GREEN}"$(python${PYSETENV_PYTHON_VERSION} -V) ${GREEN} already installed on the system"${RESET}
        
        else
            read -p "install python${PYSETENV_PYTHON_VERSION} on the system (Y/N)" y_n
            case $y_n in
                Y|y) 
                    add-apt-repository ppa:fkrull/deadsnakes
                    apt-get update
                    apt-get install python${PYSETENV_PYTHON_VERSION}
                    apt-get autoremove -y ;;
                N|n) 
                    echo -e ${YELLOW}"[!] ${RED}Aborting"${RESET}
                    exit 1;;
                *) 
                    echo -e ${YELLOW}"[*] ${BOLD_YELLOW}Enter either Y|y for yes or N|n for no"
                    exit 1;;
            esac
        fi
    fi
elif [ -f /etc/system-release ];
    # Add Python on CentOS
then
    # Get Os details
    OS_NAME=$(cat /etc/system-release | cut -d ' ' -f1)
    OS_VERSION=$(cat /etc/system-release | cut -d ' ' -f3)

    echo -e ${YELLOW}"[*] ${GREEN}Operating System:${BOLD_GREEN}" ${OS_NAME} ${GREEN}"Version: "${BOLD_GREEN}${OS_VERSION}${RESET}
    echo -e ${YELLOW}"[*] ${GREEN}Path to virtual environment directory:${BOLD_GREEN}" ${PYSETENV_VIRTUAL_DIR_PATH}${RESET}
    echo -e ${YELLOW}"[*] ${GREEN}Python Version On Config.ini:${BOLD_GREEN}" ${PYSETENV_PYTHON_VERSION}${RESET}

    if hash python${PYSETENV_PYTHON_VERSION};
    then
        echo -e ${YELLOW}"[*] ${CYAN}Checking python version installed currently on the system..."${RESET}
        echo -e ${YELLOW}"[*] " ${BOLD_GREEN}"$(python${PYSETENV_PYTHON_VERSION} -V) ${GREEN} already installed on the system"
    else
        read -p "install python${PYSETENV_PYTHON_VERSION} on the system (Y/N)" y_n
        case $y_n in
            Y|y)
                sudo yum install gcc openssl-devel bzip2-devel sqlite-devel -y
                cd /usr/src
                case $PYSETENV_PYTHON_VERSION in
                    "3.1")
                        curl -o python.tgz https://www.python.org/ftp/python/3.1.5/Python-3.1.5.tgz
                        ;;
                    "3.2")
                        curl -o python.tgz https://www.python.org/ftp/python/3.2.6/Python-3.2.6.tgz
                        ;;
                    "3.3")
                        curl -o python.tgz https://www.python.org/ftp/python/3.3.7/Python-3.3.7.tgz
                        ;;
                    "3.4")
                        curl -o python.tgz https://www.python.org/ftp/python/3.4.9/Python-3.4.9.tgz
                        ;;
                    "3.5")
                        curl -o python.tgz https://www.python.org/ftp/python/3.5.9/Python-3.5.9.tgz
                        ;;
                    "3.6")
                        sudo curl -o python.tgz https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
                        ;;
                    "3.7")
                        curl -o python.tgz https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
                        ;;
                    "3.8")
                        curl -o python.tgz https://www.python.org/ftp/python/3.8.6/Python-3.8.6.tgz
                        ;;
                    "3.9")
                        curl -o python.tgz https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
                        ;;
                    *) echo python version not found
                esac
                sudo tar xzf python.tgz
                cd Python-3*
                sudo ./configure --enable-optimizations
                sudo make altinstall
                sudo rm /usr/src/python.tgz
                sudo rm -rf /usr/src/Python-3*
                cd ~
                    ;;

            N|n)
                echo -e ${YELLOW}"[!] ${RED}Aborting"${RESET}
                exit 1;;

            *)
                echo -e ${YELLOW}"[*] ${BOLD_YELLOW}Enter either Y|y for yes or N|n for no"
                exit 1;;

        esac
    fi
else
    echo -e ${YELLOW}"Exiting ! ! !"${RESET}
    exit 1
fi

if [ -f ${HOME}/.py_setup.sh ];
then
    echo -e ${YELLOW}"[*] "${BOLD_GREEN}"pysetenv already installed"
    echo -e ${YELLOW}"***********************************************************"${RESET}
    exit 1
fi

echo -e ${YELLOW}"[+] ${CYAN}Creating directory to hold all Python virtual environments"${RESET}
mkdir -p $HOME/virtualenvs
echo -e ${YELLOW}"[*] ${CYAN}Downloading pysetenv"${PURPLE}

curl -# https://raw.githubusercontent.com/connessionetech/python-installer/master/py_setup.sh -o ${HOME}/.py_setup.sh
curl -# https://raw.githubusercontent.com/connessionetech/python-installer/master/config.ini -o ${HOME}/.config.ini

if [ -e "${HOME}/.zshrc" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.zshrc"${RESET}
    echo "source ~/.py_setup.sh" >> ${HOME}/.zshrc

elif [ -e "${HOME}/.bashrc" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.bashrc"${RESET}
    echo -e "source ~/.py_setup.sh" >> ${HOME}/.bashrc

elif [ -e "${HOME}/.bash_profile" ];
then
    echo -e ${GREEN}"[+] ${CYAN}Adding ${GREEN}~/.bash_profile"${RESET}
    sudo echo -e "source ~/.py_setup.sh" >> ${HOME}/.bash_profile
fi

# installation complete
echo -e ${YELLOW}"[*] ${CYAN}Installation Completed Successfully!"

# Usage Info
echo -e ${GREEN} "Type: ${BOLD_GREEN}source ~/.bashrc ${CYAN}to activate pysetenv or open a new terminal and start using pysetenv"
echo -e ${GREEN} "Usage: ${BOLD_GREEN}pysetenv --new VIRTUAL_ENVIRONMENT_NAME ${CYAN}to create new virtual environment"
echo -e ${GREEN} "Usage: ${BOLD_GREEN}pysetenv VIRTUAL_ENVIRONMENT_NAME ${CYAN}to activate the new virtual environment"
echo -e ${YELLOW}"***********************************************************"${RESET}
echo ""
echo ""
