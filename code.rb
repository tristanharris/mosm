10      EL=39:NO=88:NV=57:G=28
20      m3380
m30
die

def m30
30      m4400
40      LL=0
50      m3310
60      Pstr=Xstr(VAL(LEFTstr(Dstr,1)))+" "+Ystr(VAL(MIDstr(Dstr,2,1)))+" "
70      Jstr=Rstr+". "+"YOU ARE "+Pstr+RIGHTstr(Dstr,LEN(Dstr)-2)+" ":m4830
80      m3330:Jstr=""
90      FOR I=1 TO G-1
100     READ Ostr
110     Pstr=Ystr(VAL(LEFTstr(Ostr,1))):m3350
120     if F[I]=0 AND C[I]=R then Jstr=Jstr+" "+Pstr+" "+Ostr+",";end
130     NEXT I
140     if R=29 AND F[48]=0 then Jstr=Jstr+" GRARGS FEASTING,";end
150     if R=29 AND F[48]=1 then Jstr=Jstr+" A SLEEPING GRARG,";end
160     if R=12 OR R=22 then Jstr=Jstr+" A PONY,";end
170     if R=64 then Jstr=Jstr+" A HERMIT,";end
180     if R=18 AND Estr[18]="N" then Jstr=Jstr+" AN OAK DOOR,";end
190     if R=59 AND F[68]=1 then Jstr=Jstr+" OGBAN (DEAD),";end
200     if Jstr<>"" then Jstr=", YOU CAN SEE"+Jstr;end
210     Jstr=Jstr+" AND YOU CAN GO "
220     m4830:PRINT " ";
230     FOR I=1 TO LEN(Estr[R)]:PRINT MIDstr(Estr[R),I,1];",";
240     NEXT I:PRINT:PRINT
250     Rstr="PARDON?":PRINT "======================================"
260     PRINT:PRINT:PRINT "WHAT WILL YOU DO NOW "
270     INPUT Istr
280     if Istr="SAVE GAME" then m4630;end
290     Vstr="":Tstr="":VB=0:B=0
300     FOR I=1 TO LEN(Istr)
310     if MIDstr(Istr,I,1)=" " AND Vstr="" then Vstr=LEFTstr(Istr,I-1);end
320     if MIDstr(Istr,I+1,1)<>" " AND Vstr<>"" then Tstr=MIDstr(Istr,I+1,LEN(Istr)-1):I=LEN(Istr);end
330     NEXT I:IF Tstr="" then Vstr=Istr;end
340     while LEN(Vstr)<3; Vstr=Vstr+"O";end
350     if Vstr="PLAY" then Vstr="BLO";end
360     Ustr=LEFTstr(Vstr,3)
370     FOR I=1 TO NV:IF MIDstr(Bstr,I*3-2,3)=Ustr then VB=I:I=NV;end
380     NEXT I:F[36]=0
begin
390     m3330
400     FOR I=1 TO NO:READ Ostr:IF I<=G then m3350;end
410     if Tstr=Ostr then B=I:I=NO;end
420     NEXT I
430     if B=0 AND F[36]=0 AND Tstr>"" then Tstr=Tstr+"S":F[36]=1
end until !(B=0 AND F[36]=0 AND Tstr>"")
440     if VB=0 then VB=NV+1;end
450     if Tstr="" then Rstr="I NEED TWO WORDS";end
460     if VB>NV then Rstr="TRY SOMETHING ELSE";end
470     if VB>NV AND B=0 then Rstr="YOU CANNOT "+Istr;end
480     if !(B>G OR B=0) then
490     if !(VB=8 OR VB=9 OR VB=14 OR VB=17 OR VB=44 OR VB>54) then
500     if VB<NV AND C[B]<>0 then Rstr="YOU DO NOT HAVE THE "+Tstr:m30;end
end
end
510     if R=56 AND F[35]=0 AND VB<>37 AND VB<>53 then Rstr=X1str+" HAS GOT YOU!":m30;end
520     if !(VB=44 OR VB=47 OR VB=19 OR VB=57 OR VB=49) then
530     if R=48 AND F[63]=0 then Rstr=X9str:m30;end
end
540     H=VAL(STRstr(R)+STRstr(B))
560     send([:m800,:m800,:m800,:m800,:m800,:m800,:m1220,:m1290,:m1290,:m1470,:m1470,:m1750,:m1890,
580     :m1960,:m1980,:m2010,:m2050,:m2870,:m2120,:m2220,:m2310,:m2380,:m2420,:m2450,:m2470,:m2520,
600     :m2550,:m2580,:m2610,:m2650,:m2670,:m2700,:m2720,:m2730,:m2830,:m2800,:m2870,:m2730,:m2920,
620     :m2950,:m2990,:m3010,:m3050,:m3070,:m2310,:m2990,:m3070,:m3010,:m2120,:m3190,:m1470,:m3100,
640     :m2870,:m3150,:m1290,:m1290,:m3170,:m3200][VB])
650     if !F[62]=1 then
660     if R=41 then F[67]=F[67]+1:if F[67]=10 then F[56]=1:Rstr="YOU SANK!";end;end
670     if R=56 AND F[35]=0 AND C[10]<>0 then Rstr=X1str+" GETS YOU!":F[56]=1;end
680     if F[56]=0 then m30;end
690     m4400:PRINT Rstr
700     PRINT "YOU HAVE FAILED IN YOUR QUEST!"
710     PRINT:PRINT "BUT YOU ARE GRANTED ANOTHER TRY"
720     m3360:RUN
end
730     m4400
740     PRINT "HOOOOOOORRRRRAAAAAYYYYYY!"
750     PRINT
760     PRINT "YOU HAVE SUCCEEDED IN YOUR"
770     PRINT "QUEST AND BROUGHT PEACE TO"
780     PRINT "THE LAND"
790     STOP
def m800
800     D=VB
810     if D=5 then D=1;end
820     if D=6 then D=3;end
830     if !(NOT ((R=75 AND D=2) OR (R=76 AND D=4)) OR F[64]=1) then
840     Rstr="B USPMM TUPQT ZPV DSPTTJOH":m4260:RETURN
end
850     if F[64]=1 then F[64]=0;end
860     if !(F[51]=1 OR F[29]=1) then
870     if F[55]=1 then F[56]=1:Rstr="GRARGS HAVE GOT YOOU!":RETURN;end
880     if R=29 AND F[48]=0 then Rstr="GRARGS WILL SEE YOU!":RETURN;end
890     if R=73 OR R=42 OR R=9 OR R=10 then Rstr=X3str:F[55]=1:RETURN;end
end
900     if C[8]=0 AND ((R=52 AND D=2) OR (R=31 AND D<>3))THEN Rstr="THE BOAT IS TOO HEAVY":RETURN
910     if C[8]<>0 AND ((R=52 AND D=4) OR (R=31 AND D=3)) then Rstr="YOU CANNOT SWIM":RETURN;end
920     if R=52 AND C[8] AND D=4 AND F[30]=0 then Rstr="NO POWER!":RETURN;end
930     if R=41 AND D=3 AND F[31]=0 then Rstr="UIF CPBU JT TJOLJOH!":m4260:RETURN;end
940     if R=33 AND D=1 AND F[32]=0 then Rstr="OGBAN'S BOAR BLOCK YOUR PATH":RETURN;end
950     if ((R=3 AND D=2) OR (R=4 AND D=4)) AND F[45]=0 then Rstr=X5str:RETURN;end
960     if R=35 AND C[13]<>R then Rstr="THE ICE IS BREAKING!":RETURN;end
970     if R=5 AND (D=2 OR D=4) then m4310;end
980     if R=4 AND D=4 then Rstr="PASSAGE IS TOO STEEP":RETURN;end
990     if R=7 AND D=2 AND F[46]=0 then Rstr="A HUGE HOUND BARS YOUR WAY":RETURN;end
1000    if (R=38 OR R=37) AND F[50]=0 then Rstr="JU JT UPP EBSL":m4260:RETURN;end
1010    if R=49 AND D=2 AND F[54]=0 then ET Rstr="MYSTERIOUS FORCES HOLD YOU BACK":RETURN;end
1020    if R=49 AND D=3 AND F[68]=0 then Rstr="YOU MEET OGBAN!!!":F[56]=1:RETURN;end
1030    if R=38 ANF F[65]=0 then Rstr="RATS NIBBLE YOUR ANKLES":RETURN;end
1040    if R=58 AND (D=1 OR D=4) AND F[66]=0 then Rstr="YOU GET CAUGHT IN THE WEBS!":RETURN;end
1050    if R=48 AND D=4 AND F[70]=0 then Rstr="THE DOOR DOES NOT OPEN":RETURN;end
1060    if R=40 AND F[47]=1 then F[68]=1;end
1070    if R=37 AND D=4 AND Estr[37]="EW" then R=67:Rstr="THE PASSAGE WAS STEEP!":RETURN;end
1080    if R=29 AND D=3 then F[48]=1:F[20]=0;end
1090    if R=8 AND D=2 then F[46]=0;end
1100    OM=R:FOR I=1 TO LEN(Estr[R)]
1110    Kstr=MIDstr(Estr[OM),I,1]
1120    if (Kstr="N" OR Kstr="U") AND D=1 then R=R-10;end
1130    if Kstr="E" AND D=2 then R=R+1;end
1140    if (Kstr="S" OR Kstr="D") AND D=3 then R=R+10;end
1150    if Kstr="W" AND D=4 then R=R-1;end
1160    NEXT I:Rstr="OK"
1170    if R=OM then Rstr="YOU CANNOT GO THAT WAY";end
1180    if ((OM=75 AND D=2) OR (OM=76 AND D=4)) then Rstr="OK. YOU CROSSED";end
1190    if F[29]=1 then F[39]=F[39]+1;end
1200    if F[39]>5 AND F[29]=1 then Rstr="CPPUT IBWF XPSO PVU":m4260: F[29]=0:C[3]=81;end
1210    RETURN
1220    m3330:Rstr="OK":F[49]=0
1230    PRINT "YOU HAVE ";
1240    FOR I=1 TO G:READ Ostr:m3350:IF I=1 AND C[1]=0 AND F[44]=1 then Ostr="COIN";end
1250    if !(I=G AND C[5]=0) then
1260    if C[I]=0 then PRINT Ostr;",";:F[49]=1;end
1270    NEXT I:IF F[49]=0 then PRINT "NOTHING";end
end
1280    PRINT:m3360:RETURN
end

def m1290
1290    if H=6577 then Rstr="HOW?":RETURN;end
1300    if H=4177 OR H=5177 then B=16:m2380:RETURN;end
1310    if B=38 then Rstr="TOO HEAVY!":RETURN;end
1320    if B=4 AND F[43]=0 then Rstr="IT IS FIRMLY NAILED ON!":RETURN;end
1330    CO=0:FOR I=1 TO G-1:IF C[I]=0 then CO=CO+1;end
1340    NEXT I:IF CO>13 then Rstr="YOU CANNOT CARRY ANYMORE":RETURN;end
1350    if B>G then Rstr="YOU CANNOT GET THE "+Tstr:RETURN;end
1360    if B=0 then RETURN;end
1370    if C[B]<>R then Rstr="IT IS NOT HERE";end
1380    if F[B]=1 then Rstr="WHAT "+Tstr+"?";end
1390    if C[B]=0 then Rstr="YOU ALREADY HAVE IT";end
1400    if C[B]=R AND F[B]=0 then C[B]=0:Rstr="YOU HAVE THE "+Tstr;end
1410    if B=28 then C[5]=81;end
1420    if B=5 then C[28]=0;end
1430    if C[4]=0 AND C[12]=0 AND C[15]=0 then F[54]=1;end
1440    if B=8 AND F[30]=1 then C[2]=0;end
1450    if B=2 then F[30]=0;end
1460    RETURN
end

def m1470
1470    Rstr="YOU SEE WHAT YOU MIGHT EXPECT!"
1480    if B>0 then Rstr="NOTHING SPECIAL";end
1490    if B=46 OR B=88 then m2550;end
1500    if H=8076 then Rstr="IT IS EMPTY";end
1510    if H=8080 then Rstr="AHA!":F[1]=0;end
1520    if H=7029 then Rstr="OK":F[2]=0;end
1530    if B=20 then Rstr="NBUDIFT JO QPDLFU":m4260:C[26]=0;end
1540    if H=1648 then Rstr="THEREARE SOME LETTERS '"+Gstr[2]"'";end
1550    if H=7432 then Rstr="UIFZ BSF BQQMF USFFT":m4260:F[5]=0;end
1560    if H=2134 OR H=2187 then Rstr="OK":F[16]=0;end
1570    if B=35 then Rstr="IT IS FISHY!":F[17]=0;end
1580    if H=3438 then Rstr="OK":F[22]=0;end
1590    if H=242 then Rstr="A FADED INSCRIPTION";end
1600    if (H=1443 OR H=1485) AND F[33]=0 then Rstr="B HMJNNFSJOH GSPN UIF EFQUIT":m4260;end
1610    if (H=1443 OR H=1485) AND F[33]=1 then Rstr="SOMETHING HERE...":F[12]=0;end
1620    if H=2479 OR H=2444 then Rstr="THERE IS A HANDLE";end
1630    if B=9 then Rstr="UIF MBCFM SFBET 'QPJTPO'":m4260;end
1640    if H=4055 then m3290;end
1650    if H=2969 AND F[49]=1 then Rstr="VERY UGLY!";end
1660    if H=7158 OR H=7186 then Rstr="THERE ARE LOOSE BRICKS";end
1670    if R=49 then Rstr="VERY INTERESTING!";end
1680    if B=52 OR B=82 OR B=81 then Rstr="INTERESTING!";end
1690    if H=6978 then Rstr="THERE IS A WOODEN DOOR";end
1700    if H=6970 then Rstr="YOU FOUND SOMETHING":F[4]=0;end
1710    if H=2066 then Rstr="A LARGE CUPBOARD IN THE CORNER";end
1720    if H=6865 OR H=6853 then Rstr="THERE ARE NINE STONES";end
1730    if H=248 then Rstr="A GBEFE XPSE - 'N S I T'":m4260;end
1740    RETURN
end

def m1750
1750    if R=64 then Rstr="HE GIVES IT BACK!";end
1760    if H=6425 then m3210;end
1770    if R=75 OR R=76 then Rstr="HE DOES NOT WANT IT";end
1780    if B=62 AND F[44]=0 then Rstr="YOU HAVE RUN OUT!";end
1790    if (H=7562 OR H=7662) AND F[44]>0 AND C[1]=0 then Rstr="HE TAKES IT":F[64]=1;end
1800    if F[64]=1 then F[44]=F[44]-1;end
1810    if B=1 then Rstr="HE TAKES THEM ALL!":C[1]=81:F[64]=1:F[44]=0;end
1820    if H=2228 AND C[5]=81 then Rstr=XBstr+"NORTH":C[28]=81:R=12;end
1830    if (H=2228 AND C[5]=81) OR H=225 then Rstr=XBstr+"NORTH":R=12;end
1840    if (H=1228 AND C[5]=81) OR H=125 then Rstr=XBstr+"SOUTH":R=12;end
1850    if R=7 OR R=33 then Rstr="HE EATS IT!":C[B]=81;end
1860    if H=711 then F[46]=1:Rstr="HE IS DISTRACTED";end
1870    if H=385 OR H=3824 then Rstr="THEY SCURRY AWAY":C[B]=81:F[65]=1;end
1880    RETURN
1890    Rstr="YOU SAID IT"
1900    if B=84 then Rstr="YOU MUST SAY THEM ONE BY ONE!":RETURN;end
1910    if R<>47 OR B<71 OR B>75 OR C[27]<>0 then RETURN;end
1920    if B=71 AND F[60]=0 then Rstr=X7str:F[60]=1:RETURN;end
1930    if B=72 AND F[60]=1 AND F[61]=0 then Rstr=X8str:F[61]=1:RETURN;end
1940    if B=(F[52]+73) AND F[60]=1 AND F[61]=1 then F[62]=1:RETURN;end
1950    Rstr="THE WRONG SACRED WORD!":F[56]=1:RETURN
end

def m1960
1960    if B=5 OR B=10 then m1290;end
1970    RETURN
1980    if B=3 then F[29]=1:Rstr="ZPV BSF JOWJTJCMF":F[55]=0:m4260;end
1990    if B=20 then F[51]=1:Rstr="ZPV BSF EJTHVJTFE":F[55]=0:m4260;end
2000    RETURN
2010    if B=2 OR B=14 then Rstr="NOTHING TO TIE IT TO!";end
2020    if H=7214 then Rstr="IT IS TIED":C[14]=72:F[53]=1;end
2030    if H=722 then Rstr="OK":F[40]=1:C[2]=72;end
2040    RETURN
2050    if H=1547 AND F[38]=1 then Rstr="ALL RIGHT":R=16;end
2060    if B=14 OR B=2 then Rstr="NOT ATTACHED TO ANYTHING!";end
2070    if H=5414 AND C[14]=54 then Rstr="YOU ARE AT THE TOP";end
2080    if H=7214 AND F[53]=1 then Rstr="GOING DOWN":R=71;end
2090    if H=722 AND F[40]=1 then R=71:Rstr="IT IS TORN":C[2]=81:F[40]=0;end
2100    if H=7114 AND F[53]=1 then C[14]=71:F[53]=0:Rstr="IT FALLS DOWN-BUMP!";end
2110    RETURN
2120    if H=522 then Rstr="OK":F[30]=1;end
2130    if B=1 OR B=62 OR B=5 OR B=28 OR B=11 OR B=24 then m1750;end
2140    if H=416 then Rstr="ZPV IBWF LFQU BGMPBU":F[31]=1:m4260:RETURN;end
2150    if H=4116 then Rstr="IT IS NOT BIG ENOUGH!":RETURN;end
2160    if B=18 OR B=7 then m2470;end
2170    if B=13 then m2730;end
2180    if B=19 then m3070;end
2190    if B=10 then m2870;end
2200    if B=16 OR B=6 then m2380;end
2210    RETURN
2220    if B=76 OR B=38 then m1470;end
2230    if H=2030 then F[9]=0:Rstr="OK";end
2240    if H=6030 then Rstr="OK":F[3]=0;end
2250    if H=2444 OR H=1870 then Rstr="YOU ARE NOT STRONG ENOUGH";end
2260    if H=3756 then Rstr="A PASSAGE!":Estr[37]="EW";end
2270    if H=5960 then m3260;end
2280    if H=6970 then Rstr="IT FALLS OFF ITS HINGES";end
2290    if H=4870 then Rstr="IT IS LOCKED";end
2300    RETURN
2310    if B>G then Rstr="IT DOES NOT BURN";end
2320    if B=26 then Rstr="YOU LIT THEM";end
2330    if H=3826 then Rstr="NOT BRIGHT ENOUGH";end
2340    if (B=23 OR H=6970) AND C[26]<>0 then Rstr="OP NBUDIFT":m4260;end
2350    if B=23 AND C[26]=0 then Rstr="A BRIGHT "+Vstr:F[50]=1;end
2360    if H=6970 AND C[26]=0 then F[43]=1:Rstr="IT HAS TURNED TO ASHES";end
2370    RETURN
end

def m2380
2380    if (B=16 OR B=6) AND (R=41 OR R=51) then Rstr="YOU CAPSIZED!":F[56]=1;end
2390    if H=6516 AND C[16]=0 then Rstr="IT IS NOW FULL":F[34]=1;end
2400    if H=656 then Rstr="IT LEAKS OUT!";end
2410    RETURN
2420    if B<>22 OR R<>15 then Rstr="DOES NOT GROW!":RETURN;end
2430    Rstr="OK":F[34]=1
2440    RETURN
end

def m2450
2450    if B=22 AND F[37]=1 AND F[34]=1 then Rstr=X2str:F[38]=1:m4260;end
2460    RETURN
end

def m2470
2470    if B=7 OR B=18 then Rstr="THWACK!";end
2480    if H=5818 then Rstr="YOU CLEARED THE WEBS":F[66]=1;end
2490    if H=187 then Rstr="THE DOOR BROKE!":Estr[18]="NS":Estr[28]="NS";end
2500    if H=717 then Rstr="YOU BROKE THROUGH":Estr[71]="N";end
2510    RETURN
2520    if B=16 then B=22:m2450;end
2530    if H=499 then Rstr="WHERE?";end
2540    RETURN
end

def m2550
2550    if H=4337 then VB=2:m800:RETURN;end
2560    if R=36 then Rstr="YOU FOUND SOMETHING":F[13]=0;end
2570    RETURN
2580    if R=76 then VB=4:m800:RETURN;end
2590    if R=75 then VB=2:m800;end
2600    RETURN
2610    if (B=3 AND F[29]=1) then Rstr="TAKEN OFF":F[29]=0;end
2620    if (B=20 AND F[51]=1) then Rstr="OK":F[51]=0;end
2630    if B=36 OR B=50 then m2950;end
2640    RETURN
2650    if H=3859 OR H=3339 OR H=1241 OR H=2241 OR H=751 then Rstr="WITH WHAT?";end
2660    RETURN
2670    if H=2340 then Rstr="IT GOES ROUND";end
2680    if H=2445 then Rstr="UIF HBUFT PQFQ, UIF QPPM FNQUJFT":F[33]=1:m4260;end
2690    RETURN
2700    if R=14 OR R=51 then Rstr="YOU HAVE DROWNED":F[56]=1;end
2710    RETURN
2720    Rstr="HOW?":RETURN
end

def m2730
2730    if B=0 OR B>G then RETURN;end
2740    C[B]=R:Rstr="DONE"
2750    if H=418 OR H=518 then Rstr="YOU DROWNED!":F[56]=1;end
2760    if B=8 AND F[30]=1 then C[2]=R;end
2770    if B=16 AND F[34]=1 then Rstr="YOU LOST THE WATER!":F[34]=0;end
2780    if B=2 AND F[30]=1 then F[30]=0;end
2790    RETURN
2800    if B=62 AND F[44]=0 then Rstr="YOU DO NOT HAVE ANY";end
2810    if H=5762 AND C[1]=0 AND F[44]>0 then m3230;end
2820    RETURN
2830    if B=0 OR B>G then RETURN;end
2840    Rstr="DID NOT GO FAR!":C[B]=R
2850    if H=3317 then Rstr="ZPV DBVHIU UIF CPBS":F[32]=1:m4260;end
2860    RETURN
end

def m2870
2870    if B=10 then Rstr+"B OJDF UVOF":m4260;end
2880    if H=5233 then Rstr="WHAT WITH?";end
2890    if B=83 then Rstr="HOW, O MUSICAL ONE?";end
2900    if H=5610 then F[35]=1:Rstr=X1str+" IS FREE!":Estr[56]="NS";end
2910    RETURN
2920    if B=0 OR B>G then RETURN;end
2930    if B=5 OR B=24 then Rstr="YUM YUM!":C[B]=81;end
2940    RETURN
end

def m2950
2950    if R=4 AND B=50 then F[45]=1:Rstr="YOU REVEALED A STEEP PASSAGE";end
2960    if R=3 AND B=50 then Rstr="YOU CANNOT MOVE RUBBLE FROM HERE";end
2970    if H=7136 then Rstr="THEY ARE WEDGED IN!";end
2980    RETURN
2990    if (B=67 OR B=68) AND C[9]=0 AND R=49 then Rstr="OK":F[47]=1;end
3000    RETURN
3010    if R<>27 OR B<>63 then RETURN;end
3020    begin PRINT:PRINT "HOW MANY TIMES?":INPUT MR:IF MR=0 then PRINT "A NUMBER":end:end until MR>0
3030    if MR=F[42] then Rstr="A ROCK DOOR OPENS":Estr[27]="EW":RETURN;end
3040    Rstr="ZPV IBWF NJTUSFBUFE UIF CFMM!":F[56]=1:m4260:RETURN
3050    if H=5861 then H=5818:m2470;end
3060    RETURN
end

def m3070
3070    if (H=4864 OR H=4819) AND C[19]=0 then Rstr=X6str:F[63]=1:m4260;end
3080    if B=27 then m1290;end
3090    RETURN
3100    if H=7549 OR H=7649 then Rstr="WHAT WITH?";end
3110    if B=1 OR B=62 then m1750;end
3120    RETURN
3130    if H=4870 AND C[21]=0 then Rstr="THE KEY TURNS!":F[70]=1;end
3140    RETURN
3150    if H=1870 then Rstr="HOW?";end
3160    RETURN
3170    if R=48 then Rstr="HOW?";end
3180    RETURN
3190    Rstr="ARE YOU THIRSTY?"
3200    RETURN
end

def m3210
3210    Rstr="HE TAKES IT AND SAYS '"+STRstr(F[42])+" RINGS ARE NEEDED'":C[25]=81
3220    RETURN
end

def m3230
3230    F[44]=F[44]-1:Rstr="A NUMBER APPEARS - "+STRstr(F[41])
3240    if F[44]=0 then C[1]=81;end
3250    RETURN
end

def m3260
3260    PRINT:Rstr="XIBU JT UIF DPEF":m4260:PRINT Rstr:INPUT CN
3270    Rstr="WRONG!":IF CN=F[41] then Rstr="IT OPENS":F[21]=0;end
3280    RETURN
end

def m3290
3290    T=R:R=F[F[52]+57]:m3310:R=T
3300    Rstr=X4str+RIGHTstr(Dstr,LEN(Dstr)-2):RETURN
end

def m3310
3310    RESTORE:FOR I=1 TO R:READ Dstr:NEXT I
3320    RETURN
end

def m3330
3330    RESTORE:FOR I=1 TO 80:READ Dstr:NEXT I
3340    RETURN
end

def m3350
3350    Ostr=RIGHTstr(Ostr,LEN(Ostr)-1):RETURN
end

def m3360
3360    PRINT "PRESS RETURN TO CONTINUE"
3370    INPUT Zstr:RETURN
end

def m3380
3380    DIM C[G],Estr[80],F[70],Xstr[6],Ystr[6],Gstr[2]
3390    m3330
3400    FOR I=1 TO NO:READ Tstr:NEXT I
3410    FOR I=1 TO 6:READ Xstr[I],Ystr[I]:NEXT I
3420    Bstr="NOOEOOSOOWOOUOODOOINVGETTAKEXAREAGIVSAYPICWEATIECLIRIGUSEOPE"
3430    Bstr=Bstr+"LIGFILPLAWATSWIEMPENTCROREMFEETURDIVBAILEATHRINSBLODROEATMOV"
3440    Bstr=Bstr+"INTRINCUTHOLBURPOISHOUNLWITDRICOUPAYMAKBRESTEGATREF"
3450    X6str="XV SFGMFDUFE UIF XJABSET HMSBF! if JT EFBE"
3460    X1str="THE GHOST OF THE GOBLIN GUARDIAN"
3470    X2str="B MBSHF WJOF HSPXT JO TFDPOET!"
3480    X3str="A GRARG PATROL APPROACHES"
3490    X4str="MAGIC WORDS LIE AT THE CROSSROADS, THE FOUNTAIN AND THE "
3500    X5str="A PILE OF RUBBLE BLOCKS YOUR PATH"
3510    X7str="THE MOUNTAIN RUMBLES!"
3520    X8str="TOWERS FALL DOWN!"
3530    X9str="THE WIZARD HAS YOU IN HIS GLARE"
3540    XBstr="HE LEADS YOU "
3550    m4400:PRINT "DO YOU WANT TO"
3560    PRINT:PRINT "   1. START A NEW GAME"
3570    PRINT "OR 2. CONTINUE A SAVED GAME"
begin
3580    PRINT:PRINT:PRINT "TYPE IN EITHER 1 OR 2"
3590    INPUT C:end until !(C<>1 AND C<>2)
3600    if C=1 then m4450;end
3610    if C=2 then m4600;end
3620    RETURN
end

3630    DATA 11HALF-DUG GRAVE,12GOBLIN GRAVEYARD
3640    DATA 11HOLLOW TOMB,23STALACTITES AND STALAGMITES
3650    DATA 11MAZE OF TUNNELS,11VAULTED CAVERN
3660    DATA 23HIGH GLASS GATES,12ENTRANCE HALL TO THE PALACE
3670    DATA 31GRARG SENTRY POST,12GUARD ROOM
3680    DATA 31MARSHY INLET,23RUSTYGATES
3690    DATA 12GAMEKEEPER'S COTTAGE,31MISTY POOL
3700    DATA 11HIGH-WALLED GARDEN,14INSCRIBED CAVERN
3710    DATA 34ORNATE FOUNTAIN,11DANK CORRIDOR
3720    DATA 12LONG GALLERY,12KITCHENS OF THE PALACE
3730    DATA 34OLDKILN,44OVERGROWN TRACK
3740    DATA 31DISUSED WATERWHHEL,33SLUICE GATES
3750    DATA 11GAP BETWEEN SOME BOULDERS,41PERILOUS PATH
3760    DATA 31SILVER BELL IN THE ROCK,12DUNGEONS OF THE PALLACE
3770    DATA 11BANQUETING HALL,42PALACE BATTLEMENTS
3780    DATA 44ISLAND SHORE,31BEACHED KETCH
3790    DATA 13BARREN COUNTRYSIDE,33SACKS ON THE UPPER FLOOR
3800    DATA 46FROZEN POND,21MOUNTAIN HUT
3810    DATA 31ROW OF CASKS,11WINE CELLAR
3820    DATA 12HALL OF TAPESTRIES,11DUSTY LIBRARY
3830    DATA 13ROUGH WATER,11PLOUGHED FIELD
3840    DATA 55OUTSIDE A WINDMILL,42LOWER FLOOR OF THE MILL
3850    DATA 44ICY PATH,41SCREE SLOPE
3860    DATA 12SILVER CHAMBER,12WIZARD'S LAIR
3870    DATA 11MOSAIC-FLOORED HALL,12SILVER THRONE ROOM
3880    DATA 12MIDDLE OF THE LAKE,42EDGE OF AN ICY LAKE
3890    DATA 41PITTED TRACK,41HIGH PINNACLE
3900    DATA 55ABOVE A GLACIER,21HUGE FALLEN OAK
3910    DATA 11TURRET ROOM WITH A SLOT MACHINE,11COBWEBBY ROOM
3920    DATA 31SAFE IN OGBAN'S CHAMBER,31CUPBOARD IN A CORNER
3930    DATA 11NARROW PASSAGE,16CAVE
3940    DATA 11WOODMAN'S HUT,42SIDE OF A WOODED VALLEY
3950    DATA 21STREAM IN A VALLEY BOTTOM,11DEEP DARK WOOD
3960    DATA 11SHADY HOLLOW,34ANCIENT STONE CIRCLE
3970    DATA 16STABLE,14ATTIC BEDROOM
3980    DATA 11DAMP WELL BOTTOM,32TOPOF A DEEP WELL
3990    DATA 31BURNT-OUT CAMPFIRE,16ORCHARD
4000    DATA 62END OF A BRIDGE,62END OF A BRIDGE
4010    DATA 61CROSSROADS,41WINDING ROAD
4020    DATA 11VILLAGE OF RUSTIC HOUSES,11WHITE COTTAGE
4030    DATA 3COINS,1SHEET,3BOOTS,1HORSESHOE,3APPLES,1BUCKET,4AXE,1BOAT,1PHIAL
4040    DATA 3REEDS,1BONE,1SHIELD,3PLANKS,1ROPE,1RING,1JUG,1NET,1SWORD
4050    DATA 1SILVER PLATE,1UNIFORM,1KEY,3SEEDS,1LAMP,3BREAD,1BROOCH,3MATCHES
4060    DATA 2STONE OF DESTINY,4APPLE,BED,CUPBOARD,BRIDGE,TREES,SAIL,KILN
4070    DATA KETCH,BRICKS,WINDMILL,SACKS,OGBAN'S BOAR,WHEEL
4080    DATA PONY,GRAVESTONES,POOL,GATES,HANDLE,HUT,VINE,INSCRIPTIONS,TROLL,RUBBLE
4090    DATA HOUND,FOUNTAIN,CIRCLE,MOSAICS,BOOKS,CASKS,WELL,WALLS,RATS,SAFE
4100    DATA COBWEBS,COIN,BELL,UP SILVER PLATE,STONES,KITCHENS,GOBLET,WINE
4110    DATA GRARGS,DOOR,AWAKE,GUIDE,PROTECT,LEAD,HELP,CHEST,WATER
4120    DATA STABLES,SLUICE GATES,POT,STATUE,PINNACLE,MUSIC,MAGIC WORDS
4130    DATA MISTY POOL,WELL BOTTOM,OLD KILN,MOUNTAIN HUT
4140    DATA IN,A,NEAR,THE,BY,SOME,ON,AN,"","",AT,A SMALL
4150    DATA E,ESW,WE,EW,EW,ESW,ESW,ES,EW,SW
4160    DATA S,N,ES,SW,S,NW,N,N,ES,NSW
4170    DATA NS,E,NSW,N,NES,EW,W,S,NS,N
4180    DATA NES,W,NS,D,NES,SW,E,NW,NS,S
4190    DATA NS,E,NSEW,WU,UD,NS,E,SW,NSE,NW
4200    DATA NE,EW,NSW,E,WN,S,E,NEW,NW,S
4210    DATA ES,SW,NES,EW,SW,NE,EW,ESW,SW,ND
4220    DATA " ",E,NEW,EW,NEW,EW,EW,NEW,NEW,WU
4230    DATA 80,70,60,69,74,72,63,52,20,11,1,14,36,54,61,21,32,10,50
4240    DATA 29,59,34,13,80,30,81,47,74
4250    DATA 1,2,3,4,5,9,12,13,16,17,20,21,22

def m4260
4260    Zstr="":FOR I=1 TO LEN(Rstr)
4270    Cstr=MIDstr(Rstr,I,1):IF Cstr<"A" then Zstr=Zstr+Cstr;else
4280    C=ASC[Cstr]-1:IF C=64 then C=90;end
4290    Zstr=Zstr+CHRstr(C)
end
4300    NEXT I:Rstr=Zstr:RETURN
end

def m4310
4310    Jstr="SSSSSSSS":NG=0
begin
4320    MP=D/2:m4400
4330    PRINT "YOU ARE LOST IN THE":PRINT "      TUNNELS"
4340    PRINT WHICH WAY? (NS,W OR E)
4350    if NG>15 then PRINT "(OR G TO GIVE UP!)";end
4360    PRINT:PRINT Wstr:Jstr=RIGHTstr(Jstr+RIGHTstr(Wstr,1),8)
4370    if Wstr="G" then F[56]=1:RETURN;end
4380    if Jstr<>Gstr[MP] then NG=NG+1
end until !(Jstr<>Gstr[MP])
4390    RETURN
end

def m4400
4400    CLS:PRINT
4410    PRINT TAB(EL/2-9);"MYSTERY OF SILVER"
4420    PRINT TAB(EL/2-9);"    MOUNTAIN"
4430    PRINT "======================================"
4440    PRINT:PRINT:RETURN
end

def m4450
4450    FOR I=1 TO 80:READ Estr[I]:NEXT I
4460    FOR I=1 TO G:READ C[I]:NEXT I
4470    FOR I=1 TO 13:READ A:F[A]=1:NEXT I
4480    F[41]=INT(RND(1)*900)+100:F[42]=INT(RND(1)*3)+2
4490    F[44]=4:F[57]=68:F[58]=54:F[59]=15:F[52]=INT(RND(1)*3)
4500    R=77:Rstr="GOOD LUCK ON YOUR QUEST!"
4510    Gstr[1]="":FOR I=1 TO 8
4520    Fstr=MIDstr(Bstr,1+INT(RND(1)*4)*3,1)
4530    Gstr[1]=Gstr[1]+Fstr
4540    if Fstr="N" then Lstr="S";end
4550    if Fstr="S" then Lstr="N";end
4560    if Fstr="E" then Lstr="W";end
4570    if Fstr="W" then Lstr="E";end
4580    Gstr[2]=Lstr+Gstr[2]
4590    NEXT I:RETURN
end

def m4600
4600    m4640:m4670
4610    R=F[69]:Rstr="OK. CARRY ON"
4620    RETURN
end

def m4630
4630    F[69]=R:m4640:m4760:PRINT "BYE...":STOP
end

def m4640
4640    PRINT:PRINT "PLEASE ENTER A FILE NAME":INPUT FLstr
4650    RETURN
end

def m4670
4660    REM READ DATA FILE
4670    REM
4680    PRINT "OK. SEARCHING FOR ";FLstr
4690    X=OPENIN(FLstr):PRINT "OK. LOADING"
4700    FOR I=1 TO 80:INPUT#X,Estr[I]:NEXT
4710    FOR I=1 TO G:INPUT#X,C[I]:NEXT
4720    FOR I=1 TO 70:INPUT#X,F[I]:NEXT
4730    INPUT#X,Gstr[1]:INPUT#X,Gstr[2]
4740    CLOSE#X:RETURN
end

def m4760
4750    REM SAVE DATA FILE
4760    REM
4770    X=OPENOUT(FLstr):PRINT "OK. SAVING"
4780    FOR I=1 TO 80:PRINT#X,Estr[I]:NEXT
4790    FOR I=1 TO G:PRINT#X,C[I]:NEXT
4800    FOR I=1 TO 70:PRINT#X,F[I]:NEXT
4810    PRINT#X,Gstr[1]:PRINT#X,Gstr[2]
4820    CLOSE#X:RETURN
end

def m4830
4830    LS=1:LP=1
4840    FOR I=1 TO LEN(Jstr)
4850    if MIDstr(Jstr,I,1)=" " AND LL>EL then PRINT MIDstr(Jstr,LP,LS-LP):LL=I-LS:LP=LS+1;end
4860    if MIDstr(Jstr,I,1)=" " then LS=I;end
4870    LL=LL+1:NEXT I
4800    PRINT MIDstr(Jstr,LP,LEN(Jstr)-LP);
4890    RETURN


