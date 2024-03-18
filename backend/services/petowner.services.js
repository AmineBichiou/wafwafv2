const PetOwner = require('../model/petowner');
const jwt = require('jsonwebtoken');

class PetOwnerService {
    static async RegisterPetOwner(name, email, password, codepostal, phone, image, pets) {
        try {
            const newPetOwner = new PetOwner({ name, email, password, codepostal, phone, image, pets });
            return await newPetOwner.save();
        } catch (error) {
            throw error;
        }
    }

    static async LoginPetOwner(email) {
        try {
            return await PetOwner.findOne({ email });
        } catch (error) {
            throw error;
        }
    }

    static async generateToken(token, secret, jwt_expire) {
        try {
            return jwt.sign(token, secret, { expiresIn: jwt_expire });
        } catch (error) {
            throw error;
        }
    }

    static async getPetOwner() {
        try {
            return await PetOwner.find();
        } catch (error) {
            throw error;
        }
    }

    static async getPetOwnerById(id) {
        try {
            return await PetOwner.findById(id);
        } catch (error) {
            throw error;
        }
    }

    static async getIdByEmail(email) {
        try {
            const petOwner = await PetOwner.findOne({ email });
            if (!petOwner) {
                throw new Error('PetOwner not found');
            }
            return petOwner._id;
        } catch (error) {
            throw new Error(error.message);
        }
    }
}

module.exports = PetOwnerService;
