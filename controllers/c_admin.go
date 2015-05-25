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
	if this.currentUser.Role == models.Role_Auditor || this.currentUser.Role == models.Role_Administrator || this.currentUser.Role == models.Role_System {

	} else {
		if this.IsAjax() {
			this.renderJson(utils.JsonResult(false, "", "拒绝访问未授权的功能，请联系系统管理员……"))
			return
		} else {
			// 跳转到错误页
			//this.Redirect(this.UrlFor("Home.Error", ":msg", utils.UrlEncode("拒绝访问未授权的功能，请联系系统管理员……")), 302)
			//this.end()
			this.error_page(utils.UrlEncode("拒绝访问未授权的功能，请联系系统管理员……"))
			return
		}
	}
}

// 媒体管理
func (this *Admin) Media() {
	// 读取分页规则
	p := new(models.Pagination)

	if size, err := this.GetInt("size"); err != nil || size == 0 {
		p.Size = 20
	}
	p.Index, _ = this.GetInt("index")

	art := new(models.Articles)

	// 读取全部文章
	as, _ := art.ListEx(p, "")

	this.Data["index"] = "article"
	this.Data["articles"] = as
}

// 项目审核
func (this *Admin) Company() {
	com := new(models.Company)
	//com.Status, _ = this.GetInt("status")
	com.Status = 1 //已提交审核的公司

	cs, _ := com.AllList(nil)

	this.Data["index"] = "company"
	this.Data["companys"] = cs
}

// 指定为大赛项目
func (this *Admin) Startup() {
	id, err := this.GetInt64("id")

	if err != nil || id <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的参数")))
		return
	}

	com := new(models.Company)
	com.Id = id
	com.Startup, _ = this.GetInt("startup")

	// 检查要提交数据的项目是否存在，防止第三方恶意写入
	if !this.exists(id, true) {
		this.renderJson(utils.JsonResult(false, "", models.Err("项目主体错误或不存在")))
		return
	}

	this.extend(com)

	if err := com.SetStartup(); err == nil {
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 提交审核
func (this *Admin) SubmitAudit() {
	id, err := this.GetInt64("id")

	if err != nil || id <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err("缺乏相应的参数")))
		return
	}

	com := new(models.Company)
	com.Id = id
	com.Status, _ = this.GetInt("status")
	com.Reason = this.GetString("reason")
	com.Startup, _ = this.GetInt("startup")

	// 检查要提交数据的项目是否存在，防止第三方恶意写入
	if !this.exists(id, true) {
		this.renderJson(utils.JsonResult(false, "", models.Err("项目主体错误或不存在")))
		return
	}

	this.extend(com)

	if err := com.SetStatus(); err == nil {
		this.renderJson(utils.JsonResult(true, "", com))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 账户管理
func (this *Admin) Account() {
	act := new(models.Accounts)
	act.Id = this.currentUser.Id
	act.Role = this.currentUser.Role

	// 读取低于当前用户角色的可用账户列表
	as, _ := act.AllList()

	this.Data["index"] = "account"
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
		this.renderJson(utils.JsonResult(false, "", "输入数据有误,请修正后重试……"))
	}
	// 提交更改
	if err := act.UpdateRole(); err == nil {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.renderJson(utils.JsonResult(false, "", err.Error()))
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
		this.renderJson(utils.JsonResult(false, "", "输入数据有误,请修正后重试……"))
	}
	// 提交更改
	if err := act.UpdateStatus(); err == nil {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.renderJson(utils.JsonResult(false, "", err.Error()))
	}
}

//////////////////////////////////////
