export countrylanguage, createListOfcountrylanguage

struct countrylanguage
    CountryCode::String
    Language::String
    IsOfficial::Bool
    Percentage::Float64
end

function createListOfcountrylanguage(data)
    boolField = true

    listOfCountry = []
    for row in data
        if row[3] == "F"
            boolField == false
        else 
            boolField == true
        end
        country = countrylanguage(row[1], row[2], boolField,row[4])
        push!(listOfCountry, country)
    end

    return listOfCountry
end