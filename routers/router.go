package routers

import (
	"github.com/astaxie/beego"
	"techbase/controllers"
)

func init() {
	// 屏蔽路由大小写敏感
	beego.RouterCaseSensitive = false

	home := &controllers.Home{}
	beego.Router("/", home, "get:Get")
	beego.Router("/brandshow", home, "get:Show")
	beego.Router("/home", home, "get:Home")
	beego.Router("/media", home, "get:Media")
	beego.Router("/community", home, "get:Community")
	beego.Router("/herstart", home, "get:HerStart")
	beego.Router("/brand/:id", home, "get:Brand")
	beego.Router("/signout", home, "post:SignOut")
	beego.Router("/home/error/:msg", home, "get:Error")
	beego.AutoRouter(home)

	conn := &controllers.Connect{}
	beego.AutoRouter(conn)
}
