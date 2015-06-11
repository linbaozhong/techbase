package controllers

import (
	"techbase/models"
	"techbase/utils"
)

type Auth struct {
	Base
}

func (this *Auth) Prepare() {
	this.Base.Prepare()

	// 检查当前用户是否合法用户
	if this.currentUser.Id <= 0 {
		//
		if this.IsAjax() {
			this.renderJson(utils.JsonResult(false, "", utils.UrlEncode("无效用户,请登录……")))
			return
		} else {
			// 跳转到错误页
			//this.Redirect("/login?returnurl="+this.Ctx.Request.URL.String(), 302)
			this.Redirect(this.UrlFor("Home.Error", ":msg", utils.UrlEncode("你正在访问未经许可的内容，请登录后重试……")), 302)
			this.end()
		}
	}
	//// 检查当前用户是否被禁用
	//act := new(models.Accounts)
	//act.Id = this.currentUser.Id
	//this.currentUser.Role, this.currentUser.Status, _ = act.GetRole()

	if this.currentUser.Status == models.Locked {
		//---跳转至错误页
		this.Redirect(this.UrlFor("Home.Error", ":msg", utils.UrlEncode("你的账户已经被禁用，请联系网站管理员……")), 302)
		this.end()
	}

	//// 当前用户角色是否存在
	//if this.GetSession("role") == nil || this.GetSession("role") == -1 {
	//	// 读取用户角色
	//	act := new(models.Accounts)
	//	act.Id = this.currentUser.Id
	//	role, _ := act.GetRole()
	//	// 写入Session
	//	this.SetSession("role", role)
	//	this.currentUser.Role = role
	//} else {
	//	this.currentUser.Role = this.GetSession("role").(int)
	//}

	this.Data["index"] = ""
	this.Data["account"] = this.currentUser

	this.Layout = "_adminLayout.tpl"
	this.LayoutSections = make(map[string]string)
	this.LayoutSections["Head"] = "_head.tpl"
	this.LayoutSections["Footer"] = "_footer.tpl"
}

func (this *Auth) Finish() {
	this.Base.Finish()
}

/////////////////////////////////////
/*
* 检查用户提交的数据是否自己项目的数据
 */
func (this *Auth) exists(id int64, any ...bool) bool {
	com := new(models.Company)
	com.Id = id

	if len(any) > 0 && any[0] {
		return com.Exists()
	} else {
		com.AccountId = this.currentUser.Id
		return com.Exists()
	}
}
