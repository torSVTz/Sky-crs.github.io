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

const PackageController = require('./../../Controller/Package.Controller');
const Package = new PackageController();



router.get('/package', (req, res) => res.sendAsyncApi(Package.selectAll()));
router.post('/package/insert',upload.single('picturefile'), (req, res) =>{     
const items =  Package.insertPackage(req.body,req.file.filename);
res.sendAsyncApi(items);
});

module.exports = router;
