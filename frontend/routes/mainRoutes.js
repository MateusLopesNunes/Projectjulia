const exppres = require('express');
const router = exppres.Router();

const MainController = require("../controllers/mainController");

router.get("/", MainController.showHome);
router.get("/dashboard", MainController.showDashboard);
router.post("/grafico", MainController.postGraphList);
router.get("/getCountryCitys", MainController.getCountryCity);

module.exports = router;