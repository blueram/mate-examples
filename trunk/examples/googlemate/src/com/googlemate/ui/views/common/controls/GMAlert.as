package com.googlemate.ui.views.common.controls
{	
	import nl.flexperiments.display.AirAlert;
	
	public class GMAlert
	{
		/**
	     *  show
	     */
	    public static function show(text:String = "", title:String = "",
                                flags:uint = 0x4 /* Alert.OK */, 
                                closeHandler:Function = null, 
                                iconClass:Class = null, 
                                defaultButtonFlag:uint = 0x4 /* Alert.OK */,
                                button1Label:String = "",
                                button2Label:String = ""):AirAlert
    	{
    		var gmAlert:AirAlert;
			gmAlert = new AirAlert();
			
			gmAlert = AirAlert.show(text, title, flags, closeHandler, iconClass, defaultButtonFlag);
    		
			gmAlert.alertForm.textField.selectable = false;
			
			gmAlert.alertForm.buttons[0].buttonMode = true;
			gmAlert.alertForm.buttons[1].buttonMode = true;
			
			if (button1Label != "")
			{
				gmAlert.alertForm.buttons[0].label = button1Label;
			}
			
			if (button2Label != "")
			{
				gmAlert.alertForm.buttons[1].label = button2Label;
			}

    		return gmAlert;
    	}
	}
}
