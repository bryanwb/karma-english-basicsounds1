package
{
 	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.text.*;
	import flash.external.*;

	public class lessonStarting extends Sprite
	{
		var conn:LocalConnection;
		var lessonArray:Array=new Array();
		static var pwd:String;//present working directory
		
		function lessonStarting()
		{
			
			conn = new LocalConnection();
            conn.client = this;
            try 
			{
                conn.connect("LESSON");//naming connection for calling this swf file.......
            } 
			catch (error:ArgumentError) 
			{
				trace(error);

            }		
			for(var i:uint=0;i<7;i++)//here there is only 1 element
				lessonArray.push("f");
				
			conn.addEventListener(StatusEvent.STATUS, onStatus);
			conn.send("FRAMEWORK","getNumLessonTab",lessonArray.length);//calling FRAMEWORK for returning number of tab in Lesson window..	
			//showLesson(2);
		}
		
		private function onStatus(event:StatusEvent):void 
		{
            switch (event.level) 
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
            }
	 	}
		
	/*	
		public function stopSound() : void
		{
			for (var i = 1; i < lessonArray.length; i++)
			{
				if (lessonArray[0] != "f")
				{
					lessonArray[0].channel.stop();
					lessonArray[0].stopTalking(null);
				}
				else if (lessonArray[1] != "f")
				{
					lessonArray[1].channel.stop();
					lessonArray[1].stopTalking(null);
				}
				else if (lessonArray[2] != "f")
				{
					lessonArray[2].channel.stop();
					lessonArray[2].stopTalking(null);
				}
				else if (lessonArray[3] != "f" )
				{
					lessonArray[3].channel.stop();
					lessonArray[3].stopTalking(null);
				}
				else if (lessonArray[4] != "f")
				{
					lessonArray[4].channel.stop();
					lessonArray[4].stopTalking(null);
				}
				else if (lessonArray[5] != "f")
				{
					lessonArray[5].channel.stop();
					lessonArray[5].stopTalking(null);
				}
				else if (lessonArray[6] != "f" )
				{
					lessonArray[6].channel.stop();
					lessonArray[6].stopTalking(null);
				}
				else if (lessonArray[7] != "f")
				{
					lessonArray[7].channel.stop();
					lessonArray[7].stopTalking(null);
				}
			}
		}
		*/

		
		
		public function showLesson(num:uint,path:String):void
		{
			//this.stopSound();
			pwd = path;
				for(var i=0;i<this.numChildren;i++)
					this.removeChildAt(0);
					
					if(lessonArray[num-1] != "f")//not for first time
					{
						this.addChild(lessonArray[num-1]);
					}
					else//for first time
					{
						switch(num)
						{		
							case 1:
							lessonArray[num-1] = new Lesson1;														
							break;
							
														
							case 2:
							lessonArray[num-1] = new Lesson2;							
							break;
							
							case 3:
							lessonArray[num-1] = new Lesson3;														
							break;							
														
							case 4:
							lessonArray[num-1] = new Lesson4;							
							break;
							
							case 5:
							lessonArray[num-1] = new Lesson5;							
							break;
							
							case 6:
							lessonArray[num-1] = new Lesson6;														
							break;
							
							case 7:
							lessonArray[num-1] = new Lesson7;							
							break;
							
							
						}
						lessonArray[num-1].x = 22;
						lessonArray[num-1].y = 73; 
						this.addChild(lessonArray[num-1]);
					}
					
		}
		
	}//end of class
}//end of package