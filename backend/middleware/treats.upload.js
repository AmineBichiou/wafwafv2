const multer = require('multer');
const path = require('path');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads/treats');
    },
    filename: function (req, file, cb) {
        cb(null, Date.now()+ '-' + file.originalname);
    }
});

const fileFilter = (req, file, cb) => {
    const ValidExtensions = ['.jpg', '.jpeg', '.png'];
    if(ValidExtensions.includes(path.extname(file.originalname).toLowerCase())){
        return cb(new Error('Only images are allowed')  );
    }
    const fileSize = parseInt(req.headers['content-length']);
    if(fileSize > 1000000){
        return cb(new Error('File size is too large'));
    }

    cb(null, true);

};
let upload = multer({ 
    storage: storage,
    FileFilter: fileFilter,
    fileSize : 1000000,

  });

module.exports = upload.single('treatImage');