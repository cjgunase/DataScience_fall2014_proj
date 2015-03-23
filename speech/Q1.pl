#%presHash=();
open(pres,"pres.txt") or die $!;
while(<pres>){
	chomp; 
	my @values=split('\t',$_);
	$values[0] =~ s/^\s+|\s+$//g;
	$values[0] =~ s/\s+//g;
	my $key = lc $values[0];
	$presHash{$key}= $values[1];
		
}


open(LB,"speeches.csv") or die $!;
open(out,">out.txt") or die $!;

while(<LB>){
	chomp; 
	
	my @values2=split(",",$_);
	
	$values2[1] =~ s/^\s+|\s+$//g;
	$values2[1] =~ s/\s+//g;
	$key = lc $values2[1];
	
	if(exists($presHash{$key})){
		
		print out "$values2[0]\t$presHash{$key}\n";}

}


