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

        let listOfLabel = [];
        let listOfData = [];

        listOfCountryJson["countrys"].forEach((element) => {
            listOfLabel.push(element.Name)
            listOfData.push(element.Population)
        });

        console.log(`/chart/Population?label="${listOfLabel}"&data="${listOfData}"`)

        res.redirect(`/chart/Population?label=${listOfLabel}&data=${listOfData}`)
    }

    static async showChartPopulation (req, res) {
        let listOfLabel = req.query.label;
        let listOfData = req.query.data;

        console.log(listOfLabel);
        console.log(listOfData);

        let chartData = {
            "label" : `[${listOfLabel}]`,
            "data" :`[${listOfData}]`
        };

        let jsonDta = {
            "chartData" : chartData
        }

        console.log(jsonDta)


        res.render("main/chart", {jsonDta});
    }

}