package controllers

import (
	"github.com/astaxie/beego/httplib"
)

type Jingtai struct {
	Admin
}

// 首页
func (this *Jingtai) Index() {

	req := httplib.Get(this.root())

	_html, err := req.String()
	if err == nil {
		this.trace(_html)
	} else {
		this.trace(err)
	}

}
