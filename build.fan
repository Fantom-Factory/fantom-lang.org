using build
using fanr

class Build : BuildPod {

	new make() {
		podName = "afFantomLang"
		summary = "The Fantom-Lang Website"
		version = Version("1.1.0.13")

		meta = [
			"pod.dis"		: "fantom-lang.org",
			"afIoc.module"	: "afFantomLang::AppModule",
			"repo.public"	: "false"
		]

		depends = [
			"sys        1.0.70 - 1.0",
			"concurrent 1.0.70 - 1.0",
			"web        1.0.70 - 1.0",
			"util       1.0.70 - 1.0",

			// ---- Core ------------------------
			"afBeanUtils  1.0.12 - 1.0",
			"afConcurrent 1.0.26 - 1.0",
			"afIoc        3.0.8  - 3.0",
			"afIocConfig  1.1.2  - 1.1",
			"afIocEnv     1.1.0  - 1.1",

			// ---- Web -------------------------
			"afBedSheet   1.5.16 - 1.5",	// for SleepSafe
			"afPillow     1.2.2  - 1.2",
			"afEfanXtra   2.0.6  - 2.0",
			"afColdFeet   1.4.0  - 1.4",
			"afDuvet      1.1.12 - 1.1",
			"afSlim       1.3.2  - 1.3",
			"afSitemap    1.1.0  - 1.1",
			"afGoogleAnalytics 0.1.10  - 0.1",

			"afAskFanny   0.0.4 - 0.0",
			"afSleepSafe  1.0.6 - 1.0"
		]

		srcDirs = [`fan/`, `fan/web/`, `fan/web/components/`, `fan/web/pages/`]
		resDirs = [
			,
		]

		docApi = false
		docSrc = false
	}
}
