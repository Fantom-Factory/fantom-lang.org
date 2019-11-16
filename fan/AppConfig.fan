using afIocConfig

const class AppConfig : ConfigClass {

	@Config	const Str		contactEmail
	
//	@Config	const Str		smtpHost
//	@Config	const Int		smtpPort
//	@Config	const Str		smtpUsername
//	@Config	const Str		smtpPassword
//	@Config	const Bool		smtpSsl
//
//	@Config	const Bool		emailEnabled
//	@Config	const Str		emailFrom
//	@Config	const Str		emailSendErrsTo


	new make(|This| f) { f(this)
		contactEmail = contactEmail.reverse
	}

//	SmtpClient smtpClient() {
//		SmtpClient {
//			host		= smtpHost
//			port		= smtpPort
//			username	= smtpUsername
//			password	= smtpPassword
//			ssl			= smtpSsl
//		}
//    }
}
