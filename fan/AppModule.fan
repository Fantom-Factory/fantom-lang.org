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
		config["afSleepSafe.csp.report-uri"]	= null
		config["afSleepSafe.cspReportFn"]		= null
	}
}
