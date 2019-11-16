using afIoc
using afIocConfig::ApplicationDefaults
using afAskFanny::Index
using afAskFanny::IndexBuilder

@SubModule { modules=[WebModule#] }
const class AppModule {
	
	Void defineServices(RegistryBuilder defs) {
		defs.addService(AppConfig#)
	}
	
	Void onRegistryStartup(Configuration config) {
		config.remove("afIoc.logServices")
	}
	
	@Build
	Index buildFannyindex() {
		IndexBuilder().indexCorePods.build
	}
	
	@Contribute { serviceType=ApplicationDefaults# }
	Void contributeAppDefaults(Configuration config) {
		// trying to remove these now gives me errors??
//		config.remove("afSleepSafe.csp.report-uri")
//		config.remove("afSleepSafe.cspReportFn")
	}
}
