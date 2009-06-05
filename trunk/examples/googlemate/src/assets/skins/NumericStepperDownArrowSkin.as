package assets.skins
{

import flash.display.GradientType;
import flash.display.Graphics;
import flash.filters.DropShadowFilter;
import mx.skins.Border;
import mx.styles.StyleManager;
import mx.utils.ColorUtil;

/**
 *  The skin for all the states of the down button in a NumericStepper.
 */
public class NumericStepperDownArrowSkin extends Border
{
	//--------------------------------------------------------------------------
	//
	//  Class variables
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private static var cache:Object = {};
	
	//--------------------------------------------------------------------------
	//
	//  Class methods
	//
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  Constructor.
	 */
	public function NumericStepperDownArrowSkin()
	{
		super();		
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden properties
	//
	//--------------------------------------------------------------------------

	//----------------------------------
	//  measuredWidth
	//----------------------------------

	/**
	 *  @private
	 */
	override public function get measuredWidth():Number
	{
		return 19;
	}

	//----------------------------------
	//  measuredHeight
	//----------------------------------

	/**
	 *  @private
	 */
	override public function get measuredHeight():Number
	{
		return 11;
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @private
	 */
	override protected function updateDisplayList(w:Number, h:Number):void
	{
		super.updateDisplayList(w, h);

		// User-defined styles.
		var arrowColor:uint = getStyle("iconColor");
		var arrowOverColor:uint = getStyle("iconOverColor");
		var arrowDownColor:uint = getStyle("iconDownColor");
		var arrowDisabledColor:uint = getStyle("iconDisabledColor");
		var borderColor:uint = getStyle("borderColor");
		var cornerRadius:Number = getStyle("cornerRadius");
		var fillAlphas:Array = getStyle("fillAlphas");
		var fillColors:Array = getStyle("fillColors");
		StyleManager.getColorNames(fillColors);
		var themeColor:uint = getStyle("themeColor");		
		
		var cr:Object  = { tl: 0, tr: 0, bl: 0, br: cornerRadius };
		var cr1:Object = { tl: 0, tr: 0, bl: 0, br: Math.max(cornerRadius - 1, 0) };

		// Draw the background and border.
		var g:Graphics = graphics;
		
		g.clear();
		
		switch (name)
		{
			case "downArrowUpSkin":
			{
   				var upFillColors:Array = [getStyle('upBackgroundColor'), getStyle('upBackgroundColor')];

   				var upFillAlphas:Array = [ 1, 1 ];

				// border
				drawRoundRect(
					0, 0, w, h, cr,
					[ borderColor, borderColor ], 1,
					verticalGradientMatrix(0, 0, w, h),
					GradientType.LINEAR, null, 
					{ x: 1, y: 0, w: w - 2, h: h - 1, r: cr1 });

				// fill
				drawRoundRect(
					1, 0, w - 2, h - 1, cr1,
					upFillColors, upFillAlphas,
					verticalGradientMatrix(1, 1 - h, w - 2, 2 * h - 2));
				
				break;
			}
			
			case "downArrowOverSkin":
			{
				var overFillColors:Array = [ getStyle('overBackgroundColor'), getStyle('overBackgroundColor') ];

				var overFillAlphas:Array = [ 1, 1 ];

				// border
				drawRoundRect(
					0, 0, w, h, cr,
					[ borderColor, borderColor ], 1,
					verticalGradientMatrix(0, 0, w, h),
					GradientType.LINEAR, null, 
                    { x: 1, y: 0, w: w - 2, h: h - 1, r: cr1 }); 
					
				// fill
				drawRoundRect(
					1, 0, w - 2, h - 1, cr1,
					overFillColors, overFillAlphas,
					verticalGradientMatrix(1, 1 - h, w - 2, 2 * h - 3)); 
				
				// arrow 
				arrowColor = arrowOverColor;
				
				break;
			}
			
			case "downArrowDownSkin":
			{
				var downFillColors:Array = [ getStyle('downBackgroundColor'), getStyle('downBackgroundColor') ];
				
				var downFillAlphas:Array = [ 1, 1 ];
				
				// border
				drawRoundRect(
					0, 0, w, h, cr,
					[ borderColor, borderColor ], downFillAlphas,
					verticalGradientMatrix(0, 0, w, h),
					GradientType.LINEAR, null, 
                    { x: 1, y: 0, w: w - 2, h: h - 1, r: cr1 }); 
					
				// fill
				drawRoundRect(
					1, 0, w - 2, h - 1, cr1,
					downFillColors, downFillAlphas,
					verticalGradientMatrix(1, 1 - h, w - 2, 2 * h - 2));
				
				// arrow 
				arrowColor = arrowDownColor;
				
				break;
			}
			
			case "downArrowDisabledSkin":
			{
   				var disFillColors:Array = [ getStyle('disabledBackgroundColor'), getStyle('disabledBackgroundColor') ];
   				
				var disFillAlphas:Array =
					[ Math.max( 0, fillAlphas[0] - 0.15),
					  Math.max( 0, fillAlphas[1] - 0.15) ];

				// border
				drawRoundRect(
					0, 0, w, h, cr,
					disFillColors, 0.5,
					verticalGradientMatrix(0, 0, w, h),
					GradientType.LINEAR, null, 
					{ x: 1, y: 0, w: w - 2, h: h - 1, r: cr1 }); 

				// fill
				drawRoundRect(
					1, 0, w - 2, h - 1, cr1,
					disFillColors, disFillAlphas,
					verticalGradientMatrix(1, 1 - h, w - 2, 2 * h - 2)); 
				
				arrowColor = getStyle("disabledIconColor");
				
				// arrow 
				arrowColor = arrowDisabledColor;
				
				break;
			}
		}

		// Draw the arrow.
		g.beginFill(arrowColor);
		g.moveTo(w / 2, h / 2 + 1.5);
		g.lineTo(w / 2 - 3.5, h / 2 - 2.5);
		g.lineTo(w / 2 + 3.5, h / 2 - 2.5);
		g.lineTo(w / 2, h / 2 + 1.5);
		g.endFill();
	}
}

}
