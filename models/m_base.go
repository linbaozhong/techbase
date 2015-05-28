package models

import (
	"errors"
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/validation"
	//_ "github.com/go-sql-driver/mysql"
	"github.com/astaxie/beego/cache"
	"github.com/go-xorm/core"
	"github.com/go-xorm/xorm"
	_ "github.com/mattn/go-sqlite3"
	"math"
	"strings"
	"techbase/utils"
)

//页面公共信息
type Page struct {
	SiteName    string //网站名称
	Title       string //页面标题
	Company     string //公司名称
	Domain      string //域名
	Copyright   string //版权
	Keywords    string //Seo关键词
	Description string //Seo描述
	Author      string //作者
	Product     string //产品名称
	Version     string //版本
}
type Current struct {
	Id     int64  `json:"id"`
	Name   string `json:"name"`
	Avatar string `json:"avatar"`
	From   string `json:"from"`
	Role   int    `json:"role"`
	Status int    `json:status`
}

//公共字段
type Field struct {
	Sequence int
	Status   int8
	Deleted  int8
	Updator  int64
	Updated  int64
	Ip       string
	Name     string
	Role     int
}

//错误信息
type Error struct {
	Key     string `json:"key"`
	Message string `json:"message"`
}

//分页
type Pagination struct {
	Count int `json:"count"` //总页数
	Prev  int `json:"prev"`  //上页索引
	Index int `json:"index"` //当前页
	Next  int `json:"next"`  //下页索引
	Size  int `json:"size"`  //每页条数
}

//列表选项
type SelectItem struct {
	Key      string
	Value    string
	Selected bool //是否选中项
}

//上传文件
type UploadFile struct {
	Name string `json:"name"` //文件名
	Ext  string `json:"ext"`  //扩展名（文件类型）
	Path string `json:"path"` //路径
	Size int64  `json:"size"` //文件大小
}

type ReturnJson struct {
	Page *Pagination `json:"page"`
	Data interface{} `json:"data"`
}

var (
	db *xorm.Engine
	bm cache.Cache
)

func init() {
	var err error
	//db, err = xorm.NewEngine("mysql", "writer:writer2015@tcp(dbwriter.mysql.rds.aliyuncs.com:3306)/writer?charset=utf8")
	db, err = xorm.NewEngine("sqlite3", "./data/techbase.db")

	if err != nil {
		beego.Trace(err)
	}

	db.SetMapper(core.SameMapper{})

	//db.ShowInfo = true
	//db.ShowDebug = true
	db.ShowSQL = true
	db.ShowErr = true
	//db.ShowWarn = true

	// 缓存
	bm, err = cache.NewCache("memory", `{"interval":60}`)
	if err != nil {
		beego.Trace(err)
	}
}

/*
* 数据有效性检查
 */
func dataCheck(d interface{}) ([]Error, error) {
	//数据有效性检验
	valid := validation.Validation{}
	b, err := valid.Valid(d)

	if err != nil {
		return nil, err
	}
	if !b {
		// 整理错误信息
		es := make([]Error, 0)

		for _, err := range valid.Errors {
			es = append(es, Error{Key: err.Key, Message: err.Message})
			beego.Error(fmt.Sprintf("无效数据：%s-%s", err.Key, err.Message))
		}
		return es, errors.New("无效数据")
	}
	return nil, nil
}

//xorm的补充
func parseDb(dbs []map[string][]byte) []map[string]string {
	_st := make([]map[string]string, 0)
	for _, value := range dbs {
		_mt := make(map[string]string)
		for k, v := range value {
			_mt[k] = string(v)
		}
		_st = append(_st, _mt)
	}
	return _st
}

// 根据记录总数，返回总页数
func getPageCount(rows int64, page *Pagination) {
	fmt.Println(rows, page.Size)
	page.Count = int(math.Ceil(float64(rows) / float64(page.Size)))
}

// 错误
func Err(s string, k ...string) Error {
	e := new(Error)
	e.Message = s

	if len(k) > 0 {
		e.Key = k[0]
	}
	return *e
}

// ---------- 数据库 DAL 层 -------------------

// Select 语句
type Dal struct {
	Field   string
	From    string
	Where   string
	OrderBy string
	Size    int
	Offset  int
}

// 生成Select语句
func (this *Dal) Select() string {
	_sql := make([]string, 0)
	_sql = append(_sql, "select "+this.Field+" from "+this.From)

	if strings.TrimSpace(this.Where) != "" {
		_sql = append(_sql, "where "+this.Where)
	}

	if strings.TrimSpace(this.OrderBy) != "" {
		_sql = append(_sql, "order by  "+this.OrderBy)
	}

	if this.Size > 0 {
		_sql = append(_sql, fmt.Sprintf("limit %d offset %d", this.Size, this.Offset))
	}

	return strings.Join(_sql, " ")
}

// 记录数目统计
func (this *Dal) Count(params ...interface{}) int64 {

	this.Field = "count(*) as counts"
	return utils.Str2int64(this.Single("counts", params...))
}

// 返回第一行第一个字段的字符串形式
func (this *Dal) Single(field string, params ...interface{}) string {
	if rows, err := db.Query(this.Select(), params...); len(rows) > 0 && err == nil {
		return strings.TrimSpace(string(rows[0][field]))
	}
	return ""
}
