package controllers

import (
	"techbase/models"
)

// 读取项目信息
func (this *Base) getCompanyInfo(id int64, all ...bool) *models.Company {
	com := new(models.Company)
	com.Id = id

	if len(all) == 0 {
		com.AccountId = this.currentUser.Id
	}

	if id > 0 {
		if _, err := com.Get(); err != nil {
			this.trace(err)
		}
	}
	this.Data["company"] = com

	return com
}

// 读取联系信息
func (this *Base) getContactInfo(id int64) {
	com := new(models.Contact)
	com.CompanyId = id

	if id > 0 {
		if _, err := com.Get(); err != nil {
			this.trace(err)
		}
	}
	this.Data["contact"] = com
}

// 读取项目介绍
func (this *Base) getIntroduceInfo(id int64) {
	com := new(models.Introduce)
	com.CompanyId = id

	if id > 0 {
		if _, err := com.Get(); err != nil {
			this.trace(err)
		}
	}
	this.Data["introduce"] = com
}

// 读取相关链接
func (this *Base) getLinksInfo(id int64) {
	com := new(models.Links)
	com.CompanyId = id

	if id > 0 {
		if _, err := com.Get(); err != nil {
			this.trace(err)
		}
	}
	this.Data["links"] = com
}

// 读取创始团队成员
func (this *Base) getMembersList(id int64) {
	com := new(models.Members)
	com.CompanyId = id

	var ms []models.Members
	var err error

	if id > 0 {
		ms, err = com.List()
		if err != nil {
			this.trace(err)
		}
	}
	this.Data["companyId"] = id
	this.Data["members"] = ms
}

// 读取融资经历
func (this *Base) getLoopsList(id int64) {
	com := new(models.Loops)
	com.CompanyId = id

	var ls []models.Loops
	var err error

	if id > 0 {
		ls, err = com.List()
		if err != nil {
			this.trace(err)
		}
	}
	this.Data["companyId"] = id
	this.Data["loops"] = ls
	////
	//_json, err := utils.Interface2Json(ls, false, false)
	//if err != nil {
	//	this.trace(err)
	//}

	//return _json
}

// 错误页
func (this *Base) error_page(args ...string) {
	switch len(args) {
	case 1:
		// 跳转到错误页
		this.Redirect(this.UrlFor("Home.Error", ":msg", args[0]), 302)
	case 2:
		// 跳转到错误页
		this.Redirect(this.UrlFor("Home.Error", ":msg", args[0], ":url", args[1]), 302)
	default:
		// 跳转到错误页
		this.Redirect(this.UrlFor("Home.Error", ":msg", "未知错误"), 302)
	}

	this.end()
}
