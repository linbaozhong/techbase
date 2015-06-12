package controllers

type M struct {
	Front
}

func (this *M) Prepare() {
	this.Base.Prepare()

	this.Layout = "_mLayout.tpl"
}

//
func (this *M) Show() {
	id, err := this.getParamsInt64("0")
	if err != nil || id <= 0 {
		// 转向错误页
	}
	this.Data["review"] = this.GetString("review")
	this.Data["articleId"] = id
	this.setTplNames("show")
}
