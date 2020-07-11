const validate = require("validate.js")
const database = require('../Config/databases')

class CustomertypeController {
    constructor(valid = validate, db = database.MyqlDatabases) {
        this._database = new db();
        this._validate = valid;
        this._validate.validators.presence.message = 'ບໍ່ສາມາດເປັນຄ່າວ່າງໄດ້';
        this.validate_rule = {
            cus_ty_name_lao: {
                presence: {
                    allowEmpty: false
                }
            },
            cus_ty_description_lao: {
                presence: {
                    allowEmpty: false
                }
            },
            cus_ty_name_eng: {
                presence: {
                    allowEmpty: false
                }
            },
            cus_ty_description_eng: {
                presence: {
                    allowEmpty: false
                }
            }
        }
       
    }
    async  selectAll() {     
        const items = await this._database.query('call pcd_customer_type()');
        return items.length == 0 ? null : items[0]
    }
    async  selectOne(id) {     
        const errors = this._validate({ id }, { id: { numericality: true } } , this.validate_rule);
        if (errors) throw  errors ;
        const items = await this._database.query('call pcd_customer_type_one(?)',[id]);
        return items.length == 0 ? null : items[0]
    }
    async  Insert(value) {     
        const errors = this._validate(value ,this.validate_rule);  
        if (errors) throw  errors ;
      
        const items = await this._database.query('call pcd_customer_type_insert(?,?,?,?)',
        [
            value.cus_ty_name_lao,
            value.cus_ty_description_lao,
            value.cus_ty_name_eng,
            value.cus_ty_description_eng
        ]
        );
        return items.length == 0 ? null : items[0]
    }

    async  Update(value,id) {     
        const errors = this._validate(value ,this.validate_rule);  
        if (errors) throw  errors ;     
        const items = await this._database.query('call pcd_customer_type_update(?,?,?,?,?)',
        [
            id,
            value.cus_ty_name_lao,
            value.cus_ty_description_lao,
            value.cus_ty_name_eng,
            value.cus_ty_description_eng
        ]
        );
        return items.length == 0 ? null : items[0]
    }
}

module.exports = CustomertypeController;