package controllers

import (
	"fmt"
	"techbase/models"
	"techbase/utils"
)

type Item struct {
	Front
}

// 全部审核通过的项目列表
func (this *Item) Index() {
	com := new(models.Company)
	ids := make([]int64, 0)
	// // 融资状态
	// if apply, err := this.GetInt("apply"); err == nil && (apply == 2 || apply == 3) {
	// 	this.Data["apply"] = apply
	// 	com.Apply = apply
	// } else {
	// 	this.Data["apply"] = -1
	// 	com.Apply = -1
	// }
	// // 行业
	// if field, err := this.GetInt("field"); err == nil && field >= 0 {
	// 	this.Data["field"] = field
	// 	// 按指定行业读取项目id
	// 	ids = new(models.FieldCompany).GetCompanyId(utils.Int2str(field))

	// } else {
	// 	this.Data["field"] = -1
	// }
	// // 城市
	// if city, err := this.GetInt("city"); err == nil && city >= 0 {
	// 	this.Data["city"] = city
	// 	com.City = city
	// } else {
	// 	this.Data["city"] = -1
	// 	com.City = -1
	// }
	// // 是否大赛项目
	// if source, err := this.GetInt("source"); err == nil {
	// 	this.Data["source"] = source
	// 	com.Startup = source
	// } else {
	// 	this.Data["source"] = -1
	// 	com.Startup = -1
	// }

	com.Apply = -1
	com.City = -1
	com.Startup = -1

	// 融资轮次
	loop, err := this.GetInt("loop")
	if err == nil {
		this.Data["loop"] = loop
	} else {
		this.Data["loop"] = -1
		loop = -1
	}

	// // 如果指定行业的项目数为空，直接返回空记录集
	// if this.Data["field"] != -1 && len(ids) == 0 {
	// 	this.Data["companys"] = nil
	// 	return
	// }

	// 按指定融资轮次读取项目id
	ids = new(models.Loops).GetCompany(loop, ids)

	//this.trace(loop, ids)
	// 如果符合融资条件的项目数为空，直接返回空记录集
	if len(ids) == 0 {
		this.Data["companys"] = nil
		return
	}

	com.Status = 2 //已审核通过的公司

	// 按综合条件读取项目
	this.Data["companys"], _ = com.AllList(ids)

	// 按综合条件项目融资情况
	if len(ids) > 0 {
		loop := new(models.Loops)
		ls, _ := loop.ListByCompany(ids)
		this.Data["applyLoop"] = ls
	} else {
		this.Data["applyLoop"] = make([]models.Loops, 0)
	}

	this.Data["index"] = "items"
}

// 项目详情
func (this *Item) Info() {
	id, _ := this.GetInt64("0")

	if id <= 0 {
		this.error_page("项目不存在")
		return
	}

	com := this.getCompanyInfo(id, false)
	if com.Id <= 0 {
		this.error_page("项目不存在")
		return
	}

	this.getIntroduceInfo(id)

	//	//联系人信息只有审核人和投资人可见
	//	if this.currentUser.Role < models.Role_Editor || this.currentUser.Role == models.Role_VC {
	//联系人信息只有审核人和投资人可见
	if this.currentUser.Role < models.Role_Editor {
		this.Data["look"] = true
		this.getContactInfo(id)
	} else {
		this.Data["look"] = false
	}

	this.getLinksInfo(id)
	this.getMembersList(id)
	this.getLoopsList(id)

	this.setTplNames("info")
	// 记录阅读次数
	go this.readed(com)
}

// 阅读次数
func (this *Item) readed(com *models.Company) {
	//
	sessionId := this.Ctx.GetCookie("snow_sessionId")
	if this.currentUser.Id > 0 || len(sessionId) > 0 {
		sns := new(models.SnsProject)
		sns.AccountId = this.currentUser.Id
		sns.SessionId = sessionId
		sns.ProjectId = com.Id

		if ok := sns.SetReaded(); ok {
			com.SetReaded()
		}
	}
}

// 国家
func (this *Item) Country() {
	bs := this.getOptions(models.Type_Country)
	this.renderJson(utils.JsonResult(true, "", bs))
}

// 城市
func (this *Item) City() {
	// 国家id
	parentId, _ := this.GetInt64("parentId")
	// 读取选项
	bs := this.getOptions(models.Type_City, parentId)

	this.renderJson(utils.JsonResult(true, "", bs))
}

// 公司领域/行业
func (this *Item) Field() {
	bs := this.getOptions(models.Type_Field)
	this.renderJson(utils.JsonResult(true, "", bs))
}

// 公司职位
func (this *Item) Place() {
	bs := this.getOptions(models.Type_Place)
	this.renderJson(utils.JsonResult(true, "", bs))
}

// 公司运营状态
func (this *Item) State() {
	bs := this.getOptions(models.Type_State)
	this.renderJson(utils.JsonResult(true, "", bs))
}

// 公司融资经历
func (this *Item) Loop() {
	bs := this.getOptions(models.Type_Loop)
	this.renderJson(utils.JsonResult(true, "", bs))
}

// 货币种类
func (this *Item) Money() {
	bs := this.getOptions(models.Type_Money)
	this.renderJson(utils.JsonResult(true, "", bs))
}

// 全部基础数据
func (this *Item) Basic() {
	cache_key := fmt.Sprintf("%s_%s", this.controllerName, this.actionName)
	// 检查和读取cache
	if cache_val := BCache.Get(cache_key); cache_val != nil {
		if callback := this.GetString("callback"); callback != "" {
			this.renderJsonp(cache_val)
		} else {
			this.renderJson(utils.ActionResult(true, cache_val))
		}
		return
	}

	basic := new(models.Basic)
	bs, err := basic.All()

	if err == nil {

		// 缓存
		BCache.Put(cache_key, bs, 600)

		if callback := this.GetString("callback"); callback != "" {
			this.renderJsonp(bs)
		} else {
			this.renderJson(utils.JsonResult(true, "", bs))
		}
	} else {
		this.trace(err)
		this.renderJson(utils.JsonResult(false, "", models.Error(models.Err(err.Error()))))
	}
}

// 读取选项
func (this *Item) getOptions(args ...int64) []models.Basic {
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
