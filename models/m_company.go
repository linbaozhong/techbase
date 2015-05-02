package models

type Company struct {
	Id        int64  `json:"id"`
	AccountId int64  `json:"accountId"`
	Name      string `json:"name" valid:"Required;MaxSize(50)"`
	Fullname  string `json:"fullname" valid:"MaxSize(250)"`
	Website   string `json:"website" valid:"MaxSize(250)"`
	Logo      string `json:"logo" valid:"MaxSize(250)"`
	Intro     string `json:"intro" valid:"Required;MaxSize(250)"`
	City      int    `json:"city"`
	Country   int    `json:"country"`
	StartTime int64  `json:"startTime"`
	Field     string `json:"field"`
	State     int    `json:"state" valid:"Required"`
	Status    int    `json:"status"`
	Deleted   int    `json:"deleted"`
	Creator   int64  `json:"creator"`
	Created   int64  `json:"created"`
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

// 列表
func (this *Company) List() ([]Company, error) {
	cs := make([]Company, 0)

	err := db.Where("AccountId=? and deleted=?", this.AccountId, Undelete).Find(&cs)

	return cs, err
}

// 读取
func (this *Company) Get() (bool, error) {
	return db.Id(this.Id).Get(this)
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
		_, err = db.Id(this.Id).Update(this)
	}
	return err, nil
}

/*
* 联系公司
 */
type Contact struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId"`
	Name      string `json:"name" valid:"Required;MaxSize(50)"`
	Place     int    `json:"place" valid:"Required"`
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
		_, err = db.Id(this.Id).Update(this)
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
		_, err = db.Id(this.Id).Update(this)
	}
	return err, nil
}

/*
* 公司相关链接
 */
type Links struct {
	Id        int64  `json:"id"`
	CompanyId int64  `json:"companyId"`
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
		_, err = db.Id(this.Id).Update(this)
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
	Place     int    `json:"place" valid:"Required;"`
	Title     string `json:"title" valid:"MaxSize(50)"`
	Avatar    string `json:"avatar" valid:"MaxSize(250)"`
	Updator   int64  `json:"updator"`
	Updated   int64  `json:"updated"`
	Ip        string `json:"ip" valid:"MaxSize(23)"`
}

// 读取
func (this *Members) List() ([]Members, error) {
	ms := make([]Members, 0)
	err := db.Where("companyId=?", this.CompanyId).Find(&ms)
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
		_, err = db.Id(this.Id).Update(this)
	}
	return err, nil
}

/*
* 公司融资经历
 */
type Loops struct {
	Id          int64   `json:"id"`
	CompanyId   int64   `json:"companyId"`
	Loop        int     `json:"loop" valid:"Required;"`
	AmountMoney int     `json:"amountMoney"`
	Amount      float64 `json:"amount"`
	ValueMoney  int     `json:"valueMoney"`
	Value       float64 `json:"value"`
	Year        int     `json:"year" valid:"Required;"`
	Month       int     `json:"month" valid:"Required;"`
	Investor    string  `json:"investor"`
	Updator     int64   `json:"updator"`
	Updated     int64   `json:"updated"`
	Ip          string  `json:"ip" valid:"MaxSize(23)"`
}

// 读取
func (this *Loops) List() ([]Loops, error) {
	ls := make([]Loops, 0)
	err := db.Where("companyId=?", this.CompanyId).Find(&ls)
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
		_, err = db.Id(this.Id).Update(this)
	}
	return err, nil
}
