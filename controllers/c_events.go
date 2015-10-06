package controllers

import (
	"techbase/models"
	"techbase/utils"
)

type Events struct {
	Admin
}

func (this *Events) Index() {
	this.Data["index"] = "events"

}
func (this *Events) List() {
	evt := new(models.Events)

	es, err := evt.List(false, "")

	if err == nil {
		this.renderJson(utils.JsonResult(true, "", es))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 保存
func (this *Events) Save() {
	evt := new(models.Events)
	evt.Id, _ = this.GetInt64("id")
	evt.Topic = this.GetString("topic")
	evt.Start, _ = this.GetInt64("start")
	evt.End, _ = this.GetInt64("end")
	evt.Intro = this.GetString("intro")
	evt.Img = this.GetString("img")
	evt.Address = this.GetString("address")

	if evt.Id == 0 {
		this.extendEx(evt)
	} else {
		this.extend(evt)
	}

	if err, _ := evt.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", evt))
	} else {
		this.renderJson(utils.JsonResult(false, "", err.Error()))
	}
}

// 设置状态
func (this *Events) SetStatus() {
	evt := new(models.Events)

	id, err := this.GetInt64("id")
	status, err := this.GetInt("status")

	if err == nil && id > 0 {
		evt.Id = id
		evt.Status = status
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
		return
	}

	this.extend(evt)

	if ok, err := evt.SetStatus(); err == nil && ok > 0 {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}

}

//删除
func (this *Events) SetDeleted() {
	evt := new(models.Events)

	id, err := this.GetInt64("id")
	deleted, err := this.GetInt("deleted")

	if err == nil && id > 0 {
		evt.Id = id
		evt.Deleted = deleted
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
		return
	}

	this.extend(evt)

	if ok, err := evt.SetDeleted(); err == nil && ok > 0 {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}

}
