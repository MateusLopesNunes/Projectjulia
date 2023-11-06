const exppres = require('express');
const router = exppres.Router();

const MainController = require("../controllers/MainController");

router.get("/", MainController.showHome);
router.get("/dashboard", MainController.showDashboard);

module.exports = router;