class Country {
  constructor(
    code,
    name,
    continent,
    region,
    surfaceArea,
    indepYear,
    population,
    lifeExpectancy,
    gnp,
    gnpOld,
    localName,
    governmentForm,
    headOfState,
    capital,
    code2
  ) {
    this.Code = code;
    this.Name = name;
    this.Continent = continent;
    this.Region = region;
    this.SurfaceArea = surfaceArea;
    this.IndepYear = indepYear;
    this.Population = population;
    this.LifeExpectancy = lifeExpectancy;
    this.GNP = gnp;
    this.GNPOld = gnpOld;
    this.LocalName = localName;
    this.GovernmentForm = governmentForm;
    this.HeadOfState = headOfState;
    this.Capital = capital;
    this.Code2 = code2;
  }

  static createCountryFromJSON(jsonData) {
    console.log(jsonData)
    // const countryData = JSON.parse(jsonData); 
    const countryData = jsonData; 
    const country = new Country(
      countryData.Code,
      countryData.Name,
      countryData.Continent,
      countryData.Region,
      countryData.SurfaceArea,
      countryData.IndepYear,
      countryData.Population,
      countryData.LifeExpectancy,
      countryData.GNP,
      countryData.GNPOld,
      countryData.LocalName,
      countryData.GovernmentForm,
      countryData.HeadOfState,
      countryData.Capital,
      countryData.Code2
    );
  
    return country;
  }
}

module.exports = Country;





