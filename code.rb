10      LET EL=39:LET NO=88:LET NV=57:LET G=28
20      m3380
30      m4400
40      LET LL=0
50      m3310
60      LET Pstr=Xstr(VAL(LEFTstr(Dstr,1)))+" "+Ystr(VAL(MIDstr(Dstr,2,1)))+" "
70      LET Jstr=Rstr+". "+"YOU ARE "+Pstr+RIGHTstr(Dstr,LEN(Dstr)-2)+" ":m4830
80      m3330:LET Jstr=""
90      FOR I=1 TO G-1
100     READ Ostr
110     LET Pstr=Ystr(VAL(LEFTstr(Ostr,1))):m3350
120     IF F[I]=0 AND C[I]=R THEN LET Jstr=Jstr+" "+Pstr+" "+Ostr+","
130     NEXT I
140     IF R=29 AND F[48]=0 THEN LET Jstr=Jstr+" GRARGS FEASTING,"
150     IF R=29 AND F[48]=1 THEN LET Jstr=Jstr+" A SLEEPING GRARG,"
160     IF R=12 OR R=22 THEN LET Jstr=Jstr+" A PONY,"
170     IF R=64 THEN LET Jstr=Jstr+" A HERMIT,"
180     IF R=18 AND Estr[18]="N" THEN LET Jstr=Jstr+" AN OAK DOOR,"
190     IF R=59 AND F[68]=1 THEN LET Jstr=Jstr+" OGBAN (DEAD),"
200     IF Jstr<>"" THEN LET Jstr=", YOU CAN SEE"+Jstr
210     LET Jstr=Jstr+" AND YOU CAN GO "
220     m4830:PRINT " ";
230     FOR I=1 TO LEN(Estr[R)]:PRINT MIDstr(Estr[R),I,1];",";
240     NEXT I:PRINT:PRINT
250     LET Rstr="PARDON?":PRINT "======================================"
260     PRINT:PRINT:PRINT "WHAT WILL YOU DO NOW "
270     INPUT Istr
280     IF Istr="SAVE GAME" THEN GOTO 4630
290     LET Vstr="":LET Tstr="":LET VB=0:LET B=0
300     FOR I=1 TO LEN(Istr)
310     IF MIDstr(Istr,I,1)=" " AND Vstr="" THEN LET Vstr=LEFTstr(Istr,I-1)
320     IF MIDstr(Istr,I+1,1)<>" " AND Vstr<>"" THEN LET Tstr=MIDstr(Istr,I+1,LEN(Istr)-1):LET I=LEN(Istr)
330     NEXT I:IF Tstr="" THEN LET Vstr=Istr
340     IF LEN(Vstr)<3 THEN LET Vstr=Vstr+"O":GOTO 340
350     IF Vstr="PLAY" THEN LET Vstr="BLO"
360     LET Ustr=LEFTstr(Vstr,3)
370     FOR I=1 TO NV:IF MIDstr(Bstr,I*3-2,3)=Ustr THEN LET VB=I:LET I=NV
380     NEXT I:LET F[36]=0
390     m3330
400     FOR I=1 TO NO:READ Ostr:IF I<=G THEN m3350
410     IF Tstr=Ostr THEN LET B=I:LET I=NO
420     NEXT I
430     IF B=0 AND F[36]=0 AND Tstr>"" THEN LET Tstr=Tstr+"S":LET F[36]=1:GOTO 390
440     IF VB=0 THEN LET VB=NV+1
450     IF Tstr="" THEN LET Rstr="I NEED TWO WORDS"
460     IF VB>NV THEN LET Rstr="TRY SOMETHING ELSE"
470     IF VB>NV AND B=0 THEN LET Rstr="YOU CANNOT "+Istr
480     IF B>G OR B=0 THEN GOTO 510
490     IF VB=8 OR VB=9 OR VB=14 OR VB=17 OR VB=44 OR VB>54 THEN GOTO 510
500     IF VB<NV AND C[B]<>0 THEN LET Rstr="YOU DO NOT HAVE THE "+Tstr:GOTO 30
510     IF R=56 AND F[35]=0 AND VB<>37 AND VB<>53 THEN LET Rstr=X1str+" HAS GOT YOU!":GOTO 30
520     IF VB=44 OR VB=47 OR VB=19 OR VB=57 OR VB=49 THEN GOTO 540
530     IF R=48 AND F[63]=0 THEN LET Rstr=X9str:GOTO 30
540     LET H=VAL(STRstr(R)+STRstr(B))
550     ON INT((VB-1)/13)+1 GOTO 560,580,600,620,640
560     ON VB m800,800,800,800,800,800,1220,1290,1290,1470,1470,1750,1890
570     GOTO 650
580     ON VB-13 m1960,1980,2010,2050,2870,2120,2220,2310,2380,2420,2450,2470,2520
590     GOTO 650
600     ON VB-26 m2550,2580,2610,2650,2670,2700,2720,2730,2830,2800,2870,2730,2920
610     GOTO 650
620     ON VB-39 m2950,2990,3010,3050,3070,2310,2990,3070,3010,2120,3190,1470,3100
630     GOTO 650
640     ON VB-52 m2870,3150,1290,1290,3170,3200
650     IF F[62]=1 THEN GOTO 730
660     IF R=41 THEN LET F[67]=F[67]+1:IF F[67]=10 THEN LET F[56]=1:LET Rstr="YOU SANK!"
670     IF R=56 AND F[35]=0 AND C[10]<>0 THEN LET Rstr=X1str+" GETS YOU!":LET F[56]=1
680     IF F[56]=0 THEN GOTO 30
690     m4400:PRINT Rstr
700     PRINT "YOU HAVE FAILED IN YOUR QUEST!"
710     PRINT:PRINT "BUT YOU ARE GRANTED ANOTHER TRY"
720     m3360:RUN
730     m4400
740     PRINT "HOOOOOOORRRRRAAAAAYYYYYY!"
750     PRINT
760     PRINT "YOU HAVE SUCCEEDED IN YOUR"
770     PRINT "QUEST AND BROUGHT PEACE TO"
780     PRINT "THE LAND"
790     STOP
def m800
800     LET D=VB
810     IF D=5 THEN LET D=1
820     IF D=6 THEN LET D=3
830     IF NOT ((R=75 AND D=2) OR (R=76 AND D=4)) OR F[64]=1 THEN GOTO 850
840     LET Rstr="B USPMM TUPQT ZPV DSPTTJOH":m4260:RETURN
850     IF F[64]=1 THEN LET F[64]=0
860     IF F[51]=1 OR F[29]=1 THEN GOTO 900
870     IF F[55]=1 THEN LET F[56]=1:LET Rstr="GRARGS HAVE GOT YOOU!":RETURN
880     IF R=29 AND F[48]=0 THEN LET Rstr="GRARGS WILL SEE YOU!":RETURN
890     IF R=73 OR R=42 OR R=9 OR R=10 THEN LET Rstr=X3str:LET F[55]=1:RETURN
900     IF C[8]=0 AND ((R=52 AND D=2) OR (R=31 AND D<>3))THEN LET Rstr="THE BOAT IS TOO HEAVY":RETURN
910     IF C[8]<>0 AND ((R=52 AND D=4) OR (R=31 AND D=3)) THEN LET Rstr="YOU CANNOT SWIM":RETURN
920     IF R=52 AND C[8] AND D=4 AND F[30]=0 THEN LET Rstr="NO POWER!":RETURN
930     IF R=41 AND D=3 AND F[31]=0 THEN LET Rstr="UIF CPBU JT TJOLJOH!":m4260:RETURN
940     IF R=33 AND D=1 AND F[32]=0 THEN LET Rstr="OGBAN'S BOAR BLOCK YOUR PATH":RETURN
950     IF ((R=3 AND D=2) OR (R=4 AND D=4)) AND F[45]=0 THEN LET Rstr=X5str:RETURN
960     IF R=35 AND C[13]<>R THEN LET Rstr="THE ICE IS BREAKING!":RETURN
970     IF R=5 AND (D=2 OR D=4) THEN m4310
980     IF R=4 AND D=4 THEN LET Rstr="PASSAGE IS TOO STEEP":RETURN
990     IF R=7 AND D=2 AND F[46]=0 THEN LET Rstr="A HUGE HOUND BARS YOUR WAY":RETURN
1000    IF (R=38 OR R=37) AND F[50]=0 THEN LET Rstr="JU JT UPP EBSL":m4260:RETURN
1010    IF R=49 AND D=2 AND F[54]=0 THEN ET Rstr="MYSTERIOUS FORCES HOLD YOU BACK":RETURN
1020    IF R=49 AND D=3 AND F[68]=0 THEN LET Rstr="YOU MEET OGBAN!!!":LET F[56]=1:RETURN
1030    IF R=38 ANF F[65]=0 THEN LET Rstr="RATS NIBBLE YOUR ANKLES":RETURN
1040    IF R=58 AND (D=1 OR D=4) AND F[66]=0 THEN LET Rstr="YOU GET CAUGHT IN THE WEBS!":RETURN
1050    IF R=48 AND D=4 AND F[70]=0 THEN LET Rstr="THE DOOR DOES NOT OPEN":RETURN
1060    IF R=40 AND F[47]=1 THEN LET F[68]=1
1070    IF R=37 AND D=4 AND Estr[37]="EW" THEN LET R=67:LET Rstr="THE PASSAGE WAS STEEP!":RETURN
1080    IF R=29 AND D=3 THEN LET F[48]=1:LET F[20]=0
1090    IF R=8 AND D=2 THEN LET F[46]=0
1100    LET OM=R:FOR I=1 TO LEN(Estr[R)]
1110    LET Kstr=MIDstr(Estr[OM),I,1]
1120    IF (Kstr="N" OR Kstr="U") AND D=1 THEN LET R=R-10
1130    IF Kstr="E" AND D=2 THEN LET R=R+1
1140    IF (Kstr="S" OR Kstr="D") AND D=3 THEN LET R=R+10
1150    IF Kstr="W" AND D=4 THEN LET R=R-1
1160    NEXT I:LET Rstr="OK"
1170    IF R=OM THEN LET Rstr="YOU CANNOT GO THAT WAY"
1180    IF ((OM=75 AND D=2) OR (OM=76 AND D=4)) THEN LET Rstr="OK. YOU CROSSED"
1190    IF F[29]=1 THEN LET F[39]=F[39]+1
1200    IF F[39]>5 AND F[29]=1 THEN LET Rstr="CPPUT IBWF XPSO PVU":m4260: LET F[29]=0:LET C[3]=81
1210    RETURN
1220    m3330:LET Rstr="OK":LET F[49]=0
1230    PRINT "YOU HAVE ";
1240    FOR I=1 TO G:READ Ostr:m3350:IF I=1 AND C[1]=0 AND F[44]=1 THEN LET Ostr="COIN"
1250    IF I=G AND C[5]=0 THEN GOTO 1270
1260    IF C[I]=0 THEN PRINT Ostr;",";:LET F[49]=1
1270    NEXT I:IF F[49]=0 THEN PRINT "NOTHING"
1280    PRINT:m3360:RETURN
end

def m1290
1290    IF H=6577 THEN LET Rstr="HOW?":RETURN
1300    IF H=4177 OR H=5177 THEN LET B=16:m2380:RETURN
1310    IF B=38 THEN LET Rstr="TOO HEAVY!":RETURN
1320    IF B=4 AND F[43]=0 THEN LET Rstr="IT IS FIRMLY NAILED ON!":RETURN
1330    LET CO=0:FOR I=1 TO G-1:IF C[I]=0 THEN LET CO=CO+1
1340    NEXT I:IF CO>13 THEN LET Rstr="YOU CANNOT CARRY ANYMORE":RETURN
1350    IF B>G THEN LET Rstr="YOU CANNOT GET THE "+Tstr:RETURN
1360    IF B=0 THEN RETURN
1370    IF C[B]<>R THEN LET Rstr="IT IS NOT HERE"
1380    IF F[B]=1 THEN LET Rstr="WHAT "+Tstr+"?"
1390    IF C[B]=0 THEN LET Rstr="YOU ALREADY HAVE IT"
1400    IF C[B]=R AND F[B]=0 THEN LET C[B]=0:LET Rstr="YOU HAVE THE "+Tstr
1410    IF B=28 THEN LET C[5]=81
1420    IF B=5 THEN LET C[28]=0
1430    IF C[4]=0 AND C[12]=0 AND C[15]=0 THEN LET F[54]=1
1440    IF B=8 AND F[30]=1 THEN LET C[2]=0
1450    IF B=2 THEN LET F[30]=0
1460    RETURN
end

def m1470
1470    LET Rstr="YOU SEE WHAT YOU MIGHT EXPECT!"
1480    IF B>0 THEN LET Rstr="NOTHING SPECIAL"
1490    IF B=46 OR B=88 THEN m2550
1500    IF H=8076 THEN LET Rstr="IT IS EMPTY"
1510    IF H=8080 THEN LET Rstr="AHA!":LET F[1]=0
1520    IF H=7029 THEN LET Rstr="OK":LET F[2]=0
1530    IF B=20 THEN LET Rstr="NBUDIFT JO QPDLFU":m4260:LET C[26]=0
1540    IF H=1648 THEN LET Rstr="THEREARE SOME LETTERS '"+Gstr[2]"'"
1550    IF H=7432 THEN LET Rstr="UIFZ BSF BQQMF USFFT":m4260:LET F[5]=0
1560    IF H=2134 OR H=2187 THEN LET Rstr="OK":LET F[16]=0
1570    IF B=35 THEN LET Rstr="IT IS FISHY!":LET F[17]=0
1580    IF H=3438 THEN LET Rstr="OK":LET F[22]=0
1590    IF H=242 THEN LET Rstr="A FADED INSCRIPTION"
1600    IF (H=1443 OR H=1485) AND F[33]=0 THEN LET Rstr="B HMJNNFSJOH GSPN UIF EFQUIT":m4260
1610    IF (H=1443 OR H=1485) AND F[33]=1 THEN LET Rstr="SOMETHING HERE...":LET F[12]=0
1620    IF H=2479 OR H=2444 THEN LET Rstr="THERE IS A HANDLE"
1630    IF B=9 THEN LET Rstr="UIF MBCFM SFBET 'QPJTPO'":m4260
1640    IF H=4055 THEN m3290
1650    IF H=2969 AND F[49]=1 THEN LET Rstr="VERY UGLY!"
1660    IF H=7158 OR H=7186 THEN LET Rstr="THERE ARE LOOSE BRICKS"
1670    IF R=49 THEN LET Rstr="VERY INTERESTING!"
1680    IF B=52 OR B=82 OR B=81 THEN LET Rstr="INTERESTING!"
1690    IF H=6978 THEN LET Rstr="THERE IS A WOODEN DOOR"
1700    IF H=6970 THEN LET Rstr="YOU FOUND SOMETHING":LET F[4]=0
1710    IF H=2066 THEN LET Rstr="A LARGE CUPBOARD IN THE CORNER"
1720    IF H=6865 OR H=6853 THEN LET Rstr="THERE ARE NINE STONES"
1730    IF H=248 THEN LET Rstr="A GBEFE XPSE - 'N S I T'":m4260
1740    RETURN
end

def m1750
1750    IF R=64 THEN LET Rstr="HE GIVES IT BACK!"
1760    IF H=6425 THEN m3210
1770    IF R=75 OR R=76 THEN LET Rstr="HE DOES NOT WANT IT"
1780    IF B=62 AND F[44]=0 THEN LET Rstr="YOU HAVE RUN OUT!"
1790    IF (H=7562 OR H=7662) AND F[44]>0 AND C[1]=0 THEN LET Rstr="HE TAKES IT":LET F[64]=1
1800    IF F[64]=1 THEN LET F[44]=F[44]-1
1810    IF B=1 THEN LET Rstr="HE TAKES THEM ALL!":LET C[1]=81:LET F[64]=1:LET F[44]=0
1820    IF H=2228 AND C[5]=81 THEN LET Rstr=XBstr+"NORTH":LET C[28]=81:LET R=12
1830    IF (H=2228 AND C[5]=81) OR H=225 THEN LET Rstr=XBstr+"NORTH":LET R=12
1840    IF (H=1228 AND C[5]=81) OR H=125 THEN LET Rstr=XBstr+"SOUTH":LET R=12
1850    IF R=7 OR R=33 THEN LET Rstr="HE EATS IT!":C[B]=81
1860    IF H=711 THEN LET F[46]=1:LET Rstr="HE IS DISTRACTED"
1870    IF H=385 OR H=3824 THEN LET Rstr="THEY SCURRY AWAY":LET C[B]=81:LET F[65]=1
1880    RETURN
1890    LET Rstr="YOU SAID IT"
1900    IF B=84 THEN LET Rstr="YOU MUST SAY THEM ONE BY ONE!":RETURN
1910    IF R<>47 OR B<71 OR B>75 OR C[27]<>0 THEN RETURN
1920    IF B=71 AND F[60]=0 THEN LET Rstr=X7str:LET F[60]=1:RETURN
1930    IF B=72 AND F[60]=1 AND F[61]=0 THEN LET Rstr=X8str:LET F[61]=1:RETURN
1940    IF B=(F[52]+73) AND F[60]=1 AND F[61]=1 THEN LET F[62]=1:RETURN
1950    LET Rstr="THE WRONG SACRED WORD!":LET F[56]=1:RETURN
end

def m1960
1960    IF B=5 OR B=10 THEN m1290
1970    RETURN
1980    IF B=3 THEN LET F[29]=1:LET Rstr="ZPV BSF JOWJTJCMF":LET F[55]=0:m4260
1990    IF B=20 THEN LET F[51]=1:LET Rstr="ZPV BSF EJTHVJTFE":LET F[55]=0:m4260
2000    RETURN
2010    IF B=2 OR B=14 THEN LET Rstr="NOTHING TO TIE IT TO!"
2020    IF H=7214 THEN LET Rstr="IT IS TIED":LET C[14]=72:LET F[53]=1
2030    IF H=722 THEN LET Rstr="OK":LET F[40]=1:LET C[2]=72
2040    RETURN
2050    IF H=1547 AND F[38]=1 THEN LET Rstr="ALL RIGHT":LET R=16
2060    IF B=14 OR B=2 THEN LET Rstr="NOT ATTACHED TO ANYTHING!"
2070    IF H=5414 AND C[14]=54 THEN LET Rstr="YOU ARE AT THE TOP"
2080    IF H=7214 AND F[53]=1 THEN LET Rstr="GOING DOWN":LET R=71
2090    IF H=722 AND F[40]=1 THEN LET R=71:LET Rstr="IT IS TORN":LET C[2]=81:LET F[40]=0
2100    IF H=7114 AND F[53]=1 THEN LET C[14]=71:LET F[53]=0:LET Rstr="IT FALLS DOWN-BUMP!"
2110    RETURN
2120    IF H=522 THEN LET Rstr="OK":LET F[30]=1
2130    IF B=1 OR B=62 OR B=5 OR B=28 OR B=11 OR B=24 THEN m1750
2140    IF H=416 THEN LET Rstr="ZPV IBWF LFQU BGMPBU":LET F[31]=1:m4260:RETURN
2150    IF H=4116 THEN LET Rstr="IT IS NOT BIG ENOUGH!":RETURN
2160    IF B=18 OR B=7 THEN m2470
2170    IF B=13 THEN m2730
2180    IF B=19 THEN m3070
2190    IF B=10 THEN m2870
2200    IF B=16 OR B=6 THEN m2380
2210    RETURN
2220    IF B=76 OR B=38 THEN m1470
2230    IF H=2030 THEN LET F[9]=0:LET Rstr="OK"
2240    IF H=6030 THEN LET Rstr="OK":LET F[3]=0
2250    IF H=2444 OR H=1870 THEN LET Rstr="YOU ARE NOT STRONG ENOUGH"
2260    IF H=3756 THEN LET Rstr="A PASSAGE!":LET Estr[37]="EW"
2270    IF H=5960 THEN m3260
2280    IF H=6970 THEN LET Rstr="IT FALLS OFF ITS HINGES"
2290    IF H=4870 THEN LET Rstr="IT IS LOCKED"
2300    RETURN
2310    IF B>G THEN LET Rstr="IT DOES NOT BURN"
2320    IF B=26 THEN LET Rstr="YOU LIT THEM"
2330    IF H=3826 THEN LET Rstr="NOT BRIGHT ENOUGH"
2340    IF (B=23 OR H=6970) AND C[26]<>0 THEN LET Rstr="OP NBUDIFT":m4260
2350    IF B=23 AND C[26]=0 THEN LET Rstr="A BRIGHT "+Vstr:LET F[50]=1
2360    IF H=6970 AND C[26]=0 THEN LET F[43]=1:LET Rstr="IT HAS TURNED TO ASHES"
2370    RETURN
end

def m2380
2380    IF (B=16 OR B=6) AND (R=41 OR R=51) THEN LET Rstr="YOU CAPSIZED!":LET F[56]=1
2390    IF H=6516 AND C[16]=0 THEN LET Rstr="IT IS NOW FULL":LET F[34]=1
2400    IF H=656 THEN LET Rstr="IT LEAKS OUT!"
2410    RETURN
2420    IF B<>22 OR R<>15 THEN LET Rstr="DOES NOT GROW!":RETURN
2430    LET Rstr="OK":F[34]=1
2440    RETURN
end

def m2450
2450    IF B=22 AND F[37]=1 AND F[34]=1 THEN LET Rstr=X2str:LET F[38]=1:m4260
2460    RETURN
end

def m2470
2470    IF B=7 OR B=18 THEN LET Rstr="THWACK!"
2480    IF H=5818 THEN LET Rstr="YOU CLEARED THE WEBS":LET F[66]=1
2490    IF H=187 THEN LET Rstr="THE DOOR BROKE!":LET Estr[18]="NS":LET Estr[28]="NS"
2500    IF H=717 THEN LET Rstr="YOU BROKE THROUGH":LET Estr[71]="N"
2510    RETURN
2520    IF B=16 THEN LET B=22:m2450
2530    IF H=499 THEN LET Rstr="WHERE?"
2540    RETURN
end

def m2550
2550    IF H=4337 THEN LET VB=2:m800:RETURN
2560    IF R=36 THEN LET Rstr="YOU FOUND SOMETHING":LET F[13]=0
2570    RETURN
2580    IF R=76 THEN LET VB=4:m800:RETURN
2590    IF R=75 THEN LET VB=2:m800
2600    RETURN
2610    IF (B=3 AND F[29]=1) THEN LET Rstr="TAKEN OFF":LET F[29]=0
2620    IF (B=20 AND F[51]=1) THEN LET Rstr="OK":LET F[51]=0
2630    IF B=36 OR B=50 THEN m2950
2640    RETURN
2650    IF H=3859 OR H=3339 OR H=1241 OR H=2241 OR H=751 THEN LET Rstr="WITH WHAT?"
2660    RETURN
2670    IF H=2340 THEN LET Rstr="IT GOES ROUND"
2680    IF H=2445 THEN LET Rstr="UIF HBUFT PQFQ, UIF QPPM FNQUJFT":LET F[33]=1:m4260
2690    RETURN
2700    IF R=14 OR R=51 THEN LET Rstr="YOU HAVE DROWNED":LET F[56]=1
2710    RETURN
2720    LET Rstr="HOW?":RETURN
end

def m2730
2730    IF B=0 OR B>G THEN RETURN
2740    LET C[B]=R:LET Rstr="DONE"
2750    IF H=418 OR H=518 THEN LET Rstr="YOU DROWNED!":LET F[56]=1
2760    IF B=8 AND F[30]=1 THEN LET C[2]=R
2770    IF B=16 AND F[34]=1 THEN LET Rstr="YOU LOST THE WATER!":LET F[34]=0
2780    IF B=2 AND F[30]=1 THEN LET F[30]=0
2790    RETURN
2800    IF B=62 AND F[44]=0 THEN LET Rstr="YOU DO NOT HAVE ANY"
2810    IF H=5762 AND C[1]=0 AND F[44]>0 THEN m3230
2820    RETURN
2830    IF B=0 OR B>G THEN RETURN
2840    LET Rstr="DID NOT GO FAR!":LET C[B]=R
2850    IF H=3317 THEN LET Rstr="ZPV DBVHIU UIF CPBS":LET F[32]=1:m4260
2860    RETURN
end

def m2870
2870    IF B=10 THEN LET Rstr+"B OJDF UVOF":m4260
2880    IF H=5233 THEN LET Rstr="WHAT WITH?"
2890    IF B=83 THEN LET Rstr="HOW, O MUSICAL ONE?"
2900    IF H=5610 THEN LET F[35]=1:LET Rstr=X1str+" IS FREE!":LET Estr[56]="NS"
2910    RETURN
2920    IF B=0 OR B>G THEN RETURN
2930    IF B=5 OR B=24 THEN LET Rstr="YUM YUM!":LET C[B]=81
2940    RETURN
end

def m2950
2950    IF R=4 AND B=50 THEN LET F[45]=1:LET Rstr="YOU REVEALED A STEEP PASSAGE"
2960    IF R=3 AND B=50 THEN LET Rstr="YOU CANNOT MOVE RUBBLE FROM HERE"
2970    IF H=7136 THEN LET Rstr="THEY ARE WEDGED IN!"
2980    RETURN
2990    IF (B=67 OR B=68) AND C[9]=0 AND R=49 THEN LET Rstr="OK":LET F[47]=1
3000    RETURN
3010    IF R<>27 OR B<>63 THEN RETURN
3020    PRINT:PRINT "HOW MANY TIMES?":INPUT MR:IF MR=0 THEN PRINT "A NUMBER":GOTO 3020
3030    IF MR=F[42] THEN LET Rstr="A ROCK DOOR OPENS":LET Estr[27]="EW":RETURN
3040    LET Rstr="ZPV IBWF NJTUSFBUFE UIF CFMM!":LET F[56]=1:m4260:RETURN
3050    IF H=5861 THEN LET H=5818:m2470
3060    RETURN
end

def m3070
3070    IF (H=4864 OR H=4819) AND C[19]=0 THEN LET Rstr=X6str:LET F[63]=1:m4260
3080    IF B=27 THEN m1290
3090    RETURN
3100    IF H=7549 OR H=7649 THEN LET Rstr="WHAT WITH?"
3110    IF B=1 OR B=62 THEN m1750
3120    RETURN
3130    IF H=4870 AND C[21]=0 THEN LET Rstr="THE KEY TURNS!":LET F[70]=1
3140    RETURN
3150    IF H=1870 THEN LET Rstr="HOW?"
3160    RETURN
3170    IF R=48 THEN LET Rstr="HOW?"
3180    RETURN
3190    LET Rstr="ARE YOU THIRSTY?"
3200    RETURN
end

def m3210
3210    LET Rstr="HE TAKES IT AND SAYS '"+STRstr(F[42])+" RINGS ARE NEEDED'":LET C[25]=81
3220    RETURN
end

def m3230
3230    LET F[44]=F[44]-1:LET Rstr="A NUMBER APPEARS - "+STRstr(F[41])
3240    IF F[44]=0 THEN LET C[1]=81
3250    RETURN
end

def m3260
3260    PRINT:LET Rstr="XIBU JT UIF DPEF":m4260:PRINT Rstr:INPUT CN
3270    LET Rstr="WRONG!":IF CN=F[41] THEN LET Rstr="IT OPENS":LET F[21]=0
3280    RETURN
end

def m3290
3290    LET T=R:LET R=F[F[52]+57]:m3310:LET R=T
3300    LET Rstr=X4str+RIGHTstr(Dstr,LEN(Dstr)-2):RETURN
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
3350    LET Ostr=RIGHTstr(Ostr,LEN(Ostr)-1):RETURN
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
3420    LET Bstr="NOOEOOSOOWOOUOODOOINVGETTAKEXAREAGIVSAYPICWEATIECLIRIGUSEOPE"
3430    LET Bstr=Bstr+"LIGFILPLAWATSWIEMPENTCROREMFEETURDIVBAILEATHRINSBLODROEATMOV"
3440    LET Bstr=Bstr+"INTRINCUTHOLBURPOISHOUNLWITDRICOUPAYMAKBRESTEGATREF"
3450    LET X6str="XV SFGMFDUFE UIF XJABSET HMSBF! IF JT EFBE"
3460    LET X1str="THE GHOST OF THE GOBLIN GUARDIAN"
3470    LET X2str="B MBSHF WJOF HSPXT JO TFDPOET!"
3480    LET X3str="A GRARG PATROL APPROACHES"
3490    LET X4str="MAGIC WORDS LIE AT THE CROSSROADS, THE FOUNTAIN AND THE "
3500    LET X5str="A PILE OF RUBBLE BLOCKS YOUR PATH"
3510    LET X7str="THE MOUNTAIN RUMBLES!"
3520    LET X8str="TOWERS FALL DOWN!"
3530    LET X9str="THE WIZARD HAS YOU IN HIS GLARE"
3540    LET XBstr="HE LEADS YOU "
3550    m4400:PRINT "DO YOU WANT TO"
3560    PRINT:PRINT "   1. START A NEW GAME"
3570    PRINT "OR 2. CONTINUE A SAVED GAME"
3580    PRINT:PRINT:PRINT "TYPE IN EITHER 1 OR 2"
3590    INPUT C:IF C<>1 AND C<>2 THEN GOTO 3580
3600    IF C=1 THEN m4450
3610    IF C=2 THEN m4600
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
4260    LET Zstr="":FOR I=1 TO LEN(Rstr)
4270    LET Cstr=MIDstr(Rstr,I,1):IF Cstr<"A" THEN LET Zstr=Zstr+Cstr:GOTO 4300
4280    LET C=ASC[Cstr]-1:IF C=64 THEN LET C=90
4290    LET Zstr=Zstr+CHRstr(C)
4300    NEXT I:LET Rstr=Zstr:RETURN
end

def m4310
4310    LET Jstr="SSSSSSSS":LET NG=0
4320    LET MP=D/2:m4400
4330    PRINT "YOU ARE LOST IN THE":PRINT "      TUNNELS"
4340    PRINT WHICH WAY? (NS,W OR E)
4350    IF NG>15 THEN PRINT "(OR G TO GIVE UP!)"
4360    PRINT:PRINT Wstr:LET Jstr=RIGHTstr(Jstr+RIGHTstr(Wstr,1),8)
4370    IF Wstr="G" THEN LET F[56]=1:RETURN
4380    IF Jstr<>Gstr[MP] THEN LET NG=NG+1:GOTO 4320
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
4470    FOR I=1 TO 13:READ A:LET F[A]=1:NEXT I
4480    LET F[41]=INT(RND(1)*900)+100:LET F[42]=INT(RND(1)*3)+2
4490    LET F[44]=4:LET F[57]=68:LET F[58]=54:LET F[59]=15:LET F[52]=INT(RND(1)*3)
4500    LET R=77:LET Rstr="GOOD LUCK ON YOUR QUEST!"
4510    LET Gstr[1]="":FOR I=1 TO 8
4520    LET Fstr=MIDstr(Bstr,1+INT(RND(1)*4)*3,1)
4530    LET Gstr[1]=Gstr[1]+Fstr
4540    IF Fstr="N" THEN LET Lstr="S"
4550    IF Fstr="S" THEN LET Lstr="N"
4560    IF Fstr="E" THEN LET Lstr="W"
4570    IF Fstr="W" THEN LET Lstr="E"
4580    LET Gstr[2]=Lstr+Gstr[2]
4590    NEXT I:RETURN
end

def m4600
4600    m4640:m4670
4610    LET R=F[69]:LET Rstr="OK. CARRY ON"
4620    RETURN
end

def m4630
4630    LET F[69]=R:m4640:m4760:PRINT "BYE...":STOP
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
4830    LET LS=1:LET LP=1
4840    FOR I=1 TO LEN(Jstr)
4850    IF MIDstr(Jstr,I,1)=" " AND LL>EL THEN PRINT MIDstr(Jstr,LP,LS-LP):LET LL=I-LS:LET LP=LS+1
4860    IF MIDstr(Jstr,I,1)=" " THEN LET LS=I
4870    LET LL=LL+1:NEXT I
4800    PRINT MIDstr(Jstr,LP,LEN(Jstr)-LP);
4890    RETURN


