package utils

type Result struct {
	Ok   bool        `json:"ok"`
	Key  string      `json:"key"`
	Data interface{} `json:"data"`
}

//返回JSON格式消息
func JsonResult(ok bool, key string, data interface{}) *Result {
	var r = new(Result)
	r.Ok = ok
	r.Key = key
	r.Data = data
	return r
}
