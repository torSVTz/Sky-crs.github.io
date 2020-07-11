const router = require('express').Router();
var multer = require('multer');

const myStorage = multer.diskStorage(
    {
   destination: function(req,file,cb) {
       cb(null, 'upload/image/')
   },
    filename: function(req, file, cb){
        cb(null, Date.now() + file.originalname)       
    }
}
);

const fileFilter =(req , file , cb)=>{
if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png'){
    cb(null,true)
}else {
    cb(null,false)
}
}

const  upload = multer({
     storage : myStorage,
     limits:{
         fileSize: 1024 *1024* 5
     },
     fileFilter : fileFilter
    
})

const AdvertriseController = require('./../../Controller/advertrise.Controller');
const advertrise = new AdvertriseController();


router.put('/advertrise/update/:id',upload.single('picturefile'), (req, res) =>{
    const items = advertrise.UpdateData(req.body,req.file.filename,req.params.id);
res.sendAsyncApi(items);   
});
router.get('/advertrise', (req, res) => res.sendAsyncApi(advertrise.selectAll()));
router.post('/advertrise/insert',upload.single('picturefile'), (req, res) =>{
    const items = advertrise.InsertData(req.body,req.file.filename);
res.sendAsyncApi(items);   
});

module.exports = router;
