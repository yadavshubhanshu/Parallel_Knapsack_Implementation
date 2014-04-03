import x10.util.Timer;
import x10.io.File;
import x10.util.ArrayList;
import x10.lang.Exception;
import x10.io.FileNotFoundException;
import x10.array.*;




public class Implementation6 {

	public static def max(a:long,b:long):long
	{
		return	( (a>b)?a:b );
	}

	
	public static def getValue(things:long,capacity:long,value:ArrayList[long],weight:ArrayList[long]):long {
		
		val c = capacity;
		var items:long = things;
		var value_array:ArrayList[long] = value;
		var weight_array:ArrayList[long] = weight;
		

		val time = System.nanoTime();	
		
		
		var temp_array:ArrayList[long] = new ArrayList[long](c+1);
		var profit_array:ArrayList[long] = new ArrayList[long](c+1);
		val keep = new Array_2[long](items+1,c+1,(i:long,j:long)=>0 as long);

		
		for(j in 0..c){
			profit_array(j) = 0;
			temp_array(j) = 0;
		}
		
		
		for (i in 1..items) {
			
			val buf = temp_array;
			
			for(k in 0..c){temp_array(k) = profit_array(k);}
			for(k in 0..c){profit_array(k) = buf(k);}						

			for(j in 1..c){
				if( j<weight_array(i) ){
					profit_array(j) = temp_array(j);
					keep(i,j) = 0;
				}
				else{
					profit_array(j) = max(temp_array(j),value_array(i)+temp_array(j-weight_array(i)));
					if(profit_array(j)==temp_array(j)){keep(i,j)=0;}else{keep(i,j) = 1;}
				}
			}
			
			
		}

		var w:long = c;
		
		Console.OUT.println("The items being used(given by sequential implementation) are : ");

		for(var i:long = items;i>=1;i--){
			if(keep(i,w) == 1){
				Console.OUT.print(i+ " ");
				w = w-weight_array(i);
			}

		}
		Console.OUT.println();
		Console.OUT.println("The time taken for sequential is "+ (System.nanoTime()-time)/1000000);		
		return profit_array(c);
	}
	
}