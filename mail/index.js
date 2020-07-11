const mailer = require('nodemailer');
const { welcome } = require("./welcome_template");
const { Welcomeapi } = require("./welcome_template_api");
const { resetPass } = require("./resetpass_template");
const config = require("../Config/env.config")

const getEmailData = (to, name, token, template, username, password) => {
    let data = null;

    switch (template) {
        case "welcomeapi":
            data = {
                from: "CRS",
                to: to,
                subject: `Welcome to CRS ${name}`,
                html: Welcomeapi(token, name)
            }
            break;
        case "welcome":
            data = {
                from: "CRS",
                to: to,
                subject: `Welcome to CRS ${name}`,
                html: welcome(token, username, password)
            }
            break;
        case "resetpassword":
            data = {
                from: config.email,
                to: to,
                subject: `Welcome to CRS ${name}`,
                html: resetPass(token)
            }
            break;
        default:
            data;
    }

    return data;
}


module.exports = {
    sendEmail: (to, name, token, username, password, type) => {
        const smtpTransport = mailer.createTransport({
            service: "Gmail",
            auth: {
                user: config.email,
                pass: config.empassword
            }
        });

        const mail = getEmailData(to, name, token, type, username, password);
        smtpTransport.sendMail(mail, function (error, response) {
            if (error) return false;
            cb()
            smtpTransport.close();
            return true;
        })
        return true;
    }
}
