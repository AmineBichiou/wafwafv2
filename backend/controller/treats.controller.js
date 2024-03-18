const treatServices = require('../services/treats.services');
const upload = require('../middleware/treats.upload');

exports.createTreat = async (req, res, next) => {
    upload(req, res, function(err) {
        if (err) {
            return next(err);
        } else {
            const path = req.file.path !== undefined ? req.file.path.replace(/\\/g, "/") : "";
            const treatName = req.body.treatName;
            const treatDescription = req.body.treatDescription;
            const treatPrice = req.body.treatPrice;
            const treatSalePrice = req.body.treatSalePrice;
            const treatSKU = req.body.treatSKU;
            const treatStatus = req.body.treatStatus;
            const treatImage = path !== "" ? "/" + path : "";
            try{
                const newTreat = treatServices.addTreat(treatName, treatDescription,treatPrice,treatSalePrice,treatSKU,treatStatus, treatImage);
                res.json(newTreat);
            }
            catch (error) {
                return next(error);
            }
        }
    }
    );
}
    
            

exports.getTreats = async (req, res, next) => {
    try {
        const { treatName } = req.query;
        const data = await treatServices.getTreats({ treatName });
        return res.status(200).json({
            message: 'Treats fetched successfully',
            data: data
        });
    } catch (error) {
        console.error(error); 
        return res.status(500).json({
            message: 'Internal server error',
            error: error.message
        });
    }
};
exports.getTreatById = async (req, res, next) => {
    try {
        const { id } = req.params;
        const treat = await treatServices.getTreatsById(id);
        
        if (!treat) {
            return res.status(404).json({
                message: 'Treat not found'
            });
        }

        return res.status(200).json({
            message: 'Treat fetched successfully',
            data: treat
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            message: 'Internal server error',
            error: error.message
        });
    }
};


exports.updateTreat = async (req, res, next) => {
    try {
        upload(req, res, async function(err) {
            if (err) {
                return next(err);
            } else {
                try {
                    const path = req.file && req.file.path !== undefined ? req.file.path.replace(/\\/g, "/") : "";
                    const { id } = req.params;
                    const { treatName, treatDescription,treatPrice,treatSalePrice,treatSKU,treatStatus } = req.body;
                    const treatImage = path !== "" ? "/" + path : "";

                    const updatedTreat = await treatServices.updateTreats(id, treatName, treatDescription,treatPrice,treatSalePrice,treatSKU,treatStatus, treatImage);

                    return res.status(200).json({
                        message: 'Treat updated successfully',
                        data: updatedTreat
                    });
                } catch (error) {
                    console.error(error);
                    if (error.message === 'Treat not found') {
                        return res.status(404).json({
                            message: 'Treat not found'
                        });
                    } else {
                        return res.status(500).json({
                            message: 'Internal server error',
                            error: error.message
                        });
                    }
                }
            }
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            message: 'Internal server error',
            error: error.message
        });
    }
};


exports.deleteTreat = async (req, res, next) => {
    try {
        const { id } = req.params;
        const result = await treatServices.deleteTreats(id);
        
        if (result.deletedCount === 0) {
            return res.status(404).json({
                message: 'Treat not found'
            });
        }

        return res.status(200).json({
            message: 'Treat deleted successfully',
            data: result
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            message: 'Internal server error',
            error: error.message
        });
    }
};

