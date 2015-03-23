my @wordlist;
open(list,"wordlist.txt") or die $!;
		while(<list>){
			chomp;
			push(@wordlist,$_);
		}
close(list);

open(final,">bernouliTest.csv") or die $!;
foreach(@wordlist){print final "$_,";}
print final "party\n";

open(stop,"stopwords.txt") or die $!;
my %stopWords=();
while(<stop>){
	chomp;
	$stopWords{$_}="1";
}
close(stop);



my $dem="";
my $rep="";
open(file,"out.txt") or die $!;

while(<file>){
	chomp; 
	my %wordHash=();
	my $string;
	my @vals = split("\t",$_);
	if($vals[1] eq "Democratic"){
		
		$fileName=$vals[0].".txt";
		open(D,$fileName) or die $!;
		while(<D>){
			chomp; 
			$word = $_;
			unless(exists($stopWords{$word})){ $wordHash{$word}="1";}
			
		}
		close(D);
		foreach(@wordlist){ if(exists($wordHash{$_})){ print final "1,";}else{print final "0,"}}
		print final "Democratic\n";
		
	}else{
		 	
		 $fileName=$vals[0].".txt";
		open(D,$fileName) or die $!;
		while(<D>){
			chomp; 
			$word = $_;
			unless(exists($stopWords{$word})){$wordHash{$word}="1";}
			
		}
		close(D);	
		foreach(@wordlist){ if(exists($wordHash{$_})){ print final "1,";}else{print final "0,"}}
		print final"Republican\n"; 	
		 }
	
}

