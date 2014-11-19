def start
	$EL=39
	$NO=88
	$NV=57
	$G=28
	m3380
	m30
	exit
end

def m30
  m4400
  $LL=0
  m3310
  $Pstr=$Xstr[VAL(LEFTstr($Dstr,1))]+" "+$Ystr[VAL(MIDstr($Dstr,2,1))]+" "
  $Jstr=$Rstr+". "+"YOU ARE "+$Pstr+RIGHTstr($Dstr,LEN($Dstr)-2)+" "
  m4830
  m3330
  $Jstr=""
  for $I in 1..($G-1)
		$Ostr=mREAD
		$Pstr=$Ystr[VAL(LEFTstr($Ostr,1))]
		m3350
		if $F[$I]==0 && $C[$I]==$R then
			$Jstr=$Jstr+" "+$Pstr+" "+$Ostr+","
		end
	end
  if $R==29 && $F[48]==0 then
    $Jstr=$Jstr+" GRARGS FEASTING,"
  end
  if $R==29 && $F[48]==1 then
    $Jstr=$Jstr+" A SLEEPING GRARG,"
  end
  if $R==12 || $R==22 then
    $Jstr=$Jstr+" A PONY,"
  end
  if $R==64 then
    $Jstr=$Jstr+" A HERMIT,"
  end
  if $R==18 && $Estr[18]=="N" then
    $Jstr=$Jstr+" AN OAK DOOR,"
  end
  if $R==59 && $F[68]==1 then
    $Jstr=$Jstr+" OGBAN (DEAD),"
  end
  if $Jstr!="" then
    $Jstr=", YOU CAN SEE"+$Jstr
  end
  $Jstr=$Jstr+" AND YOU CAN GO "
  m4830
  print " "
  for $I in 1..LEN($Estr[$R])
		print MIDstr($Estr[$R],$I,1)+","
	end
  puts
  puts
  $Rstr="PARDON?"
  puts "======================================"
  puts
  puts
  puts "WHAT WILL YOU DO NOW "
  $Istr=mINPUT
  if $Istr=="SAVE GAME" then
    m4630
  end
  $Vstr=""
  $Tstr=""
  $VB=0
  $B=0
  for $I in 1..LEN($Istr)
		if MIDstr($Istr,$I,1)==" " && $Vstr=="" then
			$Vstr=LEFTstr($Istr,$I-1)
		end
		if MIDstr($Istr,$I+1,1)!=" " && $Vstr!="" then
			$Tstr=MIDstr($Istr,$I+1,LEN($Istr)-1)
			$I=LEN($Istr)
		end
	end
  if $Tstr=="" then
    $Vstr=$Istr
  end
  while LEN($Vstr)<3
    $Vstr=$RVstr+"O"
  end
  if $Vstr=="PLAY" then
    $Vstr="BLO"
  end
  $RUstr=LEFTstr($Vstr,3)
  for $I in 1..$NV
		if MIDstr($Bstr,$I*3-2,3)==$RUstr then
			$VB=$I
			$I=$NV
		end
	end
  $F[36]=0
	begin
		m3330
		for $I in 1..$NO
			$Ostr=mREAD
			if $I<=$G then
				m3350
			end
			if $Tstr==$Ostr then
				$B=$I
				$RI=$NO
			end
		end
		if $B==0 && $F[36]==0 && $Tstr!="" then
			$Tstr=$Tstr+"S"
			$F[36]=1
		end
	end until !($B=0 && $F[36]=0 && $Tstr!="")
  if $VB==0 then
    $VB=$NV+1
  end
  if $Tstr=="" then
    $Rstr="$I NEED TWO WORDS"
  end
  if $VB>$NV then
    $Rstr="TRY SOMETHING ELSE"
  end
  if $VB>$NV && $B==0 then
    $Rstr="YOU CANNOT "+$Istr
  end
  if !($B>$G || $B==0) then
		if !($VB==8 || $VB==9 || $VB==14 || $VB==17 || $VB==44 || $VB>54) then
			if $VB<$NV && $C[$B]!=0 then
				$Rstr="YOU DO NOT HAVE THE "+$Tstr
				m30
			end
		end
	end
  if $R==56 && $F[35]==0 && $VB!=37 && $VB!=53 then
    $Rstr=$X1str+" HAS GOT YOU!"
		m30
  end
  if !($VB==44 || $VB==47 || $VB==19 || $VB==57 || $VB==49) then
		if $R==48 && $F[63]==0 then
			$Rstr=$X9str
			m30
		end
	end
  $H=VAL(STRstr($R)+STRstr($B))
  send([:m800,:m800,:m800,:m800,:m800,:m800,:m1220,:m1290,:m1290,:m1470,:m1470,:m1750,:m1890,
		:m1960,:m1980,:m2010,:m2050,:m2870,:m2120,:m2220,:m2310,:m2380,:m2420,:m2450,:m2470,:m2520,
		:m2550,:m2580,:m2610,:m2650,:m2670,:m2700,:m2720,:m2730,:m2830,:m2800,:m2870,:m2730,:m2920,
		:m2950,:m2990,:m3010,:m3050,:m3070,:m2310,:m2990,:m3070,:m3010,:m2120,:m3190,:m1470,:m3100,
		:m2870,:m3150,:m1290,:m1290,:m3170,:m3200][$VB])
  if !$F[62]==1 then
		if $R==41 then
			$F[67]==$F[67]+1
			if $F[67]==10 then
				$F[56]=1
				$Rstr="YOU SANK!"
			end
		end
		if $R==56 && $F[35]==0 && $C[10]!=0 then
			$Rstr=$X1str+" GETS YOU!"
			$F[56]=1
		end
		if $F[56]==0 then
			m30
		end
		m4400
		puts $Rstr
		puts "YOU HAVE FAILED IN YOUR QUEST!"
		puts
		puts "BUT YOU ARE GRANTED ANOTHER TRY"
		m3360
		RUN
	end

  m4400
  puts "HOOOOOOORRRRRAAAAAYYYYYY!"
  puts
  puts "YOU HAVE SUCCEEDED IN YOUR"
  puts "QUEST AND BROUGHT PEACE TO"
  puts "THE LAND"
  exit
end

def m800
  $D=$VB
  if $D==5 then
    $D=1
  end
  if $D==6 then
    $D=3
  end
  if !(!(($R==75 && $D==2) || ($R==76 && $D==4)) || $F[64]==1) then
		$Rstr="$B USPMM TUPQT ZPV DSPTTJOH"
		m4260
		return
	end
  if $F[64]==1 then
    $F[64]=0
  end
  if !($F[51]==1 || $F[29]==1) then
		if $F[55]==1 then
			$F[56]=1
			$Rstr="GRARGS HAVE GOT YOOU!"
			return
		end
		if $R==29 && $F[48]==0 then
			$Rstr="GRARGS WILL SEE YOU!"
			return
		end
		if $R==73 || $R==42 || $R==9 || $R==10 then
			$Rstr=$X3str
			$F[55]=1
			return
		end
	end
	if $C[8]==0 && (($R==52 && $D==2) || ($R==31 && $D!=3)) then
    $Rstr="THE BOAT IS TOO HEAVY"
		return
  end
  if $C[8]!=0 && (($R==52 && $D==4) || ($R==31 && $D==3)) then
    $Rstr="YOU CANNOT SWIM"
		return
  end
  if $R==52 && $C[8] && $D==4 && $F[30]==0 then
    $Rstr="$NO POWER!"
		return
  end
  if $R==41 && $D==3 && $F[31]==0 then
    $Rstr="UIF CPBU JT TJOLJOH!"
		m4260
		return
  end
  if $R==33 && $D==1 && $F[32]==0 then
    $Rstr="OGBAN'S BOAR BLOCK YOUR PATH"
		return
  end
  if (($R==3 && $D==2) || ($R==4 && $D==4)) && $F[45]==0 then
    $Rstr=$X5str
		return
  end
  if $R==35 && $C[13]!=$R then
    $Rstr="THE ICE IS BREAKING!"
		return
  end
  if $R==5 && ($D==2 || $D==4) then
    m4310
  end
  if $R==4 && $D==4 then
    $Rstr="PASSAGE IS TOO STEEP"
		return
  end
  if $R==7 && $D==2 && $F[46]==0 then
    $Rstr="A HUGE HOUND BARS YOUR WAY"
		return
  end
  if ($R==38 || $R==37) && $F[50]==0 then
    $Rstr="JU JT UPP EBSL"
		m4260
		return
  end
  if $R==49 && $D==2 && $F[54]==0 then
    $Rstr="MYSTERIOUS FORCES HOLD YOU BACK"
		return
  end
  if $R==49 && $D==3 && $F[68]==0 then
    $Rstr="YOU MEET OGBAN!!!"
		$F[56]=1
		return
  end
  if $R==38 && $F[65]==0 then
    $Rstr="RATS NIBBLE YOUR ANKLES"
		return
  end
  if $R==58 && ($D==1 || $D==4) && $F[66]==0 then
    $Rstr="YOU GET CAUGHT IN THE WEBS!"
		return
  end
  if $R==48 && $D==4 && $F[70]==0 then
    $Rstr="THE DOOR DOES NOT OPEN"
		return
  end
  if $R==40 && $F[47]==1 then
    $F[68]=1
  end
  if $R==37 && $D==4 && $Estr[37]=="EW" then
    $R=67
		$Rstr="THE PASSAGE WAS STEEP!"
		return
  end
  if $R==29 && $D==3 then
    $F[48]=1
		$F[20]=0
  end
  if $R==8 && $D==2 then
    $F[46]=0
  end
  $OM=$R
  for $I in 1..LEN($Estr[$R])
		$Kstr=MIDstr($Estr[$OM],$I,1)
		if ($Kstr=="N" || $Kstr=="U") && $D==1 then
			$R=$R-10
		end
		if $Kstr=="E" && $D==2 then
			$R=$R+1
		end
		if ($Kstr=="S" || $Kstr=="D") && $D==3 then
			$R=$R+10
		end
		if $Kstr=="W" && $D==4 then
			$R=$R-1
		end
	end
  $Rstr="OK"
  if $R==$OM then
    $Rstr="YOU CANNOT GO THAT WAY"
  end
  if (($OM==75 && $D==2) || ($OM==76 && $D==4)) then
    $Rstr="OK. YOU CROSSED"
  end
  if $F[29]==1 then
    $F[39]=$F[39]+1
  end
  if $F[39]>5 && $F[29]==1 then
    $Rstr="CPPUT IBWF XPSO PVU"
		m4260
    $F[29]=0
		$C[3]=81
  end
  return
end

def m1220
  m3330
  $Rstr="OK"
  $F[49]=0
  print "YOU HAVE "
  for $I in 1..$G
		$Ostr=mREAD
		m3350
		if $I==1 && $C[1]==0 && $F[44]==1 then
			$Ostr="COIN"
		end
		if !($I==$G && $C[5]==0) then
			if $C[$I]==0 then
				print $Ostr+","
				$F[49]=1
			end
		end
		if $F[49]==0 then
			puts "NOTHING"
		end
	end
  puts
  m3360
  return
end

def m1290
  if $H==6577 then
    $Rstr="HOW?"
		return
  end
  if $H==4177 || $H==5177 then
    $B=16
		m2380
		return
  end
  if $B==38 then
    $Rstr="TOO HEAVY!"
		return
  end
  if $B==4 && $F[43]==0 then
    $Rstr="IT IS FIRMLY NAILED ON!"
		return
  end
  $CO=0
  for $I in 1..($G-1)
		if $C[$I]==0 then
			$CO=$CO+1
		end
  end
  if $CO>13 then
    $Rstr="YOU CANNOT CARRY ANYMORE"
		return
  end
  if $B>$G then
    $Rstr="YOU CANNOT GET THE "+$Tstr
		return
  end
  if $B==0 then
    return
  end
  if $C[$B]!=$R then
    $Rstr="IT IS NOT HERE"
  end
  if $F[$B]==1 then
    $Rstr="WHAT "+$Tstr+"?"
  end
  if $C[$B]==0 then
    $Rstr="YOU ALREADY HAVE IT"
  end
  if $C[$B]==$R && $F[$B]==0 then
    $C[$B]=0
		$Rstr="YOU HAVE THE "+$Tstr
  end
  if $B==28 then
    $C[5]=81
  end
  if $B==5 then
    $C[28]=0
  end
  if $C[4]==0 && $C[12]==0 && $C[15]==0 then
    $F[54]=1
  end
  if $B==8 && $F[30]==1 then
    $C[2]=0
  end
  if $B==2 then
    $F[30]=0
  end
  return
end

def m1470
  $Rstr="YOU SEE WHAT YOU MIGHT EXPECT!"
  if $B>0 then
    $Rstr="NOTHING SPECIAL"
  end
  if $B==46 || $B==88 then
    m2550
  end
  if $H==8076 then
    $Rstr="IT IS EMPTY"
  end
  if $H==8080 then
    $Rstr="AHA!"
		$F[1]=0
  end
  if $H==7029 then
    $Rstr="OK"
		$F[2]=0
  end
  if $B==20 then
    $Rstr="NBUDIFT JO QPDLFU"
		m4260
		$C[26]=0
  end
  if $H==1648 then
    $Rstr="THEREARE SOME LETTERS '"+$Gstr[2]+"'"
  end
  if $H==7432 then
    $Rstr="UIFZ BSF BQQMF USFFT"
		m4260
		$F[5]=0
  end
  if $H==2134 || $H==2187 then
    $Rstr="OK"
		$F[16]=0
  end
  if $B==35 then
    $Rstr="IT IS FISHY!"
		$F[17]=0
  end
  if $H==3438 then
    $Rstr="OK"
		$F[22]=0
  end
  if $H==242 then
    $Rstr="A FADED INSCRIPTION"
  end
  if ($H==1443 || $H==1485) && $F[33]==0 then
    $Rstr="$B HMJNNFSJOH GSPN UIF EFQUIT"
		m4260
  end
  if ($H==1443 || $H==1485) && $F[33]==1 then
    $Rstr="SOMETHING HERE..."
		$F[12]=0
  end
  if $H==2479 || $H==2444 then
    $Rstr="THERE IS A HANDLE"
  end
  if $B==9 then
    $Rstr="UIF MBCFM SFBET 'QPJTPO'"
		m4260
  end
  if $H==4055 then
    m3290
  end
  if $H==2969 && $F[49]==1 then
    $Rstr="VERY UGLY!"
  end
  if $H==7158 || $H==7186 then
    $Rstr="THERE ARE LOOSE BRICKS"
  end
  if $R==49 then
    $Rstr="VERY INTERESTING!"
  end
  if $B==52 || $B==82 || $B==81 then
    $Rstr="INTERESTING!"
  end
  if $H==6978 then
    $Rstr="THERE IS A WOODEN DOOR"
  end
  if $H==6970 then
    $Rstr="YOU FOUND SOMETHING"
		$F[4]=0
  end
  if $H==2066 then
    $Rstr="A LARGE CUPBOARD IN THE CORNER"
  end
  if $H==6865 || $H==6853 then
    $Rstr="THERE ARE NINE STONES"
  end
  if $H==248 then
    $Rstr="A GBEFE XPSE - 'N S I T'"
		m4260
  end
  return
end

def m1750
  if $R==64 then
    $Rstr="HE GIVES IT BACK!"
  end
  if $H==6425 then
    m3210
  end
  if $R==75 || $R==76 then
    $Rstr="HE DOES NOT WANT IT"
  end
  if $B==62 && $F[44]==0 then
    $Rstr="YOU HAVE RUN OUT!"
  end
  if ($H==7562 || $H==7662) && $F[44]>0 && $C[1]==0 then
    $Rstr="HE TAKES IT"
		$F[64]=1
  end
  if $F[64]==1 then
    $F[44]=$F[44]-1
  end
  if $B==1 then
    $Rstr="HE TAKES THEM ALL!"
		$C[1]=81
		$F[64]=1
		$F[44]=0
  end
  if $H==2228 && $C[5]==81 then
    $Rstr=$XBstr+"NORTH"
		$C[28]=81
		$R=12
  end
  if ($H==2228 && $C[5]==81) || $H==225 then
    $Rstr=$XBstr+"NORTH"
		$R=12
  end
  if ($H==1228 && $C[5]==81) || $H==125 then
    $Rstr=$XBstr+"SOUTH"
		$R=12
  end
  if $R==7 || $R==33 then
    $Rstr="HE EATS IT!"
		$C[$B]=81
  end
  if $H==711 then
    $F[46]=1
		$Rstr="HE IS DISTRACTED"
  end
  if $H==385 || $H==3824 then
    $Rstr="THEY SCURRY AWAY"
		$C[$B]=81
		$F[65]=1
  end
  return
end

def m1890
  $Rstr="YOU SAID IT"
  if $B==84 then
    $Rstr="YOU MUST SAY THEM ONE BY ONE!"
		return
  end
  if $R!=47 || $B<71 || $B>75 || $C[27]!=0 then
    return
  end
  if $B==71 && $F[60]==0 then
    $Rstr=$X7str
		$F[60]=1
		return
  end
  if $B==72 && $F[60]==1 && $F[61]==0 then
    $Rstr=$X8str
		$F[61]=1
		return
  end
  if $B==($F[52]+73) && $F[60]==1 && $F[61]==1 then
    $F[62]=1
		return
  end
  $Rstr="THE WRONG SACRED WORD!"
  $F[56]=1
  return
end

def m1960
  if $B==5 || $B==10 then
    m1290
  end
  return
end

def m1980
  if $B==3 then
    $F[29]=1
		$Rstr="ZPV BSF JOWJTJCMF"
		$F[55]=0
		m4260
  end
  if $B==20 then
    $F[51]=1
		$Rstr="ZPV BSF EJTHVJTFE"
		$F[55]=0
		m4260
  end
  return
end

def m2010
  if $B==2 || $B==14 then
    $Rstr="NOTHING TO TIE IT TO!"
  end
  if $H==7214 then
    $Rstr="IT IS TIED"
		$C[14]=72
		$F[53]=1
  end
  if $H==722 then
    $Rstr="OK"
		$F[40]=1
		$C[2]=72
  end
  return
end

def m2050
  if $H==1547 && $F[38]==1 then
    $Rstr="ALL RIGHT"
		$R=16
  end
  if $B==14 || $B==2 then
    $Rstr="NOT ATTACHED TO ANYTHING!"
  end
  if $H==5414 && $C[14]==54 then
    $Rstr="YOU ARE AT THE TOP"
  end
  if $H==7214 && $F[53]==1 then
    $Rstr="GOING DOWN"
		$R=71
  end
  if $H==722 && $F[40]==1 then
    $R=71
		$Rstr="IT IS TORN"
		$C[2]=81
		$F[40]=0
  end
  if $H==7114 && $F[53]==1 then
    $C[14]=71
		$F[53]=0
		$Rstr="IT FALLS DOWN-BUMP!"
  end
  return
end

def m2120
  if $H==522 then
    $Rstr="OK"
		$F[30]=1
  end
  if $B==1 || $B==62 || $B==5 || $B==28 || $B==11 || $B==24 then
    m1750
  end
  if $H==416 then
    $Rstr="ZPV IBWF LFQU BGMPBU"
		$F[31]=1
		m4260
		return
  end
  if $H==4116 then
    $Rstr="IT IS NOT BIG ENOUGH!"
		return
  end
  if $B==18 || $B==7 then
    m2470
  end
  if $B==13 then
    m2730
  end
  if $B==19 then
    m3070
  end
  if $B==10 then
    m2870
  end
  if $B==16 || $B==6 then
    m2380
  end
  return
end

def m2220
  if $B==76 || $B==38 then
    m1470
  end
  if $H==2030 then
    $F[9]=0
		$Rstr="OK"
  end
  if $H==6030 then
    $Rstr="OK"
		$F[3]=0
  end
  if $H==2444 || $H==1870 then
    $Rstr="YOU ARE NOT STRONG ENOUGH"
  end
  if $H==3756 then
    $Rstr="A PASSAGE!"
		$Estr[37]="EW"
  end
  if $H==5960 then
    m3260
  end
  if $H==6970 then
    $Rstr="IT FALLS OFF ITS HINGES"
  end
  if $H==4870 then
    $Rstr="IT IS LOCKED"
  end
  return
end

def m2310
  if $B>$G then
    $Rstr="IT DOES NOT BURN"
  end
  if $B==26 then
    $Rstr="YOU LIT THEM"
  end
  if $H==3826 then
    $Rstr="NOT BRIGHT ENOUGH"
  end
  if ($B==23 || $H==6970) && $C[26]!=0 then
    $Rstr="OP NBUDIFT"
		m4260
  end
  if $B==23 && $C[26]==0 then
    $Rstr="A BRIGHT "+$Vstr
		$F[50]=1
  end
  if $H==6970 && $C[26]==0 then
    $F[43]=1
		$Rstr="IT HAS TURNED TO ASHES"
  end
  return
end

def m2380
  if ($B==16 || $B==6) && ($R==41 || $R==51) then
    $Rstr="YOU CAPSIZED!"
		$F[56]=1
  end
  if $H==6516 && $C[16]==0 then
    $Rstr="IT IS NOW FULL"
		$F[34]=1
  end
  if $H==656 then
    $Rstr="IT LEAKS OUT!"
  end
  return
end

def m2420
  if $B!=22 || $R!=15 then
    $Rstr="DOES NOT GROW!"
		return
  end
  $Rstr="OK"
  $F[34]=1
  return
end

def m2450
  if $B==22 && $F[37]==1 && $F[34]==1 then
    $Rstr=$X2str
		$F[38]=1
		m4260
  end
  return
end

def m2470
  if $B==7 || $B==18 then
    $Rstr="THWACK!"
  end
  if $H==5818 then
    $Rstr="YOU CLEARED THE WEBS"
		$F[66]=1
  end
  if $H==187 then
    $Rstr="THE DOOR BROKE!"
		$Estr[18]="NS"
		$Estr[28]="NS"
  end
  if $H==717 then
    $Rstr="YOU BROKE THROUGH"
		$Estr[71]="N"
  end
  return
end

def m2520
  if $B==16 then
    $B=22
		m2450
  end
  if $H==499 then
    $Rstr="WHERE?"
  end
  return
end

def m2550
  if $H==4337 then
    $VB=2
		m800
		return
  end
  if $R==36 then
    $Rstr="YOU FOUND SOMETHING"
		$F[13]=0
  end
  return
end

def m2580
  if $R==76 then
    $VB=4
		m800
		return
  end
  if $R==75 then
    $VB=2
		m800
  end
  return
end

def m2610
  if ($B==3 && $F[29]==1) then
    $Rstr="TAKEN OFF"
		$F[29]=0
  end
  if ($B==20 && $F[51]==1) then
    $Rstr="OK"
		$F[51]=0
  end
  if $B==36 || $B==50 then
    m2950
  end
  return
end

def m2650
  if $H==3859 || $H==3339 || $H==1241 || $H==2241 || $H==751 then
    $Rstr="WITH WHAT?"
  end
  return
end

def m2670
  if $H==2340 then
    $Rstr="IT GOES ROUND"
  end
  if $H==2445 then
    $Rstr="UIF HBUFT PQFQ, UIF QPPM FNQUJFT"
		$F[33]=1
		m4260
  end
  return
end

def m2700
  if $R==14 || $R==51 then
    $Rstr="YOU HAVE DROWNED"
		$F[56]=1
  end
  return
end

def m2720
  $Rstr="HOW?"
  return
end

def m2730
  if $B==0 || $B>$G then
    return
  end
  $C[$B]=$R
  $Rstr="DONE"
  if $H==418 || $H==518 then
    $Rstr="YOU DROWNED!"
		$F[56]=1
  end
  if $B==8 && $F[30]==1 then
    $C[2]=$R
  end
  if $B==16 && $F[34]==1 then
    $Rstr="YOU LOST THE WATER!"
		$F[34]=0
  end
  if $B==2 && $F[30]==1 then
    $F[30]=0
  end
  return
end

def m2800
  if $B==62 && $F[44]==0 then
    $Rstr="YOU DO NOT HAVE ANY"
  end
  if $H==5762 && $C[1]==0 && $F[44]>0 then
    m3230
  end
  return
end

def m2830
  if $B==0 || $B>$G then
    return
  end
  $Rstr="DID NOT GO FAR!"
  $C[$B]=$R
  if $H==3317 then
    $Rstr="ZPV DBVHIU UIF CPBS"
		$F[32]=1
		m4260
  end
  return
end

def m2870
  if $B==10 then
    $Rstr="$B OJDF UVOF"
		m4260
  end
  if $H==5233 then
    $Rstr="WHAT WITH?"
  end
  if $B==83 then
    $Rstr="HOW, O MUSICAL ONE?"
  end
  if $H==5610 then
    $F[35]=1
		$Rstr=$X1str+" IS FREE!"
		$Estr[56]="NS"
  end
  return
end

def m2920
  if $B==0 || $B>$G then
    return
  end
  if $B==5 || $B==24 then
    $Rstr="YUM YUM!"
		$C[$B]=81
  end
  return
end

def m2950
  if $R==4 && $B==50 then
    $F[45]=1
		$Rstr="YOU REVEALED A STEEP PASSAGE"
  end
  if $R==3 && $B==50 then
    $Rstr="YOU CANNOT MOVE RUBBLE FROM HERE"
  end
  if $H==7136 then
    $Rstr="THEY ARE WEDGED IN!"
  end
  return
end

def m2990
  if ($B==67 || $B==68) && $C[9]==0 && $R==49 then
    $Rstr="OK"
		$F[47]=1
  end
  return
end

def m3010
  if $R!=27 || $B!=63 then
    return
  end
  begin puts
		puts "HOW MANY TIMES?"
		$MR=mINPUT
		if $MR==0 then
			puts "A NUMBER"
		end
  end until $MR>0
  if $MR==$F[42] then
    $Rstr="A ROCK DOOR OPENS"
		$Estr[27]="EW"
		return
  end
  $Rstr="ZPV IBWF NJTUSFBUFE UIF CFMM!"
  $F[56]=1
  m4260
  return
end

def m3050
  if $H==5861 then
    $H=5818
		m2470
  end
  return
end

def m3070
  if ($H==4864 || $H==4819) && $C[19]==0 then
    $Rstr=$X6str
		$F[63]=1
		m4260
  end
  if $B==27 then
    m1290
  end
  return
end

def m3100
  if $H==7549 || $H==7649 then
    $Rstr="WHAT WITH?"
  end
  if $B==1 || $B==62 then
    m1750
  end
  return
end

def m3130
  if $H==4870 && $C[21]==0 then
    $Rstr="THE KEY TURNS!"
		$F[70]=1
  end
  return
end

def m3150
  if $H==1870 then
    $Rstr="HOW?"
  end
  return
end

def m3170
  if $R==48 then
    $Rstr="HOW?"
  end
  return
end

def m3190
  $Rstr="ARE YOU THIRSTY?"
  return
end

def m3210
  $Rstr="HE TAKES IT AND SAYS '"+STRstr($F[42])+" RINGS ARE NEEDED'"
  $C[25]=81
  return
end

def m3230
  $F[44]=$F[44]-1
  $Rstr="A NUMBER APPEARS - "+STRstr($F[41])
  if $F[44]==0 then
    $C[1]=81
  end
  return
end

def m3260
  puts
  $Rstr="XIBU JT UIF DPEF"
  m4260
  puts $Rstr
  $CN=mINPUT
  $Rstr="WRONG!"
  if $CN==$F[41] then
    $Rstr="IT OPENS"
		$F[21]=0
  end
  return
end

def m3290
  $T=$R
  $R=$F[$F[52]+57]
  m3310
  $R=$T
  $Rstr=$X4str+RIGHTstr($Dstr,LEN($Dstr)-2)
  return
end

def m3310
	mRESTORE
  for $I in 1..$R
		$Dstr=mREAD
  end
  return
end

def m3330
	mRESTORE
  for $I in 1..80
		$Dstr=mREAD
  end
  return
end

def m3350
  $Ostr=RIGHTstr($Ostr,LEN($Ostr)-1)
  return
end

def m3360
  puts "PRESS return TO CONTINUE"
  $Zstr=mINPUT
  return
end

def m3380
  $C=[]
  $Estr=[]
  $F=[]
  $Xstr=[]
  $Ystr=[]
  $Gstr=[]
  m3330
	for $I in 1..$NO
		$Tstr=mREAD
  end
	for $I in 1..6
		$Xstr[$I]=mREAD
		$Ystr[$I]=mREAD
  end
  $Bstr="NOOEOOSOOWOOUOODOOINVGETTAKEXAREAGIVSAYPICWEATIECLIRIGUSEOPE"
  $Bstr=$Bstr+"LIGFILPLAWATSWIEMPENTCROREMFEETURDIVBAILEATHRINSBLODROEATMOV"
  $Bstr=$Bstr+"INTRINCUTHOLBURPOISHOUNLWITDRICOUPAYMAKBRESTEGATREF"
  $X6str="XV SFGMFDUFE UIF XJABSET HMSBF! if JT EFBE"
  $X1str="THE GHOST OF THE GOBLIN GUARDIAN"
  $X2str="$B MBSHF WJOF HSPXT JO TFDPOET!"
  $X3str="A GRARG PATROL APPROACHES"
  $X4str="MAGIC WORDS LIE AT THE CROSSROADS, THE FOUNTAIN AND THE "
  $X5str="A PILE OF RUBBLE BLOCKS YOUR PATH"
  $X7str="THE MOUNTAIN RUMBLES!"
  $X8str="TOWERS FALL DOWN!"
  $X9str="THE WIZARD HAS YOU IN HIS GLARE"
  $XBstr="HE LEADS YOU "
  m4400
  puts "DO YOU WANT TO"
  puts
  puts "   1. START A NEW GAME"
  puts "OR 2. CONTINUE A SAVED GAME"
	begin
		puts
		puts
		puts "TYPE IN EITHER 1 OR 2"
		$C=mINPUT.to_i
  end until !($C!=1 && $C!=2)
  if $C==1 then
    m4450
  end
  if $C==2 then
    m4600
  end
  return
end

def mRESTORE
	$DATA=%q{
  DATA 11HALF-DUG GRAVE,12GOBLIN GRAVEYARD
  DATA 11HOLLOW TOMB,23STALACTITES AND STALAGMITES
  DATA 11MAZE OF TUNNELS,11VAULTED CAVERN
  DATA 23HIGH GLASS GATES,12ENTRANCE HALL TO THE PALACE
  DATA 31GRARG SENTRY POST,12GUARD ROOM
  DATA 31MARSHY INLET,23RUSTYGATES
  DATA 12GAMEKEEPER'S COTTAGE,31MISTY POOL
  DATA 11HIGH-WALLED GARDEN,14INSCRIBED CAVERN
  DATA 34ORNATE FOUNTAIN,11DANK CORRIDOR
  DATA 12LONG GALLERY,12KITCHENS OF THE PALACE
  DATA 34OLDKILN,44OVERGROWN TRACK
  DATA 31DISUSED WATERWHHEL,33SLUICE GATES
  DATA 11GAP BETWEEN SOME BOULDERS,41PERILOUS PATH
  DATA 31SILVER BELL IN THE ROCK,12DUNGEONS OF THE PALLACE
  DATA 11BANQUETING HALL,42PALACE BATTLEMENTS
  DATA 44ISLAND SHORE,31BEACHED KETCH
  DATA 13BARREN COUNTRYSIDE,33SACKS ON THE UPPER FLOOR
  DATA 46FROZEN POND,21MOUNTAIN HUT
  DATA 31ROW OF CASKS,11WINE CELLAR
  DATA 12HALL OF TAPESTRIES,11DUSTY LIBRARY
  DATA 13ROUGH WATER,11PLOUGHED FIELD
  DATA 55OUTSIDE $A WINDMILL,42LOWER FLOOR OF THE MILL
  DATA 44ICY PATH,41SCREE SLOPE
  DATA 12SILVER CHAMBER,12WIZARD'S LAIR
  DATA 11MOSAIC-FLOORED HALL,12SILVER THRONE ROOM
  DATA 12MIDDLE OF THE LAKE,42EDGE OF AN ICY LAKE
  DATA 41PITTED TRACK,41HIGH PINNACLE
  DATA 55ABOVE $A GLACIER,21HUGE FALLEN OAK
  DATA 11TURRET ROOM WITH $A SLOT MACHINE,11COBWEBBY ROOM
  DATA 31SAFE IN OGBAN'S CHAMBER,31CUPBOARD IN $A CORNER
  DATA 11NARROW PASSAGE,16CAVE
  DATA 11WOODMAN'S HUT,42SIDE OF $A WOODED VALLEY
  DATA 21STREAM IN $A VALLEY BOTTOM,11DEEP DARK WOOD
  DATA 11SHADY HOLLOW,34ANCIENT STONE CIRCLE
  DATA 16STABLE,14ATTIC BEDROOM
  DATA 11DAMP WELL BOTTOM,32TOPOF $A DEEP WELL
  DATA 31BURNT-OUT CAMPFIRE,16ORCHARD
  DATA 62END OF $A BRIDGE,62END OF $A BRIDGE
  DATA 61CROSSROADS,41WINDING ROAD
  DATA 11VILLAGE OF RUSTIC HOUSES,11WHITE COTTAGE
  DATA 3COINS,1SHEET,3BOOTS,1HORSESHOE,3APPLES,1BUCKET,4AXE,1BOAT,1PHIAL
  DATA 3REEDS,1BONE,1SHIELD,3PLANKS,1ROPE,1RING,1JUG,1NET,1SWORD
  DATA 1SILVER PLATE,1UNIFORM,1KEY,3SEEDS,1LAMP,3BREAD,1BROOCH,3MATCHES
  DATA 2STONE OF DESTINY,4APPLE,BED,CUPBOARD,BRIDGE,TREES,SAIL,KILN
  DATA KETCH,BRICKS,WINDMILL,SACKS,OGBAN'S BOAR,WHEEL
  DATA PONY,GRAVESTONES,POOL,GATES,HANDLE,HUT,VINE,INSCRIPTIONS,TROLL,RUBBLE
  DATA HOUND,FOUNTAIN,CIRCLE,MOSAICS,BOOKS,CASKS,WELL,WALLS,RATS,SAFE
  DATA COBWEBS,COIN,BELL,UP SILVER PLATE,STONES,KITCHENS,GOBLET,WINE
  DATA GRARGS,DOOR,AWAKE,GUIDE,PROTECT,LEAD,HELP,CHEST,WATER
  DATA STABLES,SLUICE GATES,POT,STATUE,PINNACLE,MUSIC,MAGIC WORDS
  DATA MISTY POOL,WELL BOTTOM,OLD KILN,MOUNTAIN HUT
  DATA IN,$A,NEAR,THE,BY,SOME,ON,AN,"","",AT,$A SMALL
  DATA E,ESW,WE,EW,EW,ESW,ESW,ES,EW,SW
  DATA S,N,ES,SW,S,NW,N,N,ES,NSW
  DATA NS,E,NSW,N,NES,EW,W,S,NS,N
  DATA NES,W,NS,$D,NES,SW,E,NW,NS,S
  DATA NS,E,NSEW,WU,UD,NS,E,SW,NSE,NW
  DATA NE,EW,NSW,E,WN,S,E,NEW,NW,S
  DATA ES,SW,NES,EW,SW,NE,EW,ESW,SW,ND
  DATA " ",E,NEW,EW,NEW,EW,EW,NEW,NEW,WU
  DATA 80,70,60,69,74,72,63,52,20,11,1,14,36,54,61,21,32,10,50
  DATA 29,59,34,13,80,30,81,47,74
  DATA 1,2,3,4,5,9,12,13,16,17,20,21,22
	}.chomp.gsub(/\s*DATA\s*/,',')[2..-1].gsub('"','').split(',')
end

def m4260
  $Zstr=""
  for $I in 1..LEN($Rstr)
		$Cstr=MIDstr($Rstr,$I,1)
		if $Cstr<"A" then
			$Zstr=Zstr+$Cstr
		else
			$C=ASC[$Cstr]-1
			if $C==64 then
				$C=90
			end
			$Zstr=Zstr+CHRstr($C)
		end
	end
  $Rstr=$Zstr
  return
end

def m4310
  $Jstr="SSSSSSSS"
  $NG=0
	begin
		$MP=$D/2
		m4400
		puts "YOU ARE LOST IN THE"
		puts "      TUNNELS"
		puts "WHICH WAY? (NS,W OR E)"
		if $NG>15 then
			puts "(OR $G TO GIVE UP!)"
		end
		puts
		puts $Wstr
		$Jstr=RIGHTstr($Jstr+RIGHTstr($Wstr,1),8)
		if $Wstr=="$G" then
			$F[56]=1
		return
		end
		if $Jstr!=$Gstr[$MP] then
			$NG=NG+1
		end
	end until !($Jstr!=$Gstr[$MP])
  return
end

def m4400
  system('clear')
  puts
  puts TAB($EL/2-9)+"MYSTERY OF SILVER"
  puts TAB($EL/2-9)+"    MOUNTAIN"
  puts "======================================"
  puts
  puts
  return
end

def m4450
	for $I in 1..80
		$Estr[$I]=mREAD
  end
	for $I in 1..$G
		$C[$I]=mREAD
  end
	for $I in 1..13
		$A=mREAD
		$F[$A]=1
  end
  $F[41]=INT(RND(1)*900)+100
  $F[42]=INT(RND(1)*3)+2
  $F[44]=4
  $F[57]=68
  $F[58]=54
  $F[59]=15
  $F[52]=INT(RND(1)*3)
  $R=77
  $Rstr="GOOD LUCK ON YOUR QUEST!"
  $Gstr[1]=""
  for $I in 1..8
		$Fstr=MIDstr($Bstr,1+INT(RND(1)*4)*3,1)
		$Gstr[1]=$Gstr[1]+$Fstr
		if $Fstr=="N" then
			$Lstr="S"
		end
		if $Fstr=="S" then
			$Lstr="N"
		end
		if $Fstr=="E" then
			$Lstr="W"
		end
		if $Fstr=="W" then
			$Lstr="E"
		end
		$Gstr[2]=$Lstr+$Gstr[2]
	end
  return
end

def m4600
  m4640
  m4670
  $R=$F[69]
  $Rstr="OK. CARRY ON"
  return
end

def m4630
  $F[69]=$R
  m4640
  m4760
  puts "BYE..."
  exit
end

def m4640
  puts
  puts "PLEASE ENTER A FILE NAME"
  $FLstr=mINOUT
  return
end

def m4670
  #READ DATA FILE
  #puts "OK. SEARCHING FOR "+$FLstr
  #$X=OPENIN($FLstr)
  #puts "OK. LOADING"
	#for $I in 1..80
  #INPUT#$X,$Estr[$I]
  #end
	#for $I in 1..$G
  #INPUT#$X,$C[$I]
  #end
	#for $I in 1..70
  #INPUT#$X,$F[$I]
  #end
  #INPUT#$X,$Gstr[1]
  #INPUT#$X,$Gstr[2]
  #CLOSE#$X
  return
end

def m4760
  #SAVE DATA FILE
  #$X=OPENOUT($FLstr)
  #puts "OK. SAVING"
	#for $I in 1..80
  #puts#$X,$Estr[$I]
  #end
	#for $I in 1..$G
  #puts#$X,$C[$I]
  #end
	#for $I in 1..70
  #puts#$X,$F[$I]
  #end
  #puts#$X,$Gstr[1]
  #puts#$X,$Gstr[2]
  #CLOSE#$X
  return
end

def m4830
  $LS=1
  $LP=1
  for $I in 1..LEN($Jstr)
		if MIDstr($Jstr,$I,1)==" " && $LL>$EL then
			puts MIDstr($Jstr,$LP,$LS-$LP)
			$LL=$I-$LS
			$LP=$LS+1
		end
		if MIDstr($Jstr,$I,1)==" " then
			$LS=$I
		end
		$LL=LL+1
  end
  print MIDstr($Jstr,$LP,LEN($Jstr)-$LP)
  return
end

def mREAD
	$DATA.shift
end

def TAB(len)
	' '*len
end

def mINPUT
	gets.chomp
end


start
