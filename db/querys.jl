include("db.jl")
include("../model/countrylanguage.jl")
include("../model/city.jl")
include("../model/country.jl")

using .CountryModel


function sqlGet(sql_query)
    data = DBInterface.execute(conn::MySQL.Connection, sql_query) 
    return data
end

function sqlGetCountry(parameter)
    sql_query  = "select * from country where Code='$parameter';"
    data = DBInterface.execute(conn::MySQL.Connection, sql_query) 
    return data
end

dataCountry = sqlGet("select * from countrylanguage;")
dataCity = sqlGet("select * from city;")
dataCountry = sqlGet("select * from country;")
oneCountryData = sqlGetCountry("BRA")
country = CountryModel.getCountryByCountry(oneCountryData)
print(country)

# listOfCountry = createListOfcountrylanguage(dataCountry)
# listOfCity = createListOfCity(dataCity)
# listOfCountry = CountryModel.createListOfCountry(dataCountry)
# # print(listOfCountry[1])
# # print(listOfCity[1])
# print(listOfCountry)