const PetOwnerService = require('../services/petowner.services');
const multer = require('multer');
const upload = require('../middleware/upload');
const path = require('path');

// Multer configuration
/*const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads'); 
    },
    filename: function (req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    }
});

const upload = multer({ storage: storage });*/
/*exports.register = upload.single('image'), async (req, res) => {
    try {
        const { name, email, password, codepostal, phone } = req.body;
        //const image = req.file.filename;
        const newPetOwner = await PetOwnerService.RegisterPetOwner(name, email, password, codepostal, phone, image);
        res.json(newPetOwner);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
};*/
exports.register = async (req, res,next ) => {
    upload(req, res, async (err) => {
        if(err){
            next(err);
        }
        else {
            const url = req.protocol + '://' + req.get('host');
            const path = req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
            const name = req.body.name;
            const email = req.body.email;
            const password= req.body.password;
            const codepostal= req.body.codepostal;
            const phone= req.body.phone;
            const image= path != "" ? url + '/' + path : "";
            const pets = req.body.pets;
            try{
                const newPetOwner =await PetOwnerService.RegisterPetOwner(name, email, password, codepostal, phone, image,pets);
                res.json(newPetOwner);
            }
            catch (error) {
                res.status(400).json({ error: error.message });
            }
            
                

        }
    });
}



exports.login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const petowner = await PetOwnerService.LoginPetOwner(email);
        if(!petowner){
            throw new Error('PetOwner not found');
        }
        const isMatch = await petowner.comparePassword(password);
        if(!isMatch){
            throw new Error('Password not match');
        }
        let token = { _id: petowner._id, email: petowner.email };
        const jwtToken = await PetOwnerService.generateToken(token, "aminebichiou2@gmail.com", "5h");
        res.status(200).json({status:true,token:jwtToken });
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
}; 

exports.getPetOwner = async (req, res) => {
    try {
        const petowner = await PetOwnerService.getPetOwner();
        res.json(petowner);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
};

exports.getPetOwnerById = async (req, res) => {
    try {
        const petowner = await PetOwnerService.getPetOwnerById(req.params.id);
        res.json(petowner);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
};

exports.logout = async (req, res) => {
    try {
        res.status(200).json({status:true,token:null });
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
}

exports.getIdByEmail = async (req, res) => {
    try {
        const email = req.params.email; 
        const petOwnerId = await PetOwnerService.getIdByEmail(email);
        res.json(petOwnerId);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
};

