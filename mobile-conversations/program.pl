use strict;
use Data::Dumper qw(Dumper);
use Data::Dump qw(dump);
MAIN:{
	my $N = 'NOTSET';

	my @pos;
	my @neg;
	my @noc;

	my $cposS;
	my $cposE;
	my $cnoc;
	my $cnegS;
	my $cnegE;

    my $dpos;
    my $dnoc;
    my $dneg;

	#temps
    my @temp;

	#read eval
	while(my $line = <STDIN>){
		if ($N eq 'NOTSET') {
			$N = $line *1;
		}else{
			#Ti Xi and Delta
			$line =~ /(.*) (.*)/;
			$temp[0] = $1 *1;
			$temp[1] = $2 *1;
			$temp[2]  = $temp[1]  - $temp[0] ;

			if($temp[2] > 0){
				push(@pos,[@temp]);
			}elsif($temp[2] < 0){
				push(@neg,[@temp]);
			}else{
				push(@noc,[@temp]);
			}
		}
	}

	@pos = sort {$a->[0] <=> $b->[0]} @pos;
	@neg = sort {$b->[1] <=> $a->[1]} @neg;
	@noc = sort {$b->[0] <=> $a->[0]} @noc;

	$cposS = startMin(@pos);
	$cposE = endBal(@pos);
	$cnoc = minLeftmost(@noc);
	$cnegS = startMin(@neg);
	$cnegE = endBal(@neg);


	#$dpos = $cposE - $cposS;
    #$dnoc = 0;
    #$dneg = $cnegE - $cnegS;

	print "pos:\n";
	debug(@pos);
	print "$cposS    $cposE\n";
	


	print "noc:\n";
	debug(@noc);
	print "$cnoc  $cnoc\n";


	print "neg:\n";
	debug(@neg);
	print "$cnegS   $cnegE\n";

print "\n\nANSWER:";
	#Solution
	if ($cposS == 0) {
		if($cnoc >= $cnegS){
			print $cnoc;
		}else{
			print $cnegS;
		}
	} else {
		if (($cposS >= $cnoc) and ($cposS >= $cnegS) ) {
			print $cposS;
		} else {
			if (($cposE >= $cnoc) and ($cposE >= $cnegS) ) {
				print $cposS;
			} else {
				if($cnoc >= $cnegS){
					print $cposS + ($cnoc - $cposE);
				}else{
					print $cposS + ($cnegS - $cposE);
				}
			}
		}
	}

print "\n";
}

sub debug {
	my @db = @_;
	print dump(@db);
	print "\n";
}

sub minLeftmost{
	my @db = @_;
	if (scalar(@db) >= 1) {
		return $db[0][0];
	}else{
		return 0;
	}
}

sub startMin{
	my @db = @_;
	my $minBalance = minLeftmost(@db);
	my $currBalance = $minBalance;
    my $extra = 0;

	for (my $var = 0; $var < scalar(@db); $var++) {
		if ($db[$var][0] > $currBalance) {
			$extra = $db[$var][0] - $currBalance;
			$minBalance += $extra;
			$currBalance += $extra;
		}
		$currBalance = $currBalance + $db[$var][2];
		print "-m($minBalance)  c($currBalance)   e($extra)\n";

	}
	return $minBalance;

}

sub endBal{
	my @db = @_;
	my $minBalance = minLeftmost(@db);
	my $currBalance = $minBalance;
    my $extra = 0;

	for (my $var = 0; $var < scalar(@db); $var++) {
		if ($db[$var][0] > $currBalance) {
			$extra = $db[$var][0] - $currBalance;
			$minBalance += $extra;
			$currBalance += $extra;
		}
		$currBalance = $currBalance + $db[$var][2];
	}
	return $currBalance;

}