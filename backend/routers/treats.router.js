const router = require('express').Router();

const TreatsController = require('../controller/treats.controller');

router.post('/createTreat', TreatsController.createTreat);
router.get('/getTreats', TreatsController.getTreats);
router.get('/getTreatById/:id', TreatsController.getTreatById);
router.put('/updateTreat/:id', TreatsController.updateTreat);
router.delete('/deleteTreat/:id', TreatsController.deleteTreat);

module.exports = router;