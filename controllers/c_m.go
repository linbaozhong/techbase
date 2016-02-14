package controllers

import (
	"techbase/models"
)

type M struct {
	Front
}

func (this *M) Prepare() {
	this.Base.Prepare()

	this.Layout = "_mLayout.tpl"
}

// 文章
func (this *M) Show() {
	id, err := this.getParamsInt64("0")
	if err != nil || id <= 0 {
		// 转向错误页
	}
	this.Data["review"] = this.GetString("review")
	this.Data["articleId"] = id
	this.setTplNames("show")
}

// 事件
func (this *M) Event() {
	id, err := this.getParamsInt64("0")
	if err != nil || id <= 0 {
		// 转向错误页
		this.error_page()
	}

	ev := new(models.Events)
	ev.Id = id

	ok := false

	if this.GetString("review") == "1" {
		ok, err = ev.Get(false)
	} else {
		ok, err = ev.Get(true)
	}

	if !ok || err != nil {
		// 转向错误页
		this.error_page()
	} else {
		this.Data["event"] = ev
		this.Data["index"] = "rili"

		this.setTplNames("event")
	}

}
