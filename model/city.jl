export city, createListOfcountrylanguage

struct city
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
        country = city(row[1], row[2], row[3], row[4], row[5])
        push!(listOfCountry, country)
    end

    return listOfCity
end