module queryBuilder

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

    function returnListOfCountry()
        dataCountry = sqlGet("select * from country;")
        listOfCountry = CountryModel.createListOfCountry(dataCountry)

        return listOfCountry;

    end

end