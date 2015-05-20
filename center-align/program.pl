use strict;


my $page = '';
my $lines = 0;
my $maxLine = 0;

# Read input files
while(my $line = <STDIN>) {
	$lines = $lines + 1;

	if ((length($line) - 1)  > $maxLine) {
		$maxLine = length($line) - 1;
	}

    $page = $page . $line ;
}
#handle single line entry
if ($lines == 1) {
	for (my $var = 0; $var < $maxLine + 3; $var++) {
		print "*";
	}
	print "\n";
	$page =~ s/\n//;
	print "*"."$page"."*\n";
	for (my $var = 0; $var < $maxLine + 3; $var++) {
		print "*";
	}
	exit;
}
my @chars = split("", $page);
my $stars = '';

#print first line
for (my $var = 0; $var < $maxLine; $var++) {
	$stars .= "*";
}
$stars .= "**\n*";

#middle lines
foreach my $char (@chars) {
	if ($char eq "\n") {
		$stars .= "*\n*";
	}else{
		$stars .= "$char";
	}
}

#print last line
$stars .= "*\n";
for (my $var = 0; $var < $maxLine; $var++) {
	$stars .= "*";
}
$stars .= "**\n";

#print "$stars";


my @unjustlines = split("\n", $stars);

foreach my $givenline (@unjustlines) {
	print "*";
	my $targetline = $givenline;
	$targetline =~ s/^\*//;
	$targetline =~ s/\*$//;
	$targetline =~ s/^( )+//;
	$targetline =~ s/( )+$//;

	my $templen = length($targetline);
	my $delta = $maxLine - $templen;
	my $left = '';
	my $right = '';

	while ($delta) {
	 	if ($delta % 2) {
	 		$left .= " ";
	 	} else {
	 		$right .= " ";
	 	}
	 	$delta--;
	} 
	print "$left"."$targetline"."$right"."*\n";
}