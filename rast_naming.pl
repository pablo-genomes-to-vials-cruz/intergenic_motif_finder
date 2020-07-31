open FILE, $ARGV[0] or die "I cant open the input file, the table it is\n";

while($line=<FILE>){
	$line=~/(\d+\.\d+)(.+)/;
	$genome_id="$1";
	$data_line="$2";

	open RAST, "RAST.ids" or die "I cant open the RAST file\n";
	while ($rast=<RAST>){
		if ($rast=~/$genome_id/){
		$rast=~/(\d+)\t(\d+\.\d+)\t(.+)\t(\d+)/;	
		$name="$3";
		print "$name\t$data_line\n";	
		}
	}

}
