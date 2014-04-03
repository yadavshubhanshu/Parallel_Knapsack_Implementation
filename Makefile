X10C=${X10_HOME}/bin/x10c++
FLAGS=-O

run: Main.x10 Implementation7.x10 Implementation6.x10
	$(X10C) $(FLAGS) -o $@ $^



clean:
	rm -f run *.h *.out *.err *.log *~ *.cc