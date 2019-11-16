using afEfanXtra::BeforeRender
using afPillow::Page
using afAskFanny
using afIoc::Inject
using afBedSheet::HttpRequest
using afBedSheet::BedSheetServer
using afGoogleAnalytics::GoogleAnalytics

@Page { url=`/askFanny` }
const mixin AskFannyPage : FangPage {
	@Inject abstract Index				index
	@Inject abstract HttpRequest		httpReq
	@Inject abstract GoogleAnalytics	ganal

	abstract Str		query
	abstract Section[]	results
	abstract Str[]		didYouMean
	
	abstract Section[]	docs
	abstract Section[]	types
	abstract Section[]	slots
	
	override Void beforeRender() {
		query		= httpReq.url.query.get("q", "").split.first
		results		= index.askFanny(query)
		didYouMean	= index.didYouMean(query)
		
		docs		= Section[,]
		types		= Section[,]
		slots		= Section[,]
		
		results.each |section| {
			switch (section.what) {
				case SectionType.field:
				case SectionType.method:
					slots.add(section)
				case SectionType.type:
					types.add(section)
				default:
					docs.add(section)
			}
		}
		
		// render pageView WITH the query
		ganal.renderPageView(httpReq.url)
	}
	
	Str cssActive(Section[] secs) {
		cssCustom(secs, "active")
	}

	Str cssShow(Section[] secs) {
		cssCustom(secs, "show active")
	}

	private Str cssCustom(Section[] secs, Str css) {
		if (secs == docs)
			return docs.size > 0 ? css : ""

		if (secs == types)
			return docs.size == 0 && types.size > 0 ? css : ""

		if (secs == slots)
			return docs.size == 0 && types.size == 0 && slots.size > 0 ? css : ""
		
		throw Err("WTF")
	}

}