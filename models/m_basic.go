/*
*	基础数据
 */
package models

type Basic struct {
	Id       int64  `json:"id"`
	ParentId int64  `json:"parentId"`
	Type     int    `json:"type"`
	Name     string `json:"name" valid:"Required"`
	Value    int    `json:"value"`
	Alias    string `json:"alias"`
	Status   int    `json:"status"`
	Deleted  int    `json:"deleted"`
	Updator  int64  `json:"updator"`
	Updated  int64  `json:"updated"`
	Ip       string `json:"ip"`
}

// 列表
func (this *Basic) List() ([]Basic, error) {
	bs := make([]Basic, 0)

	err := db.Where("parentid=? and type=? and deleted=?", this.ParentId, this.Type, Undelete).Find(&bs)

	return bs, err
}

func (this *Basic) Save() (error, []Error) {
	// 数据有效性检验
	es, err := dataCheck(this)
	if err != nil {
		return err, es
	}
	if this.Id == 0 {
		_, err = db.Insert(this)
	} else {
		_, err = db.Id(this.Id).Cols("name", "value", "alias").Update(this)
	}
	return err, nil
}

func (this *Basic) MaxValue() (bool, error) {
	return db.Where("type=? and parentid=? and deleted=?", this.Type, this.ParentId, Undelete).Limit(1).Desc("value").Get(this)
}
