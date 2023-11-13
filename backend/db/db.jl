using MySQL
using DBInterface

export conn

conn = DBInterface.connect(MySQL.Connection, "127.0.0.1","root", "admin", db = "world")

