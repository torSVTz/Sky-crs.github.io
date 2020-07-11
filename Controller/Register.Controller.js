const validate = require('validate.js');
const database = require('./../Config/databases');
const UUID = require('uuid-random');
const Callsendmail = require('../mail/index')
const bcrypt = require('bcrypt');
const saltRounds = 10;
class RegisterController {
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
            },
            password: {
                presence: {
                    allowEmpty: false
                }
            },
            username: {
                presence: {
                    allowEmpty: false
                }
            },
            package_id: {
                presence: {
                    allowEmpty: false
                }
            },
            customer_type_id: {
                presence: {
                    allowEmpty: false
                }
            },
            lg: {
                presence: {
                    allowEmpty: false
                }
            },
            lat: {
                presence: {
                    allowEmpty: false
                }
            }
        }
    }

    async InsertData(Data) {
        const errors = this._validate(Data, this.validate_rule);
        if (errors) throw errors;
        const salt = bcrypt.genSaltSync(saltRounds);
        const hash = bcrypt.hashSync(Data.password, salt);

        const items = await this._database.query('call pcd_register(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
            [
                UUID(),
                Data.gender,
                Data.firstname,
                Data.lastname,
                Data.phone_number,
                Data.email,
                Data.province_id,
                Data.district_id,
                Data.village_id,
                hash,
                Data.username,
                Data.package_id,
                Data.customer_type_id,
                Data.details,
                Data.lg,
                Data.lat
            ]
        );
        if (items.affectedRows == 2) {

            if (Callsendmail.sendEmail(Data.email, Data.firstname, null, Data.username, Data.password, 'welcome') == true) {
                return { success: true, items };
            } else {
                return { success: true, message: "please check your email we can not send the code to your email..." };
            }
        } else {
            return items;
        }
    }
}

module.exports = RegisterController;