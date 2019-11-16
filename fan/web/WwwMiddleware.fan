using afIoc::Inject
using afIocEnv::IocEnv
using afIocConfig::ConfigSource
using afBedSheet::BedSheetServer
using afBedSheet::BedSheetConfigIds
using afBedSheet::HttpRequest
using afBedSheet::Middleware
using afBedSheet::MiddlewarePipeline
using afBedSheet::ResponseProcessors
using afBedSheet::Redirect
using afPillow::Pages

const class WwwMiddleware : Middleware {
	@Inject	const HttpRequest 			httpReq
	@Inject	const BedSheetServer		bedServer
	@Inject	const ResponseProcessors	resPro
	@Inject	const IocEnv				iocEnv
	@Inject	const Pages					pages
			const Str					bedHost
	
	new make(ConfigSource configSrc, |This| f) {
		f(this)
		this.bedHost = ((Uri) configSrc.get(BedSheetConfigIds.host, Uri#)).host
	}
	
	override Void service(MiddlewarePipeline pipeline) {
		if (iocEnv.isProd) {

			// bedServer.host that returns proxy info hasn't been released yet -> 1.5.8
			host := httpReq.headers["X-Forwarded-Host"] ?: httpReq.headers.host
			if (host != bedHost) {
				httpUrl	:= host == "askfanny.fantomfactory.org"
					// pageMeta.pageUrlAbs() hasn't been released yet - so use bedServer -> 1.1.4
					? bedServer.toAbsoluteUrl(pages.get(AskFannyPage#).pageUrl).plusQuery(httpReq.url.query)
					: bedServer.toAbsoluteUrl(pages.get(IndexPage#).pageUrl) + httpReq.url
				
				resPro.processResponse(Redirect.movedTemporarily(httpUrl))
				return
			}
		}
		
		pipeline.service
	}
}
