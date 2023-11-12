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
        console.log(req.body)
        let listOfCountryRaw = req.body["selectedCountries"]
        let listaPaises = listOfCountryRaw.split(',');

        let listOfCountry = {
            "list" : listaPaises
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
        let listOfName = []

        listOfCountryJson["countrys"].forEach((element) => {
            listOfLabel.push(`${element.Name}`)
            listOfData.push(element.Population)
            listOfName.push({
                "name" : element.Name
            })
        });

        let listOflabelWithQuotes = [];
        listOfLabel.forEach((element) => {
            let label = `"${element}"`;
            listOflabelWithQuotes.push(label)
        });

        let chartData = {
            "label" : `[${listOflabelWithQuotes}]`,
            "data" :`[${listOfData}]`,
            "country" : listOfName
        };

        res.render("main/chart", {chartData});

    }

    static async showChartPopulation (req, res) {
    //     let listOfLabel = req.query.label;
    //     let listOfData = req.query.data;

    //     console.log(listOfLabel);
    //     console.log(listOfData);

    //     let chartData = {
    //         "label" : `[${listOfLabel}]`,
    //         "data" :`[${listOfData}]`,
    //         "country" : listOfLabel
    //     };


    //     res.render("main/chart", {chartData});
     }

}