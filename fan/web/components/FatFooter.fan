using afIoc::Inject
using afEfanXtra::BeforeRender

const mixin FatFooter : FangComponent {

	@Inject abstract AppConfig appConfig
	
	override Void beforeRender() {
		injector.injectRequireModule("unscramble", null, [".js-contactUs"])
	}

	Int currentYear() {
		Date.today.year
	}
	
	Str version() {
		FatFooter#.pod.version.toStr
	}
} 
