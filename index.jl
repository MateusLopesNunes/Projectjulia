include("controllers/mainController.jl")

using HTTP,  Sockets
using .mainController


const ROUTER = HTTP.Router()
HTTP.register!(ROUTER, "GET", "/", mainController.getHome)
HTTP.register!(ROUTER, "GET", "/dashboard", mainController.getDashboard)
HTTP.register!(ROUTER, "GET", "/template", mainController.getTemplate)
HTTP.register!(ROUTER, "POST", "/population", mainController.postPopulation)
HTTP.register!(ROUTER, "GET", "/population", mainController.getGraph)


server = HTTP.serve(ROUTER, Sockets.localhost, 8080)

# close(server)
# @assert istaskdone(server.task)