package controllers

import (
	"fmt"
	"techbase/models"
	"techbase/utils"
)

type Article struct {
	Admin
}

// 创建项目视图
func (this *Article) Edit() {

	id, _ := this.getParamsInt64("0")

	com := this.getCompanyInfo(id)

	// 如果已经提交审核，禁止编辑，跳转至项目信息页
	if id > 0 && (com.Creator != this.currentUser.Id || com.Status > 0) {
		this.Redirect(fmt.Sprintf("/articls/info/%d", id), 302)
		this.end()
	}

	this.getContactInfo(id)

	this.Data["subTitle"] = "新文章"

	this.Data["companyId"] = id
}

func (this *Article) Save() {
	art := new(models.Articles)

	if art.Id == 0 {
		this.extendEx(art)
	} else {
		this.extend(art)
	}

	if err, es := art.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", art))
	} else {
		this.renderJson(utils.JsonResult(false, "", es))
	}
}
