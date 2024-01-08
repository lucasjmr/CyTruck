#!/bin/bash

Wprocess()
{
while IFS= read -r line; do
    echo -e "\e[32m$line\e[0m"
    sleep 0.05
done < 'ascii/welcome.txt'
}

d1_process()
{
    echo 'Starting d1 process ...'
    start_time=$(date +%s)

    # Create csv with top 10 drivers <driver name>;<number of occurence> in temp/datad1.csv
    awk -F ';' 'NR > 1 { key=$6";"$1; if (!(key in driver_array)) { driver_array[key] = 1; array[$6]++; }} END { for (i in array) { print i ";" array[i]; }}' "$CSV_PATH" | sort -t';' -k2 -n | tail -n10 > temp/datad1.csv
    # NR > 1 Removes the useless first line containing data infos
    # 
    # AWK - 
    #   key=$6";"$1 creates a key for each line <drivername>;<routeid>
    #   if the combination of routeid/driver doesnt exist, add it to driver_array. So we can know how much times drivers did a different routeid
    #   Now we create a new array, wich will add one to every different key for each driver. => number of different routes per driver in associative array
    #   Next, we send <drivername>;<number_of_occurrences> in the sort command with a pipe.
    #
    # Now we can sort driver names, less routes at the top, most routes at the bottom of file 
    # keeps first 10 drivers, prints them in temp/datad1.csv

    echo 'Generating d1 histogram ...'

    echo "set title 'Option -d1 : Nb routes = f(Driver)' ; set xtics font 'DejaVuSans,8' ; set yrange [-1:10] ; set style fill solid border -1 ; set xlabel 'NB ROUTES' ; set ylabel 'DRIVER NAMES' ; set datafile separator ';' ; set terminal png ; set output 'images/d1.png' ; plot 'temp/datad1.csv' using (\$2*0.5):0:(\$2*0.5):(0.3):yticlabels(1) with boxxyerrorbars t ''" | gnuplot

    end_time=$(date +%s)
    echo "Finished d1 data file process and plot in $(( end_time - start_time )) seconds."
}

d2_process()
{
    echo 'Starting d2 process ...'
    start_time=$(date +%s)

    # Creates csv with top 10 drivers <driver_name>;<distance> in temp/datad2.csv
    awk -F';' ' NR > 1 {distance_array[$6]+=$5} END {for (i in distance_array) print i ";" distance_array[i]}' "$CSV_PATH" | sort -t';' -k2 -n | tail -n10 > temp/datad2.csv
    # NR > 1 : Removes the useless first line containing data infos
    # 
    # AWK - 
    #   {distance_array[$6]+=$5} : creates associative array with the 6th field (driver name), and add every distance (5th field) to the associated driver
    #   END : Waits for all lines to be processed. 
    #   {for (i in distance_array) print i ";" distance_array[i]} : formates the output file to be <driver_name>;<distance>
    # 
    # sorts driver names, most distance at the bottom, less distance at the top of file 
    # keeps last 10 drivers, prints them in temp/datad2.csv

    echo 'Generating d2 histogram ...'

    echo "set title 'Option -d2 : Distance = f(Driver)' ; set yrange [-1:10] ; set style fill solid border -1; set xlabel 'DISTANCE (km)' ; set ylabel 'DRIVER NAMES' ; set datafile separator ';' ; set terminal png ; set output 'images/d2.png' ; set xtics font 'DejaVuSans,8' ; plot 'temp/datad2.csv' using (\$2*0.5):0:(\$2*0.5):(0.3):yticlabels(1) with boxxyerrorbars t ''" | gnuplot

    end_time=$(date +%s)
    echo "Finished d2 data file process and plot in $(( end_time - start_time )) seconds."
}

d3_process()
{
	 echo 'starting d3 process ...'
	 start_time=$(date +%s)
	 
	awk -F';' 'NR > 1 { key=$6";"$1; if (!(key in driver_array)) { driver_array[key] = 1; array[$6]++; }} END { for (i in array) { print i ";" array[i]; }}' "$CSV_PATH" | sort -t';' -k2 -n | head -n10 > temp/datad3.csv
    # NR > 1 Removes the useless first line containing data infos
    
    # AWK - 
    #   key=$6";"$1 creates a key for each line <drivername>;<routeid>
    #   if the combination of routeid/driver doesnt exist, add it to driver_array. So we can know how much times drivers did a different routeid
    #   Now we create a new array, wich will add one to every different key for each driver. => number of different routes per driver in associative array
    #   Next, we send <drivername>;<number_of_occurrences> in the sort command with a pipe.
    #
    # Now we can sort driver names, most routes at the top, less routes at the bottom of file 
    # keeps first 10 drivers, prints them in temp/datad1.csv
    
	echo "set title 'Option -d3 : Nb routes = f(Driver)' ; set xtics font 'DejaVuSans,8' ; set yrange [-1:10] ; set style fill solid border -1 ; set xlabel 'NB ROUTES' ; set ylabel 'DRIVER NAMES' ; set datafile separator ';' ; set terminal png ; set output 'images/d3.png' ; plot 'temp/datad3.csv' using (\$2*0.5):0:(\$2*0.5):(0.3):yticlabels(1) with boxxyerrorbars t ''" | gnuplot
	
	end_time=$(date +%s)
    echo "Finished d3 data file process and plot in $(( end_time - start_time )) seconds."
}

d4_process()
{
    echo 'Starting d4 process ...'
    start_time=$(date +%s)

    # Creates csv with last 10 drivers <driver_name>;<distance> in temp/datad4.csv
    awk -F';' ' NR > 1 {distance_array[$6]+=$5} END {for (i in distance_array) print i ";" distance_array[i]}' "$CSV_PATH" | sort -t';' -k2 -n | head -n10 > temp/datad4.csv
    # NR > 1 : Removes the useless first line containing data infos
    
    # AWK - 
    #   {distance_array[$6]+=$5} : creates associative array with the 6th field (driver name), and add every distance (5th field) to the associated driver
    #   END : Waits for all lines to be processed. 
    #   {for (i in distance_array) print i ";" distance_array[i]} : formates the output file to be <driver_name>;<distance>
    # 
    # Now we can sort driver names, most routes at the bottom, most routes at the bottom of file
    # keeps first 10 drivers and prints them in temp/datad4.csv

    echo 'Generating d4 histogram ...'

    echo "set title 'Option -d4 : Distance = f(Driver)' ; set yrange [-1:10] ; set style fill solid border -1; set xlabel 'DISTANCE (km)' ; set ylabel 'DRIVER NAMES' ; set datafile separator ';' ; set terminal png ; set output 'images/d4.png' ; set xtics font 'DejaVuSans,8' ; plot 'temp/datad4.csv' using (\$2*0.5):0:(\$2*0.5):(0.3):yticlabels(1) with boxxyerrorbars t ''" | gnuplot

    end_time=$(date +%s)
    echo "Finished d4 data file process and plot in $(( end_time - start_time )) seconds."
}

Lprocess()
{
    echo 'Starting L process ...'
    start_time=$(date +%s)

    awk -F';' ' NR > 1 {route_array[$1]+=$5} END {for (i in route_array) print i ";" route_array[i]}' "$CSV_PATH" | sort -t';' -k2 -n | tail -n10 | sort -r > temp/dataL.csv
    # NR > 1 : Removes the useless first line containing data infos
    # 
    # AWK - 
    #   {route_array[$1]+=$5} : creates associative array with the 1th field (route id), and add every distance (5th field) to the associated route
    #   END : Waits for all lines to be processed. 
    #   {for (i in route_array) print i ";" route_array[i]} : formates the output file to be <route_id>;<total_distance>
    # 
    # sorts total route distances, most distance at the bottom, less distance at the top of file 
    # keeps last 10 drivers
    # sorts route id then prints them in temp/dataL.csv

    echo 'Generating L histogram ...'

    echo "set title 'Option -l : Distance = f(Route)' ; set ytics 500 ; set yrange [0:*] ; set datafile separator ';' ; set xtics font 'DejaVuSans,8' ; set xlabel 'Route ID' ; set ylabel 'DISTANCE (km)' ; set style data histograms ; set style fill solid border -1 ; set terminal png ; set output 'images/L.png' ; plot 'temp/dataL.csv' using 2:xticlabels(1) notitle" | gnuplot

    end_time=$(date +%s)
    echo "Finished L data file process and plot in $(( end_time - start_time )) seconds."
}

Tprocess()
{

    # 1. Make the executable by calling makefile
    cd progc/makefileFolder
    make t
    cd ../..

    echo 'Starting T process ...'
    start_time=$(date +%s)

    # 2. Run Tprocess
    ./temp/Tprocess "$CSV_PATH"

    # 3. Create plot
    echo 'Generating Clustered histogram ...'
    echo "set terminal png ; set output 'images/T.png' ; set title 'Option -t : Nb routes = f(Towns)' ; set style data histogram ; set style histogram clustered ; set style fill solid border -1 ; set boxwidth 0.9 ; set xtics rotate by -45 ; set xlabel 'TOWN NAMES' font 'DejaVuSans,8' ; set ylabel 'NB ROUTES' ; set datafile separator ';' ; plot 'temp/dataT.csv' using 2:xtic(1) title 'Total routes', '' using 3 title 'First town'" | gnuplot

    end_time=$(date +%s)
    echo "Finished T data file process and plot in $(( end_time - start_time )) seconds."
}

Sprocess()
{

    # 1. Make the executable by calling makefile
    cd progc/makefileFolder
    make s
    cd ../..

    echo 'Starting S process ...'
    start_time=$(date +%s)
    
    # 2. Run Tprocess
    ./temp/Sprocess "$CSV_PATH"

    # 3. Create plot
    echo 'Generating filledcurves plot ...'
    echo "file = 'temp/dataS.csv'; set terminal png; set output 'images/S.png'; set datafile separator ';'; set title 'Option -s : Distance = f(Route)'; set xlabel 'ROUTE ID'; set ylabel 'DISTANCE (km)'; set xtics rotate by -45 scale 0 font ',8'; plot file using 0:5:3 with filledcurves title 'Distances Max/Min (km)', file using 0:4 smooth mcs with lines title 'Distance average (km)'" | gnuplot


    end_time=$(date +%s)
    echo "Finished S data file process and plot in $(( end_time - start_time )) seconds."
}

Pprocess()
{
while IFS= read -r line; do
    echo -e "\e[32m$line\e[0m"
    sleep 0.1
done < 'ascii/art.txt'
}


print_help()
{
    echo 'Welcome to the DOCUMENTATION ;D
Usage : "./main.sh <path-to-csv-file> [OPTION1] [OPTION2] [...] [OPTION5]"
Options : 
	- h : prints this help message. It ignores all other options if used.
	- d1 : creates an horizontal histogram in "images/" with top 10 drivers by number of routes.
	- d2 : creates an horizontal histogram in "images/" with top 10 drivers by number of kilometers traveled.
	- d3 : creates an horizontal histogram in "images/" with last 10 drivers by number of routes.
	- d4 : creates an horizontal histogram in "images/" with top 10 drivers by number of kilometers traveled.
	- l : creates a vertical histogram in "images/" with top 10 longest routes.
	- t : creates a grouped histogram in "images/" with top 10 cities visited by the routes.
	- s : creates a graphic  with max/min et average distance per step for 50 routes.
 	- w : create a fabulous Welcome text animation.
  	- p : it'\''s an easter egg.

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

if [[ $# -lt 2 ]] || [[ $# -gt 10 ]] ; then # If number of options is lower than 2 or higher (both strict) than 5, error.
    echo 'Wrong number of options -> ./main.sh <path_to_data_file> -h for help.' >&2
    exit 1
elif [[ ! -f "$1" ]] ; then # Checks if first option is the csv.
    echo 'The first option must be the path to csv -> ./main.sh <path_to_data_file> -h for help.' >&2
    exit 2
fi

CSV_PATH="$1" # Saves the path of the csv (first option) before using SHIFT command
shift # Shifts to the first option
declare -a options_array=("$@") # Saves entered options (exept path) in an array
checkh=0
checkd1=0
checkd2=0
checkd3=0
checkd4=0
checkl=0
checkt=0
checks=0
checkp=0
checkw=0

for i in "${options_array[@]}" # Checks if there are wrong options, -h, or more than one given option 
do
    case "$i" in 
        "-h" ) 
            ((checkh++));;
        "-d1" )
            ((checkd1++));;
        "-d2" )
            ((checkd2++));;
        "-d3" )
            ((checkd3++));;
        "-d4" )
            ((checkd4++));;
        "-l" ) 
            ((checkl++));;
        "-t" )
            ((checkt++));;
	    "-p" )
            ((checkp++));;
        "-w" )
            ((checkw++));;
        "-s" ) 
            ((checks++));;
        *) # If there are, exit program
            echo 'One or more specified options are not valid -> ./main.sh <path_to_data_file> -h for help.' >&2
            exit 3 
            ;;
    esac
done

if [ "$checkh" -gt 1 ] || [ "$checkd1" -gt 1 ] || [ "$checkd2" -gt 1 ] || [ "$checkd3" -gt 1 ] || [ "$checkd4" -gt 1 ] || [ "$checkl" -gt 1 ] || [ "$checkt" -gt 1 ] || [ "$checks" -gt 1 ] || [ "$checkp" -gt 1 ] ||  [ "$checkw" -gt 1 ]; then # If there is -h and no wrong option, print help
    echo 'You must specify option only one time.'
    exit 0
elif [ "$checkh" -eq 1 ]; then
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

if [ ! -f 'progc/cfiles/main_T.c' ] || [ ! -f 'progc/headers/header_T.h' ] || [ ! -f 'progc/makefileFolder/makefile' ] || [ ! -f 'progc/cfiles/main_S.c' ] || [ ! -f 'progc/headers/header_S.h' ] ; then # Checks if c, header or makefile file are missing
    echo 'C file and/or header and/or makefile are missing from "progc/"' >&2
    exit 4
fi

# Plays music to wait for the processes
paplay "music.mp3" &

start_time=$(date +%s)
echo 'Checking if the data file you gave is valid or not. Please wait (8s max)'
if [ "$(awk -F';' ' NR > 1 {a[$1]++} END {for (i in a) if (a[i] >= 1) count++} END { print count }' "$CSV_PATH")" -lt 50 ] ; then # If the number of lines is lower than 50
    echo 'The data file you gave is not valid. Must be more than 50 uniques RouteId' >&2
    kill $(pgrep paplay)
    exit 6
fi
end_time=$(date +%s)
echo "File is valid. Operation took $(( end_time - start_time )) seconds."


# ------------------------------ MAIN PROCESS OF OPTIONS ------------------------------ 

while [ "$#" -gt 0 ] ; do # Process every options 
    case "$1" in 
        "-d1") 
            d1_process
            ;;
        "-d2") 
            d2_process
            ;;
        "-d3") 
            d3_process
            ;;
        "-d4") 
            d4_process
            ;;
        "-l") 
            Lprocess 
            ;;
        "-t") 
            Tprocess 
            ;;
	    "-p") 
            Pprocess 
            ;;
        "-w") 
            Wprocess 
            ;;
        "-s") 
            Sprocess
            ;;
    esac
    shift
done 

# Ends music
kill $(pgrep paplay)
