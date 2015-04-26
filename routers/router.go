package routers

import (
	"github.com/astaxie/beego"
	"techbase/controllers"
)

func init() {
	// 屏蔽路由大小写敏感
	beego.RouterCaseSensitive = false
	// 前段
	home := &controllers.Home{}
	beego.Router("/", home, "get:Get")
	beego.Router("/help", home, "get:Help")
	beego.Router("/signout", home, "post:SignOut")
	beego.Router("/home/error/:msg", home, "get:Error")

	beego.Router("/brandshow", home, "get:Show")
	beego.Router("/home", home, "get:Home")
	beego.Router("/media", home, "get:Media")
	beego.Router("/community", home, "get:Community")
	beego.Router("/herstart", home, "get:HerStart")
	beego.Router("/brand/:id", home, "get:Brand")
	beego.AutoRouter(home)
	// 社交帐户登录
	conn := &controllers.Connect{}
	beego.AutoRouter(conn)
	// 帐户信息管理
	act := &controllers.Accounts{}
	beego.Router("/my/profile", act, "get:Profile")
	beego.Router("/my/save", act, "post:Post")
	beego.AutoRouter(act)
	// 系统后台管理
	admin := &controllers.Admin{}
	beego.AutoRouter(admin)
}
