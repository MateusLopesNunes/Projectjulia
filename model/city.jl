module CityModel

    struct City
        Id::Int32
        Name::String
        CountryCode::String
        District::String
        Population::Int32
    end

    function createListOfCity(data)

        listOfCity = []

        for row in data
            print(row)
            print(typeof(row[1]))
            city = convertRowIntoCity(row)
            push!(listOfCountry, city)
        end

        return listOfCity
    end

    function convertRowIntoCity(row)
        id = row[1]
        name = row[2]
        countryCode = row[3]
        district = row[4]
        population = row[5]

        city = City(id, name, countryCode, district, population)

        return city

    end
end