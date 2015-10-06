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
	beego.Router("/baodao", home, "get:Baodao")
	beego.Router("/rili", home, "get:Rili")
	beego.Router("/about", home, "get:About")
	beego.Router("/herstart", home, "get:HerStart")
	beego.Router("/brand/:id", home, "get:Brand")
	beego.AutoRouter(home)

	// 移动端
	m := &controllers.M{}
	beego.AutoRouter(m)

	// 社交帐户登录
	conn := &controllers.Connect{}
	beego.AutoRouter(conn)

	// 帐户信息管理
	act := &controllers.Accounts{}
	beego.Router("/my/profile", act, "get:Profile")
	beego.Router("/my/save", act, "post:Post")
	beego.AutoRouter(act)

	// 项目管理
	com := &controllers.Company{}
	beego.Router("/my/company", com, "get:Index")
	beego.Router("/my/apply/:id", com, "get:Apply")
	beego.Router("/company/:id", com)
	//beego.Router("/company/list", com, "get:List")
	beego.AutoRouter(com)

	// 项目展示
	item := &controllers.Item{}
	beego.AutoRouter(item)

	// 融资服务
	apply := &controllers.Apply{}
	beego.AutoRouter(apply)

	// 媒体管理
	article := &controllers.Article{}
	beego.AutoRouter(article)
	// 活动日历
	events := &controllers.Events{}
	beego.AutoRouter(events)
	// 页面静态化
	jintai := &controllers.Jingtai{}
	beego.AutoRouter(jintai)
	// 后台管理
	admin := &controllers.Admin{}
	beego.AutoRouter(admin)

	// 基础数据管理
	basic := &controllers.Basic{}
	beego.Router("/basic/index/:typeId", basic, "get:Index")
	beego.Router("/basic/list", basic, "get:List")
	beego.Router("/basic/save", basic, "Post:Save")
	beego.AutoRouter(basic)
	//
	up := &controllers.Upload{}
	beego.Router("/up", up)
	beego.Router("/up/avatar", up, "post:Avatar")
	beego.Router("/up/file", up, "post:File")
	beego.AutoRouter(up)
}
