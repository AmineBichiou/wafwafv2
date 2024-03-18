
const twilio = require('twilio');
const otpGenerator = require("otp-generator");
const crypto = require("crypto");

const Crypto_Key = "test";
const num = "21620319318";
const sendSMS = async (req, res) => {
  const accountSid = 'AC60150e7124a0a7f449c9786f0c6ff21a';
  const authToken  = '5afa83993466d307e2f7755d3c57220f';
  try {
    const otp = otpGenerator.generate(4, {
      upperCaseAlphabets: false,
      specialChars: false,
      lowerCaseAlphabets: false,
    });
    
    const time_to_live = 3 * 60 * 1000;
    const expires = Date.now() + time_to_live;
    const data = `${req.body.phone}.${otp}.${expires}`;
    const hash = crypto
      .createHmac("sha256", Crypto_Key)
      .update(data)
      .digest("hex");

    const fullHash = `${hash}.${expires}`;
    const client = new twilio(accountSid, authToken);
    client.messages
      .create({
         body: `Dear Customer, your OTP is ${otp}. It will expire in 3 minutes`,
         from: '+16203159609',
         to: req.body.phone
       })
      .then(message => console.log(message.sid));
    return res.status(200).send({
      message: "Success",
      data: fullHash,
    });


  }
  
  catch (error) {
    return res.status(500).send({
      message: "Error",
      error: error.message,
    });
  }
}

const verifySMS = async (req, res) => {
  let [hashValue, expires] = req.body.hash.split(".");

  let now = Date.now();
  if (now > parseInt(expires))
    return res.status(400).send({ message: "OTP Expired" });

  let data = `${req.body.phone}.${req.body.otp}.${expires}`;

  let newCalculatedHash = crypto
    .createHmac("sha256", Crypto_Key)
    .update(data)
    .digest("hex");

  if (newCalculatedHash === hashValue) {
    return res.status(200).send({ message: "Success" });
  }
  return res.status(400).send({ message: "Invalid OTP" });
};




module.exports = {
    sendSMS,
    verifySMS
    };
