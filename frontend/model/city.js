class City {
    constructor(
        id,
        countryCode,
        district,
        name, 
        population
    ){
        this.id = id,
        this.countryCode = countryCode,
        this.district = district,
        this.name = name,
        this.population = population
    }

    static createCityFromJSON(jsonData){
        const city = new City(
            jsonData.Id,
            jsonData.CountryCode,
            jsonData.District,
            jsonData.Name,
            jsonData.Population
        );

        return city;
    }
}

module.exports = City;
