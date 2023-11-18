const axios = require('axios'); 

const Country = require('../model/country.js');
const City = require("../model/city.js");

const apiUrl = "http://127.0.0.1:8080";

module.exports = class MainController {

   
    static async showHome (req, res) {
       
        res.render("main/home");
    }

    static async showDashboard (req, res){
        let countryData = {}
        let url = `${apiUrl}/dashboard`;

        await axios.get(url)
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

        let url = `${apiUrl}/postGraph`

        await axios.post(url, listOfCountry)
        .then(response => {
            listOfCountryJson = response.data;
        })
        .catch(error => {
            console.error(error);
        });

        let listOfLabel = [];
        let listOfData = [];
        let listOfCountrys = []

        listOfCountryJson["countrys"].forEach((element) => {
            listOfLabel.push(`${element.Name}`)
            listOfData.push(element.Population)
            let countryObj = Country.createCountryFromJSON(element)
            listOfCountrys.push({
                "Country" : countryObj
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
            "country" : listOfCountrys
        };

        res.render("main/chart", {chartData});

    }

    static async getCountryCity(req, res){
        let country = req.query.country;

        let json = {
            "country" : country
        };

        let url = `${apiUrl}/cityPerCountry`;

        let countrysData;

        await axios.post(url, json)
        .then(response => {
            countrysData = response.data;
        })
        .catch(error => {
            console.error(error);
        });

        let listOfCitys = [];

        countrysData["Citys"].forEach((element) => {
            let city = City.createCityFromJSON(element);
            listOfCitys.push(city)
        });

        let jsonCity = {
            "citys" : listOfCitys
        }

        res.json(jsonCity);


    }

    static async postGraphListOfCity(req, res){
        let listOfCityRaw = req.body["selectedCitys"]
        let listCity = listOfCityRaw.split(',');

        let listOfCitys = {
            "citys" : listCity
        };

        let listOfCitysJson = {};
        
        let url = `${apiUrl}/city/population`;

        try {
            await axios.post(url, listOfCitys)
            .then(response => {
                listOfCitysJson = response.data;
                console.log(response.data)
            })
            .catch(error => {
                console.error(error);
            });
    
            let listofCityObj = [];
            listOfCitysJson["citys"].forEach((element) => {
                let city = City.createCityFromJSON(element);
                listofCityObj.push(city)
            });

            let listOflabelWithQuotes = [];
            listofCityObj.forEach((element) => {
                let label = `"${element.name}"`;
                listOflabelWithQuotes.push(label)
            });

            let listOfData = [];
            listofCityObj.forEach((element) => {
                listOfData.push(element.population);
            });    
    
            let chartDataCity = {
                "label" : `[${listOflabelWithQuotes}]`,
                "data" :`[${listOfData}]`,
                "city" : listofCityObj
            };

            console.log(chartDataCity)

            res.render("main/chartCity", {chartDataCity})
    
        } catch (error) {
            console.log(error)
        }
    }

}