const router = require('express').Router();

const CustomertypeController = require('./../../Controller/Customer_type.Controller');
const Customertype = new CustomertypeController();


router.get('/customertype', (req, res) => res.sendAsyncApi(Customertype.selectAll()));
router.get('/customertype/:id', (req, res) => res.sendAsyncApi(Customertype.selectOne(req.params.id)));
router.post('/customertype/insert', (req, res) => res.sendAsyncApi(Customertype.Insert(req.body)));
router.put('/customertype/update/:id', (req, res) => res.sendAsyncApi(Customertype.Update(req.body, req.params.id)));

module.exports = router;
