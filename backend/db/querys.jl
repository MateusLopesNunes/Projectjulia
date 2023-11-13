module queryBuilder

    include("db.jl")
    include("../model/countrylanguage.jl")
    include("../model/city.jl")
    include("../model/country.jl")

    using .CountryModel
    using .CityModel
    using .CountryLanguageModel

    function sqlGet(sql_query)
        data = DBInterface.execute(conn::MySQL.Connection, sql_query) 
        return data
    end

    function sqlGetPrepare(sql_query, params)
        stmt = DBInterface.prepare(conn::MySQL.Connection, sql_query)
        data = DBInterface.execute(stmt, params...)
        return data
    end

    function returnListOfCountry()
        dataCountry = sqlGet("select * from country;")
        listOfCountry = CountryModel.createListOfCountry(dataCountry)

        return listOfCountry;

    end

    # function sqlGetCountry(parameter)
    #     sql_query  = "select * from country where Code='?';"
    #     params = (parameter,)  # Tupla com os valores dos parâmetros
    #     data = sqlGetPrepare(sql_query, params)
    #     return data
    # end

    function listOfPopulation(listOfCountry::Vector{Any})

        inParameter = ""
        for country in listOfCountry
            inParameter = inParameter * "'$country', "
        end

        inParameter = inParameter[1:(length(inParameter) - 2)]
        #sqlQuery = "SELECT * FROM Country WHERE Code IN (?);"
        # data = sqlGetPrepare(sqlQuery, listOfCountry)
        sqlQuery = "SELECT * FROM Country WHERE Code IN ($inParameter);"
        data = sqlGet(sqlQuery)

        listOfCountry = CountryModel.createListOfCountry(data)
        
        return listOfCountry
    end

    function countryToJson(country::Country)
        return CountryModel.country_to_json(country)
    end
end