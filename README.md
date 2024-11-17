## SMCalc - Software Metrics Calculator

This is a RASCAL program that analyses Java projects and prints analysis of their different metrics to the terminal.

## Project layout

* Main.rsc file contains main() function that calls runAnalysisOn(loc) on different files. Change files by uncommenting lines;
* metrics directory contains logic for different metric calculations;
* utils directory contains general methods used by the application;
* tests directory contains files that test the functionality of the software metric calculation methods;

## Instructions

#### Running SMCalc

Follow the instructions below to run the program:

* Install VSCode on your machine;
* Install the ""Rascal Metaprogramming Language"" extension;
* Press the key combination Ctrl / Cmd + Shift + P and then choose "Create Rascal Terminal";
* In the terminal run the command `import Main;`
* Then run the following command `main();`

You should see the analysis being printed out in the terminal. The program uses relative paths to the CWD (current working directory). Make sure that your CWD is the root directory of this repository (the rascal terminal should be launched here). An alternative way of running the program is to import the projects from test-projects directory to you workspace. If that is what is needed, then the project constants in the Main.main() method should be changed to the constants with the prefix PROJECT instead of CWD.

#### Testing SMCalc

It is assumed that you already have VSCode installed on your machine and have the Rascal Metaprogramming Language extension present. Follow the instructions below to run the tests:

* Launch rascal terminal;
* Import all test files with `import tests::<TestClassName>;`
* Run the command `:test`

You should see the output in the rascal terminal.

## Report

Report can be found [here](report.pdf).

## Copyrights

Authors: Vakaris Paulavičius and Ilia Balandin

MSc Software Engineering, Software Evolution, University of Amsterdam, 2024
