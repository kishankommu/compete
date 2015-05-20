use strict;

my $first = 0;

my $all = ',';
my @tmp;
my $copy = '';
while(my $ln = <STDIN>) {
	if ($first == 0) {
		$first = $ln *1;
	} else {
		$copy = '';
		$copy = $ln;

		chomp $copy;
	    @tmp = split("",$copy);
	     $all .= scalar(reverse($copy)) . ",";

	     if ($all =~ /,$copy,/) {
	     	print length($copy) ." ". $tmp[length($copy)/2];
	     }
	}
}

