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

	//this.Layout = "_adminLayout.tpl"

}

//
func (this *Admin) Index() {
	this.setTplNames("index")
}

// 审核公司
func (this *Admin) company() {
	com := new(models.Company)
	com.Status, _ = this.GetInt("status")

	cs, _ := com.AllList()

	this.Data["companys"] = cs
}

// 审核账户
func (this *Admin) Account() {
	act := new(models.Accounts)
	act.Id = this.currentUser.Id
	act.Role = this.currentUser.Role

	as, _ := act.AllList()

	this.Data["accounts"] = as
}
