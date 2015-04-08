package controllers

import (
//"techbase/models"
//"zouzhe/utils"
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
