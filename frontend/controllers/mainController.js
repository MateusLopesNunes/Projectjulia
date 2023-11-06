const axios = require('axios'); 
module.exports = class MainController {
   
    static async showHome (req, res) {
       
        res.render("main/home");
    }

    static async showDashboard (req, res){
        let countryData = {}

        await axios.get('http://127.0.0.1:8080/dashboard')
        .then(response => {
            countryData = response.data;
        })
        .catch(error => {
            console.error(error);
        });

        let countrys = []
        countryData["country"].forEach(element => {
            let country = {};
            console.log(element);
            country["name"] = element;
            countrys.push(country);
        })

        console.log(countrys)
        res.render("main/dashboard", {countrys});
    }

}