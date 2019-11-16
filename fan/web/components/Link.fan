using afIoc::Inject
using afEfanXtra

//@Abstract
const mixin Link : FangComponent {

	abstract Str	title
	abstract Str?	href
	abstract Str?	desc
	abstract Str?	credit

	@InitRender
	Void init(Str title, Str? href, Str? credit, Str? desc := null) {
		this.title	= title.trim
		this.href	= href?.trimToNull
		this.credit	= credit == "me" ? "Steve Eynon" : credit?.trimToNull
		this.desc	= desc?.trimToNull
	}
} 

const mixin LinkBy : Link { }

const mixin LinkOn : Link { }
