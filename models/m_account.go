package models

import (
	//"fmt"
	// "errors"
	//"fmt"
	"github.com/astaxie/beego/validation"
)

// 账户
type Accounts struct {
	Id           int64  `json:"accoundId"`
	LoginName    string `json:"loginName" valid:"MaxSize(50)"`
	Password     string `json:"password"`
	RealName     string `json:"realName" valid:"MaxSize(50)"`
	UnionId      string `json:"unionId"`
	OpenId       string `json:"openId" valid:"MaxSize(32)"`
	MOpenId      string `json:"openId" valid:"MaxSize(32)"`
	OpenFrom     string `json:"openFrom" valid:"MaxSize(10)"`
	NickName     string `json:"nickName" valid:"MaxSize(50)"`
	Gender       int    `json:"gender" valid:"Range(0,1)"`
	Avatar_1     string `json:"avatar_1" valid:"MaxSize(250)"`
	Avatar_2     string `json:"avatar_2" valid:"MaxSize(250)"`
	AccessToken  string `json:"accessToken" valid:"MaxSize(150)"`
	RefreshToken string `json:"refreshToken" valid:"MaxSize(150)"`
	Role         int    `json:"role"`
	Status       int    `json:"status" valid:"Range(0,1)"`
	Deleted      int    `json:"deleted" valid:"Range(0,1)"`
	Updator      int64  `json:"updator"`
	Updated      int64  `json:"updated"`
	Ip           string `json:"ip" valid:"MaxSize(23)"`
}

// 账户简介
type AccountProfile struct {
	Id       int64  `json:"accoundId"`
	NickName string `json:"nickName"`
	Telphone string `json:"telphone"`
	Email    string `json:"email"`
	Intro    string `json:"intro"`
	Role     int    `json:role`
	Status   int    `json:"status"`
	Updated  int64  `json:"updated"`
}

// 全部账户列表
func (this *Accounts) AllList() ([]AccountProfile, error) {
	as := make([]AccountProfile, 0)

	//sql := "select accounts.id, accounts.nickname,accounts.role, accounts.status,accounts.updated,profile.telphone,profile.email,profile.intro from accounts left join profile on accounts.id=profile.id where accounts.id!=? and accounts.role>? and accounts.status=? and accounts.deleted=?"
	//err := db.Sql(sql, this.Id, this.Role, Unlock, Undelete).Find(&as)
	sql := "select accounts.id, accounts.nickname,accounts.role, accounts.status,accounts.updated,profile.telphone,profile.email,profile.intro from accounts left join profile on accounts.id=profile.id where accounts.id!=? and accounts.role>? and accounts.deleted=?"
	err := db.Sql(sql, this.Id, this.Role, Undelete).Find(&as)
	return as, err
}

// 账号是否存在
func (this *Accounts) Exists() (bool, error) {
	return db.Get(this)
}

// 自定义数据验证
func (this *Accounts) Valid(v *validation.Validation) {
	//登录名必须是email
	if this.LoginName != "" {
		v.Email(this.LoginName, "loginName")
	}
}

// 增加新账户
func (this *Accounts) Post() (error, []Error) {

	if this.RealName == "" {
		this.RealName = this.NickName
	}
	//数据有效性检验
	if d, err := dataCheck(this); err != nil {
		return err, d
	}
	//
	var err error
	if this.Id > 0 {
		_, err = db.Id(this.Id).Update(this)
	} else {
		_, err = db.Insert(this)
	}
	return err, nil
}

// 读取用户角色
func (this *Accounts) GetRole() (role int, status int, err error) {
	ok, err := db.Get(this)
	if ok {
		role = this.Role
		status = this.Status
	} else {
		role = -1
		status = Locked
	}
	return
}

// 更改用户角色
func (this *Accounts) UpdateRole() error {
	_, err := db.Id(this.Id).Cols("role", "updator", "updated", "ip").Update(this)
	return err
}

// 禁用或启用账户
func (this *Accounts) UpdateStatus() error {
	_, err := db.Id(this.Id).Cols("status", "updator", "updated", "ip").Update(this)
	return err
}

// 更新第三方登录的refreshToken
func (this *Accounts) RefreshAccessToken() (int64, error) {
	return db.Id(this.Id).Cols("unionId", "accessToken", "refreshToken", "updated").Update(this)
}

// --------------------------------------------------
