RandStr( L=0,N=0,U=0 ) { ; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  Loop % (L+(Z:=0)) {    ;   [color=indigo]** Simple Random String Generator **[/color] [color=black]by SKAN,  02-Sep-2008[/color]
   Random,R,97,122       ;     www.autohotkey.com/forum/viewtopic.php?p=217712#217712
   P.=Chr(R) Z           ;
} Loop %N% {             ;
   Random,R,1,9          ;    RandStr( 10 )           10 character all lower case
   P.=R Z                ;    RandStr( 0,10,0 )       10 character numeric string
} Loop %U% {             ;    RandStr( 0,0,10 )       10 character all upper case
   Random,R,65,90        ;    RandStr( 5,0,5 )        10 character mixed case
   P.=Chr(R) Z           ;
} StringTrimRight,P,P,1  ;    RandStr( 4,4 )           8 character lower alphanumeric
Sort,P,Random D%Z%       ;    RandStr( 0,4,4 )         8 character upper alphanumeric
Return RegExReplace(P,Z) ;    RandStr( 3,3,3 )         9 character mixed alphanumeric
}
