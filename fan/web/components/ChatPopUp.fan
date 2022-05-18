using afIoc::Inject
using afBedSheet::FileHandler
using afEfanXtra::EfanComponent
using afEfanXtra::BeforeRender

const mixin ChatPopUp : EfanComponent {
	
	@Inject abstract FileHandler	fileHandler
	
	// disable popup - it's not really needed
	@BeforeRender
	Bool onBeforeRender() { false }
	
	Uri assetUri(Uri localUrl) {
		fileHandler.fromLocalUrl(localUrl).clientUrl
	}

	Str assetUrl(Uri localUrl) {
		assetUri(localUrl).encode
	}
} 
