package com.cafetownsend.model.constants
{
	import spark.effects.easing.IEaser;
	import spark.effects.easing.Power;

	final public class EffectConstants
	{
		public static const DURATION:int = 400;
		
		public static const EASE: IEaser = new Power( 0.20 );
	}
}