include("db/querys.jl")
#include("public/base.jl")

using HTTP,  Mustache, DataFrames

#using .baseTemplate
using .queryBuilder

template = mt"""
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
"""

baseTemplateData = mt"""
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <!-- <link rel="stylesheet" href="css/bootstrap.css"> -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
            <title>Teste</title>
        </head>
        <body>
            <h1>Bem Vindo</h1>
            <nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/dashboard"> Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="/template"> Template</a>
                        </li>
                    </ul>
                </div>
                </div>
            </nav>
            <div> {{{:DATA}}} </div>
            <script>
            </script>
        </body>
    </html>
    """


    
function getTemplate()
        
    listOfCountry = queryBuilder.returnListOfCountry()
    listOfValue = []
    for country in listOfCountry
        push!(listOfValue, country.Name)
    end

    d = DataFrame(names=["matheus", "Medrado", "Paulo"], summs=[10,20,30])
    e = DataFrame(countrys=listOfValue)
    out = render(template, TITLE="O titulo usa template ", D=d,E=e)

    finalHTML = out = render(baseTemplateData, DATA=out )

    println(finalHTML)

end

getTemplate()