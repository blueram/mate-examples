package com.googlemate.ui.views.common.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.LinkBar;
	import mx.controls.LinkButton;
	import mx.core.IFlexDisplayObject;

	public class GMToggleLinkBar extends LinkBar
	{
		/**
	     *  Constructor
	     */
	    public function GMToggleLinkBar()
	    {
	        super();
	    }
    
		/**
	     *  createNavItem
	     */
	    override protected function createNavItem(label:String, icon:Class = null):IFlexDisplayObject
	    {
	    	var newLink:Button = Button(super.createNavItem(label, icon));
	    	
	    	enableLink( newLink as LinkButton );

	    	return newLink;
	    }
	    
	    /**
	     *  clickHandler
	     */
	    override protected function clickHandler(event:MouseEvent):void
	    {
			super.clickHandler(event);
	        
	        var index:int = getChildIndex(Button(event.currentTarget));
	        
	        // enable all
	        for (var i:int = 0; i < numChildren; i++)
			{
				if (getChildAt(i) is LinkButton)
				{
					enableLink( getChildAt(i) as LinkButton );
				}
			}
			
			// disable clicked link
			enableLink( getChildAt(index) as LinkButton, false );
	    }
	    
	    /**
	     *  enableLink
	     */
	    public function enableLink( link:LinkButton, enable:Boolean=true ):void
	    {		
	    	link.enabled = enable;
	    	link.buttonMode = enable;
	    	link.mouseEnabled = enable;
	    	link.focusEnabled = false;
	    	link.setStyle("textDecoration", (enable ? "underline" : "none") );
	    }
	    
	}
}
