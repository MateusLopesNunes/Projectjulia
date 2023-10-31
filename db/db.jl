using MySQL
using DBInterface
include("../model/countrylanguage.jl")
include("../model/city.jl")

conn = DBInterface.connect(MySQL.Connection, "127.0.0.1","root", "admin", db = "world")

function sqlGet(sql_query)
    data = DBInterface.execute(conn::MySQL.Connection, sql_query) 
    return data
end

dataCountry = sqlGet("select * from countrylanguage;")
dataCity = sqlGet("select * from city;")


listOfCountry = createListOfcountrylanguage(dataCountry)
listOfCity = createListOfCity(dataCity)

print(listOfCountry[1])
print(listOfCity[1])
