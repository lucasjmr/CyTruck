# CyTruck




## Authors

- [@lucasjmr](https://www.github.com/lucasjmr)

- [@Biggyy](https://www.github.com/Biggyy)

- [@WeKup](https://www.github.com/WeKup)


## Dependencies
```bash
  bash
```
```bash
  gnuplot
```
```bash
  make
```
```bash
  ggc
```
```bash
  pulseaudio (should be installed by default in Linux)

```



## How to use

- Download the game source files.
- Open a terminal window and navigate to the directory containing the source files.
- To run the program you need to type the following command:
```bibtex
./main.sh data/temp_data.csv with some more option like -w , -d1 and more than you will discover soon
```

## All the options

alright so now let's talk about the options of this project.
First of all let's talk about the mandatory options:

- Option D1: creates an horizontal histogram in "images" with top 10 drivers by number of routes.
- Option D2: creates an horizontal histogram in "images" with top 10 drivers by number of kilometers traveled.
- Option L: creates a vertical histogram in "images" with top 10 longest routes.
- Option T: creates a grouped histogram in "images" with top 10 cities visited by the routes.
- Option S: creates a graphic  with max/min et average distance per step for 50 routes.
- Option H: prints this help message. It ignores all other options if used.

Now the new options:
- Option D3: creates an horizontal histogram in "images" with last 10 drivers by number of routes.
- Option D4: creates an horizontal histogram in "images" with top 10 drivers by number of kilometers traveled.
- Option W: create a fabulous Welcome text animation.
- Option P: it's an easter egg.

commit 29/01/2024 : rien n'a changé

reste a faire : fixe le mainT.c
                VERIF QUE LES MUSIQUES SONT LA AVANT D'EXECUTER LES PROCESS
