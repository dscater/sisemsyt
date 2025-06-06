<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Comprobante</title>
    <style>
        html,
        body {
            color: black;
        }

        .bg-black {
            background: black;
            color: white;
        }

        .text-md {
            font-size: 1.3em;
        }

        b {
            font-size: 1.15em;
        }

        table {
            border-collapse: collapse;
        }

        table tbody tr td {
            padding: 5px;
        }
    </style>
</head>

<body>
    <h1>Código de autenticación</h1>
    <p>{!! $datos['mensaje'] !!}</p>
    <h3>{{ $datos['codigo'] }}</h3>
</body>

</html>
