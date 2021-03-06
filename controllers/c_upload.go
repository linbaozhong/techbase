package controllers

import (
	"techbase/utils"
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
		//
		if filepath, err := _image.ToThumbnail(img.FullName, ""); err == nil {
			//如果返回的是相对路径，改为绝对路径
			if filepath[:1] != "/" {
				filepath = "/" + filepath
			}
			fs[index].Path = filepath
		} else {
			this.trace(err)
		}
	}

	if err == nil {
		this.renderJson(utils.JsonResult(true, "", fs))
	} else {
		this.renderJson(utils.JsonResult(false, "", err))
	}
}

// ckeditor上传图片
func (this *Upload) File() {

	var url string
	//var state string

	fs, err := this.upload("upload")

	if err == nil {
		//	state = "SUCCESS"
		//如果返回的是相对路径，改为绝对路径
		if fs[0].Path[:1] != "/" {
			fs[0].Path = "/" + fs[0].Path
		}
		url = fs[0].Path
	} else {
		//	state = err.Error()
	}

	this.renderString("<script type=\"text/javascript\">window.parent.CKEDITOR.tools.callFunction(" + this.GetString("CKEditorFuncNum") + ",'" + url + "','');</script>")

}
