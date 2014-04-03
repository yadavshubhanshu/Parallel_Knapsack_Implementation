import x10.util.Timer;
import x10.io.File;
import x10.util.ArrayList;
import x10.lang.Exception;
import x10.io.FileNotFoundException;
import x10.array.Array;

public class Main {
	

	public static def main(args:Rail[String]) {
		var F:File;
        if(args.size!=1) {
        	Console.ERR.println(args(0) + " is not valid file");
        	throw new IllegalArgumentException(args(0) + " is not a valid file");
        }
        
        val filename = args(0n);
        F  = new File(filename); 
        var lineCount:Int = 0n;

        var items:long = 0l;
        var capacity:long = 0l;
        val value_array = new ArrayList[long]();
        val weight_array = new ArrayList[long]();

        for (line in F.lines()) {

        	if(line.trim().length() == 0n) {
                continue;
            }
        	
        	if( line.charAt(0n) == '/') {
                Console.OUT.println(line);
                continue;
            }

            if(lineCount==0n) {

            	val splitFirstLine = line.split(" ");
            	items = Int.parse(splitFirstLine(0));
            	capacity = Int.parse(splitFirstLine(1));
            	value_array(lineCount) = 0;
            	weight_array(lineCount) = 0;
            	lineCount++;
            }
            else{

            	val splitLine = line.split(" ");
            	weight_array(lineCount) = Int.parse(splitLine(1));
            	value_array(lineCount) = Int.parse(splitLine(2));
            	lineCount++;
            }
        }
	
        var implementation:Implementation6 = new Implementation6();
        val value1 = implementation.getValue(items,capacity,value_array,weight_array);
	
	 var implementation2:Implementation7 = new Implementation7();
        val value2 = implementation2.getValue(items,capacity,value_array,weight_array);
	
        Console.OUT.println("The Knapsack solution is "+value2);
        
	}


}
