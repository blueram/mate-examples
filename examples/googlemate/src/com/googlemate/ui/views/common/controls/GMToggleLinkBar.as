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
	    	
	    	setLinkEnabled( newLink as LinkButton );

	    	return newLink;
	    }
	    
	    /**
	     *  commitProperties
	     */
	    override protected function commitProperties():void
	    {
	        super.commitProperties();
	
			disableSelectedLink( selectedIndex );
	    }
    
    	/**
	     *  clickHandler
	     */
	    override protected function clickHandler(event:MouseEvent):void
	    {
			super.clickHandler(event);
	        
	        var index:int = getChildIndex(Button(event.currentTarget));
	        
	        disableSelectedLink( index );
	    }
	    
    	/**
	     *  disableSelectedLink
	     */
	    public function disableSelectedLink( index:int ):void
	    {
	    	// enable all
	        for (var i:int = 0; i < numChildren; i++)
			{
				if (getChildAt(i) is LinkButton)
				{
					setLinkEnabled( getChildAt(i) as LinkButton );
				}
			}
			
			// disable selected link
			setLinkEnabled( getChildAt(index) as LinkButton, false );
	    }
	    
	    /**
	     *  setLinkEnabled
	     */
	    public function setLinkEnabled( link:LinkButton, enable:Boolean=true ):void
	    {
	    	if ( link )
	    	{
	    		link.enabled = enable;
		    	link.buttonMode = enable;
		    	link.mouseEnabled = enable;
		    	link.focusEnabled = false;
		    	link.setStyle("textDecoration", (enable ? "underline" : "none") );
	    	}			
	    } 
	}
}
