/*
* 我的项目管理模块
 */

package controllers

import (
	"errors"
	"fmt"
	"strings"
	"techbase/models"
	"zouzhe/utils"
)

type Company struct {
	Auth
}

// 我的项目首页
func (this *Company) Index() {
	this.Data["subTitle"] = "我管理的项目"
}

// 创建项目视图
func (this *Company) Edit() {

	id, _ := this.getParamsInt64("0")

	com := this.getCompanyInfo(id)

	// 如果已经提交审核，禁止编辑，跳转至项目信息页
	if id > 0 && (com.Creator != this.currentUser.Id || com.Status > 0) {
		this.Redirect(fmt.Sprintf("/item/info/%d", id), 302)
		this.end()
	}

	this.getContactInfo(id)

	this.Data["subTitle"] = "项目简介"

	this.Data["companyId"] = id
}

// 申请融资
func (this *Company) Apply() {
	id, _ := this.GetInt64(":id")
	this.trace(id)
	this.setTplNames("apply")
}

// 我的项目列表
func (this *Company) List() {
	com := new(models.Company)

	com.AccountId = this.currentUser.Id

	cs, _ := com.List()

	this.renderJson(utils.JsonResult(true, "", cs))
}

// 读取项目信息
func (this *Company) GetCompany() {
	// 项目id
	id, _ := this.getParamsInt64("0")

	this.getCompanyInfo(id)

	this.Layout = ""
	this.setTplNames("_company")
}

// 写项目信息
func (this *Company) PostCompany() {
	com := new(models.Company)
	com.Id, _ = this.GetInt64("id")
	com.AccountId = this.currentUser.Id
	com.Name = this.GetString("name")
	com.Website = this.GetString("website")
	com.CompanyName = this.GetString("companyName")
	com.Fullname = this.GetString("fullname")
	com.Intro = this.GetString("intro")
	com.Logo = this.GetString("logo")
	com.Country, _ = this.GetInt("country")
	com.City, _ = this.GetInt("city")
	com.Field = strings.Join(this.GetStrings("field"), ",")
	com.State, _ = this.GetInt("state")
	com.StartTime = this.GetString("starttime")

	this.extendEx(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.renderJson(utils.JsonResult(false, "", es))
	}
}

// 提交项目审核状态
func (this *Company) SubmitAudit() {
	com := new(models.Company)
	com.Id, _ = this.GetInt64("id")
	com.Status = models.Audit_Ing

	// 检查要提交数据的项目是否存在，防止第三方恶意写入
	if !this.exists(com.Id) {
		this.renderJson(utils.JsonResult(false, "", models.Err("项目主体错误或不存在")))
		return
	}

	this.extend(com)

	if err := com.SetStatus(); err == nil {
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 读取联系信息
func (this *Company) GetContact() {
	// 项目id
	id, _ := this.getParamsInt64("0")

	this.getContactInfo(id)
	this.Data["subTitle"] = "联系方式"

	this.Layout = ""
	this.setTplNames("_contact")
}

//写联系信息
func (this *Company) PostContact() {
	companyId, err := this.GetInt64("companyId")
	if err != nil || companyId <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的项目信息")))
		return
	}
	// 检查要提交数据的项目是否存在，防止第三方恶意写入
	if !this.exists(companyId) {
		this.renderJson(utils.JsonResult(false, "", []models.Error{models.Err("项目主体错误或不存在")}))
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
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.trace(err, es)
		es = append(es, models.Error{Message: err.Error()})
		this.renderJson(utils.JsonResult(false, "", es))
	}
}

// 读取项目介绍
func (this *Company) GetIntroduce() {
	// 项目id
	id, _ := this.getParamsInt64("0")

	this.getIntroduceInfo(id)

	this.Data["subTitle"] = "项目详情"
	this.Layout = ""
	this.setTplNames("_introduce")
}

//写项目介绍
func (this *Company) PostIntroduce() {
	companyId, err := this.GetInt64("companyId")
	if err != nil || companyId <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的项目信息")))
		return
	}
	com := new(models.Introduce)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Images = this.GetString("images")
	com.Content = this.GetString("content")

	// 检查要提交数据的项目是否存在，防止第三方恶意写入
	if !this.exists(companyId) {
		this.renderJson(utils.JsonResult(false, "", []models.Error{models.Err("项目主体错误或不存在")}))
		return
	}

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.trace(err, es)
		es = append(es, models.Err(err.Error()))
		this.renderJson(utils.JsonResult(false, "", es))
	}
}

// 读取项目相关链接
func (this *Company) GetLinks() {
	// 项目id
	id, _ := this.getParamsInt64("0")

	this.getLinksInfo(id)

	this.Data["subTitle"] = "相关链接"
	this.Layout = ""
	this.setTplNames("_links")
}

//写相关链接
func (this *Company) PostLinks() {
	companyId, err := this.GetInt64("companyId")
	if err != nil || companyId <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的项目信息")))
		return
	}
	com := new(models.Links)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Qrcode = this.GetString("qrcode")
	com.Iphone = this.GetString("iphone")
	com.Ipad = this.GetString("ipad")
	com.Android = this.GetString("android")
	com.Windows = this.GetString("windows")
	com.Web = this.GetString("web")

	// 检查要提交数据的项目是否存在，防止第三方恶意写入
	if !this.exists(companyId) {
		this.renderJson(utils.JsonResult(false, "", []models.Error{models.Err("项目主体错误或不存在")}))
		return
	}

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.trace(err, es)
		es = append(es, models.Error{Message: err.Error()})
		this.renderJson(utils.JsonResult(false, "", es))
	}
}

// 读取项目创始团队
func (this *Company) GetMembers() {
	// 项目id
	id, _ := this.getParamsInt64("0")
	//
	com := this.getCompanyInfo(id)

	// 如果已经提交审核，禁止编辑，跳转至项目信息页
	if id > 0 && (com.Creator != this.currentUser.Id || com.Status > 0) {
		this.Redirect(fmt.Sprintf("/company/info/%d", id), 302)
		this.end()
	}

	this.getMembersList(id)

	this.Data["companyId"] = id
	this.Data["subTitle"] = "创始团队"
	this.Layout = ""
	this.setTplNames("_members")
}

// 读取一个创始团队成员
func (this *Company) GetMember() {
	id, err := this.GetInt64("id")
	if err != nil || id <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的参数")))
		return
	}
	com := new(models.Members)
	com.Id = id

	if has, err := com.Get(); err == nil {
		this.trace(has, err)
		if has {
			this.renderJson(utils.JsonResult(true, "", com))
		} else {
			this.renderJson(utils.JsonResult(false, "", "没有找到符合条件的数据"))
		}
	} else {
		this.trace(err)
		this.renderJson(utils.JsonResult(false, "", err.Error()))
	}
}

//写创始团队
func (this *Company) PostMembers() {
	companyId, err := this.GetInt64("companyId")
	if err != nil || companyId <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的项目信息")))
		return
	}
	com := new(models.Members)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Name = this.GetString("name")
	com.Place, _ = this.GetInt("place")
	com.Title = this.GetString("title")
	com.Avatar = this.GetString("avatar")

	// 检查要提交数据的项目是否存在，防止第三方恶意写入
	if !this.exists(companyId) {
		this.renderJson(utils.JsonResult(false, "", []models.Error{models.Err("项目主体错误或不存在")}))
		return
	}

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.trace(err, es)
		es = append(es, models.Error{Message: err.Error()})
		this.renderJson(utils.JsonResult(false, "", es))
	}
}

// 删除团队成员
func (this *Company) DeleteMember() {
	id, err := this.GetInt64("id")
	if err != nil || id <= 0 {
		this.renderJson(utils.JsonResult(false, "", errors.New("缺乏相应的参数")))
		return
	}

	com := new(models.Members)
	com.Id = id
	com.Deleted = models.Deleted

	this.extend(com)

	if err := com.Delete(); err == nil {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.renderJson(utils.JsonResult(false, "", err.Error()))
	}
}

// 读取融资经历
func (this *Company) GetLoops() {
	// 项目id
	id, _ := this.getParamsInt64("0")

	this.getLoopsList(id)

	this.Data["companyId"] = id
	this.Data["subTitle"] = "融资经历"
	this.Layout = ""
	this.setTplNames("_loops")
}

//写融资经历
func (this *Company) PostLoops() {
	companyId, err := this.GetInt64("companyId")
	if err != nil || companyId <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的项目信息")))
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

	// 检查要提交数据的项目是否存在，防止第三方恶意写入
	if !this.exists(companyId) {
		this.renderJson(utils.JsonResult(false, "", []models.Error{models.Err("项目主体错误或不存在")}))
		return
	}

	this.extend(com)

	if err, es := com.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.trace(err, es)
		es = append(es, models.Error{Message: err.Error()})
		this.renderJson(utils.JsonResult(false, "", es))
	}
}

// 读取一个融资经历实体
func (this *Company) GetLoop() {
	id, err := this.GetInt64("id")
	if err != nil || id <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的参数")))
		return
	}
	com := new(models.Loops)
	com.Id = id

	if has, err := com.Get(); err == nil {
		this.trace(has, err)
		if has {
			this.renderJson(utils.JsonResult(true, "", com))
		} else {
			this.renderJson(utils.JsonResult(false, "", "没有找到符合条件的数据"))
		}
	} else {
		this.trace(err)
		this.renderJson(utils.JsonResult(false, "", err.Error()))
	}
}

// 删除融资经历
func (this *Company) DeleteLoops() {
	id, err := this.GetInt64("id")
	if err != nil || id <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的参数")))
		return
	}

	com := new(models.Loops)
	com.Id = id
	com.Deleted = models.Deleted

	this.extend(com)

	if err := com.Delete(); err == nil {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.renderJson(utils.JsonResult(false, "", err.Error()))
	}
}

//////////////////////////////////////////
