package controllers

import (
	"techbase/models"
	"zouzhe/utils"
)

type Auth struct {
	Base
}

func (this *Auth) Prepare() {
	this.Base.Prepare()

	// 检查当前用户是否合法用户
	if !this.allowRequest() {
		//
		if this.IsAjax() {
			this.renderJson(utils.JsonMessage(false, "", "无效用户,请登录……"))
			return
		} else {
			// 跳转到错误页
			this.Redirect("/login?returnurl="+this.Ctx.Request.URL.String(), 302)
			this.end()
		}
	}
	// 当前用户角色是否存在
	if this.GetSession("role") == nil || this.GetSession("role") == -1 {
		// 读取用户角色
		act := new(models.Accounts)
		act.Id = this.currentUser.Id
		role, _ := act.GetRole()
		// 写入Session
		this.SetSession("role", role)
		this.currentUser.Role = role
	} else {
		this.currentUser.Role = this.GetSession("role").(int)
	}

	this.Data["index"] = ""

	this.Layout = "_frontLayout.tpl"
	this.LayoutSections = make(map[string]string)

}

func (this *Auth) Finish() {
	this.trace(this.Lang)
}
