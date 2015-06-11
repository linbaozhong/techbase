package models

import (
	// "errors"
	//"fmt"
	"github.com/astaxie/beego/validation"
)

// 账户简介
type Profile struct {
	Id       int64  `json:"accoundId"`
	Telphone string `json:"telphone" valid:"Phone;MaxSize(50)"`
	Email    string `json:"email" valid:"Email;MaxSize(250)"`
	Intro    string `json:"intro" valid:"MaxSize(250)"`
	Updated  int64  `json:"updated"`
	Ip       string `json:"ip" valid:"MaxSize(23)"`
}

// 检查账号是否存在
func (this *Profile) Exists() (bool, error) {
	return db.Get(this)
}

// 自定义数据验证
func (this *Profile) Valid(v *validation.Validation) {
	//登录名必须是email
	if this.Email != "" {
		v.Email(this.Email, "loginName")
	}
}

// 增加新账户简介
func (this *Profile) Post() (error, []Error) {
	//数据有效性检验
	if d, err := dataCheck(this); err != nil {
		return err, d
	}
	var err error
	// 检查账号是否存在
	_profile := new(Profile)
	_profile.Id = this.Id

	if ok, _ := _profile.Exists(); ok {
		// 更新
		_, err = db.Id(this.Id).Update(this)
	} else {
		// 插入
		_, err = db.Insert(this)
	}
	return err, nil
}

// 读取帐户简介
func (this *Profile) Get() (bool, error) {
	return db.Get(this)
}
