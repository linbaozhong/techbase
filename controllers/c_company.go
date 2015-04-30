/*
* 我的公司管理模块
 */

package controllers

import (
	"techbase/models"
	"zouzhe/utils"
)

type Company struct {
	Auth
}

// 我的公司首页
func (this *Company) Index() {
	this.Data["subTitle"] = "我管理的公司"
}

// 创建公司视图
func (this *Company) Create() {
	this.Data["subTitle"] = "创建公司"

	id, _ := this.getParamsInt64("0")
	this.Data["companyId"] = id
}

// 我的公司列表
func (this *Company) List() {
	com := new(models.Company)

	com.AccountId = this.currentUser.Id

	cs, _ := com.List()

	this.renderJson(utils.JsonData(true, "", cs))
}

// 读取公司信息
func (this *Company) GetCompany() {
	// 公司id
	id, _ := this.getParamsInt64("0")

	if id > 0 {
		this.getCompanyInfo(id)
	}

	this.Layout = ""
	this.setTplNames("_company")
}

// 读取联系信息
func (this *Company) GetContact() {
	// 公司id
	id, _ := this.getParamsInt64("0")

	if id > 0 {
		this.getContactInfo(id)
	}

	this.Layout = ""
	this.setTplNames("_contact")
}

// 读取公司介绍
func (this *Company) GetIntroduce() {
	// 公司id
	id, _ := this.getParamsInt64("0")

	if id > 0 {
		this.getIntroduceInfo(id)
	}

	this.Layout = ""
	this.setTplNames("_introduce")
}

// 读取公司相关链接
func (this *Company) GetLinks() {
	// 公司id
	id, _ := this.getParamsInt64("0")

	if id > 0 {
		this.getLinksInfo(id)
	}

	this.Layout = ""
	this.setTplNames("_links")
}

// 读取公司创始团队
func (this *Company) GetMembers() {
	// 公司id
	id, _ := this.getParamsInt64("0")

	if id > 0 {
		this.getMembersList(id)
	}

	this.Layout = ""
	this.setTplNames("_members")
}

// 读取融资经历
func (this *Company) GetLoops() {
	// 公司id
	id, _ := this.getParamsInt64("0")

	if id > 0 {
		this.getLoopsList(id)
	}

	this.Layout = ""
	this.setTplNames("_loops")
}

//////////////////////////////////////////
// 读取公司信息
func (this *Company) getCompanyInfo(id int64) {
	com := new(models.Company)
	com.Id = id

	if ok, _ := com.Get(); ok {
		this.Data["company"] = com
	}
}

// 读取联系信息
func (this *Company) getContactInfo(id int64) {
	com := new(models.Contact)
	com.CompanyId = id

	if ok, _ := com.Get(); ok {
		this.Data["contact"] = com
	}
}

// 读取公司介绍
func (this *Company) getIntroduceInfo(id int64) {
	com := new(models.Introduce)
	com.CompanyId = id

	if ok, _ := com.Get(); ok {
		this.Data["introduce"] = com
	}
}

// 读取相关链接
func (this *Company) getLinksInfo(id int64) {
	com := new(models.Links)
	com.CompanyId = id

	if ok, _ := com.Get(); ok {
		this.Data["links"] = com
	}
}

// 读取创始团队成员
func (this *Company) getMembersList(id int64) {
	com := new(models.Members)
	com.CompanyId = id

	ms, err := com.List()
	if err != nil {
		this.trace(err)
	}
	this.Data["members"] = ms
}

// 读取融资经历
func (this *Company) getLoopsList(id int64) {
	com := new(models.Loops)
	com.CompanyId = id

	ls, err := com.List()
	if err != nil {
		this.trace(err)
	}
	this.Data["loops"] = ls
}
