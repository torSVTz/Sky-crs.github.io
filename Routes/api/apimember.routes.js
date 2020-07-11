const router = require('express').Router();
const ApiMember = require('./../../Controller/Apimember.Comtroller');
const apimember = new ApiMember();



router.post('/apiregister', (req, res) => res.sendAsyncApi(apimember.RegisterApimember(req.body)));
   
;
module.exports = router;
