const router = require('express').Router();
const Demouser = require('./../../Controller/Demouser.Comtroller');
const { auth } = require('./../../middleware/authentication')
const demologin = new Demouser();


router.post('/demologin', (req, res) => {
    const Token = demologin.Login(req.body)
    Token.then(result => {
        res.cookie("CRSAPI", result.token, { httpOnly: true, maxAge: 604800000 });
        res.sendAsyncApi(Token)
    })
});

router.post('/demolockout', (req, res) => {
    res.clearCookie("CRSAPI");
    res.send({ message: "successful" });
})

router.get('/demodata', auth, (req, res) => res.sendAsyncApi(demologin.SelectUser(req.cookies['CRSAPI'])))

module.exports = router;
