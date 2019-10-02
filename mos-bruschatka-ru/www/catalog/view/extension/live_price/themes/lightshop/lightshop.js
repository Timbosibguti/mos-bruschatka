
function liveprice_getCustomMethodsOfTheme( extension ) {
	
	var methods = {
		
		init : function() {

		},
		
		getElementsToUpdatePriceOnClick : function() {
			
		
		},
		
		getSelectorForElementsToUpdatePriceOnClick : function() { // to use for dynamic elements by on(event, selector, ...)

return '.ui-spinner-up, .ui-spinner-down';
        
      },
		
		getContainer : function() {
			
		},
		
		setPriceHTML : function( json ) {
			extension.getElement('.js-product-page-prices').html(json.htmls.html);
			
			
		},
		
	};
	
	return methods;
}