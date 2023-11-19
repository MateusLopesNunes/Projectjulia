include("controllers/mainController.jl")

using HTTP,  Sockets
using .mainController


const ROUTER = HTTP.Router()
HTTP.register!(ROUTER, "GET", "/dashboard", mainController.getDashboard)
HTTP.register!(ROUTER, "GET", "/dashboard5", mainController.getDashboard5)
HTTP.register!(ROUTER, "GET", "/template", mainController.getTemplate)
HTTP.register!(ROUTER, "POST", "/postGraph", mainController.postCountryPopulation)
HTTP.register!(ROUTER, "GET", "/population", mainController.getGraph)
HTTP.register!(ROUTER, "POST", "/cityPerCountry", mainController.getCityPerCountry)
HTTP.register!(ROUTER, "POST", "/city/population", mainController.postCityPopulation)

server = HTTP.serve(ROUTER, Sockets.localhost, 8080)
