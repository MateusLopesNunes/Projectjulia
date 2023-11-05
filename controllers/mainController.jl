module mainController

    include("../db/querys.jl")
    #include("../public/templates/template.jl")
    #include("../public/templates/base.jl")

    using HTTP,  Mustache, DataFrames, NodeJS, JSON
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
        var dados = {{:values}}; // Substitua com seus próprios dados
        var labels = ['label 1', 'label2', 'label3', 'label4', 'label5' ]
        var cores = ["red", "green", "blue", "orange", "purple"];
        var larguraBarra = 50;
        var espacoEntreBarras = 20;
        var alturaMaxima = canvas.height;
        
        var x = 50;
        for (var i = 0; i < dados.length; i++) {
            var altura = (dados[i] / 60) * alturaMaxima;
            
            // Desenhe a barra
            ctx.fillStyle = cores[i];
            ctx.fillRect(x, canvas.height - altura, larguraBarra, altura);
            
            // Adicione um rótulo acima da barra
            ctx.fillStyle = "black"; // Cor do texto
            ctx.font = "14px Arial"; // Estilo de fonte
            ctx.textAlign = "center"; // Alinhamento do texto
            ctx.fillText(labels[i], x + larguraBarra / 2, canvas.height - altura - 10); // Posição do rótulo
            
            x += larguraBarra + espacoEntreBarras;
        }
    """
    optionsHTML = mt"""
        <option value=\"Teste\">Teste</option>
        {{#:F}}
            <option value="{{:options}}">{{:options}}</option>
        {{/:F}} 
    """

    dashboardHTML = mt"""    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=
            , initial-scale=1.0">
            <title>Dashboards</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        </head>
        <body>
            <h1>Tela de dashboards</h1>
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                Ver Gráfico
            </button>
    
    <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalLabel">Ver Gráfico</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <h1 class="fs-3">Selecione os Países desejados</h1>
                            <p>No minimo 3 e no máximo 5</p>
                            <select class="form-select" id="selectPais" aria-label="Default select example">
                                <option selected>Selecione um País</option> 
                                {{#:F}}
                                    <option value="{{:options}}">{{:options}}</option>
                                {{/:F}} 
                            </select>
                            <div class="row mt-3">
                                <div class="col-6">
                                    <div class="d-flex flex-column" id="listSelect">
                                        <!-- Gerado no JS -->
                                        
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" id="saveButton">Save changes</button>
                        </div>
                    </div>
                </div>
            </div>
            
            <script>
                const selectPais = document.querySelector('#selectPais');
                let listSelect = document.querySelector('#listSelect');
                let saveButton = document.getElementById('saveButton');

                let listPais = []
                function getValueSelect() {
                    
                    selectPais.addEventListener('change', function(){
                        if (listPais.length < 5 && !listPais.includes(selectPais.value)) {
                            listPais.push(selectPais.value)
                            listPais = Array.from(new Set(listPais));
                            console.log(listPais)
                            updateList()
                        } else {
                            alert('Você pode selecionar no máximo 5 países.');
                        }
                    })
                }

                // <i class="bi bi-trash"></i>
                function updateList() {
                    listSelect.innerHTML = '';

                // Iterando sobre a lista de países e adicionando à lista
                listPais.forEach(function(pais, index) {
                    const listItem = document.createElement('div');
                    listItem.classList.add('d-flex', 'flex-row', 'align-items-center');

                    // Cria um elemento de parágrafo para o nome do país
                    const paragraph = document.createElement('p');
                    paragraph.classList.add('p-2', 'm-0');
                    paragraph.textContent = pais;

                    // Cria um botão de lixeira para excluir o país
                    const deleteButton = document.createElement('button');
                    deleteButton.classList.add('btn');
                    deleteButton.innerHTML = '<i class="bi bi-trash"></i>';
                    deleteButton.addEventListener('click', function() {
                        listPais.splice(index, 1);
                        updateList();
                    });

                    listItem.appendChild(paragraph);
                    listItem.appendChild(deleteButton);

                    listSelect.appendChild(listItem);
                });
            }

            saveButton.addEventListener('click', () => {
                if (listPais.length == 5){
                    const body = {
                        list : listPais
                    }
                    fetch(
                        `/population`,
                        {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(body)
                        }
                    )
                }else{
                    alert("Você precisa selecionar 5 paises")
                }
            });
                
                getValueSelect()

            </script>
        </body>
    </html>"""

    graphHtml = mt"""
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
                <div id="container">
                    <canvas id="grafico" width="400" height="300"></canvas>
                    <svg width="100%" height="100%">
                        <line x1="50" y1="50" x2="50" y2="350" stroke="black" stroke-width="2" />
                        <line x1="50" y1="350" x2="450" y2="350" stroke="black" stroke-width="2" />
                    </svg>
                </div>
            </body>
            <script>
                {{{:GRAPH}}}
            </script>
        </html>
        """



    function getHome(req::HTTP.Request)

        return HTTP.Response(200, read("public/index.html"));
    end

    function getDashboard(req::HTTP.Request)

        listOfCountry = queryBuilder.returnListOfCountry()
        listOfValue = []
        for country in listOfCountry
            push!(listOfValue, country.Name)
        end
    
        listOfOption = []
        for country in listOfValue 
            push!(listOfOption, country)
        end
        
        f = DataFrame(options=listOfOption)

        dashboardHTML
        finalHtml = render(dashboardHTML, F=f)

        return HTTP.Response(200, finalHtml);
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

    function postPopulation(req::HTTP.Request)
        content_type =  HTTP.header(req, "Content-Type")
        if  content_type == "application/json"
            try
                json_data = JSON.parse(IOBuffer(req.body))
                data = json_data["list"]
                listOfCountry = queryBuilder.listOfPopulation(data)
                
                valuesValue = ""
                keysValue = ""

                for country in listOfCountry
                    valuesValue = valuesValue * "$(country.Population), "
                    #keysValue = keysValue * "\'$(country.Name)\', "
                end

                println("aqui")
                println(valuesValue)
                println(keysValue)

                out = render(graphData,  
                    values="[$(valuesValue[1:(length(valuesValue) - 2)])]", 
                    #keys="[$(keysValue[1:(length(keysValue) - 2)])]"
                    #keys="['label 1', 'label2', 'label3', 'label4', 'label5' ]"
                )
                finalHTML = render(graphHtml, TITLE="Gráfico", GRAPH=out )
                getGraph(req::HTTP.Request, finalHTML)

                #return HTTP.Response(200, finalHTML);

            catch e
                return HTTP.Response(404, "Erro");

                println("Erro ao analisar os dados JSON da requisição: $e")
            end
        end
    end

    function getGraph(req::HTTP.Request, html)
        return HTTP.Response(200, html);
    end
end