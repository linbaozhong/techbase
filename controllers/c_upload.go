package controllers

import (
	"zouzhe/utils"
)

type Upload struct {
	Auth
}

func (this *Upload) Post() {
	fs, err := this.upload("file")

	if err == nil {
		this.renderJson(utils.JsonResult(true, "", fs))
	} else {
		this.renderJson(utils.JsonResult(false, "", err))
	}
}

// 头像
func (this *Upload) Avatar() {
	fs, err := this.upload("file")
	//缩略图
	_image := new(utils.Image)
	for index, img := range fs {
		if filepath, err := _image.ToThumbnail(img.Path[1:], ""); err == nil {
			fs[index].Path = "/" + filepath
		} else {
			//this.trace(err)
		}
	}
	if err == nil {
		this.renderJson(utils.JsonResult(true, "", fs))
	} else {
		this.renderJson(utils.JsonResult(false, "", err))
	}
}
