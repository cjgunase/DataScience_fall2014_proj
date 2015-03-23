open(stop,"stopwords.txt") or die $!;
my %stopWords=();
while(<stop>){
	chomp;
	$stopWords{$_}="1";
}
close(stop);

my @wordlist;
my %wordlisthash=();

open(list,"wordlist2.txt") or die $!;
while(<list>){
		chomp;
		push(@wordlist,$_);
		$wordlisthash{$_}="1";
	}
close(list);

open(out,">multinomialTest.csv") or die $!;
open(file,"out.txt") or die $!;

while(<file>){
	chomp; 
	my $dem="";
	my $rep="";
	my @vals = split("\t",$_);
	if($vals[1] eq "Democratic"){
		
		$fileName=$vals[0].".txt";
		open(D,$fileName) or die $!;
		while(<D>){
			chomp; 
			$word = $_;
			if(!exists($stopWords{$word}) && exists($wordlisthash{$word})){ $dem=$dem." ".$word;}
			
		}
		close(D);
		#print "Democratic\t$dem\n";
		my %wordcount;
		my @words = split(' ',$dem);
		foreach $word (@words) {
  			$wordcount{$word}++ if $word =~ /\w/;
		}
		foreach $word (@wordlist)  {
			if(exists($wordcount{$word})){
  			print out "$wordcount{$word},";}else {print out "0,"};
		}
		print out"democratic\n";
		
		
		
		
	}else{
		 	
		 $fileName=$vals[0].".txt";
		open(D,$fileName) or die $!;
		while(<D>){
			chomp; 
			$word = $_;
			if(!exists($stopWords{$word}) && exists($wordlisthash{$word})){ $rep=$rep." ".$word;}
			
		}
		close(D);
		#print "republican\t$rep\n";
		my %wordcount;
		my @words = split(' ',$rep);
		foreach $word (@words) {
  			$wordcount{$word}++ if $word =~ /\w/;
		}
		foreach $word (@wordlist)  {
  			if(exists($wordcount{$word})){
  			print out "$wordcount{$word},";}else {print out "0,"};
		}
		print out "republican\n";
		
		
			
		 	
		 }
	
}


