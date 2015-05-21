package models

import ()

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
	Readed      int    `json:"readed"`  //阅读次数
	Apply       int    `json:"apply"`   //融资状态
	ApplyId     int64  `json:"applyId"` //对应的融资协议
	Deleted     int    `json:"deleted"`
	Creator     int64  `json:"creator"`
	Created     int64  `json:"created"`
	Updator     int64  `json:"updator"`
	Updated     int64  `json:"updated"`
	Ip          string `json:"ip" valid:"MaxSize(23)"`
}

// 列表
func (this *Company) List() ([]Company, error) {
	cs := make([]Company, 0)

	err := db.Where("AccountId=? and deleted=?", this.AccountId, Undelete).Find(&cs)

	return cs, err
}

// 全部未删除公司列表
func (this *Company) AllList() ([]Company, error) {
	cs := make([]Company, 0)

	err := db.Where("status=? and deleted=?", this.Status, Undelete).Find(&cs)

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
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Where("id=? and accountId=?", this.Id, this.AccountId).Omit("deleted", "status", "creator", "created").Update(this)
	}
	return err, nil
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
	Tel       string `json:"tel" valid:"MaxSize(50)"`
	Weixin    string `json:"weixin" valid:"MaxSize(50)"`
	Email     string `json:"email" valid:"MaxSize(250)"`
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
