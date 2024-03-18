const mongoosee = require('mongoose');
const { Schema } = mongoosee;


const TreatsSchema = new Schema({
    treatName: {
        type: String,
        required: true,
    },
    treatDescription: {
        type: String,
        required: false,
    },
    treatPrice: {
        type: Number,
        required: true,
    },
    treatSalePrice : {
        type: Number,
        required: false,
        default: 0
    },
    treatSKU: {
        type: String,
        required: false,
    },
    
    stockStatus: {
        type: String,
        required: true,
        default: 'in-stock'
    },
    treatImage: {
        type: String,
        
    },
});

const Treats = mongoosee.model('Treats', TreatsSchema);

module.exports = Treats;
