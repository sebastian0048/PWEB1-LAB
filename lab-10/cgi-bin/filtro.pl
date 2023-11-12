#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;
use Encode 'decode';


my $cgi = new CGI();
print $cgi->header('text/html');
my $archivo = 'datos.csv';

my $univ = decode('UTF-8', $cgi->param('universidad'));
my $periodo =  decode('UTF-8', $cgi->param('periodo_licenciamiento'));
my $departamento = decode('UTF-8', $cgi->param('departamento'));
my $denominacion = decode('UTF-8', $cgi->param('denominacion'));




