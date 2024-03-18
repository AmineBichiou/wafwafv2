const Treats = require('../model/treats');
const { treats } = require('../model/treats');

class TreatService {
    static async addTreat(treatName, treatDescription,treatPrice,treatSalePrice,treatSKU,treatStatus, treatImage) {
        try {
            const newTreat = new Treats({ treatName, treatDescription,treatPrice,treatSalePrice,treatSKU,treatStatus, treatImage });
            return await newTreat.save();
        } catch (error) {
            throw error;
        }
    }

    static async getTreats(params) {
        try {
            const treatName = params.treatName;
            var condition = treatName ? { treatName: { $regex: new RegExp(treatName), $options: "i" } } : {};
            const data = await Treats.find(condition);
            return data;
        } catch (error) {
            throw error;
        }
    }

    static async getTreatsById(id) {
        try {
            const data = await Treats.findById(id);
            if (!data) {
                return 'Treat not found';
            }
            return data;
        } catch (error) {
            return error;
        }
    }


        static async updateTreats(id, treatName, treatDescription,treatPrice, treatSalePrice ,treatSKU,treatStatus, treatImage) {
            try {
                const updates = { treatName, treatDescription,treatPrice,treatSalePrice,treatSKU,treatStatus, treatImage };
                const data = await Treats.findByIdAndUpdate(id, updates, { useFindAndModify: false });
                if (!data) {
                    throw new Error('Treat not found');
                }
                return data;
            } catch (error) {
                throw error;
            }
        }
    
    
    

    static async deleteTreats(id) {
        try {
            const data = await Treats.findByIdAndDelete(id);
            if (!data) {
                return 'Treat not found';
            }
            return data;
        } catch (error) {
            return error;
        }
    }
}

module.exports = TreatService;
