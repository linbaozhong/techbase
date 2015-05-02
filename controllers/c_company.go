/*
* 我的公司管理模块
 */

package controllers

import (
	"errors"
	"strings"
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

//写公司信息
func (this *Company) PostCompany() {
	com := new(models.Company)
	com.Id, _ = this.GetInt64("id")
	com.AccountId = this.currentUser.Id
	com.Name = this.GetString("name")
	com.Website = this.GetString("website")
	com.Fullname = this.GetString("fullname")
	com.Intro = this.GetString("intro")
	com.Country, _ = this.GetInt("country")
	com.City, _ = this.GetInt("city")
	com.Field = strings.Join(this.GetStrings("field"), ",")
	com.State, _ = this.GetInt("state")

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonData(true, "", com))
	} else {
		this.renderJson(utils.JsonData(false, "", es))
	}
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

//写联系信息
func (this *Company) PostContact() {
	companyId, err := this.GetInt64("companyId")
	if err != nil {
		this.renderJson(utils.JsonData(false, "", errors.New("缺乏相应的公司信息")))
		return
	}
	com := new(models.Contact)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Name = this.GetString("name")
	com.Place, _ = this.GetInt("place")
	com.Title = this.GetString("title")
	com.Tel = this.GetString("tel")
	com.Weixin = this.GetString("weixin")
	com.Email = this.GetString("email")
	com.Linkedin = this.GetString("linkedin")
	com.Year, _ = this.GetInt("year")
	com.Month, _ = this.GetInt("month")

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonData(true, "", com))
	} else {
		this.renderJson(utils.JsonData(false, "", es))
	}
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

//写公司介绍
func (this *Company) PostIntroduce() {
	companyId, err := this.GetInt64("companyId")
	if err != nil {
		this.renderJson(utils.JsonData(false, "", errors.New("缺乏相应的公司信息")))
		return
	}
	com := new(models.Introduce)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Images = this.GetString("images")
	com.Content = this.GetString("content")

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonData(true, "", com))
	} else {
		this.renderJson(utils.JsonData(false, "", es))
	}
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

//写相关链接
func (this *Company) PostLinks() {
	companyId, err := this.GetInt64("companyId")
	if err != nil {
		this.renderJson(utils.JsonData(false, "", errors.New("缺乏相应的公司信息")))
		return
	}
	com := new(models.Links)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Iphone = this.GetString("iphone")
	com.Ipad = this.GetString("ipad")
	com.Android = this.GetString("android")
	com.Windows = this.GetString("windows")
	com.Web = this.GetString("web")

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonData(true, "", com))
	} else {
		this.renderJson(utils.JsonData(false, "", es))
	}
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

//写创始团队
func (this *Company) PostMembers() {
	companyId, err := this.GetInt64("companyId")
	if err != nil {
		this.renderJson(utils.JsonData(false, "", errors.New("缺乏相应的公司信息")))
		return
	}
	com := new(models.Members)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Name = this.GetString("name")
	com.Place, _ = this.GetInt("place")
	com.Title = this.GetString("title")
	com.Avatar = this.GetString("avatar")

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonData(true, "", com))
	} else {
		this.renderJson(utils.JsonData(false, "", es))
	}
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

//写融资经历
func (this *Company) PostLoops() {
	companyId, err := this.GetInt64("companyId")
	if err != nil {
		this.renderJson(utils.JsonData(false, "", errors.New("缺乏相应的公司信息")))
		return
	}
	com := new(models.Loops)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Loop, _ = this.GetInt("loop")
	com.AmountMoney, _ = this.GetInt("amountMoney")
	com.Amount, _ = this.GetFloat("amount")
	com.ValueMoney, _ = this.GetInt("valueMoney")
	com.Value, _ = this.GetFloat("value")
	com.Year, _ = this.GetInt("year")
	com.Month, _ = this.GetInt("month")
	com.Investor = this.GetString("investor")

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonData(true, "", com))
	} else {
		this.renderJson(utils.JsonData(false, "", es))
	}
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
	}
	this.Data["contact"] = com
}

// 读取公司介绍
func (this *Company) getIntroduceInfo(id int64) {
	com := new(models.Introduce)
	com.CompanyId = id

	if ok, _ := com.Get(); ok {
	}
	this.Data["introduce"] = com
}

// 读取相关链接
func (this *Company) getLinksInfo(id int64) {
	com := new(models.Links)
	com.CompanyId = id

	if ok, _ := com.Get(); ok {
	}
	this.Data["links"] = com
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
