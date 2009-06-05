package assets.skins
{
	import mx.core.EdgeMetrics;
	import mx.skins.Border;

	/**
	* The skin for all the states of a LinkButton.
	*/
	public class LinkButtonSkin extends Border
	{
	
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		* Constructor.
		*/
		public function LinkButtonSkin()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		// Overridden properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		// borderMetrics
		//----------------------------------
		
		/**
		* @private
		*/
		override public function get borderMetrics():EdgeMetrics
		{ 
			return EdgeMetrics.EMPTY;
		}
		
		//--------------------------------------------------------------------------
		//
		// Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		* @private
		*/
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
		
			var cornerRadius:Number = getStyle("cornerRadius");
			var rollOverColor:uint = getStyle("rollOverColor");
			var selectionColor:uint = getStyle("selectionColor");
		
			graphics.clear();
		
			switch (name)
			{ 
				case "upSkin":
				{
					// Draw invisible shape so we have a hit area.
					drawRoundRect(0, 0, w, h, cornerRadius, 0, 0);
					break;
				}
		
				case "overSkin":
				{
					// Draw invisible shape so we have a hit area.
					drawRoundRect(0, 0, w, h, cornerRadius, 0, 0);
					break;
				}
		
				case "downSkin":
				{
					// Draw invisible shape so we have a hit area.
					drawRoundRect(0, 0, w, h, cornerRadius, 0, 0);
					break;
				}
		
				case "disabledSkin":
				{
					// Draw invisible shape so we have a hit area.
					drawRoundRect(0, 0, w, h, cornerRadius, 0, 0);
					break;
				}
			}
		}
	}

}