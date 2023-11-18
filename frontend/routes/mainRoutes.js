const exppres = require('express');
const router = exppres.Router();

const MainController = require("../controllers/mainController");

router.get("/", MainController.showHome);
router.get("/dashboard", MainController.showDashboard);
router.post("/grafico", MainController.postGraphList);
router.post("/grafico_cidade", MainController.postGraphListOfCity);
router.get("/getCountryCitys", MainController.getCountryCity);

module.exports = router;