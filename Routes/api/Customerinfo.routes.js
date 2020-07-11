const router = require('express').Router();
const { auth } = require('./../../middleware/authentication')
const CustomerinfoController = require('./../../Controller/Customerinfo.Controller');
const customer = new CustomerinfoController();


router.put('/customer/update/:id', auth, (req, res) => res.sendAsyncApi(customer.Update(req.body, req.params.id)));
router.get('/customer', (req, res) => res.sendAsyncApi(customer.selectAll()));
router.get('/customer/:id', auth, (req, res) => res.sendAsyncApi(customer.selectOne(req.params.id)));
router.put('/customer/updatepassword/:id', auth, (req, res) => res.sendAsyncApi(customer.UpdateUserpassword(req.body, req.params.id)));
router.get('/customerRegister/:id', auth, (req, res) => res.sendAsyncApi(customer.SelectUserRegister(req.params.id)));

module.exports = router;
