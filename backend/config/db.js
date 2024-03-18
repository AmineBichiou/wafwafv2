

const mongoose = require('mongoose')

const url = `mongodb+srv://amine:Amine123@wafwaf.vyxnocl.mongodb.net/?retryWrites=true&w=majority&appName=WafWaf`;

mongoose.connect(url)
    .then( () => {
        console.log('Connected to the database ')
    })
    .catch( (err) => {
        console.error(`Error connecting to the database. n${err}`);
    })