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
        println(stmt)
        println(" ")
        data = DBInterface.execute(conn::MySQL.Connection, [params[1], params[2], params[3], params[4]]) 
        #println(data)
        println(" ")

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

    function listOfPopulation(listOfCountry::Vector{Any})

        inParameter = ""
        for country in listOfCountry
            inParameter = inParameter * "'$country', "
        end

        inParameter = inParameter[1:(length(inParameter) - 2)]
        sqlQuery = "SELECT * FROM Country WHERE Name IN ($inParameter);"
        println(sqlQuery)
        data = sqlGet(sqlQuery)
        listOfCountry = CountryModel.createListOfCountry(data)
        
        # x = 1
        # inParameter = ""
        # for country in listOfCountry
        #     inParameter = inParameter * "'\$$x', "
        #     x = x +1
        # end
        
        # inParameter = inParameter[1:(length(inParameter) - 2)]
        # sqlQuery = "SELECT * FROM Country WHERE Name IN ($inParameter);"
        # print(sqlQuery)
        # data = sqlGetPrepare(sqlQuery, listOfCountry)
        # listOfCountry = CountryModel.createListOfCountry(data)

        return listOfCountry
    end
end