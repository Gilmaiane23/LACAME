const multer = require('multer');
const path = require('path');
const fs = require('fs');
const crypto = require('crypto');

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const date = new Date();
        const localUpload = "uploads/" + [date.getFullYear(), date.getMonth()+1].join('/');
        
        if(!fs.existsSync(localUpload)) fs.mkdirSync(localUpload, {recursive:true});

        cb(null, path.resolve(localUpload));
    },
    filename: (req, file, cb) => {
        const uuid = crypto.randomUUID();
        req.body.anexo_uuid = uuid;
        req.body.extension= path.extname(file.originalname);
        cb(null, `${uuid}${req.body.extension}`);
    },
});

export const upload = multer({
    storage: storage
});