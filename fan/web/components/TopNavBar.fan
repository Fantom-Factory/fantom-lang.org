
const mixin TopNavBar : FangComponent {
	
	override Void beforeRender() {
		injector.injectRequireScript(["bootstrap":"bootstrap", "jquery":"jq"], "jq('#askFannySearchModal').on('shown.bs.modal', function (e) { jq('#navQ').focus();  });")
	}
	
	Str active(Type pageType) {
		thisPage.pageType == pageType ? "active" : ""
	}
	
} 
