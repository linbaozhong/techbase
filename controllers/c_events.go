package controllers

import (
	"techbase/models"
	"techbase/utils"
	"time"
)

type Events struct {
	Admin
}

// 活动首页
func (this *Events) Index() {
	this.Data["index"] = "events"

}

// 编辑文章
func (this *Events) Edit() {
	ev := new(models.Events)

	id, err := this.getParamsInt64("0")
	if err != nil || id <= 0 {
		this.Data["subTitle"] = "新活动"
		ev.StartTime = utils.Millisecond(time.Now())
		ev.EndTime = utils.Millisecond(time.Now())
	} else {
		ev.Id = id
		_, err = ev.Get(false)

		this.Data["subTitle"] = "活动修改"
	}

	this.Data["event"] = ev
	this.Data["index"] = "events"
}

func (this *Events) List() {
	evt := new(models.Events)

	es, err := evt.List(false, 0, "")

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
	evt.Title = this.GetString("title")
	//	_start, _ := time.Parse("2006-01-02", this.GetString("startTime"))
	//	_end, _ := time.Parse("2006-01-02", this.GetString("endTime"))
	evt.StartTime, _ = this.GetInt64("startTime")
	evt.EndTime, _ = this.GetInt64("endTime")
	evt.Intro = this.GetString("intro")
	//	evt.Img = this.GetString("img")
	//	evt.Address = this.GetString("address")

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
		if status == models.Unlock {
			status = models.Locked
		} else {
			status = models.Unlock
		}
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
		if deleted == models.Undelete {
			deleted = models.Deleted
		} else {
			deleted = models.Undelete
		}

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
