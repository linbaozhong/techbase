package models

import (
	"fmt"
	"github.com/go-xorm/xorm"
	"strings"
	"techbase/utils"
)

type Company struct {
	Id          int64  `json:"id"`
	AccountId   int64  `json:"accountId"`
	Name        string `json:"name" valid:"Required;MaxSize(50)"`
	CompanyName string `json:"comapnyName" valid:"Required;MaxSize(50)"`
	Fullname    string `json:"fullname" valid:"MaxSize(250)"`
	Website     string `json:"website" valid:"MaxSize(250)"`
	Logo        string `json:"logo" valid:"MaxSize(250)"`
	Intro       string `json:"intro" valid:"Required;MaxSize(250)"`
	City        int    `json:"city"`
	Country     int    `json:"country"`
	StartTime   string `json:"startTime"`
	Field       string `json:"field"`
	State       int    `json:"state"`   //运营状态
	Status      int    `json:"status"`  //审核状态
	Reason      string `json:"reason"`  //审核未通过的原因
	Startup     int    `json"startup"`  //是否大赛项目
	Readed      int    `json:"readed"`  //阅读次数
	Apply       int    `json:"apply"`   //融资状态 0-未申请，1-已申请，2-融资中，3-融资成功，4-融资失败
	ApplyId     int64  `json:"applyId"` //对应的融资协议
	Deleted     int    `json:"deleted"`
	Creator     int64  `json:"creator"`
	Created     int64  `json:"created"`
	Updator     int64  `json:"updator"`
	Updated     int64  `json:"updated"`
	Ip          string `json:"ip" valid:"MaxSize(23)"`
}

// 当前用户的项目列表
func (this *Company) List() ([]Company, error) {
	cs := make([]Company, 0)

	err := db.Where("AccountId=? and deleted=?", this.AccountId, Undelete).Find(&cs)

	return cs, err
}

// 全部未删除公司列表
func (this *Company) AllList(ids []int64) (cs []Company, err error) {

	session := db.NewSession()
	defer session.Close()

	fmt.Println("条件为空，直接返回", ids == nil)

	// ids=nil 没有id条件
	if ids == nil || len(ids) == 0 {
		//return
	} else {
		session.In("id", ids)

	}
	if this.Apply != -1 {
		session.And("apply=?", this.Apply)
	}
	if this.City != -1 {
		session.And("city=?", this.City)
	}
	if this.Startup != -1 {
		session.And("Startup=?", this.Startup)
	}

	session.And("status=? and deleted=?", this.Status, Undelete)

	err = session.Find(&cs)

	return
}

// 全部融资状态公司列表
func (this *Company) ApplyList(top int) ([]Company, error) {
	cs := make([]Company, 0)

	if top > 0 {
		db.Limit(top)
	}

	err := db.Where("apply = ? and status = ? and deleted = ?", this.Apply, Audit_Yes, Undelete).Desc("updated").Find(&cs)

	return cs, err
}

// 参加大赛的公司列表
func (this *Company) StartupList(top int) ([]Company, error) {
	cs := make([]Company, 0)

	if top > 0 {
		db.Limit(top)
	}
	err := db.Where("startup = ? and status = ? and deleted = ?", this.Startup, Audit_Yes, Undelete).Desc("updated").Find(&cs)

	return cs, err
}

// 读取
func (this *Company) Get() (bool, error) {
	if this.AccountId == 0 {
		return db.Id(this.Id).Get(this)
	} else {
		return db.Where("id=? and accountId=?", this.Id, this.AccountId).Get(this)
	}
}

// 保存
func (this *Company) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}

	session := db.NewSession()
	defer session.Close()
	// 事务开始
	err = session.Begin()

	if err != nil {
		session.Rollback()
		return err, nil
	}

	// 保存项目
	if this.Id == 0 {
		_, err = session.Insert(this)

		if err != nil {
			session.Rollback()
			return err, nil
		}
	} else {
		_, err = session.Where("id=? and accountId=?", this.Id, this.AccountId).Cols("Name", "CompanyName", "Fullname", "Website", "Logo", "Intro", "City", "Country", "StartTime", "Field", "State", "Updator", "Updated", "Ip").Update(this)

		if err != nil {
			session.Rollback()
			return err, nil
		}
		// 修改公司所属行业映射关系
		// 首先删除旧的关系
		_, err = session.Exec("delete from fieldCompany where companyId = ?", this.Id)

		if err != nil {
			session.Rollback()
			return err, nil
		}
	}

	// 批量插入新的映射
	if _fields := strings.Split(this.Field, ","); len(_fields) > 0 {

		fcs := make([]FieldCompany, len(_fields))
		for i, f := range _fields {
			fcs[i].CompanyId = this.Id
			fcs[i].FieldId = utils.Str2int64(f)
		}

		_, err = session.Insert(&fcs)
		if err != nil {
			session.Rollback()
			return err, nil
		}
	}

	// 提交事务
	err = session.Commit()

	return err, nil
}

// 删除
func (this *Company) Delete() error {
	_, err := db.Id(this.Id).Cols("deleted", "updator", "updated", "ip").Update(this)
	return err
}

//
func (this *Company) Exists() bool {
	var n int64
	var err error

	//if len(any) > 0 && any[0] {
	//	n, err = db.Where("id=?", this.Id).Count(this)
	//} else {
	//	n, err = db.Where("id=? and accountId=?", this.Id, this.AccountId).Count(this)
	//}
	n, err = db.Count(this)
	if err == nil {
		return n > 0
	} else {
		return false
	}
}

// 设置为大赛项目
func (this *Company) SetStartup() error {
	_, err := db.Id(this.Id).Cols("startup", "updator", "updated", "ip").Update(this)
	return err
}

// 更改审核状态
func (this *Company) SetStatus() error {
	_, err := db.Id(this.Id).Cols("status", "reason", "updator", "updated", "ip").Update(this)
	return err
}

// 阅读次数
func (this *Company) SetReaded() {
	this.Readed = this.Readed + 1
	db.Id(this.Id).Cols("readed").Update(this)
}

/*
* 联系公司
 */
type Contact struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId"`
	Name      string `json:"name" valid:"Required;MaxSize(50)"`
	Place     int    `json:"place"`
	Title     string `json:"title" valid:"MaxSize(50)"`
	Year      int    `json:"year" valid:"Required;"`
	Month     int    `json:"month" valid:"Required;"`
	Tel       string `json:"tel" valid:"Required;MaxSize(50)"`
	Weixin    string `json:"weixin" valid:"Required;MaxSize(50)"`
	Email     string `json:"email" valid:"Required;MaxSize(250)"`
	Linkedin  string `json:"linkedin" valid:"MaxSize(250)"`
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

// 读取
func (this *Contact) Get() (bool, error) {
	return db.Where("companyId=?", this.CompanyId).Get(this)
}

// 保存
func (this *Contact) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Where("id=? and companyId=?", this.Id, this.CompanyId).Update(this)
	}
	return err, nil
}

/*
* 公司介绍
 */
type Introduce struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId"`
	Images    string `json:"images" valid:"MaxSize(1250)"`
	Content   string `json:"content" valid:"MaxSize(2500)"`
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

// 读取
func (this *Introduce) Get() (bool, error) {
	return db.Where("companyId=?", this.CompanyId).Get(this)
}

// 保存
func (this *Introduce) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Where("id=? and companyId=?", this.Id, this.CompanyId).Update(this)
	}
	return err, nil
}

/*
* 公司相关链接
 */
type Links struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId"`
	Qrcode    string `json:"qrcode" valid:"MaxSize(250)"`
	Web       string `json:"web" valid:"MaxSize(250)"`
	Iphone    string `json:"iphone" valid:"MaxSize(250)"`
	Ipad      string `json:"ipad" valid:"MaxSize(250)"`
	Android   string `json:"android" valid:"MaxSize(250)"`
	Windows   string `json:"windows" valid:"MaxSize(250)"`
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

// 读取
func (this *Links) Get() (bool, error) {
	return db.Where("companyId=?", this.CompanyId).Get(this)
}

// 保存
func (this *Links) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Where("id=? and companyId=?", this.Id, this.CompanyId).Update(this)
	}
	return err, nil
}

/*
* 公司团队
 */
type Members struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId"`
	Name      string `json:"name" valid:"Required;MaxSize(50)"`
	Place     int    `json:"place"`
	Title     string `json:"title" valid:"MaxSize(50)"`
	Avatar    string `json:"avatar" valid:"MaxSize(250)"`
	Intro     string `json:"intro" valid:"MaxSize(250)"`
	Deleted   int    `json:"deleted"`
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

// 读取
func (this *Members) List() ([]Members, error) {
	ms := make([]Members, 0)
	err := db.Where("companyId=? and deleted=?", this.CompanyId, Undelete).Find(&ms)
	return ms, err
}

// 保存
func (this *Members) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Cols("name", "place", "title", "avatar").Where("id=? and companyId=?", this.Id, this.CompanyId).Update(this)
	}
	return err, nil
}

// 读取
func (this *Members) Get() (bool, error) {
	return db.Id(this.Id).Get(this)
}

// 删除
func (this *Members) Delete() error {
	_, err := db.Id(this.Id).Cols("deleted", "updator", "updated", "ip").Update(this)
	return err
}

/*
* 公司融资经历
 */
type Loops struct {
	Id          int64   `json:"id"`
	CompanyId   int64   `json:"companyId"`
	Loop        int     `json:"loop"`
	AmountMoney int     `json:"amountMoney"`
	Amount      float64 `json:"amount"`
	ValueMoney  int     `json:"valueMoney"`
	Value       float64 `json:"value"`
	Year        int     `json:"year" valid:"Required"`
	Month       int     `json:"month" valid:"Required"`
	Investor    string  `json:"investor"`
	Deleted     int     `json:"deleted"`
	Updator     int64   `json:"updator"`
	Updated     int64   `json:"updated"`
	Ip          string  `json:"ip" valid:"MaxSize(23)"`
}

// 读取
func (this *Loops) List() ([]Loops, error) {
	ls := make([]Loops, 0)
	err := db.Where("companyId=? and deleted=?", this.CompanyId, Undelete).Find(&ls)
	return ls, err
}

// 最新一轮融资
func (this *Loops) ListByCompany(ids []int64) ([]Loops, error) {
	ls := make([]Loops, 0)

	_ids := make([]string, len(ids))
	for i, id := range ids {
		_ids[i] = utils.Int642str(id)
	}

	err := db.Sql("select max(loop) as loop,amountmoney,amount,investor,companyid from loops where companyid in ("+strings.Join(_ids, ",")+") and deleted=? group by companyid", Undelete).Find(&ls)

	fmt.Println(ls)
	return ls, err
}

// 保存
func (this *Loops) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Where("id=? and companyId=?", this.Id, this.CompanyId).Update(this)
	}
	return err, nil
}

// 读取
func (this *Loops) Get() (bool, error) {
	return db.Id(this.Id).Get(this)
}

// 删除
func (this *Loops) Delete() error {
	_, err := db.Id(this.Id).Cols("deleted", "updator", "updated", "ip").Update(this)
	return err
}

// 读取指定融资轮次的公司id
func (this *Loops) GetCompany(loop int, companyIds []int64) (ids []int64) {
	var rows *xorm.Rows
	var err error

	// loop=-1表示不限融资轮次
	if loop == -1 {
		if companyIds == nil || len(companyIds) == 0 {
			rows, err = db.Sql("select distinct companyid from (select companyid, max(loop) as loop from loops group by companyid)").Rows(this)
		} else {
			rows, err = db.Sql("select distinct companyid from (select companyid, max(loop) as loop from loops group by companyid) where companyId in (" + strings.Join(utils.Int64s2Strings(companyIds), ",") + ")").Rows(this)
		}
	} else {
		if companyIds == nil || len(companyIds) == 0 {
			rows, err = db.Sql("select distinct companyid from (select companyid, max(loop) as loop from loops group by companyid) where loop = ?", loop).Rows(this)
		} else {
			rows, err = db.Sql("select distinct companyid from (select companyid, max(loop) as loop from loops group by companyid) where companyId in ("+strings.Join(utils.Int64s2Strings(companyIds), ",")+") and loop = ?", loop).Rows(this)
		}
	}

	if err != nil {
		return
	}
	defer rows.Close()

	for rows.Next() {
		if rows.Scan(this) == nil {
			ids = append(ids, this.CompanyId)
		}
	}

	return
}
