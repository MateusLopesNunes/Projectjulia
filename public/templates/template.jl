export template

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
