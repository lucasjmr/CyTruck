#!/bin/bash

print_help()
{
    echo 'Welcome to the DOCUMENTATION ;D
Usage : "./main.sh <path-to-csv-file> [OPTION1] [OPTION2] [...] [OPTION5]"
Options : 
	- h : prints this help message. It ignores all other options if used.
	- d1 : creates an horizontal histogram in "images/" with top 10 drivers by number of routes.
	- d2 : creates an horizontal histogram in "images/" with top 10 drivers by number of kilometers traveled.
	- l : creates a vertical histogram in "images/" with top 10 longest routes.
	- t : creates a grouped histogram in "images/" with top 10 cities visited by the routes.
	- s : creates a graphic  with max/min et average distance per step for 50 routes.

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⣖⣤⣶⣿⣿⣿⣿⣿⣭⡶⠶⠒⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠈⠉⠁⠒⠤⠀⡔⠄⠀⠂
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡴⢋⣥⣾⣿⣿⣿⣿⣿⣿⡿⠛⠁⢀⣠⠔⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠛⠓⢤⡀⠀⠀⢀⣀⠈⠂⠉⠀
⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠘⣿⣀⢻⡟⠉⣷⠀⠀⠀⠀⠀⠀⢀⡤⠎⠁⣀⣿⣿⣿⣿⣿⣿⣿⠟⢉⣠⣶⡾⠋⠀⠀⠀⠀⣀⣠⡤⢶⡾⠶⠀⠀⠀⠀⠀⠉⠶⣽⣾⣿⣷⣄⡀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣶⣬⣺⡟⠀⠀⠀⠀⢀⡴⠋⢀⣤⣾⣿⣿⣿⣿⣿⣿⡿⣣⣴⡿⠟⠁⠀⠀⣠⣤⣶⡿⠟⢉⣴⠋⠁⠀⠀⢀⡞⠀⠀⣦⠀⠙⢿⣿⣿⣿⣿⣦
⠀⠀⠀⠀⠀⠰⡄⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⢀⣴⣯⣶⣿⣿⣿⡿⣽⣿⣿⣿⣿⣿⣿⢿⠋⡀⣀⣤⣾⠿⣿⡿⢋⣴⣾⠟⠀⠀⠀⠀⣴⠋⠀⠀⠀⢹⣦⠠⢪⣻⣿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠻⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣻⢋⡞⣿⣿⣿⣿⣿⣿⣿⣷⣾⡿⠟⠉⣱⡾⣯⡶⣿⡿⠃⠀⠀⠀⢀⡼⠃⢠⣆⠀⠀⣇⣿⡆⡜⡏⢿⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⢷⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⡟⠁⠀⠁⣰⣿⣿⣿⣿⣿⣿⡿⠛⠁⠀⢠⣾⣿⠟⢡⣾⣿⠅⠀⠀⠀⣠⡿⠁⣰⣿⢸⢸⡆⣿⣿⣿⣼⣼⡈⣿⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠈⡇⠀⠀⠀⠀⠀⠀⠀⣴⣿⠟⣹⣿⡏⠀⠀⠀⢰⣿⣿⣿⣿⡿⠟⠉⠀⠀⠀⣰⣿⡿⠃⢠⣾⣿⠞⠀⠀⡴⣷⣿⠅⠀⣿⣿⢸⣾⡇⢻⣿⣿⣿⣿⣇⠸⣿⣿
⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⢰⡿⠁⣸⣿⡟⢠⢀⢠⢀⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⢰⣿⠟⠀⢠⣿⣿⡟⠀⢀⣼⣿⣿⡿⠀⢰⣿⣿⡟⣿⣇⢸⣿⣿⣿⣿⣿⠀⣿⣿
⠀⠀⠀⠀⢰⡾⢶⣀⣥⣤⡀⠀⠀⠀⢰⡟⠁⣴⣿⣿⣧⡟⣾⢋⣼⣿⡿⠋⠀⠀⠀⠀⠀⠀⢠⣿⠏⠀⠀⣼⣿⣿⠀⢀⣾⣿⣳⡿⠁⠀⡇⣿⣿⣿⣿⣿⡸⣿⣿⣿⣿⣿⡀⢻⡏
⠀⠀⠀⠀⢸⣇⠀⠻⣇⣸⡇⠀⠀⢀⡞⠀⣼⢿⣿⣿⣿⣹⡟⣾⡿⠋⠑⠦⠤⠤⣀⣀⣀⠤⣾⡿⠂⠀⢸⣿⣿⡇⢀⣾⡿⢱⡿⠁⠀⠐⠁⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿⣿⡇⢸⡇
⠀⠀⠀⠀⠀⠙⢷⣴⠟⠋⠀⠀⠀⡾⠀⢰⠃⢈⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⣄⡏⠀⠀⠀⢸⣿⡿⢀⣾⡿⣇⡾⠁⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠃⢰⠇⠀⠸⢸⣿⣿⣿⢋⡀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠸⠃⠀⠀⠀⢸⣿⡇⣾⡿⠁⡸⢣⡀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⢸⡇
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢺⣠⠏⢀⡀⠀⣸⣿⣿⡏⢀⣹⣶⣶⣶⣿⣯⡒⢆⡀⠀⠀⠀⠀⠀⠀⢸⣿⢳⡿⠀⢰⠇⠀⠙⢦⡀⢀⠀⠀⠸⣿⣿⣿⡿⣿⣿⣿⣿⣿⡃⣼⠁
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠋⣠⠞⠀⣼⢿⣿⣿⣱⡿⠋⠁⢠⣴⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠙⢮⡄⠀⠀⢻⣿⣿⣿⢿⣿⣿⣿⣿⠀⣿⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⣁⠞⠁⢀⣾⣿⢸⣿⡿⡿⠀⠀⣰⣿⣿⣿⣿⡟⢻⡇⠀⠀⠀⠀⠀⠀⠀⢻⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠲⣀⠈⢿⣿⣿⠈⣿⣿⣿⣿⢠⣿⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⠟⠁⢀⣴⣿⣿⣿⣾⣿⣿⠃⠀⢠⡟⠉⠙⠛⢻⣷⣿⡇⠀⠀⠀⠀⠀⠀⠀⠸⠃⠀⠀⠀⠀⢠⣤⣀⠀⡀⠀⠀⠀⠙⠚⢿⣿⣧⠸⣿⣿⣿⣾⣷⢰
⠀⠀⠀⠀⠀⠀⢀⣴⡿⢛⡥⢀⣴⣿⣿⣿⠟⠀⢹⣿⣧⠀⠀⠘⢇⠀⣀⡀⣸⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⣿⣿⣷⣿⣤⡀⠀⠀⠀⠈⢿⣿⣆⠸⣿⣿⣿⣿⣾
⠀⠀⠀⢀⣠⠾⠋⢉⣴⣫⣶⣿⣿⡿⠋⠁⠀⠀⠀⣿⣿⡄⠀⠈⢿⡀⠈⠉⢁⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣷⣧⡀⠀⠈⢻⣿⣆⠹⣿⣿⣿⣿
⠀⠀⠀⠈⢱⣄⣾⣯⣿⣿⠟⠋⠀⠀⠀⠀⠀⣠⣼⠃⠙⢷⠀⠐⠚⠿⠖⠚⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⠛⠿⢿⣿⡏⢙⡏⠻⣿⣆⠀⠀⠻⣿⣷⣿⣿⣿⣿
⡀⠀⠀⣠⣿⣿⣿⠟⣹⣵⣤⣤⣤⣤⣤⣤⡼⢿⡏⠀⠀⠀⠙⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⡃⠀⠀⠀⠀⢘⣿⣿⠇⠀⠹⣿⡆⠀⠀⢸⣏⣿⣿⣿⣿
⣡⣴⣾⣻⣿⠟⣩⣾⣿⣿⣿⣿⣿⣿⣿⡏⠀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⣳⠀⢤⣀⣠⠞⢉⡿⠀⠀⠀⢹⣷⠀⢀⣾⣾⣿⣿⣿⣿
⣿⣿⢣⣿⣗⣼⣿⣿⡿⠿⢿⡟⠛⠛⠛⣷⠞⠋⠛⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧⠀⠀⠀⠀⣠⠟⠀⠀⠀⠀⣸⠇⢀⣾⣾⣿⢿⣿⣿⣿
⣿⣿⠠⣿⠿⣿⡁⠈⠀⠀⠀⠑⣄⣠⠞⠁⠀⠀⠀⣀⡹⠶⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣒⠖⠋⠁⠀⠀⠀⠀⠞⠁⣰⣿⣿⠟⢡⣿⡿⠋⠀
⡋⠙⣸⠃⠀⠈⠻⣦⠀⢀⡴⣶⠟⠁⠀⠀⣀⡴⠚⠁⠀⠀⠀⠙⣆⠀⠀⠀⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⡿⢟⡥⣺⣿⠟⠀⠊⠀
⠀⠀⠃⠀⠀⠀⠀⢈⡿⠋⣰⠇⠀⠀⠐⠚⠁⠀⠀⠀⠀⣠⠴⠛⠋⠓⣆⠀⠈⢇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣛⣻⠵⠚⢁⡴⠟⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣰⠏⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⣠⠖⠋⠀⠀⠀⠀⠀⢸⣦⠀⠈⠳⠤⠴⠖⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠊⠉⠉⠀⢀⣤⠶⠭⠄⠀⠀⠀⠀⠀⢀
⠀⠀⠀⠀⠀⡼⠁⠀⠀⠀⠘⢦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠞⠉⠈⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣶⠋⠁⠀⠀⠀⠀⢀⣀⣀⠐⠃
⠀⠀⠀⠀⡼⠁⠀⠀⠀⠀⠀⡎⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠖⠋⠀⢀⠀⠀⢸⠀⠀⠀⡤⠤⠤⣤⡴⠒⠒⠒⢦⡖⠒⠲⠤⣄⣀⡀⠀⣀⣤⣾⡋⠉⠓⠶⠖⠚⠛⠉⠁⠀⠀⠀⢀
⠀⠀⠀⡸⠁⠀⠀⠀⠀⠀⠀⡇⠀⠈⢣⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠿⣦⡞⠀⢠⡞⠀⠀⠀⠈⡇⠀⠀⠀⢸⠇⠀⠀⠀⡇⠈⠉⠙⢿⣿⣿⣿⣆⠀⠀⠀⠀⢠⠀⠀⣠⣀⣠⣿
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡇⠀⡇⠀⢸⡓⢤⡀⠀⠀⠀⠀⠀⠀⢀⡴⢻⠉⢹⣿⠇⠀⠀⠀⠀⡇⠀⠀⠀⡸⠀⠀⠀⢰⡇⠀⠀⠀⢸⣿⣿⡿⠟⠳⠤⠖⠶⠤⣤⣴⣿⣌⢿⣿
⠀⠀⠀⠀⠀⠀⢀⠴⠋⠉⠁⡇⠀⠀⠀⠀⠇⠀⠉⠑⠶⢤⡤⠴⠞⠉⠄⣼⣠⠾⠿⠀⠀⠀⠀⠀⠃⠀⠀⠀⠃⠀⠀⠀⠸⠁⠀⠀⢰⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠦⡹
⠠⠂⠀⠀⠀⠀⢸⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣲⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡏⠘⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠈⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠁⠀⠀⠀⠀⠀⠙⠓⠤⢤⣤⣀⣀⣀⣀⣀⣠⡤⢖⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⢀⠀⠀⢀⡔⠉⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀

'
}

# ------------------------------ VERIFY OPTIONS ------------------------------

if [[ $# -lt 2 ]] || [[ $# -gt 6 ]] ; then #If number of options is lower than 2 or higher (both strict)than 5, error.
    echo 'Wrong number of options -> ./main.sh <path_to_data_file> -h for help.' >&2
    exit 1
elif [[ ! -f "$1" ]] ; then # Checks if first option is the csv.
    echo 'The first option must be the path to csv -> ./main.sh <path_to_data_file> -h for help.' >&2
    exit 2
fi

declare -a options_array=("$@") # Saves entered options in an array
check=0

for i in "${options_array[@]}" # Checks if there are wrong options and -h
do 
    case "$i" in 
        "-h" ) 
            check=1 ;;
        "-d1" | "-d2" | "-l" | "-t" | "-s" ) ;;
        *) # If there are, exit program
            echo 'One or more specified options are not valid -> ./main.sh <path_to_data_file> -h for help.' >&2
            exit 3 ;;
    esac
done

if [ "$check" -eq 1 ] ; then # If there is -h and no wrong option, print help
    print_help
    exit 0
fi

# ------------------------------ VERIFY FOLDERS AND FILES ------------------------------

if [ ! -d "images" ] ; then
    mkdir 'images'
fi

if [ -d "temp" ] ; then 
    rm -rf 'temp'/* # Salvages temp folder if it exists before processing
else 
    mkdir 'temp'
fi

if [ ! -f 'progc/cfiles/main.c' ] || [ ! -f 'progc/headers/header.h' ] || [ ! -f 'progc/makefile/makefile' ]; then # Checks if c, header or makefile file are missing
    echo 'C file and/or header and/or makefile are missing from "progc/"' >&2
    exit 4
fi

# ------------------------------ MAIN PROCESS OF OPTIONS ------------------------------ 

CSV_PATH="$1" # Saves the path of the csv before using SHIFT command
shift # Shifts to the first option

while [ "$#" -gt 0 ] ; do # Process every options 
    case "$1" in 
        "-d1") 
            echo 'Do D1' ;;
        "-d2") 
            echo 'Do D2' ;;
        "-l") 
            echo 'Do L' ;;
        "-t") 
            echo 'Do T' ;;
        "-s") 
            echo 'Do S' ;;
    esac
    shift
done 