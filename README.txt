-----------------------------------------------
FOLDER CONTENT
-----------------------------------------------
Project_Report.pdf - Project report file. 
Main.x10: The testbench for the project. 
          Opens a file of containing the knapsack arguments( namely, the capacity of knapsack, number of items, the weight and value of each item. ) supplied through the command line. Invokes the Implementation6.getValue method and Implementation7.getValue method 

Implementation6.x10: The file with the optimized sequential version of the knapsack.

Implementation7.x10: The file with the parallel multi-threaded version of knapsack. The number of threads to be used should be set here by setting the numThreads variable. Currently it is set to 8.

Implementation4.x10: Our attempt at the multi-place version. Though it gives functionally correct results, there is too much overhead due to which it performs poorly.

Makefile: A minimal Makefile to compile and run the project.

make run - Compiles the project
make clean - Cleans the folder content to enable a fresh compile.
./run <file> - runs the project - file can be any of the testcase files provided in the folder or any other file in that format.

