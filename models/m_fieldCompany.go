package models

import (
	"strings"
	"techbase/utils"
)

type FieldCompany struct {
	FieldId   int64
	CompanyId int64
}

func (this *FieldCompany) GetCompanyId(fieldIds string) (ids []int64) {

	_fids := strings.Split(fieldIds, ",")
	_ids := make([]int64, len(_fids))

	for i, id := range _fids {
		_ids[i] = utils.Str2int64(id)
	}

	rows, err := db.In("fieldId", _ids).Rows(this)
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
