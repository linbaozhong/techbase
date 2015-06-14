package models

import (
	"fmt"
)

type CompanyShift struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId" valid:"Required"`
	Email     string `json:"email" valid:"Required;MaxSize(250)"`
	Token     string `json:"token" valid:"Required;MaxSize(32)"`
	Status    int    `json:"status"` //接管状态
	Creator   int64  `json:"creator"`
	Created   int64  `json:"created"`
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

//
func (this *CompanyShift) Exists() bool {
	fmt.Println("Exists")
	n, err := db.Count(this)
	if err == nil {
		return n > 0
	} else {
		return false
	}
}

func (this *CompanyShift) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}
	_shift := new(CompanyShift)
	_shift.CompanyId = this.CompanyId

	if _shift.Exists() {
		_, err = db.Cols("email", "token", "status", "updator", "updated", "ip").Where("companyId=?", this.CompanyId).Update(this)
	} else {
		_, err = db.Insert(this)
	}
	return err, nil

}

func (this *CompanyShift) Get() (bool, error) {
	return db.Get(this)
}
