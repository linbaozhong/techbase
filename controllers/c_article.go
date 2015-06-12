package controllers

import (
	"fmt"
	//"strings"
	"techbase/models"
	"techbase/utils"
)

type Article struct {
	Admin
}

// 媒体管理
func (this *Article) Index() {
	this.Data["index"] = "article"
	this.Data["status"] = 0
}

//
func (this *Article) List() {
	// 读取分页规则
	p := new(models.Pagination)

	if size, err := this.GetInt("size"); err != nil || size == 0 {
		p.Size = 20
	} else {
		p.Size = size
	}

	p.Index, _ = this.GetInt("index")
	status, _ := this.GetInt("status")

	art := new(models.Articles)

	as := make([]models.ArticlesView, 0)
	var err error

	// 读取回收站文章
	if status == -2 {
		as, err = art.ListEx(p, "articles.deleted=?", models.Deleted)
	} else {
		// 按status读取全部文章
		as, err = art.ListEx(p, "articles.status=? and articles.deleted=?", status, models.Undelete)
	}

	if err == nil {
		this.renderJson(utils.JsonResult(true, "", as))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 创建项目视图
func (this *Article) Edit() {
	art := new(models.Articles)

	id, err := this.getParamsInt64("0")
	if err != nil || id <= 0 {
		//this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
		this.Data["subTitle"] = "文章编辑"
	} else {
		art.Id = id
		_, err = art.GetEx()

		// 如果已经提交审核，禁止编辑，跳转至项目信息页
		if id > 0 && this.currentUser.Role > 3 && art.Creator != this.currentUser.Id || art.Status > 0 {
			this.Redirect(fmt.Sprintf("/home/show/%d?review=1", id), 302)
			this.end()
		}

		this.Data["subTitle"] = "新文章"
	}

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
	art.Original, _ = this.GetInt("original")
	art.Resource = this.GetString("resource")
	art.ResourceUrl = this.GetString("resourceUrl")
	//art.Tags = strings.Join(this.GetStrings("tags"), ",")
	art.Tags, _ = this.GetInt("tags")

	if art.Id == 0 {
		this.extendEx(art)
	} else {
		this.extend(art)
	}

	if err, _ := art.Save(); err == nil {
		this.renderJson(utils.JsonResult(true, "", art))
	} else {
		this.renderJson(utils.JsonResult(false, "", err.Error()))
	}
}

// 请求审核
func (this *Article) Audit() {
	art := new(models.Articles)

	id, err := this.GetInt64("id")

	if err == nil && id > 0 {
		art.Id = id
		// 状态
		if status, _ := this.GetInt("status"); status == 0 {
			art.Status = models.Audit_Ing
		} else {
			art.Status = status
			if status == -1 {
				art.Reason = this.GetString("reason")
			}
		}
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
		return
	}
	this.extend(art)

	if _, err := art.SetStatus(); err == nil {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.trace(err)
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}

}

// 置顶
func (this *Article) SetTop() {
	art := new(models.Articles)

	id, err := this.GetInt64("id")
	istop, err := this.GetInt("istop")

	if err == nil && id > 0 {
		art.Id = id
		art.IsTop = istop
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
		return
	}

	this.extend(art)

	if ok, err := art.SetTop(); err == nil && ok > 0 {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.trace(err)
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 推荐
func (this *Article) SetRecommend() {
	art := new(models.Articles)

	id, err := this.GetInt64("id")
	recommend, err := this.GetInt("recommend")

	if err == nil && id > 0 {
		art.Id = id
		art.Recommend = recommend
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
		return
	}

	this.extend(art)

	if ok, err := art.SetRecommend(); err == nil && ok > 0 {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 推荐
func (this *Article) SetDelete() {
	art := new(models.Articles)

	id, err := this.GetInt64("id")

	if err == nil && id > 0 {
		art.Id = id
		if val, _ := this.GetInt("value"); val == 0 {
			art.Deleted = models.Deleted
		} else {
			art.Deleted = models.Undelete
			art.Status = models.Audit_Ing
		}
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
		return
	}

	this.extend(art)

	if ok, err := art.SetDelete(); err == nil && ok > 0 {
		this.renderJson(utils.JsonResult(true, "", ""))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}
