package controllers

import (
	//"techbase/models"
	"zouzhe/utils"
)

type Home struct {
	Front
}

func (this *Home) Get() {
	this.Data["account"] = this.currentUser
	this.Data["index"] = "index"
	this.setTplNames("index")
}

//
func (this *Home) Show() {
	this.Data["account"] = this.currentUser
	this.Data["index"] = "brandshow"
	this.setTplNames("brandshow")
}

//
func (this *Home) Home() {
	this.Data["account"] = this.currentUser
	this.Data["index"] = "home"
	this.setTplNames("home")
}

//
func (this *Home) Media() {
	this.Data["index"] = "media"
	this.setTplNames("media")
}

//
func (this *Home) HerStart() {
	this.Data["index"] = "home"
	this.setTplNames("herstart")
}

//
func (this *Home) Community() {
	this.Data["index"] = "community"
	this.setTplNames("community")
}

// 阅读
func (this *Home) Brand() {
	id := this.getParamsString(":id")

	if id == "" {
		// 跳转到首页
		this.Redirect("/", 302)
		this.end()
	} else {
		this.Data["index"] = "brandshow"
		this.setTplNames(id)
	}
}

// 项目详情
func (this *Home) Info() {
	id, _ := this.GetInt64("0")

	if id <= 0 {
		this.error_page("项目不存在")
		return
	}

	com := this.getCompanyInfo(id, true)
	if com.Id <= 0 {
		this.error_page("项目不存在")
		return
	}
	this.trace(this.Data["account"])

	this.getIntroduceInfo(id)
	this.getLinksInfo(id)
	this.getMembersList(id)
	this.getLoopsList(id)

	this.setTplNames("info")
	// 记录阅读次数
	com.SetReaded()
}

// 帮助
func (this *Home) Help() {
	this.setTplNames("help")
}

// 签出
func (this *Home) SignOut() {
	this.loginOut()
	this.renderJson(utils.JsonResult(true, "", ""))
}

/*
* 通用错误消息地址
 */
func (this *Home) Error() {
	this.trace(this.GetString(":msg"))
	this.Data["message"] = this.GetString(":msg")
	this.setTplNames("error")
}
