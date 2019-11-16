using afIoc::Inject
using afEfanXtra::InitRender
using afGoogleAnalytics::GoogleAnalytics
using afBedSheet::BedSheetServer

const mixin Layout : FangComponent {

	@Inject abstract GoogleAnalytics	ganal
	@Inject abstract BedSheetServer		bedServer
	
	abstract Str?	pageTitle
	abstract Str?	pageId

	@InitRender
	Void init(Str pageTitle) {
		this.pageTitle	= pageTitle.isEmpty ? "" : pageTitle + " :: "
		this.pageId 	= thisPage.pageType.name.decapitalize

		injector.injectStylesheet.fromLocalUrl(`/css/website.min.css`)
		injector.injectRequireModule("runAnchorJs", null, ["h2, h3, h4"])

		injector.injectRequireModule("initBootstrap")

		// ---- Open Graph Meta ---- Mandatory
		injector.injectMeta.withProperty("og:type"	).withContent("website")
		injector.injectMeta.withProperty("og:title"	).withContent("Fantom - The Intelligent JVM Programming Language")
		injector.injectMeta.withProperty("og:url"	).withContent(bedServer.toAbsoluteUrl(`/`).encode)
		injector.injectMeta.withProperty("og:image"	).withContent(bedServer.toAbsoluteUrl(assetUri(`/png/ogimage.png`)).encode)

		// ---- Open Graph Meta ---- Optional
//		injector.injectMeta.withProperty("og:description"	).withContent("Fantom - The Next Generation JVM Programming Language")
		injector.injectMeta.withProperty("og:locale"		).withContent("en_GB")
		injector.injectMeta.withProperty("og:site_name"		).withContent("Fantom-Lang")

		// askFanny renders its own pageView
		if (!ganal.pageViewRendered)
			ganal.renderPageView
	}

	Bool isAdminPage() {
		httpRequest.url.path.first == "/admin/"
	}
} 
