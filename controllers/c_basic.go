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
		options = this.CityOptions(models.Type_Country)
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
	typeId, _ := this.GetInt("typeId")
	parentId, _ := this.GetInt64("parentId")

	basic := new(models.Basic)
	basic.Type = typeId
	basic.ParentId = parentId

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
		this.renderJson(utils.JsonMessage(false, "", err.Error()))
	}

}

// 取当前类型的最大取值
func (this *Basic) MaxValue() {
	basic := new(models.Basic)
	basic.ParentId, _ = this.GetInt64("parentId")
	basic.Type, _ = this.GetInt("typeId")

	has, err := basic.MaxValue()
	if err == nil {
		if has {
			this.renderJson(utils.JsonData(true, "", (basic.Value + 1)))
		} else {
			this.renderJson(utils.JsonMessage(false, "", "0"))
		}
	} else {
		this.trace(err)
		this.renderJson(utils.JsonMessage(false, "", err.Error()))
	}
}

/////////////////////////

// 国家
func (this *Basic) Country() {
	bs := this.getOptions(models.Type_Country)
	this.renderJson(utils.JsonData(true, "", bs))
}

// 城市
func (this *Basic) City() {
	// 国家id
	parentId, _ := this.GetInt64("parentId")
	// 读取选项
	bs := this.getOptions(models.Type_City, parentId)

	this.renderJson(utils.JsonData(true, "", bs))
}

// 公司领域/行业
func (this *Basic) Field() {
	bs := this.getOptions(models.Type_Field)
	this.renderJson(utils.JsonData(true, "", bs))
}

// 公司领域/行业
func (this *Basic) State() {
	bs := this.getOptions(models.Type_State)
	this.renderJson(utils.JsonData(true, "", bs))
}

// 城市select选项
func (this *Basic) CityOptions(typeid int) string {
	basic := new(models.Basic)
	basic.Type = typeid

	bs, _ := basic.List()

	//遍历
	_opts := make([]string, 0)
	_opts = append(_opts, "<select id=\"selectParentId\">")
	for _, item := range bs {
		_opts = append(_opts, fmt.Sprintf("<option value=\"%d\">%s</option>", item.Value, item.Name))
	}
	_opts = append(_opts, "</select>")

	return strings.Join(_opts, "")
}

// 读取选项
func (this *Basic) getOptions(args ...int64) []models.Basic {
	basic := new(models.Basic)

	if len(args) > 0 {
		basic.Type = int(args[0])
		if len(args) > 1 {
			basic.ParentId = args[1]
		}
	}

	bs, err := basic.List()

	if err != nil {
		this.trace(err)
	}
	return bs
}
