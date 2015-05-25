package controllers

import (
	"techbase/models"
	"zouzhe/utils"
)

type Item struct {
	Front
}

// 全部审核通过的项目列表
func (this *Item) Index() {
	com := new(models.Company)
	ids := make([]int64, 0)
	// 融资状态
	if apply, err := this.GetInt("apply"); err == nil && (apply == 2 || apply == 3) {
		this.Data["apply"] = apply
		com.Apply = apply
	} else {
		this.Data["apply"] = -1
		com.Apply = -1
	}
	// 行业
	if field, err := this.GetInt("field"); err == nil && field >= 0 {
		this.Data["field"] = field
		ids = new(models.FieldCompany).GetCompanyId(utils.Int2str(field))
	} else {
		this.Data["field"] = -1
		ids = nil
	}
	// 城市
	if city, err := this.GetInt("city"); err == nil && city >= 0 {
		this.Data["city"] = city
		com.City = city
	} else {
		this.Data["city"] = -1
		com.City = -1
	}
	// 是否大赛项目
	if source, err := this.GetInt("source"); err == nil {
		this.Data["source"] = source
		com.Startup = source
	} else {
		this.Data["source"] = -1
		com.Startup = -1
	}
	// 融资轮次
	if loop, err := this.GetInt("loop"); err == nil {
		this.Data["loop"] = loop
		// 读取已融资的项目
		loopIds := new(models.Loops).GetCompany(loop)
		this.trace(ids, loopIds)
		if len(ids) == 0 {
			ids = loopIds
		} else if len(loopIds) > 0 {
			// 取交集
			for _, i := range ids {
				if has, _ := utils.Int64sContains(loopIds, i); !has {
					ids = utils.RemoveInt64Slice(ids, i)
				}
			}
		}
	} else {
		this.Data["loop"] = -1
	}

	com.Status = 2 //已审核通过的公司

	cs, _ := com.AllList(ids)

	//项目融资情况
	if len(ids) > 0 {
		loop := new(models.Loops)
		ls, _ := loop.ListByCompany(ids)
		this.Data["applyLoop"] = ls
	} else {
		this.Data["applyLoop"] = make([]models.Loops, 0)
	}

	this.Data["companys"] = cs
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
	this.getLinksInfo(id)
	this.getMembersList(id)
	this.getLoopsList(id)

	this.setTplNames("info")
	// 记录阅读次数
	com.SetReaded()
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
	basic := new(models.Basic)
	bs, err := basic.All()

	if err == nil {
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
