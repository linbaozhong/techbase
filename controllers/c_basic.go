/*
* 网站基础数据管理模块
 */

package controllers

import (
	"fmt"
	"strings"
	"techbase/models"
	"zouzhe/utils"
)

type Basic struct {
	Admin
}

// 首页
func (this *Basic) Index() {
	typeid, _ := this.GetInt(":typeid")

	var subTitle string
	var options string

	switch {
	case typeid == models.Type_Country:
		subTitle = "国家"
	case typeid == models.Type_Province:
		subTitle = "省份"
	case typeid == models.Type_City:
		options = this.options(models.Type_Country)
		subTitle = "城市"
	case typeid == models.Type_Field:
		subTitle = "领域"
	case typeid == models.Type_Loop:
		subTitle = "融资轮次"
	case typeid == models.Type_Place:
		subTitle = "职位"
	case typeid == models.Type_State:
		subTitle = "运营状态"
	}

	this.Data["subTitle"] = subTitle
	this.Data["options"] = options
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
		this.renderJson(utils.JsonData(false, "", err.Error()))
	}

}

func (this *Basic) options(typeid int) string {
	basic := new(models.Basic)
	basic.Type = typeid

	bs, _ := basic.List()

	//遍历
	_opts := make([]string, 0)
	_opts = append(_opts, "<select name=\"parentId\">")
	for _, item := range bs {
		_opts = append(_opts, fmt.Sprintf("<option value=\"%d\">%s</option>", item.Value, item.Name))
	}
	_opts = append(_opts, "</select>")

	return strings.Join(_opts, "")
}
