use strict;

my $inputlen = 0;
while(my $in = <STDIN>) {
	if ($inputlen == 0) {
	    $inputlen += $in;
	}else{
		my $line = $in;
		$line =~ s/\n//;
		my $browserline = $line;
		$browserline =~ s/^www\.//;
		$browserline =~ s/\.com/XXXX/;
		$browserline =~ s/[aeiou]//ig;
		print length($browserline)."/".length($line) ."\n";
	}
}


