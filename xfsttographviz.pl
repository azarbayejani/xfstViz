#!/usr/bin/perl
#############################################################################
#                                                                           #
#  This script takes output from a xfst "print net" statement and converts  #
#  it to a graphviz .dot file. Bugs are probably abundant.                  #
#                                                                           #
#                         Author: azarbayejani                              #
#                         http://azarbayejani.com                           #
#                                                                           #
#############################################################################


@sigma = [];
$midstate = 0;
%transitionsto = ();

$output = "";

$output .= "digraph G { \n \"\" [shape = plaintext]; \n";

while(<>){
  
  # may do something in the future with Sigma, for now just store it
  if($_ =~ /^Sigma: (.*)/){
    @sigma = split(/ /, $1);

  }elsif($_ =~ /^((f?)s\d+): \(no arcs/){
    if( $2 eq "f" ){
      $output .= "$1 [peripheries=2];\n";
    }
    
  # initializing a state
  }elsif($_ =~ /^((f?)s\d+):(.*)/){
    foreach $k (keys %transitionsto){
      $output .= "$currstate -> $k [label =\"@{$transitionsto{$k}}\"];\n";
    }

    # if we don't delete the array refs, we'll keep states that may not be
    # pointed to by the current state in the list.
    foreach $k (keys %transitionsto){
      @{$transitionsto{$k}} = ();
      delete $transitionsto{$k};
    }
    %transtionsto = ();

    $currstate = $1;
    $final = $2;
    $rest = $3;

    if($rest =~ /\.$/){
      $midstate=0;
      chop $rest;
    }else{
      $midstate = 1;
    }

    # final state handling
    if( $final eq "f" ){
      $output .= "$currstate [peripheries=2];\n";
    }
    # first state handling
    if( $currstate =~ /s0/){
      $output .= "\"\" -> $currstate;\n";
    }

    $line = join("",split(/\s+/,$rest));
    %map = split(/\->|,/,$line);
    while (($transition,$to) = each(%map)) {
      push(@{$transitionsto{$to}}, $transition);
    }

  # finishing up a state
  }elsif($midstate){
    
    # final transition handling
    if($_ =~ s/\.$//){
      $midstate=0;
    }

    $line = join("",split(/\s+/,$_));
    %map = split(/\->|,/,$line);
    while (($transition,$to) = each(%map)) {
      push(@{$transitionsto{$to}}, $transition);
    }
  }
}
#last line needs to get printed.
foreach $k (keys %transitionsto){
  $output .= "$currstate -> $k [label =\"@{$transitionsto{$k}}\"];\n";
}

$output .= "}\n";

print $output;
