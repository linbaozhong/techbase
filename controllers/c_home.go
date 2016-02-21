package controllers

import (
	"fmt"
	//	"time"
	//"github.com/astaxie/beego"
	"techbase/models"
	"techbase/utils"
)

type Home struct {
	Front
}

// 首页
func (this *Home) Get() {
	this.Data["index"] = "index"
	com := new(models.Company)
	//大赛的项目
	com.Startup = 1
	cs, _ := com.StartupList(3, Dev)
	this.Data["startup"] = cs
	//融资情况
	ids := make([]int64, len(cs))
	for i, c := range cs {
		ids[i] = c.Id
	}

	if len(ids) > 0 {
		loop := new(models.Loops)
		//ls, _ := loop.ListByCompany(strings.Join(ids, ","))
		ls, _ := loop.ListByCompany(ids)
		this.Data["startupLoop"] = ls
	} else {
		this.Data["startupLoop"] = make([]models.Loops, 0)
	}

	//融资完成的项目
	com.Apply = 3
	cs, _ = com.ApplyList(3, Dev)
	this.Data["apply"] = cs
	//融资情况
	ids = make([]int64, len(cs))
	for i, c := range cs {
		ids[i] = c.Id
	}

	if len(ids) > 0 {
		loop := new(models.Loops)
		ls, _ := loop.ListByCompany(ids)
		this.Data["applyLoop"] = ls
	} else {
		this.Data["applyLoop"] = make([]models.Loops, 0)
	}

	this.setTplNames("index")
}

// 分页读取新闻列表
func (this *Home) News() {
	// 读取分页规则
	p := new(models.Pagination)

	if size, err := this.GetInt("size"); err != nil || size == 0 {
		p.Size = 20
	} else {
		p.Size = size
	}

	p.Index, _ = this.GetInt("index")

	_type, _ := this.GetInt("type")

	cache_key := fmt.Sprintf("%s_%s_%d_%d_%d", this.controllerName, this.actionName, _type, p.Size, p.Index)
	// 检查和读取cache
	if !Dev {
		if cache_val := BCache.Get(cache_key); cache_val != nil {

			this.renderJson(utils.ActionResult(true, cache_val))

			return
		}
	}

	art := new(models.Articles)

	// 读取文章
	as := make([]models.ArticlesView, 0)
	var err error
	// 开发模式，读取全部文章
	if Dev {
		as, err = art.ListEx(p, "articles.deleted=? and articles.type=?", models.Undelete, _type)
	} else {
		// 生成模式，读取已发布的文章
		as, err = art.List(p, "articles.type=?", _type)
	}

	if err == nil {
		// 缓存
		BCache.Put(cache_key, as, 600)
		this.renderJson(utils.JsonResult(true, "", as))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 读取活动日历
func (this *Home) Event() {
	id, err := this.getParamsInt64("0")
	if err != nil || id <= 0 {
		// 转向错误页
		this.error_page()
	}

	ev := new(models.Events)
	ev.Id = id

	ok := false

	if this.GetString("review") == "1" {
		ok, err = ev.Get(false)
	} else {
		ok, err = ev.Get(true)
	}

	if !ok || err != nil {
		// 转向错误页
		this.error_page()
	} else {
		this.Data["event"] = ev
		this.Data["index"] = "rili"

		this.setTplNames("event")
	}
}

// 读取活动日历列表
func (this *Home) Events() {
	t, _ := this.GetInt64("time")
	dt := utils.Msec2Time(t)

	evt := new(models.Events)

	es, err := evt.List(true, "startTime>? and endTime<?", utils.Millisecond(dt.AddDate(0, 0, -7)), utils.Millisecond(dt.AddDate(0, 1, 7)))

	if err == nil {
		this.renderJson(utils.JsonResult(true, "", es))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

// 热门文章
func (this *Home) HotNews() {
	//热门文章的条数
	size, _ := this.GetInt("size")
	_type, _ := this.GetInt("type")
	cache_key := fmt.Sprintf("hotnews_%d_%d", size, _type)
	// 检查和读取cache
	if !Dev {
		if cache_val := BCache.Get(cache_key); cache_val != nil {
			this.renderJson(utils.ActionResult(true, cache_val))
			return
		}
	}

	art := new(models.Articles)
	if as, err := art.HotList(size, _type); err == nil {
		// 缓存
		BCache.Put(cache_key, as, 600)
		// 输出
		this.renderJson(utils.ActionResult(true, as))
	} else {
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
}

//
func (this *Home) Show() {
	id, err := this.getParamsInt64("0")
	if err != nil || id <= 0 {
		// 转向错误页
		this.error_page()
	}

	art := new(models.Articles)
	art.Id = id

	av := make([]models.ArticlesView, 0)

	if (Dev || this.GetString("review") == "1") && this.currentUser.Id > 0 {
		av, err = art.ShowArticle(false)
	} else {
		av, err = art.ShowArticle(true)
	}

	if err == nil && len(av) > 0 {
		this.Data["article"] = av[0]
		if av[0].Type == 0 {
			this.Data["index"] = "media"
		} else {
			this.Data["index"] = "baodao"
		}
		this.setTplNames("show")
	} else {
		// 转向错误页
		this.error_page()
	}
	//	this.Data["articleId"] = id
	//	this.Data["review"] = this.GetString("review")
	//	this.Data["index"] = "media"
	//	this.setTplNames("show")

}

// 读取文章
func (this *Home) ShowNews() {
	id, err := this.GetInt64("id")

	if err != nil || id <= 0 {
		// 返回错误
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}

	art := new(models.Articles)
	art.Id = id

	cache_key := fmt.Sprintf("%s_%s_%d_%s", this.controllerName, this.actionName, id, this.GetString("review"))
	// 检查和读取cache
	if !Dev {
		if cache_val := BCache.Get(cache_key); cache_val != nil {
			this.renderJson(utils.ActionResult(true, cache_val))
			return
		}
	}

	var av interface{}
	if (Dev || this.GetString("review") == "1") && this.currentUser.Id > 0 {
		av, err = art.ShowArticle(false)
	} else {
		av, err = art.ShowArticle(true)
	}

	if err == nil {
		// 缓存
		BCache.Put(cache_key, av, 600)

		this.renderJson(utils.ActionResult(true, av))
	} else {
		this.renderJson(utils.ActionResult(false, models.Err(err.Error())))
	}

}

// 阅读次数
func (this *Home) readed(art *models.Articles) {
	//
	sessionId := this.Ctx.GetCookie("snow_sessionId")
	if this.currentUser.Id > 0 || len(sessionId) > 0 {
		sns := new(models.SnsArticle)
		sns.AccountId = this.currentUser.Id
		sns.SessionId = sessionId
		sns.ArticleId = art.Id

		if ok, _ := sns.SetReaded(); ok {
			//art.SetReaded()
		}
	}
}

// 点赞
func (this *Home) Loved() {
	this.trace("点赞")
	id, err := this.GetInt64("id")

	if err != nil || id <= 0 {
		// 返回错误
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}
	//
	//
	sessionId := this.Ctx.GetCookie("snow_sessionId")
	if this.currentUser.Id > 0 || len(sessionId) > 0 {
		sns := new(models.SnsArticle)
		sns.AccountId = this.currentUser.Id
		sns.SessionId = sessionId
		sns.ArticleId = id

		if ok := sns.SetLoved(); ok {
			this.renderJson(utils.JsonResult(true, "", ""))
		} else {
			this.renderJson(utils.JsonResult(false, "", ""))
		}
	}
}

//
func (this *Home) GetSNS() {
	id, err := this.GetInt64("id")

	if err != nil || id <= 0 {
		// 返回错误
		this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
	}

	sessionId := this.Ctx.GetCookie("snow_sessionId")
	if this.currentUser.Id > 0 || len(sessionId) > 0 {
		sns := new(models.SnsArticle)
		sns.AccountId = this.currentUser.Id
		sns.SessionId = sessionId
		sns.ArticleId = id

		// 记录阅读此时
		if ok, err := sns.SetReaded(); ok {
			this.renderJson(utils.JsonResult(true, "", sns))
		} else {
			//			this.trace(sns)
			this.renderJson(utils.JsonResult(false, "", models.Err(err.Error())))
		}
	}
}

//
func (this *Home) Home() {
	this.Data["index"] = "home"
	this.setTplNames("home")
}

//
func (this *Home) Media() {
	this.Data["index"] = "media"
	this.setTplNames("media")
}

// 媒体报道
func (this *Home) Baodao() {
	this.Data["index"] = "baodao"
	this.setTplNames("baodao")
}

// 活动日历
func (this *Home) Rili() {
	this.Data["index"] = "rili"
	this.setTplNames("rili")
}

// 关于我们
func (this *Home) About() {
	this.Data["index"] = "about"
	this.setTplNames("about")
}

// 她vc
func (this *Home) Vc() {
	this.Data["index"] = "vc"
	this.setTplNames("vc")
}

//
func (this *Home) HerStart() {
	this.Data["index"] = "home"
	this.setTplNames("herstart")
}

//
func (this *Home) Community() {
	this.Data["index"] = "community"
	this.setTplNames("community")
}

// 阅读
func (this *Home) Brand() {
	id := this.getParamsString(":id")

	if id == "" {
		// 跳转到首页
		this.Redirect("/", 302)
		this.end()
	} else {
		this.Data["index"] = "brandshow"
		this.setTplNames(id)
	}
}

// 帮助
func (this *Home) Help() {
	this.setTplNames("help")
}

// 签出
func (this *Home) SignOut() {
	this.loginOut()
	this.renderJson(utils.JsonResult(true, "", ""))
}

/*
* 通用错误消息地址
 */
func (this *Home) Error() {
	this.Data["message"] = this.GetString(":msg")
	this.setTplNames("error")
}
