package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author yukihiro
	 */
	public class Main extends Sprite 
	{
		private var loader:Loader;
		private var i:int;
		private var _xml:XML;
		public function Main():void 
		{
			init();
		}
		
		private function init():void 
		{					
			i = 1;
			var timer:Timer = new Timer(3000, 6);			
			timer.addEventListener(TimerEvent.TIMER, timerInterval);			
			timer.start();			
		}
		
		private function timerInterval(event:TimerEvent):void 
		{			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadDone);		
			loader.load(new URLRequest("img/" + i +".jpg"));						
			i++;		
		}
	
		private function loadDone(event:Event):void
		{
			var bmd:BitmapData = new BitmapData(loader.width, loader.height);
			
			var mtrx:Matrix = new Matrix();
			mtrx.translate(stage.stageWidth / 2, stage.stageHeight / 2);
			mtrx.scale(1 / 4, 1 / 4);
			bmd.draw(loader,mtrx);
			
			var bitmap:Bitmap = new Bitmap(bmd);
			bitmap.smoothing = true;
			bitmap.alpha = 0;
			bitmap.addEventListener(Event.ENTER_FRAME, startFade);			
			addChild(bitmap);			
		}	
		
		private function startFade(event:Event):void
		{
			if (event.target.alpha != 1) {
				event.target.alpha += .1;
			}
		}
	}	
}