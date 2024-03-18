const router = require('express').Router();
const PetOwnerController = require('../controller/petowner.controller');
const otpController = require('../controller/otp.controller');
const twilio = require('../controller/twilio.controller');
router.post('/register', PetOwnerController.register);
router.post('/login', PetOwnerController.login);
router.post('/logout', PetOwnerController.logout);
router.get('/getPetOwner', PetOwnerController.getPetOwner);
router.get('/getPetOwnerById/:id', PetOwnerController.getPetOwnerById);
router.get('/getIdByEmail/:email', PetOwnerController.getIdByEmail);
//router.post("/send-otp", otpController.sendOTP);
//router.post("/verify-otp", otpController.verifyOTP);
router.post('/send-sms', twilio.sendSMS);
router.post('/verify-sms', twilio.verifySMS);



module.exports = router;