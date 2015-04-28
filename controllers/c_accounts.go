package controllers

import (
	"github.com/astaxie/beego/validation"
	"techbase/models"
	"zouzhe/utils"
)

type Accounts struct {
	Auth
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
		this.renderJson(utils.JsonData(false, "", errs))
		return
	}
	// 更新昵称
	this.extend(account)

	if err, errs := account.Post(); err == nil {
		this.cookie("nickname", utils.UrlEncode(account.NickName))
		this.currentUser.Name = account.NickName
	} else {
		this.renderJson(utils.JsonData(false, "", errs))
		return
	}
	// 更新简介
	this.extend(profile)

	err, errs := profile.Post()
	if err == nil {
		this.renderJson(utils.JsonData(true, "", account))
	} else {
		this.renderJson(utils.JsonData(false, "", errs))
	}
}
