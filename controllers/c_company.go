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
}

// 我的公司列表
func (this *Company) List() {
	com := new(models.Company)

	com.AccountId = this.currentUser.Id

	cs, _ := com.List()

	this.renderJson(utils.JsonData(true, "", cs))
}
