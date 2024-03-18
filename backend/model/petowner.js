const mongoose = require('mongoose');
const { Schema } = mongoose;

const bcrypt = require('bcrypt');


const petSchema = new Schema({
    name: String,
    race: Boolean,
    age: Number,
    image: String,
});


const petOwnerSchema = new Schema({
    name: String,
    email: {
        type: String,
        lowercase: true,
        required: [true, "userName can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "password is required"],
    },
    codepostal : Number,
    phone : Number,
    image : String,
    pets: [petSchema],

});
petOwnerSchema.pre('save', async function(next){
    const petOwner = this;
    if(petOwner.isModified('password')){
        petOwner.password = await bcrypt.hash(petOwner.password, 8);
    }
    next();
});
petOwnerSchema.methods.comparePassword = async function(password){
    const petOwner = this;
    return await bcrypt.compare(password, petOwner.password);
};

const PetOwner = mongoose.model('PetOwner', petOwnerSchema);

module.exports = PetOwner;