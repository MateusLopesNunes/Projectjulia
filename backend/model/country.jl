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
        
            code = row[1] 
            name = row[2] 
            continent = row[3] 
            region = row[4] 
            surfaceArea = row[5] 
            indepYear = row[6] 
            population = row[7] 
            lifeExpectancy = row[8] 
            gnp = row[9] 
            gnpOld = row[10] 
            localName = row[11] 
            governmentForm = row[12] 
            headOfState = row[13] 
            capital = row[14] 
            code2 = row[15] 

            if typeof(indepYear) == Missing
                indepYear = 0
            else 
                indepYear = indepYear
            end

            if typeof(lifeExpectancy) == Missing
                lifeExpectancy = 0
            else 
                lifeExpectancy = lifeExpectancy
            end

            if typeof(gnpOld) == Missing
                gnpOld = 0
            else 
                gnpOld = gnpOld
            end

            if typeof(headOfState) == Missing
                headOfState = "missing Head"
            else 
                headOfState = headOfState
            end

            if typeof(capital) == Missing
                capital = 0
            else 
                capital = capital
            end

            country = Country(
                code, name, continent, region, surfaceArea,
                indepYear, population, lifeExpectancy, gnp, gnpOld,
                localName, governmentForm, headOfState, capital, code2
            )
            return country
    end
end