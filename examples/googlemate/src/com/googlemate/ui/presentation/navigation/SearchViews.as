package com.googlemate.ui.presentation.navigation
{
	import com.googlemate.model.constants.Constants;
	import com.googlemate.model.vos.NavigationVO;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	/**
	 * Search Views
	 */ 
	public class SearchViews
	{
		//-----------------------------------------------------------------------------------------------------------
		//                                         Public Static Constants
		//-----------------------------------------------------------------------------------------------------------

		// Views
		public static const NO_SEARCH_RESULTS_VIEW:int 	= 0;
		public static const SEARCHING_VIEW:int 			= 1;
		public static const SEARCH_RESULTS_VIEW:int		= 2;
		
		// Default
		public static const DEFAULT_VIEW:int 			= NO_SEARCH_RESULTS_VIEW;
	}
}