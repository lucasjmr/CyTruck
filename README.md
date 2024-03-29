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
  pulseaudio (should be installed by default in any Linux system)

```



## How to use

- Download the source files.
- Open a terminal window and navigate to the directory containing the source files.
- To run the program you need to type the following command:
```bibtex
./main.sh <path-to-csv-file> [OPTION1] [OPTION2] [...] [OPTION...]"
```

## All the options

Mandatory options:

- Option D1: creates an horizontal histogram in "images" with top 10 drivers by number of routes.
- Option D2: creates an horizontal histogram in "images" with top 10 drivers by number of kilometers traveled.
- Option L: creates a vertical histogram in "images" with top 10 longest routes.
- Option T: creates a grouped histogram in "images" with top 10 cities visited by the routes.
- Option S: creates a graphic  with max/min et average distance per step for 50 routes.
- Option H: prints this help message. It ignores all other options if used.

Bonus options:
- Option D3: creates an horizontal histogram in "images" with last 10 drivers by number of routes.
- Option D4: creates an horizontal histogram in "images" with top 10 drivers by number of kilometers traveled.
- Option D5 : creates an horizontal histogram in "images" with top 10 routesID by number of steps.
- Option W: create a fabulous Welcome text animation.
- Option P: easter egg.
