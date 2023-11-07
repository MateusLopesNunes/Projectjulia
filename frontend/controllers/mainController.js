const axios = require('axios'); 

const Country = require('../model/country.js');

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
        countryData["countrys"].forEach(element => {
            let country = Country.createCountryFromJSON(element);
            console.log(country)
            countrys.push(country);
        })
        
        //console.log(countrys)
        res.render("main/dashboard", {countrys});
    }

    static async postGraphList(req, res){
        let listOfCountry = req.body["list"]
        listOfCountry = {
            "list" : listOfCountry
        };

        let listOfCountryJson = {};

        await axios.post('http://127.0.0.1:8080/postGraph', listOfCountry)
        .then(response => {
            listOfCountryJson = response.data;
        })
        .catch(error => {
            console.error(error);
        });

        console.log(listOfCountryJson)

    }

    static async showChartPopulation (req, res) {
        res.render("main/chartPopulationCountry")
    }

}