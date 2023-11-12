const exppres = require('express');
const router = exppres.Router();

const MainController = require("../controllers/mainController");

router.get("/", MainController.showHome);
router.get("/dashboard", MainController.showDashboard);
router.get("/chart", MainController.showChartPopulation);
router.post("/postGraph", MainController.postGraphList);

module.exports = router;