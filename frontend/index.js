const express = require("express");
const exphbs = require("express-handlebars");
const port = 3000;
const app = express();
const cors = require('cors');


const mainRoutes = require("./routes/mainRoutes");

app.engine('handlebars', exphbs.engine());
app.set('view engine', 'handlebars');

app.use(
    express.urlencoded({
        extended: true
    })
);

app.use(cors());
app.use(cors({
    origin: 'http://localhost:3000',
}));
app.use(express.json());

app.use(express.static('public'));

app.use("/", mainRoutes );


app.listen(port, () => {
    console.log(`App running on port ${port}`);
});
