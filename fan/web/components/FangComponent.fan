using afIoc::Inject
using afBedSheet
using afEfanXtra
using afPillow
using afDuvet

@Abstract
const mixin FangComponent : EfanComponent {
	
	@Inject abstract HttpRequest	httpRequest
	@Inject abstract Pages			pages
	@Inject abstract PageMeta		thisPage
	@Inject abstract HtmlInjector	injector
	@Inject abstract FileHandler	fileHandler
	
	@BeforeRender
	virtual Void beforeRender() { }

	Uri pageUri(Type pageType, Obj?[]? pageContext := null) {
		pages.pageMeta(pageType, pageContext).pageUrl
	}

	Str pageUrl(Type pageType, Obj?[]? pageContext := null) {
		pageUri(pageType, pageContext).encode
	}
	
	Uri assetUri(Uri localUrl) {
		fileHandler.fromLocalUrl(localUrl).clientUrl
	}
	
	Str assetUrl(Uri localUrl) {
		assetUri(localUrl).encode
	}
}
