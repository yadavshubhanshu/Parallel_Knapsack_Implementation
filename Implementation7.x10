import x10.util.Random;
import x10.util.ArrayList;
import x10.array.*;
import x10.io.File;
import x10.lang.Exception;
import x10.io.FileNotFoundException;


public class Implementation7 {
	
	
	public static def max(a:long,b:long):long
	{
		return	( (a>b)?a:b );
	}
	
	public static def getValue(things:long,capacity:long,value:ArrayList[long],weight:ArrayList[long]):long {
	
		val nThreads:long = 8;					
		val c = capacity;
		var items:long = things;
		var value_array:ArrayList[long] = value;
		var weight_array:ArrayList[long] = weight;
		var temp_array:ArrayList[long] = new ArrayList[long](c+1);
		var result:long = 0;

 
		var partitionSize:long = 0; 
		var numpartition:long = 0;  
		partitionSize = max(1, c / nThreads);
		numpartition = c / partitionSize + ((c % partitionSize == 0) ? 0 : 1);

		val time = System.nanoTime();		
		var profit_array:Array_2[long] = new Array_2[long](nThreads,c+2,(i:long,j:long)=>0 as long);
		val keep = new Array_2[long](items+1,c+1,(i:long,j:long)=>0 as long);
		val partitionState = new ArrayList[long](nThreads);
		
		for (thread in (0..(nThreads - 2))) {
			partitionState(thread) = -1;
		}
		
		partitionState(nThreads - 1) = numpartition - 1;
		
		finish for (thread in (0..(nThreads - 1))) {
			async {
				var row:long = thread + 1;
				var id:long;
				while (row <= weight.size()) {
					id = row - 1;
					val prevT:long = (thread - 1 + nThreads) % nThreads;
					while (partitionState(thread) == numpartition - 1) {
					
					}
					
					for (bi in (0..(numpartition - 1))) {
					
						when (partitionState(prevT) >= bi) {
							
							val start:long = bi * partitionSize;
							val end:long = bi == numpartition - 1 ? c : start + partitionSize - 1;
							for (w in (start..end)) {
							
								if (weight(id) > w) {
									profit_array(thread, w) = profit_array(prevT, w);
									keep(id,w) = 0;
								} else {
									profit_array(thread, w) = max(profit_array(prevT, w), profit_array(prevT, w - weight(id)) + value(id));
									if(profit_array(thread,w)==profit_array(prevT,w)){keep(id,w)=0;}else{keep(id,w) = 1;}

								}
							}
						}
						partitionState(thread) = bi;
					}
						
					partitionState(prevT) = -1;

					if (row == weight.size()) {
						result = profit_array(thread, c);
						break;
					}
					row += nThreads;
					
				}				
			}
		}
		var cap:long = c;
		
		Console.OUT.println("The items being used(given by parallel solution) are : ");

		for(var i:long = items;i>=1;i--){
			if(keep(i,cap) == 1){
				Console.OUT.print(i+ " ");
				cap = cap-weight_array(i);
			}

		}
		Console.OUT.println();

		Console.OUT.println("The time taken for parallel run is "+(System.nanoTime()-time)/1000000);
		return result;
	
	}
}