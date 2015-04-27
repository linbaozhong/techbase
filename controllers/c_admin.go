/*
* 内容管理控制器
 */
package controllers

import (
	"techbase/models"
	"zouzhe/utils"
)

type Admin struct {
	Auth
}

func (this *Admin) Prepare() {
	this.Auth.Prepare()

	// 要求管理员以上级别访问权限
	if this.currentUser.Role == models.Role_Administrator || this.currentUser.Role == models.Role_System {

	} else {
		if this.IsAjax() {
			this.renderJson(utils.JsonMessage(false, "", "拒绝访问未授权的功能，请联系系统管理员……"))
			return
		} else {
			// 跳转到错误页
			this.Redirect(this.UrlFor("Home.Error", ":msg", utils.UrlEncode("拒绝访问未授权的功能，请联系系统管理员……")), 302)
			this.end()
		}
	}

	this.Layout = "_adminLayout.tpl"

}

//
func (this *Admin) Index() {
	this.setTplNames("index")
}
