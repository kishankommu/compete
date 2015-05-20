use strict;

my $first = 0;
while(my $ln = <STDIN>) {
	if ($first == 0) {
		$first = 1;
	} else {
		my $alphabet = "abcdefghijklmnopqrstuvwxyz";
		my $tmp = '';

		my @chars = split("",$ln);
		my @chars = sort { lc($a) cmp lc($b) } @chars;
		$tmp = join("",@chars);

	    if ($tmp =~ /[a]+[b]+[c]+[d]+[e]+[f]+[g]+[h]+[i]+[j]+[k]+[l]+[m]+[n]+[o]+[p]+[q]+[r]+[s]+[t]+[u]+[v]+[w]+[x]+[y]+[z]+/) {
	    	print "YES\n";
	    } else {
	    	print "NO\n";
	    }
	}
}