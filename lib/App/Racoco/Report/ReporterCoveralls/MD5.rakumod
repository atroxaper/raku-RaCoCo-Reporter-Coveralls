use App::Racoco::Report::ReporterCoveralls::Externals :md5;

unit class App::Racoco::Report::ReportCoveralls::MD5
	is export;

method md5(Str $content --> Str) {
	md5($content.encode: 'utf-8').list».fmt("%02x").join
}