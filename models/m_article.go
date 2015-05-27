package models

import (
	// "errors"
	"fmt"
	"github.com/astaxie/beego/validation"
	"strings"
	"techbase/utils"
)

// article表
type Articles struct {
	Id          int64  `json:"id"`
	Topic       string `json:"topic"`                               //主题图
	Title       string `json:"title" valid:"Required;MaxSize(250)"` //标题
	SubTitle    string `json:"subTitle" valid:"MaxSize(250)"`       //副标题
	Intro       string `json:"intro" valid:"MaxSize(250)"`          //内容
	Content     string `json:"content" valid:"Required"`            //内容
	Published   string `json:"published"`                           //发布日期
	Tags        string `json:"tags" valid:"MaxSize(50)"`            //标签
	Original    int    `json"original"`                             //是否原创
	Author      string `json:"author"`                              //作者
	Resource    string `json"resource"`                             //来源单位
	ResourceUrl string `json"resourceUrl"`                          //来源链接
	Recommend   int    `json"recommend"`                            //推荐的
	IsTop       int    `json:"isTop"`                               //置顶的
	Position    int    `json:"position"`                            //位置
	Status      int    `json:"status" valid:"Range(-1,2)"`          //0-草稿，1-审核中，2-审核通过发布，-1-审核未通过
	Deleted     int    `json:"deleted" valid:"Range(0,1)"`
	Creator     int64  `json:"creator"`
	Created     int64  `json:"created"`
	Updator     int64  `json:"updator"`
	Updated     int64  `json:"updated"`
	Ip          string `json:"ip" valid:"MaxSize(23)"`
}

// 文章是否存在
func (this *Articles) Exists() (bool, error) {
	return db.Get(this)
}

// 自定义数据验证
func (this *Articles) Valid(v *validation.Validation) {

}

// 新文章
func (this *Articles) Save() (error, []Error) {
	//数据有效性检验
	if d, err := dataCheck(this); err != nil {
		return err, d
	}

	session := db.NewSession()
	defer session.Close()
	// 事务开始
	err := session.Begin()

	if err != nil {
		session.Rollback()
		return err, nil
	}

	// 写入数据库
	if this.Id == 0 {
		_, err = session.Insert(this)
		if err != nil {
			session.Rollback()
			return err, nil
		}
	} else {
		_, err = session.Id(this.Id).Cols("Topic", "Title", "SubTitle", "Intro", "Content", "Tags", "Original", "Auther", "Resource", "ResourceUrl", "Updator", "Updated", "Ip").Update(this)
		if err != nil {
			session.Rollback()
			return err, nil
		}

		// 变更关联映射,首先删除旧的关系
		_, err = session.Exec("delete from tagarticle where articleId = ?", this.Id)

		if err != nil {
			session.Rollback()
			return err, nil
		}

	}

	// 批量插入新的映射
	if _tags := strings.Split(this.Tags, ","); len(_tags) > 0 {

		tas := make([]TagArticle, len(_tags))
		for i, f := range _tags {
			tas[i].ArticleId = this.Id
			tas[i].TagId = utils.Str2int64(f)
		}

		_, err = session.Insert(&tas)
		if err != nil {
			session.Rollback()
			return err, nil
		}
	}

	// 提交事务
	err = session.Commit()

	return err, nil
}

// 只读取可见的
func (this *Articles) Get() (bool, error) {
	return this._get(false)
}

// 读取全部
func (this *Articles) GetEx() (bool, error) {
	return this._get(true)
}

// 读取
func (this *Articles) _get(all bool) (bool, error) {
	session := db.Id(this.Id)
	defer session.Close()

	// 可见的
	if all {
		return session.Where("articles.status=? and articles.deleted=?", Audit_Yes, Undelete).Get(this)
		//_dal.Where += fmt.Sprintf(" and articles.status=%d and articles.deleted=%d and documents.status=%d and documents.deleted=%d", Unlock, Undelete, Unlock, Undelete)
	}
	return session.Get(this)
}

// 分页列表可见的
func (this *Articles) List(page *Pagination, condition string, params ...interface{}) ([]Articles, error) {
	return this._list(true, page, condition, params...)
}

// 分页列表全部的
func (this *Articles) ListEx(page *Pagination, condition string, params ...interface{}) ([]Articles, error) {
	return this._list(false, page, condition, params...)
}

// 分页列表
func (this *Articles) _list(view bool, page *Pagination, condition string, params ...interface{}) ([]Articles, error) {
	// Dal对象
	_dal := &Dal{}
	_dal.From = "articles"
	_dal.Where = "1=1"
	_dal.OrderBy = "articlemore.position"

	// 可见的
	if view {
		_dal.Where += fmt.Sprintf(" and articles.status=%d and articles.deleted=%d", Unlock, Undelete)
	}
	// 条件
	if strings.TrimSpace(condition) != "" {
		_dal.Where += " and " + condition
	}
	// slice承载返回的结果
	as := make([]Articles, 0)

	// 读取符合条件的记录总数
	if page.Count == 0 {
		// 读取符合条件的记录总数
		if rows := _dal.Count(params...); rows > 0 {
			// 读取总页数
			getPageCount(rows, page)
		}
	}

	if page.Count > 0 {

		_dal.Size = page.Size
		_dal.Offset = page.Index * page.Size

		_dal.Field = "id,title,subtitle,updated"
		err := db.Sql(_dal.Select(), params...).Find(&as)
		return as, err
	}
	return as, nil
}

// 设置locked、deleted等状态字段的公共方法
func (this *Articles) SetStatus(action string) error {
	a := new(Articles)
	a.Id = this.Id

	// 验证当前用户的权限
	if has, err := db.Id(a.Id).Cols("creator").Get(a); has {
		// 如果不是作者，只能删除映射关系
		if a.Creator != this.Updator {
			_, err = db.Exec("delete from articlemore where articleid = ?", this.Id)
			return err
		}
	} else {
		return err
	}

	a.Updated = this.Updated
	a.Updator = this.Updator
	a.Ip = this.Ip

	switch strings.ToLower(action) {
	case "lock":
		action = "status"
		a.Status = Locked
	case "unlock":
		action = "status"
		a.Status = Unlock
	case "delete":
		action = "deleted"
		a.Deleted = Deleted
	case "undelete":
		action = "deleted"
		a.Deleted = Undelete
	}

	// 事务
	session := db.NewSession()
	defer session.Close()
	// 事务开始
	err := session.Begin()

	if err != nil {
		session.Rollback()
		return err
	}
	// 修改articles状态
	_, err = session.Id(a.Id).Cols(action, "updator", "updated", "ip").Update(a)

	if err != nil {
		session.Rollback()
		return err
	}

	// 读取关联的文档id
	if ok, err := this.GetEx(); !ok {
		session.Rollback()
		return err
	}

	// 完成事务提交
	session.Commit()

	return err
}

// 设置文档节点位置
func (this *Articles) SetPosition() (bool, error) {
	return false, nil
}

// 读取目录
func (this *Articles) Catalog(id int64) ([]Articles, error) {
	// Dal对象
	_dal := &Dal{}
	_dal.Field = "articlemore.id as moreid,articlemore.parentid,articlemore.position,articlemore.updator,articles.id,articles.documentid,articles.creator,documents.title"
	_dal.From = "articlemore,articles,documents"
	_dal.Where = fmt.Sprintf("documents.id = articles.documentId and articles.id = articlemore.articleid and articlemore.depth like '%d,%s'", id, "%")
	_dal.OrderBy = "articlemore.depth,articlemore.position"

	// 可见的
	_dal.Where += fmt.Sprintf(" and articles.status=%d and articles.deleted=%d and documents.status=%d and documents.deleted=%d", Unlock, Undelete, Unlock, Undelete)

	// slice承载返回的结果
	as := make([]Articles, 0)

	err := db.Sql(_dal.Select()).Find(&as)
	return as, err
}

// 内容分页列表（可见子孙节点）
func (this *Articles) GetContent(page *Pagination, id int64, condition string, params ...interface{}) ([]Articles, error) {
	return this._content(true, page, id, condition, params...)
}

// 内容分页列表（全部子孙节点）
func (this *Articles) GetContentEx(page *Pagination, id int64, condition string, params ...interface{}) ([]Articles, error) {
	return this._content(false, page, id, condition, params...)
}

// 内容分页列表（子孙节点）
func (this *Articles) _content(view bool, page *Pagination, id int64, condition string, params ...interface{}) ([]Articles, error) {
	// Dal对象
	_dal := &Dal{}
	_dal.From = "articlemore,articles,documents"
	_dal.Where = fmt.Sprintf("documents.id = articles.documentId and articles.id = articlemore.articleid and articlemore.depth like '%d,%s'", id, "%")

	// 可见的
	if view {
		_dal.Where += fmt.Sprintf(" and articles.status=%d and articles.deleted=%d and documents.status=%d and documents.deleted=%d", Unlock, Undelete, Unlock, Undelete)
	}
	// 条件
	if strings.TrimSpace(condition) != "" {
		_dal.Where += " and " + condition
	}
	// slice承载返回的结果
	as := make([]Articles, 0)
	// 读取符合条件的记录总数
	if rows := _dal.Count(params...); rows > 0 {

		getPageCount(rows, page)

		_dal.Size = page.Size
		_dal.Offset = page.Index * page.Size

		_dal.Field = "articlemore.id as moreid,articlemore.parentid,articlemore.position,articlemore.updator,articles.id,articles.documentid,articles.creator,documents.title,documents.content"
		_dal.OrderBy = "articlemore.depth,articlemore.position"

		err := db.Sql(_dal.Select(), params...).Find(&as)
		return as, err
	}
	return as, nil
}

// 读取一个文档
func (this *Articles) GetSingle(condition string, params ...interface{}) error {
	return this._single(true, condition, params...)
}

// 读取一个文档
func (this *Articles) _single(view bool, condition string, params ...interface{}) error {
	// Dal对象
	_dal := &Dal{}
	_dal.Field = "articles.id,articles.documentid,articles.creator,documents.title,documents.content"
	_dal.From = "articles,documents"
	_dal.Where = "documents.id = articles.documentId"

	// 可见的
	if view {
		_dal.Where += fmt.Sprintf(" and articles.status=%d and articles.deleted=%d and documents.status=%d and documents.deleted=%d", Unlock, Undelete, Unlock, Undelete)
	}
	// 条件
	if strings.TrimSpace(condition) != "" {
		_dal.Where += " and " + condition
	}

	_, err := db.Sql(_dal.Select(), params...).Get(this)
	return err
}
