/*
* 内容管理控制器
 */
package controllers

import (
	"fmt"
	"strings"
	"techbase/models"
	"zouzhe/utils"
)

type Admin struct {
	Auth
}

func (this *Admin) Prepare() {
	this.Auth.Prepare()

	// 要求管理员以上级别访问权限
	if this.currentUser.Role == models.Role_Administrator || this.currentUser.Role == models.Role_System {

	} else {
		if this.IsAjax() {
			this.renderJson(utils.JsonMessage(false, "", "拒绝访问未授权的功能，请联系系统管理员……"))
			return
		} else {
			// 跳转到错误页
			this.Redirect(this.UrlFor("Home.Error", ":msg", utils.UrlEncode("拒绝访问未授权的功能，请联系系统管理员……")), 302)
			this.end()
		}
	}
}

//
func (this *Admin) Index() {
	this.setTplNames("index")
}

// 审核公司
func (this *Admin) Company() {
	com := new(models.Company)
	com.Status, _ = this.GetInt("status")

	cs, _ := com.AllList()

	this.Data["companys"] = cs
}

// 账户管理
func (this *Admin) Account() {
	act := new(models.Accounts)
	act.Id = this.currentUser.Id
	act.Role = this.currentUser.Role

	// 读取低于当前用户角色的可用账户列表
	as, _ := act.AllList()

	this.Data["accounts"] = as

	// 角色选择框
	roles := []string{"系统管理员", "网站管理员", "内容审核人", "作者", "读者", "游客"}
	options := make([]string, 6)
	length := len(roles) - this.currentUser.Role - 1

	for i := 0; i < length; i++ {
		options[i] = fmt.Sprintf("<option value=\"%d\">%s</option>", i+this.currentUser.Role+1, roles[i+this.currentUser.Role+1])
	}
	fmt.Println(strings.Join(options, ""))
	this.Data["option"] = strings.Join(options, "")
}

// 更改用户角色
func (this *Admin) UpdateRole() {
	act := new(models.Accounts)
	act.Id, _ = this.GetInt64("id")
	act.Role, _ = this.GetInt("role")
	this.extend(act)

	// 校验输入参数,而且角色只能比当前用户的角色低
	if act.Id <= 0 || this.currentUser.Role > act.Role {
		this.renderJson(utils.JsonMessage(false, "", "输入数据有误,请修正后重试……"))
	}
	// 提交更改
	if err := act.UpdateRole(); err == nil {
		this.renderJson(utils.JsonMessage(true, "", ""))
	} else {
		this.renderJson(utils.JsonMessage(false, "", err.Error()))
	}
}

// 禁用或启用账户
func (this *Admin) UpdateStatus() {
	act := new(models.Accounts)
	act.Id, _ = this.GetInt64("id")
	act.Status, _ = this.GetInt("status")
	this.extend(act)

	// 校验输入参数,而且角色只能比当前用户的角色低
	if act.Id <= 0 {
		this.renderJson(utils.JsonMessage(false, "", "输入数据有误,请修正后重试……"))
	}
	// 提交更改
	if err := act.UpdateStatus(); err == nil {
		this.renderJson(utils.JsonMessage(true, "", ""))
	} else {
		this.renderJson(utils.JsonMessage(false, "", err.Error()))
	}
}
