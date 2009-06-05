package com.googlemate.ui.views.common.controls
{
	import com.googlemate.events.FavoriteEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.TileList;
	import mx.controls.listClasses.IListItemRenderer;
	
	[Event(name="addFavorite",type="com.googlemate.events.FavoriteEvent")]
	[Event(name="deleteFavorite",type="com.googlemate.events.FavoriteEvent")]
	
	public class GMTileList extends TileList
	{
		public function GMTileList()
		{
			super();
		}

	    /**
	     *  Favorites Flag
	     */
	    public var favorites:Boolean = false;
	    
	    /**
	     *  drawHighlightIndicator
	     */
	    override protected function drawHighlightIndicator(
                                indicator:Sprite, x:Number, y:Number,
                                width:Number, height:Number, color:uint,
                                itemRenderer:IListItemRenderer):void
	    {
	        /* don't want to draw the highlight indicator */
	    }
    
    	/**
	     *  drawSelectionIndicator
	     */
    	override protected function drawSelectionIndicator(
                                indicator:Sprite, x:Number, y:Number,
                                width:Number, height:Number, color:uint,
                                itemRenderer:IListItemRenderer):void
	    {
	        /* don't want to draw the selection indicator */
	    }
    
	    /**
	     *  drawFocus
	     */
	    override public function drawFocus(isFocused:Boolean):void
	    {
	    	/* don't want to draw the focus indicator */
	        return;
	    }
	    
	    /**
	     *  mouseUpHandler
	     */
	    override protected function mouseUpHandler(event:MouseEvent):void
	    {
			/* handling mouse events manually */
	    }
	    
	    /**
	     *  mouseDownHandler
	     */
	    override protected function mouseDownHandler(event:MouseEvent):void
	    {
			/* handling mouse events manually */
	    }
	    
	    /**
	     *  mouseClickHandler
	     */
	    override protected function mouseClickHandler(event:MouseEvent):void
	    {
	    	// don't dispatch the itemClick event if a button is clicked
	        if ( !(event.target is Button) )
	        {
	        	super.mouseClickHandler(event);
	        }
	    }
	}
}