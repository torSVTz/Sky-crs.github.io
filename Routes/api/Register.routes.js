const router = require('express').Router();

const RegisterController = require('./../../Controller/Register.Controller');
const Register = new RegisterController();


router.post('/customer/register', (req, res) => res.sendAsyncApi(Register.InsertData(req.body)));

module.exports = router;
