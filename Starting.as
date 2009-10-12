package{
 	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.external.*;

	
	
	public class Starting extends Sprite
	{
		

		
		var conn:LocalConnection;		
		var excerciseArray:Array;
		var activityName:String = new String();
		var levelNo:uint;
		static var completedQuestion:int;
		static var pwd:String;//present workin directory
		
		
		function Starting()
		{	
			//connection part will be here.........
			activityName = "Main";
			conn = new LocalConnection();
            conn.client = this;
            try 
			{
                conn.connect(activityName);
            } 
			catch (error:ArgumentError) 
			{
				//trace(error);
				var temptemp : TextField = new TextField();
				temptemp.text ="Can't connect to Activity...the connection name is already being used by another SWF";
				addChild(temptemp);
            }
			
			conn.addEventListener(StatusEvent.STATUS, onStatus);
		
			//this.toFramework();
			//listenLevel(1);
			
		}
		public function destroyActivity():void
		{
			conn.close();		
		
		}
//		private function toFramework():void//sending FRAMEWORK activity name
//		{
//			conn.send("FRAMEWORK","fromActivity",activityName);
//		}
		
		private function onStatus(evt:StatusEvent):void //dealing with status
		{
			switch (evt.level) 
			{
                case "status":
                 {   
				 	//trace("LocalConnection.send() succeeded");
					break;
				 }
				case "error":
				{
                   //trace("LocalConnection.send() failed");
					break;
				}
				case "warning":
					{
						//trace("warning");
					}
            }
	 	}
				
		public function listenLevel(lNo:uint,path:String)
		{
			levelNo=lNo;
			pwd = path;
			excerciseArray=new Array();
			for(var i:uint=0;i<10;i++)//hoping there are 10 number of tabs at level of an excerciseArray
				excerciseArray.push("f");//f is inserted to mark it is first time
			conn.send("FRAMEWORK","getNumExerciseTab",excerciseArray.length);//calling FRAMEWORK for returning number of tab in Lesson window..	
			this.listenQuestion(1,pwd);
		}
		
		public function listenQuestion(sNo:uint,path:String)//called by FRAMEWORK for changing question
		{
			pwd = path;
			for(var i=0;i<this.numChildren;i++)//removing from vision... not destroying
				this.removeChildAt(0);
				
				
			if(excerciseArray[sNo-1] != "f")//not for first time
			{
				this.addChild(excerciseArray[sNo-1]);//load already loaded from excerciseArray
			}
			else//for first time
			{
				
				excerciseArray[sNo-1]=new Excercise(sNo-1,levelNo);//loads new sprite
				this.addChild(excerciseArray[sNo-1]);
				completedQuestion++;
			}
	
			//addChild(this);
		}
		
	}		

}