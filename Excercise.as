package
{
	import flash.display.*;
	import flash.media.*;
	import flash.text.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*
	//import fl.controls.*;	
	
	public class Excercise extends Sprite
	{
		var levelObject;
		var sectime:int;
		var mintime:int;
		var tm:DisplayTimer;
		static var arrSound:Array = new Array("b","c","d","f","g","h","j","b","d","f");
		var arrRightWords:Array;
		var arrWrongWords:Array;
		var arrWordList:Array;
		var chkImg:Check;
		var intClickedNum:int;
		var strSelectedSound:String;
		var channel : SoundChannel;
		var globalTimer:Timer;
		static var TotalTime:int;
		var boolFirstTime:Boolean = true;
		var conn:LocalConnection;
		var currentQuestion:int;
		var arrWordCollection:Array;
		var arrWrongList:Array;

	function Excercise(questNum:uint,levNo:uint)
	{
		currentQuestion = questNum;
		arrWrongList = new Array("lace","mat","mirror","monkey","lamp","meat","net","nurse","pencil","nail","pen","spoon","lamp","palace","people","parent","name","rope","paste","master");
		
		
		strSelectedSound = arrSound[Math.floor(Math.random() * arrSound.length)];

		switch(strSelectedSound)
		{
			case "b":
			arrWordCollection = new Array("ball","bee","book","table","dustbin","football","butterfly","bed","bread","bird");
			break;
			
			case "c":
			arrWordCollection = new Array("cat","comb","cup","doctor","staircase","photocopy","car","cow","calf","cloth");
			break;
			
			case "d":
			arrWordCollection = new Array("door","duck","deer","video","slide","bed","card","desk","wood","drum");
			break;
			
			case "f":
			arrWordCollection = new Array("fish","frog","flower","calf","butterfly","knife","file","flag","film","food");
			break;
			
			case "g":
			arrWordCollection = new Array("goat","gate","garland","bag","tiger","pig","game","glass","mango","yogi");
			break;
			
			case "h":
			arrWordCollection = new Array("horse","hand","helmet","hen","hanger","hundred","hill","hermit","hammer","history");
			break;
			
			case "j":
			arrWordCollection = new Array("jug","jar","juice","jam","joker","jet","jump","judge","jungle","jelly");
			break;
			
		}
		tm = new DisplayTimer();
		tm.x=240;
		tm.y=-20;
		
		
		globalTimer = new Timer(1000);
		globalTimer.addEventListener(TimerEvent.TIMER,changingScore);			
		

		arrSound.splice(arrSound.indexOf(strSelectedSound),1);
		switch(Math.ceil(Math.random() * 3))
		{
			case 1:
			levelObject = new Template1();
			break;
			
			case 2:
			levelObject = new Template2();
			break;
			
			case 3:
			levelObject = new Template3();
			break;			
		}
		this.addChild(levelObject);
		var btnStart:Start = new Start();
		btnStart.x = 265;
		btnStart.y = 6;
		btnStart.scaleX = 0.4;
		btnStart.scaleY = 0.4;
		this.addChild(btnStart);
		btnStart.addEventListener(MouseEvent.CLICK,startActivity);
		//this.addChild(tm);
		levelObject.btnSpeaker.addEventListener(MouseEvent.CLICK,playSound);
		
		
		
	}
	function startActivity(evt:MouseEvent)
	{
		this.addChild(tm);
		globalTimer.start();
		evt.target.removeEventListener(MouseEvent.CLICK,startActivity);
		this.removeChild(SimpleButton(evt.target));
		this.playSound(null);
		this.getWrongRandomWords(arrWrongList);
		this.getRightRandomWords(arrWordCollection);
		this.getAllWords();
		this.fillWords();
	}
	function playSound(evt:MouseEvent)
	{
		var sound : Sound;
		
		if(channel != null)
			channel.stop();
		sound=new Sound();//"Assets/" + stringToLoad + ".swf"
		trace("is from ",strSelectedSound);
	sound.load(new URLRequest(Starting.pwd + "Activities/2_English_BasicSounds1_2_swf/sound/"+ strSelectedSound+".mp3"));
	//sound.load(new URLRequest("sound/"+strSelectedSound+".mp3"));
	channel=sound.play(0,1);
		
	}
	function fillWords()
	{
		var intTmp:int;
		var txtFormat:TextFormat = new TextFormat();
		txtFormat.bold= true;
		txtFormat.size = 30;
		txtFormat.font = "Verdana";
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button1.txtWord.defaultTextFormat = txtFormat;
		levelObject.button1.txtWord.text = arrWordList[intTmp];
		levelObject.button1.buttonMode = true;
		levelObject.button1.txtWord.mouseEnabled = false;
		levelObject.button1.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button2.txtWord.defaultTextFormat = txtFormat;
		levelObject.button2.txtWord.text = arrWordList[intTmp];
		levelObject.button2.buttonMode = true;
		levelObject.button2.txtWord.mouseEnabled = false;
		levelObject.button2.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button3.txtWord.defaultTextFormat = txtFormat;
		levelObject.button3.txtWord.text = arrWordList[intTmp];
		levelObject.button3.buttonMode = true;
		levelObject.button3.txtWord.mouseEnabled = false;
		levelObject.button3.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button4.txtWord.defaultTextFormat = txtFormat;
		levelObject.button4.txtWord.text = arrWordList[intTmp];
		levelObject.button4.buttonMode = true;
		levelObject.button4.txtWord.mouseEnabled = false;
		levelObject.button4.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button5.txtWord.defaultTextFormat = txtFormat;
		levelObject.button5.txtWord.text = arrWordList[intTmp];
		levelObject.button5.buttonMode = true;
		levelObject.button5.txtWord.mouseEnabled = false;
		levelObject.button5.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button6.txtWord.defaultTextFormat = txtFormat;
		levelObject.button6.txtWord.text = arrWordList[intTmp];
		levelObject.button6.buttonMode = true;
		levelObject.button6.txtWord.mouseEnabled = false;
		levelObject.button6.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button7.txtWord.defaultTextFormat = txtFormat;
		levelObject.button7.txtWord.text = arrWordList[intTmp];
		levelObject.button7.buttonMode = true;
		levelObject.button7.txtWord.mouseEnabled = false;
		levelObject.button7.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button8.txtWord.defaultTextFormat = txtFormat;
		levelObject.button8.txtWord.text = arrWordList[intTmp];
		levelObject.button8.buttonMode = true;
		levelObject.button8.txtWord.mouseEnabled = false;
		levelObject.button8.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button9.txtWord.defaultTextFormat = txtFormat;
		levelObject.button9.txtWord.text = arrWordList[intTmp];
		levelObject.button9.buttonMode = true;
		levelObject.button9.txtWord.mouseEnabled = false;
		levelObject.button9.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
		
		intTmp = Math.floor(arrWordList.length * Math.random());
		levelObject.button10.txtWord.defaultTextFormat = txtFormat;
		levelObject.button10.txtWord.text = arrWordList[intTmp];
		levelObject.button10.buttonMode = true;
		levelObject.button10.txtWord.mouseEnabled = false;
		levelObject.button10.addEventListener(MouseEvent.CLICK,checkAns);
		arrWordList.splice(intTmp,1);
	}
	function checkAns(evt:MouseEvent)
	{
		if(intClickedNum == 5)
		{
			return;
		}
		chkImg = new Check();
		conn= new LocalConnection();//for calling function of FRAMEWORK
		if(arrRightWords.indexOf(MovieClip(evt.target).txtWord.text) != -1)
		{
			chkImg.gotoAndStop(1);
			intClickedNum++;
		}
		else
		{
			chkImg.gotoAndStop(2);
			boolFirstTime = false;
			conn.send("FRAMEWORK","changeScore",currentQuestion+1,false);
		}
			
		chkImg.x=85;
		chkImg.y=15;
		chkImg.scaleX=0.12;
		chkImg.scaleY=0.12;
		MovieClip(evt.target).addChild(chkImg);
		evt.target.removeEventListener(MouseEvent.CLICK,checkAns);
		
		if(intClickedNum == 5)
		{
			globalTimer.stop();
			TotalTime = TotalTime + sectime + (mintime * 60);
			
			if(boolFirstTime)
				conn.send("FRAMEWORK","changeScore",currentQuestion+1,true);			
			//else
				
			if(Starting.completedQuestion == 10)
			{
				if(TotalTime <= 180)
					conn.send("FRAMEWORK", "exerciseGameStart", true);
			}
		}
	
	}
	function getWrongRandomWords(arrTemp:Array)
	{
		arrWrongWords = new Array();
		for(var i:uint;i<5;i++)
		{
			var strTemp:String = arrTemp[Math.floor(Math.random() * arrTemp.length)];
			arrTemp.splice(arrTemp.indexOf(strTemp),1);
			arrWrongWords.push(strTemp);			
		}	
	}
	
	function getRightRandomWords(arrTemp:Array)
	{
		arrRightWords = new Array();
		for(var i:uint;i<5;i++)
		{
			var strTemp:String = arrTemp[Math.floor(Math.random() * arrTemp.length)];
			arrTemp.splice(arrTemp.indexOf(strTemp),1);
			arrRightWords.push(strTemp);			
		}
	}
	function getAllWords()
	{
		arrWordList = new Array();
		for(var i:uint;i<5;i++)
		{
			arrWordList.push(arrRightWords[i]);
			arrWordList.push(arrWrongWords[i]);
		}
	}
	
	function changingScore(evt:TimerEvent)
	{
		sectime +=1;
		if(sectime >= 60)
		{
			mintime ++;			
			sectime = 0;
			
		}
		trace(sectime,mintime);
		tm.txtSec.text = sectime.toString();
		tm.txtMin.text = mintime.toString();	
		
	}
		




		
	}//end of class
}//end of package