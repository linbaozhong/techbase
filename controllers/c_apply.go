package controllers

import (
	"techbase/models"
	"zouzhe/utils"
)

type Apply struct {
	Auth
}

func (this *Apply) Index() {
	// 项目id
	id, _ := this.getParamsInt64("0")

	if id <= 0 {
		this.error_page("项目不存在")
		return
	}

	com := this.getCompanyInfo(id, true)

	if com.Id <= 0 {
		this.error_page("项目不存在")
		return
	}
	if com.Status != models.Audit_Yes {
		this.error_page("项目还没有通过审核")
		return
	}
	this.Data["companyId"] = id
	this.setTplNames("index")
}

// 提交申请
func (this *Apply) PostApply() {
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

	com := new(models.Apply)
	com.Id, _ = this.GetInt64("id")
	com.CompanyId = companyId
	com.Bpath = this.GetString("bpath")

	if this.getCheckboxBool("agree") {
		com.Agree = 1
	}

	if this.getCheckboxBool("accept") {
		com.Accept = 1
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
