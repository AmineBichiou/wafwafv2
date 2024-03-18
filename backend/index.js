const app = require('./app');
const express = require('express');
const db = require('./config/db');
const PetOwner = require('./model/petowner');
const Treats = require('./model/treats');
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.post('/petowner', async (req, res) => {
    try {
        const newPetOwner = await PetOwner.create(req.body);
        res.json(newPetOwner);
    } catch (error) {
        res.status(400)
    }
    });

    
const port = 5000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

app.get('/', (req, res) => {
  res.send('Comon World');
});