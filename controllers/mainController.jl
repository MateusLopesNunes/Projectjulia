module mainController

    include("../db/querys.jl")
    #include("../public/templates/template.jl")
    #include("../public/templates/base.jl")

    using HTTP,  Mustache, DataFrames
    using .queryBuilder
    #using template
    #using .baseTemplate

    template = mt"""
    <html>
        <head>
            <title>{{:TITLE}}</title>
        </head>
        <body>
            <table>
                <tr><th>name</th><th>summary</th></tr>
                {{#:D}}
                <tr><td>{{:names}}</td><td>{{:summs}}</td></tr>
                {{/:D}}
            </table>
            <table>
            <tr><th>Country</th></tr>
            {{#:E}}
            <tr><td>{{:countrys}}</td></tr>
            {{/:E}}
        </table>
            <h1> está funcionando</h1>
        </body>
    </html>
    """


    function getHome(req::HTTP.Request)

    return HTTP.Response(200, read("public/index.html"));
    end

    function getDashboard(req::HTTP.Request)

    return HTTP.Response(200, read("public/dashboards.html"));
    end

    function getTemplate(req::HTTP.Request)
        
    listOfCountry = queryBuilder.returnListOfCountry()
    listOfValue = []
    for country in listOfCountry
        push!(listOfValue, country.Name)
    end

    d = DataFrame(names=["matheus", "Medrado", "Paulo"], summs=[10,20,30])
    e = DataFrame(countrys=listOfValue)
    out = render(template, TITLE="O titulo usa template ", D=d,E=e)

    # finalTemplate = baseTemplate.returnTemplateFill(out)
    # println(finalTemplate)


    return HTTP.Response(200, out);

    end
end