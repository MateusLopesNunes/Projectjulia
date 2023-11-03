module mainController

    include("../db/querys.jl")
    #include("../public/templates/template.jl")
    #include("../public/templates/base.jl")

    using HTTP,  Mustache, DataFrames, NodeJS
    using .queryBuilder
    #using template
    #using .baseTemplate

    template = mt"""
    <html>
        <head>
            <title>{{:TITLE}}</title>
            <style>
                #container {
                    position: relative;
                }
                #grafico {
                    position: absolute;
                    left: 50px;
                    top: 50px;
                }
            </style>
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
            <div id="container">
                <canvas id="grafico" width="400" height="300"></canvas>
                <svg width="100%" height="100%">
                    <line x1="50" y1="50" x2="50" y2="350" stroke="black" stroke-width="2" />
                    <line x1="50" y1="350" x2="450" y2="350" stroke="black" stroke-width="2" />
                </svg>
            </div>
            <div>
                <select class="form-select" size="3" aria-label="Size 3 select example">
                    <option selected>Open this select menu</option>
                        {{{:OPTIONS}}}
                </select>
            </div>
        </body>
        <script>
            {{{:GRAPH}}}
        </script>
    </html>
    """

    graphData = mt"""
        var canvas = document.getElementById("grafico");
        var ctx = canvas.getContext("2d");

        // Dados do gráfico
        var dados = {{{:DATA}}};
        var cores = ["red", "green", "blue", "orange", "purple"];
        var larguraBarra = 50;
        var espacoEntreBarras = 20;
        var alturaMaxima = canvas.height;

        var x = 50;
        for (var i = 0; i < dados.length; i++) {
            var altura = (dados[i] / 60) * alturaMaxima;
            ctx.fillStyle = cores[i];
            ctx.fillRect(x, canvas.height - altura, larguraBarra, altura);
            x += larguraBarra + espacoEntreBarras;
        }
    """
    optionsHTML = mt"""
        <option value=\"Teste\">Teste</option>
        {{#:F}}
            <option value="{{:options}}">{{:options}}</option>
        {{/:F}} 
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

    listOfOption = []
    for country in listOfValue 
        push!(listOfOption, country)
    end

    d = DataFrame(names=["matheus", "Medrado", "Paulo"], summs=[10,20,30])
    e = DataFrame(countrys=listOfValue)
    f = DataFrame(options=listOfOption)

    out = render(graphData,  DATA="[ 50, 40, 30, 20, 5] ")
    optionData = render(optionsHTML, F=f)
    finalHTML = render(template, TITLE="O titulo usa template ", D=d, E=e, GRAPH=out, OPTIONS=optionData )



    # out = render(graphData,  DATA="[ 50, 40, 30, 20, 5] ")
    # graphHtml = render(template, TITLE="O titulo usa template ", D=d, E=e, F=out )
    # finalHTML = render(graphHtml, F=f )

    # finalTemplate = baseTemplate.returnTemplateFill(out)
    # println(finalTemplate)


    return HTTP.Response(200, finalHTML);

    end
end