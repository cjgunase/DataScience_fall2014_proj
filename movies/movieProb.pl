 no warnings "all";

my %good=();
my %goodProb =();
open(good,"good.txt") or die $!;

while(<good>){
	chomp;
	@values=split("\t",$_);
	$good{$values[0]}=$values[1];
}
close(good);

my %bad=();
my %badProb=();
open(bad,"bad.txt") or die $!;

while(<bad>){
	chomp;
	@values=split("\t",$_);
	$bad{$values[0]}=$values[1];
}
close(bad);


my %voca=();
open(voca,"vocabulary.txt") or die $!;

while(<voca>){
	chomp;
	my $goodProb=0;
	if(exists($good{$_})){ 
		#print "$good{$_}\n";
		$goodProb=($good{$_})/(216178+685);
		#print "$_\tGood\t$goodProb\n";
		$goodProb{$_}=$goodProb;
	}else{
        $goodProb=(1)/(216178+685);                 # Add one smoothing
		#print "$_\tGood\t$goodProb\n";
		$goodProb{$_}=$goodProb;
	}
	
	my $badProb=0;
	if(exists($bad{$_})){ 
		#print "$bad{$_}\n"; 
		$badProb=($bad{$_})/(44575+685);
		#print "$_\tbad\t$badProb\n";
		$badProb{$_}=$badProb;
	}else{
        $badProb=(1)/(44575+685);               #Add one smoothing
		#print "$_\tbad\t$badProb\n";
		$badProb{$_}=$badProb;
	}
	
	
}
close(voca);


$isGood=11119/13842;
$isBad=2723/13842;
my $dir = "test";
opendir DIR, $dir or die "cannot open dir $dir: $!";
my @files= readdir DIR;
closedir DIR;

print "File\tACTUAL\tPREDICTED\tposProb\n";
foreach(@files){
    $isGood=11119/13842;
    $isBad=2723/13842;
	$filename="./test/$_";
	
    
	@file = split("-",$_);
	if($file[0] eq "movies" & $file[1] eq "1"){
		print "$filename\t";
		print "negative\t";
		
		open(file,"$filename") or die $!;
		$review=<file>;
		@words=split(' ',$review);
			foreach(@words){
                $_=~ tr/a-zA-Z//dc;
                $_=lc $_;
                if(exists($goodProb{$_})){$isGood = $isGood* $goodProb{$_};}
                if(exists($badProb{$_})){$isBad = $isBad *$badProb{$_};}
			}
	
			#print "$isGood\n";
			#print "$isBad\n";
	
			if($isGood > $isBad){
				print "positive\t";
		
			}else{
				print "negative\t";}
				
		close(file);
        print "$isGood\n";

		}elsif($file[0] eq "movies" & $file[1] eq "5"){
            $isGood=11119/13842;
            $isBad=2723/13842;
	    	print "$filename\t";
		print "positive\t";		
		
		open(file,"$filename") or die $!;
		$review=<file>;
		@words=split(' ',$review);
		foreach(@words){
                $_=~ tr/a-zA-Z//dc;
                $_=lc $_;
                if(exists($goodProb{$_})){$isGood = $isGood* $goodProb{$_};}
                if(exists($badProb{$_})){$isBad = $isBad *$badProb{$_};}
				}
	
            #print "$isGood\t";
            #print "$isBad\n";
	
		if($isGood > $isBad){
			print "positive\t";
		
		}else{
			print "negative\t";
        }
				
			print "$isGood\n";
				
			}
	}
