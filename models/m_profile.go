package models

import (
	// "errors"
	// "fmt"
	// "techbase/utils"

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
func (this *Profile) Post(pwd ...string) (error, []Error) {
	//数据有效性检验
	if d, err := dataCheck(this); err != nil {
		return err, d
	}
	var err error
	// 检查账号是否存在
	_profile := new(Profile)
	_profile.Id = this.Id

	session := db.NewSession()
	defer session.Close()

	if ok, _ := _profile.Exists(); ok {
		// 更新
		_, err = session.Id(this.Id).Update(this)
	} else {
		// 插入
		_, err = session.Insert(this)
	}
	// 错误回滚
	if err != nil {
		session.Rollback()
		return err, nil
	}

	// _account := new(Accounts)
	// _account.Id = _profile.Id
	// _account.LoginName = _profile.Telphone

	// if len(pwd) > 0 && pwd[0] != "" {
	// 	_account.Password = utils.MD5(pwd[0])
    //     fmt.Println(pwd[0],_account.Password)
	// 	_, err = session.Id(_account.Id).Cols("loginname", "password").Update(_account)
	// 	// 错误回滚
	// 	if err != nil {
	// 		session.Rollback()
	// 		return err, nil
	// 	}
	// }

	err = session.Commit()

	return err, nil
}

// 读取帐户简介
func (this *Profile) Get() (bool, error) {
	return db.Get(this)
}
