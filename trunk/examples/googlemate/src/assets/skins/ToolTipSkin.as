package assets.skins
{
import flash.display.Graphics;
import flash.display.SpreadMethod;
import flash.display.GradientType;
import flash.filters.DropShadowFilter;
import flash.geom.Matrix;

import mx.controls.ToolTip;
import mx.core.EdgeMetrics;
import mx.graphics.RectangularDropShadow;
import mx.skins.RectangularBorder;
import mx.utils.GraphicsUtil;

/**
 *  The skin for a ToolTip.
 */
public class ToolTipSkin extends RectangularBorder
{

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  Constructor.
	 */
	public function ToolTipSkin() 
	{
		super(); 
	}

	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private var dropShadow:RectangularDropShadow;
	
	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  borderMetrics
	//----------------------------------

	/**
	 *  @private
	 *  Storage for the borderMetrics property.
	 */
	private var _borderMetrics:EdgeMetrics;

	/**
	 *  @private
	 */
	override public function get borderMetrics():EdgeMetrics
	{		
		if (_borderMetrics)
			return _borderMetrics;
			
		var borderStyle:String = getStyle("borderStyle");
		switch (borderStyle)
		{
			case "errorTipRight":
			{
 				_borderMetrics = new EdgeMetrics(15, 1, 3, 3);
				break;
			}
			
			case "errorTipAbove":
			{
 				_borderMetrics = new EdgeMetrics(3, 1, 3, 15);
 				break;
			}
		
			case "errorTipBelow":
			{
 				_borderMetrics = new EdgeMetrics(3, 13, 3, 3);
 				break;
			}
			
 			default: // "toolTip"
			{
				_borderMetrics = new EdgeMetrics(3, 1, 3, 3);
 				break;
			}
 		}
		
		return _borderMetrics;
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 *  If borderStyle may have changed, clear the cached border metrics.
	 */
	override public function styleChanged(styleProp:String):void
	{
		if (styleProp == "borderStyle" ||
			styleProp == "styleName" ||
			styleProp == null)
		{
			_borderMetrics = null;
		}
		
		invalidateDisplayList();
	}

	/**
	 *  @private
	 *  Draw the background and border.
	 */
	override protected function updateDisplayList(w:Number, h:Number):void
	{	
		super.updateDisplayList(w, h);

		var borderStyle:String = getStyle("borderStyle");
		var backgroundColor:uint = getStyle("backgroundColor");
		var backgroundAlpha:Number= getStyle("backgroundAlpha");
		var borderColor:uint = getStyle("borderColor");
		var cornerRadius:Number = getStyle("cornerRadius");
		var shadowColor:uint = getStyle("shadowColor");
		var shadowAlpha:Number = 0.1;

		var g:Graphics = graphics;
		g.clear();
		
		filters = [ new DropShadowFilter(5, 45, 0, 0.4) ];

		switch (borderStyle)
		{
			case "toolTip":
			{
		        var borderThickness:Number = getStyle("borderThickness");
		        var fillAlphas:Array = getStyle("fillAlphas");
		        var fillColors:Array = getStyle("fillColors");
		        var fillColorsRatios:Array = getStyle("fillColorsRatios");        
		        var fillType:String = GradientType.LINEAR;
		        var spreadMethod:String = SpreadMethod.PAD;
		        
		        var matrix:Matrix = new Matrix();	
		        matrix.createGradientBox(w, h, 0, 0, 0); 
	      
		        g.beginGradientFill(fillType, fillColors, fillAlphas, fillColorsRatios, matrix, spreadMethod);
		        if (borderThickness != 0){g.lineStyle(borderThickness, borderColor)};
		        mx.utils.GraphicsUtil.drawRoundRectComplex(graphics, 0, 0, w, h-borderThickness, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
		        g.endFill();
				
				break;
			}

			case "errorTipRight":
			{
				// border 
				drawRoundRect(
					11, 0, w - 11, h - 2, 3,
					borderColor, backgroundAlpha); 

				// left pointer 
				g.beginFill(borderColor, backgroundAlpha);
				g.moveTo(11, 7);
				g.lineTo(0, 13);
				g.lineTo(11, 19);
				g.moveTo(11, 7);
				g.endFill();
				
				filters = [ new DropShadowFilter(2, 90, 0, 0.4) ];
				break;
			}

			case "errorTipAbove":
			{
				// border 
				drawRoundRect(
					0, 0, w, h - 13, 3,
					borderColor, backgroundAlpha); 

				// bottom pointer 
				g.beginFill(borderColor, backgroundAlpha);
				g.moveTo(9, h - 13);
				g.lineTo(15, h - 2);
				g.lineTo(21, h - 13);
				g.moveTo(9, h - 13);
				g.endFill();

				filters = [ new DropShadowFilter(2, 90, 0, 0.4) ];
				break;
			}

			case "errorTipBelow":
			{
				// border 
				drawRoundRect(
					0, 11, w, h - 13, 3,
					borderColor, backgroundAlpha); 

				// top pointer 
				g.beginFill(borderColor, backgroundAlpha);
				g.moveTo(9, 11);
				g.lineTo(15, 0);
				g.lineTo(21, 11);
				g.moveTo(10, 11);
				g.endFill();
				
				filters = [ new DropShadowFilter(2, 90, 0, 0.4) ];
				break;
			}
		}
	}
}

}
