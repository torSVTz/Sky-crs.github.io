const router = require('express').Router();

const VillageController = require('./../../Controller/Village.Controller');
const Village = new VillageController();


router.get('/villages/:id', (req, res) => res.sendAsyncApi(Village.selectAll(req.params.id)));

module.exports = router;
