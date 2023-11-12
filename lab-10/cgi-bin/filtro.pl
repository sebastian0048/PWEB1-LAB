#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use feature 'fc';
use Encode 'decode';
use Text::Unidecode;

my $cgi = new CGI();
print $cgi->header('text/html');
my $archivo = 'datos.csv';

my $univ = decode('UTF-8', $cgi->param('universidad'));
my $periodo =  decode('UTF-8', $cgi->param('periodo_licenciamiento'));
my $departamento = decode('UTF-8', $cgi->param('departamento'));
my $denominacion = decode('UTF-8', $cgi->param('denominacion'));



print <<'END_HTML';
<html>
<head>
<style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            border: 1px solid #ddd;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        th, td {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>

</head>
<body>
<div class="container">
<h1>Resultados de la busqueda</h1>
<table>
<tr>
    <th>Codigo</th>
    <th>Nombre</th>
    <th>Tipo</th>
    <th>Estado</th>
    <th>Periodo</th>
    <th>Codigo filial</th>
    <th>Nombre Filial</th>
    <th>Departamento filial</th>
    <th>Provincia filial</th>
    <th>Codigo Local</th>
    <th>Departamento Local</th>
    <th>Provincia Local</th>
    <th>Distrito Local</th>
    <th>Latitud</th>
    <th>Longitud</th>
    <th>Autorizacion Local</th>
    <th>Programa</th>
    <th>Tipo Nivel Academico</th>
    <th>Nivel Academico</th>
    <th>Codigo Programa</th>
    <th>Nombre Programa 2</th>
    <th>Tipo Programa</th>
</tr>
END_HTML



open(my $data, '<', $archivo) or die "No se pudo abrir '$archivo' $!\n";
while (my $linea = <$data>) {
    
    chomp $linea;
    
    my @campos = $linea =~ /\?|([^|]+)\|/g;
    my $longitud = @campos;
    if($longitud > 0) {
        if((!$univ || fc(unidecode(@campos[1])) =~ /\b\Q$univ\E\b/i) && 
           (!$periodo || fc(unidecode(@campos[4])) =~ /\b\Q$periodo\E\b/i) &&
           (!$departamento || fc(unidecode(@campos[7])) =~ /\b\Q$departamento\E\b/i) &&
           (!$denominacion || fc(unidecode(@campos[16])) =~ /\b\Q$denominacion\E\b/i)){
            print "<tr>";
            foreach my $campo (@campos){

                print "<td>$campo</td>";
            }
        }
    }
}
print <<'END_HTML';
        </table>
    </div>
</body>
</html>;
END_HTML




