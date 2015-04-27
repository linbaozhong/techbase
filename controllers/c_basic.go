/*
* 网站基础数据管理模块
 */

package controllers

import (
	"techbase/models"
	"zouzhe/utils"
)

type Basic struct {
	Admin
}

// 首页
func (this *Basic) Index() {
	typeid, _ := this.GetInt(":typeid")
	this.trace(typeid)
	this.Data["typeid"] = typeid
}

// 列表
func (this *Basic) List() {
	typeid, _ := this.GetInt(":typeid")

	basic := new(models.Basic)
	basic.Type = typeid

	bs, _ := basic.List()

	this.renderJson(utils.JsonData(true, "", bs))
}

//
func (this *Basic) Save() {
	basic := new(models.Basic)
	basic.Id, _ = this.GetInt64("id")
	basic.Name = this.GetString("name")
	basic.ParentId, _ = this.GetInt64("parentId")
	basic.Type, _ = this.GetInt("type")
	basic.Value, _ = this.GetInt("value")

	this.extend(basic)

	if _, err := basic.Save(); err == nil {
		this.renderJson(utils.JsonData(true, "", basic))
	} else {
		this.renderJson(utils.JsonData(false, "", err))
	}

}
