package com.googlemate.ui.presentation
{	
	import com.googlemate.model.constants.Constants;
	import com.googlemate.ui.Main;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Screen;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import mx.core.Application;
	
	/**
	 *  Application Presentation Model
	 */
	public class ApplicationPresentationModel
	{
		// ----------------------------------------------------------------------------
		// Private Methods
		// ----------------------------------------------------------------------------
		
		/**
		 * Initialize
		 */ 	
        private function init():void
        {
        	nativeApplication.autoExit = true;
        	
        	// center splash screen
        	var screenBounds:Rectangle = Screen.mainScreen.bounds;
            nativeWindow.x = (screenBounds.width - nativeWindow.width) / 2;
            nativeWindow.y = (screenBounds.height - nativeWindow.height) / 2;
            
            // splash screen timer
            splashScreenTimer = new Timer(1000);
            splashScreenTimer.addEventListener(TimerEvent.TIMER, incrementSplashScreenElapsedTime);
            splashScreenTimer.start();
        }

		/**
		 * Increment splash screen elapsed time
		 */ 
        private function incrementSplashScreenElapsedTime(event:TimerEvent):void
        {
            splashScreenElapsedTime++;
            
            if ( SPLASH_SCREEN_DELAY - splashScreenElapsedTime == 0 )
            {
            	// splash screen timer
                splashScreenTimer.stop();
                splashScreenTimer.removeEventListener(TimerEvent.TIMER, incrementSplashScreenElapsedTime);
                splashScreenTimer = null;

				// close splash screen
				nativeWindow.close();

				// open new window for the main view
                mainView = new Main();
				mainView.open();
            }
        }
 
		// ----------------------------------------------------------------------------
		// Private Properties
		// ----------------------------------------------------------------------------
		
		/**
		 * Splash screen delay
		 */ 
		private const SPLASH_SCREEN_DELAY:int = Constants.SPLASH_SCREEN_DELAY;
		
		/**
		 * Splash screen elapsed time
		 */ 
		private var splashScreenElapsedTime:int = 0;
		
		/**
		 * Splash screen timer
		 */ 
		private var splashScreenTimer:Timer;
		
		/**
		 * Main View - loads after splash screen is closed
		 */ 
		private var mainView:Main;
		
		/**
		 * Native Application
		 */ 
		private var nativeApplication:NativeApplication = Application.application.nativeApplication;
		
		/**
		 * Native Window
		 */ 
		private var nativeWindow:NativeWindow = Application.application.nativeWindow;
		
		// ----------------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function ApplicationPresentationModel()
		{
			init();
		}
		
	}
}