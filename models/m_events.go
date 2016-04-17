package models

import (
	"fmt"
	"strings"
	"techbase/utils"
)

type Events struct {
	Id        int64  `json:"id"`
	Title     string `json:"title" valid:"Required;MaxSize(250)"` //主题
	StartTime int64  `json:"startTime"`                           //开始时间
	EndTime   int64  `json:"endTime"`                             //结束时间
	//	Img     string `json:"img" valid:"Required;MaxSize(250)"`   //主题图
	//	Address string `json:"Address" valid:"MaxSize(250)"`        //地址
	Intro   string `json:"Intro" valid:"Required"`    //内容
	Status  int    `json:"status" valid:"Range(0,1)"` //0-正常，1-锁定
	Deleted int    `json:"deleted" valid:"Range(0,1)"`
	Creator int64  `json:"creator"`
	Created int64  `json:"created"`
	Updator int64  `json:"updator"`
	Updated int64  `json:"updated"`
	Ip      string `json:"ip" valid:"MaxSize(23)"`
}

type EventsView struct {
	Id        int64  `json:"id"`
	Title     string `json:"title" valid:"Required;MaxSize(250)"` //主题
	StartTime int64  `json:"startTime"`                           //开始时间
	EndTime   int64  `json:"endTime"`                             //结束时间
	//	Img     string `json:"img" valid:"Required;MaxSize(250)"`   //主题图
	//	Address string `json:"Address" valid:"MaxSize(250)"`        //地址
	Intro  string `json:"Intro" valid:"Required"`    //内容
	Status int    `json:"status" valid:"Range(0,1)"` //0-正常，1-锁定
}

func (this *Events) Save() (error, []Error) {
	//数据有效性检验
	if d, err := dataCheck(this); err != nil {
		return err, d
	}
	//
	var err error
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Id(this.Id).Cols("title", "starttime", "endtime", "intro", "updator", "updated", "ip").Update(this)
	}
	return err, nil
}
func (this *Events) SetStatus() (int64, error) {
	return db.Id(this.Id).Cols("status", "updator", "updated", "ip").Update(this)
}
func (this *Events) SetDeleted() (int64, error) {
	return db.Id(this.Id).Cols("status", "deleted", "updator", "updated", "ip").Update(this)
}
func (this *Events) Get(view bool) (bool, error) {
	// 可见的
	if view {
		return db.Where("status=? and deleted=?", Unlock, Undelete).Get(this)
	}
	return db.Where("deleted=?", Undelete).Get(this)
}
func (this *Events) List(view bool, size int, condition string, params ...interface{}) ([]EventsView, error) {
	es := make([]EventsView, 0)

	var where string
	if view {
		where = fmt.Sprintf("status=%d and deleted=%d", Unlock, Undelete)
	} else {
		where = fmt.Sprintf("deleted=%d", Undelete)
	}
	if strings.TrimSpace(condition) != "" {
		where += " and " + condition
	}

	var err error

	if size > 0 {
		err = db.Sql("select id,title,starttime,endtime,status from events where "+where+" limit "+utils.Int2str(size), params...).Find(&es)

	} else {
		err = db.Sql("select id,title,starttime,endtime,status from events where "+where, params...).Find(&es)
	}
	return es, err
}
