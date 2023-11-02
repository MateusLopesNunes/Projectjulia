module CountryModel

    export Country

    struct Country
        Code::String
        Name::String
        Continent::String
        Region::String
        SurfaceArea::Float16
        IndepYear::Int32
        Population::Int32
        LifeExpectancy::Float16
        GNP::Float16
        GNPOld::Float16
        LocalName::String
        GovernmentForm::String
        HeadOfState::String
        Capital::Int32
        Code2::String
    end

    function getCountryByCountry(data)
        for row in data
            country = convertRowIntoCountry(row)
            return country
        end
    end

    function createListOfCountry(data)

        listOfCountry = []

        for row in data
            country = convertRowIntoCountry(row)
            push!(listOfCountry, country)
        end

        return listOfCountry
    end

    function convertRowIntoCountry(row)

            if typeof(row[6]) == Missing
                indepYear = 0
            else 
                indepYear = row[6]
            end

            if typeof(row[8]) == Missing
                lifeExpectancy = 0
            else 
                lifeExpectancy = row[8]
            end

            if typeof(row[10]) == Missing
                GNPOld = 0
            else 
                GNPOld = row[10]
            end

            if typeof(row[13]) == Missing
                headOfState = "missing Head"
            else 
                headOfState = row[13]
            end

            if typeof(row[14]) == Missing
                capital = 0
            else 
                capital = row[14]
            end

            # print(typeof(row[1]))
            country = Country(
                row[1], row[2], row[3], row[4], row[5],
                indepYear, row[7], lifeExpectancy, row[9], GNPOld,
                row[11], row[12], headOfState, capital, row[15]
            )
            return country
    end
end