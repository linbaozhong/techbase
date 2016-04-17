package controllers

import (
	"strings"
	"techbase/models"
	"techbase/utils"

	"github.com/astaxie/beego/validation"
)

type Accounts struct {
	Auth
}

// 检查手机号码是否存在
func (this *Accounts) Exists() {
	loginName := this.GetString("loginName")

	account := new(models.Accounts)

	// 检查该账户是否存在
	if has, _ := account.TelExists(this.currentUser.Id,loginName); has {
		this.renderJson(utils.JsonResult(true, "", "该手机号码已经存在"))
	} else {
		this.renderJson(utils.JsonResult(false, "", ""))
	}
}

//帐户简介
func (this *Accounts) Profile() {
	profile := new(models.Profile)
	// 读取
	profile.Id = this.currentUser.Id
	profile.Get()

	this.Data["nickName"] = utils.UrlDecode(this.Ctx.GetCookie("nickname"))

	this.Data["profile"] = profile
}

// 保存帐户简介
func (this *Accounts) Post() {
	account := new(models.Accounts)
	account.Id = this.currentUser.Id
	account.NickName = this.GetString("nickname")

	profile := new(models.Profile)
	// 读取请求参数
	profile.Id = account.Id
	profile.Telphone = this.GetString("telphone")
	profile.Email = this.GetString("email")
	profile.Intro = this.GetString("intro")
	//
	valid := validation.Validation{}
	valid.Required(account.NickName, "nickname").Message("帐户昵称不能为空")
	valid.Phone(profile.Telphone, "telphone").Message("电话号码格式错误")
	valid.Email(profile.Email, "email").Message("Email格式错误")

	if valid.HasErrors() {
		// 整理错误信息
		errs := make([]models.Error, 0)
		for _, err := range valid.Errors {
			errs = append(errs, models.Error{Key: err.Key, Message: err.Message})
		}
		this.renderJson(utils.JsonResult(false, "", errs))
		return
	}
	// 更新昵称 和 登录密码
	account.LoginName = profile.Telphone
	_password := strings.Trim(this.GetString("password"), " ")

	if len(_password) > 0 {
		account.Password = utils.MD5(_password)
	}
	this.extend(account)

	if err, errs := account.Post(); err == nil {
		this.cookie("nickname", utils.UrlEncode(account.NickName))
		this.currentUser.Name = account.NickName
	} else {
		this.renderJson(utils.JsonResult(false, "", errs))
		return
	}
	// 更新简介
	this.extend(profile)

	err, errs := profile.Post()
	if err == nil {
		this.renderJson(utils.JsonResult(true, "", account))
	} else {
		this.renderJson(utils.JsonResult(false, "", errs))
	}
}
