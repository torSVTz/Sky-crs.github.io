const validate = require("validate.js")
const database = require('../Config/databases')
const bcrypt = require('bcrypt');
const saltRounds = 10;
class CustomerinfoController {
    constructor(valid = validate, db = database.MyqlDatabases) {
        this._database = new db();
        this._validate = valid;
        this._validate.validators.presence.message = 'ບໍ່ສາມາດເປັນຄ່າວ່າງໄດ້';
        this.validate_rule = {
            gender: {
                presence: {
                    allowEmpty: false
                }
            },
            firstname: {
                presence: {
                    allowEmpty: false
                }
            },
            lastname: {
                presence: {
                    allowEmpty: false
                }
            },
            phone_number: {
                presence: {
                    allowEmpty: false
                }
            },
            email: {
                presence: {
                    allowEmpty: false
                }
            },
            province_id: {
                presence: {
                    allowEmpty: false
                }
            },
            district_id: {
                presence: {
                    allowEmpty: false
                }
            },
            village_id: {
                presence: {
                    allowEmpty: false
                }
            }
        }
    }

    async selectAll() {
        const items = await this._database.query('call pcd_view_customer()');
        return items.length == 0 ? null : items[0];
    }

    async selectOne(id) {
        const items = await this._database.query('call pcd_view_customer_one(?)', [id]);
        return items.length == 0 ? null : items[0];
    }

    async SelectUserRegister(id) {
        const items = await this._database.query('select * from view_register where cusid = ?', [id]);
        return items.length == 0 ? null : items[0];
    }

  async  UpdateUserpassword(Data, ID) {
        if (Data.username === "" || Data.password === "") {
            return { message: 'please input username nad password' }
        }
   
        const salt = bcrypt.genSaltSync(saltRounds);
        const hash = bcrypt.hashSync(Data.password, salt);
        const items = await this._database.query('call pcd_update_userpassword(?,?,?)',
        [
            ID,
            Data.username,
            hash
        ]
    );
 
      return items.length == 0 ? null : items[0][0];
    }


  async  Update(Data, ID) {
      
        const errors = this._validate(Data, this.validate_rule);
        if (errors) throw errors;

        const items =  await this._database.query('call pcd_update_customer(?,?,?,?,?,?,?,?,?)',
        [
            ID,
            Data.gender,
            Data.firstname,
            Data.lastname,
            Data.phone_number,
            Data.email,
            Data.province_id,
            Data.district_id,
            Data.village_id
           
        ]
    );
        return items.length == 0 ? null : items[0][0];
        
    }

}



module.exports = CustomerinfoController;