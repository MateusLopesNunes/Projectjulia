module CountryLanguageModel

    struct CountryLanguage
        CountryCode::String
        Language::String
        IsOfficial::Bool
        Percentage::Float64
    end

    function createListOfcountrylanguage(data)

        listOfCountry = []
        for row in data
            country = countryLanguage(row)
            push!(listOfCountry, country)
        end

        return listOfCountry
    end

    function convertRowIntoCountryLanguage(row)
        CountryCode = row[1]
        Language = row[2]
        IsOfficial = row[3]
        Percentage = row[4]

        if IsOfficial == "F"
            IsOfficial = false
        else 
            IsOfficial = true
        end

        countryLanguage = CountryLanguage(CountryCode, Language, IsOfficial, Percentage)

        return countryLanguage

    end
end