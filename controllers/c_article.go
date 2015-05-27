package controllers

import (
	"fmt"
	"strings"
	"techbase/models"
	"techbase/utils"
)

type Article struct {
	Admin
}

// 媒体管理
func (this *Article) Index() {
	this.Data["index"] = "article"
}

//
func (this *Article) List() {
	// 读取分页规则
	p := new(models.Pagination)

	if size, err := this.GetInt("size"); err != nil || size == 0 {
		p.Size = 20
	}
	p.Index, _ = this.GetInt("index")

	art := new(models.Articles)

	// 读取全部文章
	as, err := art.ListEx(p, "")

	if err == nil {
		this.renderJson(utils.JsonResult(true, "", as))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 创建项目视图
func (this *Article) Edit() {

	id, err := this.getParamsInt64("0")
	if err != nil || id <= 0 {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}

	art := new(models.Articles)
	art.Id = id
	_, err = art.Get()
	this.trace(art)
	// 如果已经提交审核，禁止编辑，跳转至项目信息页
	if id > 0 && (art.Creator != this.currentUser.Id || art.Status > 0) {
		this.Redirect(fmt.Sprintf("/article/info/%d", id), 302)
		this.end()
	}

	this.Data["subTitle"] = "新文章"

	this.Data["article"] = art
}

func (this *Article) Save() {
	art := new(models.Articles)

	art.Id, _ = this.GetInt64("id")
	art.Topic = this.GetString("topic")
	art.Title = this.GetString("title")
	art.SubTitle = this.GetString("subTitle")
	art.Intro = this.GetString("intro")
	art.Content = this.GetString("content")
	art.Author = this.GetString("author")

	if _original, _ := this.GetBool("original"); _original {
		art.Original = 1
	}

	art.Resource = this.GetString("resource")
	art.ResourceUrl = this.GetString("resourceUrl")
	art.Tags = strings.Join(this.GetStrings("tags"), ",")

	if art.Id == 0 {
		this.extendEx(art)
	} else {
		this.extend(art)
	}

	if err, es := art.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", art))
	} else {
		this.renderJson(utils.JsonResult(false, "", es))
	}
}
