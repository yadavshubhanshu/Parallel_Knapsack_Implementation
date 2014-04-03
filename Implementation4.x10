import x10.util.Timer;
import x10.io.File;
import x10.util.ArrayList;
import x10.lang.Exception;
import x10.io.FileNotFoundException;
import x10.array.*;


public class Implementation4 {

	public static def max(a:long,b:long):long
	{
		return	( (a>b)?a:b );
	}

	public static def getValue(things:long,capacity:long,value:ArrayList[long],weight:ArrayList[long]):long {
		Console.OUT.println("Starting Multi Place Execution\n");
		val a = Place.FIRST_PLACE;
		val c = capacity;
		val items = things;
		//val value_array = GlobalRef(value);
		//val weight_array = GlobalRef(weight);

		val time = System.nanoTime();

		val value_array:PlaceLocalHandle[ArrayList[long]] = PlaceLocalHandle.make[ArrayList[long]](PlaceGroup.WORLD, () => value);
		val weight_array:PlaceLocalHandle[ArrayList[long]] = PlaceLocalHandle.make[ArrayList[long]](PlaceGroup.WORLD, () => weight);


		val temp_array = new ArrayList[long](c+1);
		val temp_array2 = new ArrayList[long](c+1);
		for(j in 0..c){
				temp_array(j) = 0;
				temp_array2(j) = 0;
		}

		val temp_array_ref = GlobalRef(temp_array);
		val temp_array2_ref = GlobalRef(temp_array2);

		val profit_array = new DistArray_Block_1[long](c+1, (i:Long)=>0 as long);
		val keep = new Array_2[long](items+1,c+1,(i:long,j:long)=>0 as long);

		for(i in 1..items){
			finish{
			for(p in Place.places()) at(p) async {
				finish{for(pt in profit_array.localIndices()){
					val index = pt.coords()(0);
					if(index == 0)continue;
					val tempValue = temp_array_ref.getLocalOrCopy()(index);
					if(index<weight_array()(i)){
						profit_array(pt) = tempValue;
					}
					else{
						//val valueValue = value_array()(i);
						val index2 = index-weight_array()(i);
						val tempValue2 = value_array()(i) + temp_array_ref.getLocalOrCopy()(index2);
						profit_array(pt) = ((tempValue>tempValue2)?tempValue:tempValue2);
					}
					val transferItem = profit_array(pt);
					at(a){temp_array2_ref()(index) = transferItem;} 
				}
				}
			}
			}
			for(k in 0..c){
				if(temp_array2_ref()(k)==temp_array_ref()(k)){keep(i,k)=0;}else{keep(i,k)=1;}
				temp_array_ref()(k) = temp_array2_ref()(k);
			}
		}
		
		var cap:long = c;
		
		Console.OUT.println("The items being used(given by multi-place solution) are : ");

		for(var i:long = items;i>=1;i--){
			if(keep(i,cap) == 1){
				Console.OUT.print(i+ " ");
				cap = cap-weight_array()(i);
			}

		}

		Console.OUT.println();
		
		Console.OUT.println("The time taken for multi-place is "+ (System.nanoTime()-time)/1000000);		

		return temp_array(c);

	}



}