using afIoc
using afIocConfig::ApplicationDefaults
using afBedSheet
using afDuvet

const class WebModule {

	// ---- BedSheet Configuration ----------------------------------------------------------------

	@Contribute { serviceType=FileHandler# }
	Void contributeFileHandler(Configuration config) {
		config[`/`]	= `etc/web-static/`.toFile
	}
	
	@Contribute { serviceType=MiddlewarePipeline# }
	Void contributeBedSheetMiddleware(Configuration config) {
		config.inOrder |->| {
			config["www"] = config.build(WwwMiddleware#)
		}.before("afBedSheet.routes")
	}
	
	@Contribute { serviceType=ApplicationDefaults# }
	Void contributeAppDefaults(Configuration config) {
		config["afSleepSafe.csp.default-src"]	= "'none'"
		config["afSleepSafe.csp.img-src"]		= "'self' data: https://www.google-analytics.com/"
		config["afSleepSafe.csp.font-src"]		= "'self' data:"			// data: for font icons
		config["afSleepSafe.csp.child-src"]		= "'self' https://www.youtube.com/"
		config["afSleepSafe.csp.script-src"]	= "'self' https://www.google-analytics.com/"
		config["afSleepSafe.csp.style-src"]		= "'self' 'unsafe-inline'"	// inline for anchorJS
	}
	
	// ---- Duvet Configuration -------------------------------------------------------------------
	
	@Contribute { serviceType=ScriptModules# }
	Void contributeScriptModules(Configuration config, FileHandler fh) {
		config.remove("afDuvet.podModules")
		config.add(ScriptModule("jquery"		).atUrl(fh.fromLocalUrl(`/js/jquery-3.2.1.slim.min.js`	).clientUrl))
		config.add(ScriptModule("popper"		).atUrl(fh.fromLocalUrl(`/js/popper-umd-1.12.3.min.js`	).clientUrl))
		config.add(ScriptModule("bootstrap"		).atUrl(fh.fromLocalUrl(`/js/bootstrap-4.0.0.b1.min.js`	).clientUrl).requires("jquery"))
		config.add(ScriptModule("website"		).atUrl(fh.fromLocalUrl(`/js/websiteModules.js`			).clientUrl))
	}
	
	@Contribute { serviceType=RequireJsConfigTweaks# }
	Void contributeRequireJsConfigTweaks(Configuration conf) {
		conf["app.bundles"] = |Str:Obj? config| {
			bundles := (Str:Str[]) config.getOrAdd("bundles") { [Str:Str[]][:] }
			bundles["website"]	 = "anchorJs runAnchorJs initBootstrap unscramble".split
		}
	}
}
