require 'json'

def start
  $EL=39
  $num_objects=88
  $NV=57
  $G=28
  setup
  main
  exit
end

def main
  print_titles
  $LL=0
  restore_to_current_room
  $Pstr=$Xstr[VAL(LEFTstr($Dstr,1))]+" "+$Ystr[VAL(MIDstr($Dstr,2,1))]+" "
  $Jstr=$Rstr+". "+"YOU ARE "+$Pstr+RIGHTstr($Dstr,LEN($Dstr)-2)+" "
  format_description
  restore_to_objects
  $Jstr=""
  for $I in 1..($G-1)
    $object_str=mREAD
    $Pstr=$Ystr[VAL(LEFTstr($object_str,1))]
    strip_leading
    if $F[$I]==0 && $object_location[$I]==$room then
      $Jstr=$Jstr+" "+$Pstr+" "+$object_str+","
    end
  end
  if $room==29 && $F[48]==0 then
    $Jstr=$Jstr+" GRARGS FEASTING,"
  end
  if $room==29 && $F[48]==1 then
    $Jstr=$Jstr+" A SLEEPING GRARG,"
  end
  if $room==12 || $room==22 then
    $Jstr=$Jstr+" A PONY,"
  end
  if $room==64 then
    $Jstr=$Jstr+" A HERMIT,"
  end
  if $room==18 && $exits[18]=="N" then
    $Jstr=$Jstr+" AN OAK DOOR,"
  end
  if $room==59 && $F[68]==1 then
    $Jstr=$Jstr+" OGBAN (DEAD),"
  end
  if $Jstr!="" then
    $Jstr=", YOU CAN SEE"+$Jstr
  end
  $Jstr=$Jstr+" AND YOU CAN GO "
  format_description
  print " "
  for $I in 1..LEN($exits[$room])
    print MIDstr($exits[$room],$I,1)+","
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
    save_game
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
      break
    end
  end
  if $Tstr=="" then
    $Vstr=$Istr
  end
  while LEN($Vstr)<3
    $Vstr=$Vstr+"O"
  end
  if $Vstr=="PLAY" then
    $Vstr="BLO"
  end
  $Ustr=LEFTstr($Vstr,3)
  for $I in 1..$NV
    if MIDstr($cmd_list,$I*3-2,3)==$Ustr then
      $VB=$I
      break
    end
  end
  $F[36]=0
  begin
    restore_to_objects
    for $I in 1..$num_objects
      $object_str=mREAD
      if $I<=$G then
        strip_leading
      end
      if $Tstr==$object_str then
        $B=$I
        break
      end
    end
    if $B==0 && $F[36]==0 && $Tstr!="" then
      $Tstr=$Tstr+"S"
      $F[36]=1
    end
  end until !($B==0 && $F[36]==0 && $Tstr!="")
  if $VB==0 then
    $VB=$NV+1
  end
  if $Tstr=="" then
    $Rstr="I NEED TWO WORDS"
  end
  if $VB>$NV then
    $Rstr="TRY SOMETHING ELSE"
  end
  if $VB>$NV && $B==0 then
    $Rstr="YOU CANNOT "+$Istr
  end
  if !($B>$G || $B==0) then
    if !($VB==8 || $VB==9 || $VB==14 || $VB==17 || $VB==44 || $VB>54) then
      if $VB<$NV && $object_location[$B]!=0 then
        $Rstr="YOU DO NOT HAVE THE "+$Tstr
        main
      end
    end
  end
  if $room==56 && $F[35]==0 && $VB!=37 && $VB!=53 then
    $Rstr=$X1str+" HAS GOT YOU!"
    main
  end
  if !($VB==44 || $VB==47 || $VB==19 || $VB==57 || $VB==49) then
    if $room==48 && $F[63]==0 then
      $Rstr=$X9str
      main
    end
  end
  $H=VAL(STRstr($room)+STRstr($B))
  send([:go,:go,:go,:go,:go,:go,:inventory,:take,:take,:examine,:examine,:give,:say,
    :pick,:wear,:tie,:climb,:make,:use,:open,:burn,:fill,:plant,:water,:swing,:empty,
    :enter,:cross,:remove,:feed,:turn,:dive,:bail,:drop,:throw,:insert,:make,:drop,:eat,
    :move,:into,:ring,:cut,:hold,:burn,:into,:hold,:unlock,:use,:drink,:examine,:pay,
    :make,:break,:take,:take,:reflect,:noop][$VB-1])
  if !($F[62]==1) then
    if $room==41 then
      $F[67]==$F[67]+1
      if $F[67]==10 then
        $F[56]=1
        $Rstr="YOU SANK!"
      end
    end
    if $room==56 && $F[35]==0 && $object_location[10]!=0 then
      $Rstr=$X1str+" GETS YOU!"
      $F[56]=1
    end
    if $F[56]==0 then
      main
    end
    print_titles
    puts $Rstr
    puts "YOU HAVE FAILED IN YOUR QUEST!"
    puts
    puts "BUT YOU ARE GRANTED ANOTHER TRY"
    pause
    start
  end

  print_titles
  puts "HOOOOOOORRRRRAAAAAYYYYYY!"
  puts
  puts "YOU HAVE SUCCEEDED IN YOUR"
  puts "QUEST AND BROUGHT PEACE TO"
  puts "THE LAND"
  exit
end

def go
  $D=$VB
  if $D==5 then
    $D=1
  end
  if $D==6 then
    $D=3
  end
  if !(!(($room==75 && $D==2) || ($room==76 && $D==4)) || $F[64]==1) then
    $Rstr="B USPMM TUPQT ZPV DSPTTJOH"
    decode
    return
  end
  if $F[64]==1 then
    $F[64]=0
  end
  if !($F[51]==1 || $F[29]==1) then
    if $F[55]==1 then
      $F[56]=1
      $Rstr="GRARGS HAVE GOT YOU!"
      return
    end
    if $room==29 && $F[48]==0 then
      $Rstr="GRARGS WILL SEE YOU!"
      return
    end
    if $room==73 || $room==42 || $room==9 || $room==10 then
      $Rstr=$X3str
      $F[55]=1
      return
    end
  end
  if $object_location[8]==0 && (($room==52 && $D==2) || ($room==31 && $D!=3)) then
    $Rstr="THE BOAT IS TOO HEAVY"
    return
  end
  if $object_location[8]!=0 && (($room==52 && $D==4) || ($room==31 && $D==3)) then
    $Rstr="YOU CANNOT SWIM"
    return
  end
  if $room==52 && $object_location[8] && $D==4 && $F[30]==0 then
    $Rstr="NO POWER!"
    return
  end
  if $room==41 && $D==3 && $F[31]==0 then
    $Rstr="UIF CPBU JT TJOLJOH!"
    decode
    return
  end
  if $room==33 && $D==1 && $F[32]==0 then
    $Rstr="OGBAN'S BOAR BLOCK YOUR PATH"
    return
  end
  if (($room==3 && $D==2) || ($room==4 && $D==4)) && $F[45]==0 then
    $Rstr=$X5str
    return
  end
  if $room==35 && $object_location[13]!=$room then
    $Rstr="THE ICE IS BREAKING!"
    return
  end
  if $room==5 && ($D==2 || $D==4) then
    tunnels
  end
  if $room==4 && $D==4 then
    $Rstr="PASSAGE IS TOO STEEP"
    return
  end
  if $room==7 && $D==2 && $F[46]==0 then
    $Rstr="A HUGE HOUND BARS YOUR WAY"
    return
  end
  if ($room==38 || $room==37) && $F[50]==0 then
    $Rstr="JU JT UPP EBSL"
    decode
    return
  end
  if $room==49 && $D==2 && $F[54]==0 then
    $Rstr="MYSTERIOUS FORCES HOLD YOU BACK"
    return
  end
  if $room==49 && $D==3 && $F[68]==0 then
    $Rstr="YOU MEET OGBAN!!!"
    $F[56]=1
    return
  end
  if $room==38 && $F[65]==0 then
    $Rstr="RATS NIBBLE YOUR ANKLES"
    return
  end
  if $room==58 && ($D==1 || $D==4) && $F[66]==0 then
    $Rstr="YOU GET CAUGHT IN THE WEBS!"
    return
  end
  if $room==48 && $D==4 && $F[70]==0 then
    $Rstr="THE DOOR DOES NOT OPEN"
    return
  end
  if $room==40 && $F[47]==1 then
    $F[68]=1
  end
  if $room==37 && $D==4 && $exits[37]=="EW" then
    $room=67
    $Rstr="THE PASSAGE WAS STEEP!"
    return
  end
  if $room==29 && $D==3 then
    $F[48]=1
    $F[20]=0
  end
  if $room==8 && $D==2 then
    $F[46]=0
  end
  $OM=$room
  for $I in 1..LEN($exits[$room])
    $Kstr=MIDstr($exits[$OM],$I,1)
    if ($Kstr=="N" || $Kstr=="U") && $D==1 then
      $room=$room-10
    end
    if $Kstr=="E" && $D==2 then
      $room=$room+1
    end
    if ($Kstr=="S" || $Kstr=="D") && $D==3 then
      $room=$room+10
    end
    if $Kstr=="W" && $D==4 then
      $room=$room-1
    end
  end
  $Rstr="OK"
  if $room==$OM then
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
    decode
    $F[29]=0
    $object_location[3]=81
  end
end

def inventory
  restore_to_objects
  $Rstr="OK"
  $F[49]=0
  print "YOU HAVE "
  for $I in 1..$G
    $object_str=mREAD
    strip_leading
    if $I==1 && $object_location[1]==0 && $F[44]==1 then
      $object_str="COIN"
    end
    if !($I==$G && $object_location[5]==0) then
      if $object_location[$I]==0 then
        print $object_str+","
        $F[49]=1
      end
    end
  end
  if $F[49]==0 then
    puts "NOTHING"
  end
  puts
  pause
end

def take
  if $H==6577 then
    $Rstr="HOW?"
    return
  end
  if $H==4177 || $H==5177 then
    $B=16
    fill
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
    if $object_location[$I]==0 then
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
  if $object_location[$B]!=$room then
    $Rstr="IT IS NOT HERE"
  end
  if $F[$B]==1 then
    $Rstr="WHAT "+$Tstr+"?"
  end
  if $object_location[$B]==0 then
    $Rstr="YOU ALREADY HAVE IT"
  end
  if $object_location[$B]==$room && $F[$B]==0 then
    $object_location[$B]=0
    $Rstr="YOU HAVE THE "+$Tstr
  end
  if $B==28 then
    $object_location[5]=81
  end
  if $B==5 then
    $object_location[28]=0
  end
  if $object_location[4]==0 && $object_location[12]==0 && $object_location[15]==0 then
    $F[54]=1
  end
  if $B==8 && $F[30]==1 then
    $object_location[2]=0
  end
  if $B==2 then
    $F[30]=0
  end
end

def examine
  $Rstr="YOU SEE WHAT YOU MIGHT EXPECT!"
  if $B>0 then
    $Rstr="NOTHING SPECIAL"
  end
  if $B==46 || $B==88 then
    enter
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
    decode
    $object_location[26]=0
  end
  if $H==1648 then
    $Rstr="THEREARE SOME LETTERS '"+$Gstr[2]+"'"
  end
  if $H==7432 then
    $Rstr="UIFZ BSF BQQMF USFFT"
    decode
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
    $Rstr="B HMJNNFSJOH GSPN UIF EFQUIT"
    decode
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
    decode
  end
  if $H==4055 then
    examine_sub
  end
  if $H==2969 && $F[49]==1 then
    $Rstr="VERY UGLY!"
  end
  if $H==7158 || $H==7186 then
    $Rstr="THERE ARE LOOSE BRICKS"
  end
  if $room==49 then
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
    decode
  end
end

def give
  if $room==64 then
    $Rstr="HE GIVES IT BACK!"
  end
  if $H==6425 then
    give_ring
  end
  if $room==75 || $room==76 then
    $Rstr="HE DOES NOT WANT IT"
  end
  if $B==62 && $F[44]==0 then
    $Rstr="YOU HAVE RUN OUT!"
  end
  if ($H==7562 || $H==7662) && $F[44]>0 && $object_location[1]==0 then
    $Rstr="HE TAKES IT"
    $F[64]=1
  end
  if $F[64]==1 then
    $F[44]=$F[44]-1
  end
  if $B==1 then
    $Rstr="HE TAKES THEM ALL!"
    $object_location[1]=81
    $F[64]=1
    $F[44]=0
  end
  if $H==2228 && $object_location[5]==81 then
    $Rstr=$XBstr+"NORTH"
    $object_location[28]=81
    $room=12
  end
  if ($H==2228 && $object_location[5]==81) || $H==225 then
    $Rstr=$XBstr+"NORTH"
    $room=12
  end
  if ($H==1228 && $object_location[5]==81) || $H==125 then
    $Rstr=$XBstr+"SOUTH"
    $room=12
  end
  if $room==7 || $room==33 then
    $Rstr="HE EATS IT!"
    $object_location[$B]=81
  end
  if $H==711 then
    $F[46]=1
    $Rstr="HE IS DISTRACTED"
  end
  if $H==385 || $H==3824 then
    $Rstr="THEY SCURRY AWAY"
    $object_location[$B]=81
    $F[65]=1
  end
end

def say
  $Rstr="YOU SAID IT"
  if $B==84 then
    $Rstr="YOU MUST SAY THEM ONE BY ONE!"
    return
  end
  if $room!=47 || $B<71 || $B>75 || $object_location[27]!=0 then
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
end

def pick
  if $B==5 || $B==10 then
    take
  end
end

def wear
  if $B==3 then
    $F[29]=1
    $Rstr="ZPV BSF JOWJTJCMF"
    $F[55]=0
    decode
  end
  if $B==20 then
    $F[51]=1
    $Rstr="ZPV BSF EJTHVJTFE"
    $F[55]=0
    decode
  end
end

def tie
  if $B==2 || $B==14 then
    $Rstr="NOTHING TO TIE IT TO!"
  end
  if $H==7214 then
    $Rstr="IT IS TIED"
    $object_location[14]=72
    $F[53]=1
  end
  if $H==722 then
    $Rstr="OK"
    $F[40]=1
    $object_location[2]=72
  end
end

def climb
  if $H==1547 && $F[38]==1 then
    $Rstr="ALL RIGHT"
    $room=16
  end
  if $B==14 || $B==2 then
    $Rstr="NOT ATTACHED TO ANYTHING!"
  end
  if $H==5414 && $object_location[14]==54 then
    $Rstr="YOU ARE AT THE TOP"
  end
  if $H==7214 && $F[53]==1 then
    $Rstr="GOING DOWN"
    $room=71
  end
  if $H==722 && $F[40]==1 then
    $room=71
    $Rstr="IT IS TORN"
    $object_location[2]=81
    $F[40]=0
  end
  if $H==7114 && $F[53]==1 then
    $object_location[14]=71
    $F[53]=0
    $Rstr="IT FALLS DOWN-BUMP!"
  end
end

def use
  if $H==522 then
    $Rstr="OK"
    $F[30]=1
  end
  if $B==1 || $B==62 || $B==5 || $B==28 || $B==11 || $B==24 then
    give
  end
  if $H==416 then
    $Rstr="ZPV IBWF LFQU BGMPBU"
    $F[31]=1
    decode
    return
  end
  if $H==4116 then
    $Rstr="IT IS NOT BIG ENOUGH!"
    return
  end
  if $B==18 || $B==7 then
    swing
  end
  if $B==13 then
    drop
  end
  if $B==19 then
    hold
  end
  if $B==10 then
    make
  end
  if $B==16 || $B==6 then
    fill
  end
end

def open
  if $B==76 || $B==38 then
    examine
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
    $exits[37]="EW"
  end
  if $H==5960 then
    open_sub
  end
  if $H==6970 then
    $Rstr="IT FALLS OFF ITS HINGES"
  end
  if $H==4870 then
    $Rstr="IT IS LOCKED"
  end
end

def burn
  if $B>$G then
    $Rstr="IT DOES NOT BURN"
  end
  if $B==26 then
    $Rstr="YOU LIT THEM"
  end
  if $H==3826 then
    $Rstr="NOT BRIGHT ENOUGH"
  end
  if ($B==23 || $H==6970) && $object_location[26]!=0 then
    $Rstr="OP NBUDIFT"
    decode
  end
  if $B==23 && $object_location[26]==0 then
    $Rstr="A BRIGHT "+$Vstr
    $F[50]=1
  end
  if $H==6970 && $object_location[26]==0 then
    $F[43]=1
    $Rstr="IT HAS TURNED TO ASHES"
  end
end

def fill
  if ($B==16 || $B==6) && ($room==41 || $room==51) then
    $Rstr="YOU CAPSIZED!"
    $F[56]=1
  end
  if $H==6516 && $object_location[16]==0 then
    $Rstr="IT IS NOW FULL"
    $F[34]=1
  end
  if $H==656 then
    $Rstr="IT LEAKS OUT!"
  end
end

def plant
  if $B!=22 || $room!=15 then
    $Rstr="DOES NOT GROW!"
    return
  end
  $Rstr="OK"
  $F[34]=1
end

def water
  if $B==22 && $F[37]==1 && $F[34]==1 then
    $Rstr=$X2str
    $F[38]=1
    decode
  end
end

def swing
  if $B==7 || $B==18 then
    $Rstr="THWACK!"
  end
  if $H==5818 then
    $Rstr="YOU CLEARED THE WEBS"
    $F[66]=1
  end
  if $H==187 then
    $Rstr="THE DOOR BROKE!"
    $exits[18]="NS"
    $exits[28]="NS"
  end
  if $H==717 then
    $Rstr="YOU BROKE THROUGH"
    $exits[71]="N"
  end
end

def empty
  if $B==16 then
    $B=22
    water
  end
  if $H==499 then
    $Rstr="WHERE?"
  end
end

def enter
  if $H==4337 then
    $VB=2
    go
    return
  end
  if $room==36 then
    $Rstr="YOU FOUND SOMETHING"
    $F[13]=0
  end
end

def cross
  if $room==76 then
    $VB=4
    go
    return
  end
  if $room==75 then
    $VB=2
    go
  end
end

def remove
  if ($B==3 && $F[29]==1) then
    $Rstr="TAKEN OFF"
    $F[29]=0
  end
  if ($B==20 && $F[51]==1) then
    $Rstr="OK"
    $F[51]=0
  end
  if $B==36 || $B==50 then
    move
  end
end

def feed
  if $H==3859 || $H==3339 || $H==1241 || $H==2241 || $H==751 then
    $Rstr="WITH WHAT?"
  end
end

def turn
  if $H==2340 then
    $Rstr="IT GOES ROUND"
  end
  if $H==2445 then
    $Rstr="UIF HBUFT PQFQ, UIF QPPM FNQUJFT"
    $F[33]=1
    decode
  end
end

def dive
  if $room==14 || $room==51 then
    $Rstr="YOU HAVE DROWNED"
    $F[56]=1
  end
end

def bail
  $Rstr="HOW?"
end

def drop
  if $B==0 || $B>$G then
    return
  end
  $object_location[$B]=$room
  $Rstr="DONE"
  if $H==418 || $H==518 then
    $Rstr="YOU DROWNED!"
    $F[56]=1
  end
  if $B==8 && $F[30]==1 then
    $object_location[2]=$room
  end
  if $B==16 && $F[34]==1 then
    $Rstr="YOU LOST THE WATER!"
    $F[34]=0
  end
  if $B==2 && $F[30]==1 then
    $F[30]=0
  end
end

def insert
  if $B==62 && $F[44]==0 then
    $Rstr="YOU DO NOT HAVE ANY"
  end
  if $H==5762 && $object_location[1]==0 && $F[44]>0 then
    insert_sub
  end
end

def throw
  if $B==0 || $B>$G then
    return
  end
  $Rstr="DID NOT GO FAR!"
  $object_location[$B]=$room
  if $H==3317 then
    $Rstr="ZPV DBVHIU UIF CPBS"
    $F[32]=1
    decode
  end
end

def make
  if $B==10 then
    $Rstr="B OJDF UVOF"
    decode
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
    $exits[56]="NS"
  end
end

def eat
  if $B==0 || $B>$G then
    return
  end
  if $B==5 || $B==24 then
    $Rstr="YUM YUM!"
    $object_location[$B]=81
  end
end

def move
  if $room==4 && $B==50 then
    $F[45]=1
    $Rstr="YOU REVEALED A STEEP PASSAGE"
  end
  if $room==3 && $B==50 then
    $Rstr="YOU CANNOT MOVE RUBBLE FROM HERE"
  end
  if $H==7136 then
    $Rstr="THEY ARE WEDGED IN!"
  end
end

def into
  if ($B==67 || $B==68) && $object_location[9]==0 && $room==49 then
    $Rstr="OK"
    $F[47]=1
  end
end

def ring
  if $room!=27 || $B!=63 then
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
    $exits[27]="EW"
    return
  end
  $Rstr="ZPV IBWF NJTUSFBUFE UIF CFMM!"
  $F[56]=1
  decode
end

def cut
  if $H==5861 then
    $H=5818
    swing
  end
end

def hold
  if ($H==4864 || $H==4819) && $object_location[19]==0 then
    $Rstr=$X6str
    $F[63]=1
    decode
  end
  if $B==27 then
    take
  end
end

def pay
  if $H==7549 || $H==7649 then
    $Rstr="WHAT WITH?"
  end
  if $B==1 || $B==62 then
    give
  end
end

def unlock
  if $H==4870 && $object_location[21]==0 then
    $Rstr="THE KEY TURNS!"
    $F[70]=1
  end
end

def break
  if $H==1870 then
    $Rstr="HOW?"
  end
end

def reflect
  if $room==48 then
    $Rstr="HOW?"
  end
end

def drink
  $Rstr="ARE YOU THIRSTY?"
end

def give_ring
  $Rstr="HE TAKES IT AND SAYS '"+STRstr($F[42])+" RINGS ARE NEEDED'"
  $object_location[25]=81
end

def insert_sub
  $F[44]=$F[44]-1
  $Rstr="A NUMBER APPEARS - "+STRstr($F[41])
  if $F[44]==0 then
    $object_location[1]=81
  end
end

def open_sub
  puts
  $Rstr="XIBU JT UIF DPEF"
  decode
  puts $Rstr
  $CN=mINPUT
  $Rstr="WRONG!"
  if $CN==$F[41] then
    $Rstr="IT OPENS"
    $F[21]=0
  end
end

def examine_sub
  $T=$room
  $room=$F[$F[52]+57]
  restore_to_current_room
  $room=$T
  $Rstr=$X4str+RIGHTstr($Dstr,LEN($Dstr)-2)
end

def restore_to_current_room
  mRESTORE
  for $I in 1..$room
    $Dstr=mREAD
  end
end

def restore_to_objects
  mRESTORE
  for $I in 1..80
    $Dstr=mREAD
  end
end

def strip_leading
  $object_str=RIGHTstr($object_str,LEN($object_str)-1)
end

def pause
  puts "PRESS return TO CONTINUE"
  $Zstr=mINPUT
end

def setup
  $object_location=Array.new($G+1,0)
  $exits=Array.new(80+1,'')
  $F=Array.new(70+1,0)
  $Xstr=Array.new(6+1,'')
  $Ystr=Array.new(6+1,'')
  $Gstr=Array.new(2+1,'')
  restore_to_objects
  for $I in 1..$num_objects
    $Tstr=mREAD
  end
  for $I in 1..6
    $Xstr[$I]=mREAD
    $Ystr[$I]=mREAD
  end
  $cmd_list="NOOEOOSOOWOOUOODOOINVGETTAKEXAREAGIVSAYPICWEATIECLIRIGUSEOPE"
  $cmd_list=$cmd_list+"LIGFILPLAWATSWIEMPENTCROREMFEETURDIVBAILEATHRINSBLODROEATMOV"
  $cmd_list=$cmd_list+"INTRINCUTHOLBURPOISHOUNLWITDRICOUPAYMAKBRESTEGATREF"
  $X6str="XV SFGMFDUFE UIF XJABSET HMSBF! if JT EFBE"
  $X1str="THE GHOST OF THE GOBLIN GUARDIAN"
  $X2str="B MBSHF WJOF HSPXT JO TFDPOET!"
  $X3str="A GRARG PATROL APPROACHES"
  $X4str="MAGIC WORDS LIE AT THE CROSSROADS, THE FOUNTAIN AND THE "
  $X5str="A PILE OF RUBBLE BLOCKS YOUR PATH"
  $X7str="THE MOUNTAIN RUMBLES!"
  $X8str="TOWERS FALL DOWN!"
  $X9str="THE WIZARD HAS YOU IN HIS GLARE"
  $XBstr="HE LEADS YOU "
  print_titles
  puts "DO YOU WANT TO"
  puts
  puts "   1. START A NEW GAME"
  puts "OR 2. CONTINUE A SAVED GAME"
  begin
    puts
    puts
    puts "TYPE IN EITHER 1 OR 2"
    $Cx=mINPUT.to_i
  end until !($Cx!=1 && $Cx!=2)
  if $Cx==1 then
    new_game
  end
  if $Cx==2 then
    load_game
  end
end

def mRESTORE
  rooms = [
    "1HALF-DUG GRAVE", "12GOBLIN GRAVEYARD",
    "11HOLLOW TOMB", "23STALACTITES AND STALAGMITES",
    "11MAZE OF TUNNELS", "11VAULTED CAVERN",
    "23HIGH GLASS GATES", "12ENTRANCE HALL TO THE PALACE",
    "31GRARG SENTRY POST", "12GUARD ROOM",
    "31MARSHY INLET", "23RUSTYGATES",
    "12GAMEKEEPER'S COTTAGE", "31MISTY POOL",
    "11HIGH-WALLED GARDEN", "14INSCRIBED CAVERN",
    "34ORNATE FOUNTAIN", "11DANK CORRIDOR",
    "12LONG GALLERY", "12KITCHENS OF THE PALACE",
    "34OLDKILN", "44OVERGROWN TRACK",
    "31DISUSED WATERWHHEL", "33SLUICE GATES",
    "11GAP BETWEEN SOME BOULDERS", "41PERILOUS PATH",
    "31SILVER BELL IN THE ROCK", "12DUNGEONS OF THE PALLACE",
    "11BANQUETING HALL", "42PALACE BATTLEMENTS",
    "44ISLAND SHORE", "31BEACHED KETCH",
    "13BARREN COUNTRYSIDE", "33SACKS ON THE UPPER FLOOR",
    "46FROZEN POND", "21MOUNTAIN HUT",
    "31ROW OF CASKS", "11WINE CELLAR",
    "12HALL OF TAPESTRIES", "11DUSTY LIBRARY",
    "13ROUGH WATER", "11PLOUGHED FIELD",
    "55OUTSIDE A WINDMILL", "42LOWER FLOOR OF THE MILL",
    "44ICY PATH", "41SCREE SLOPE",
    "12SILVER CHAMBER", "12WIZARD'S LAIR",
    "11MOSAIC-FLOORED HALL", "12SILVER THRONE ROOM",
    "12MIDDLE OF THE LAKE", "42EDGE OF AN ICY LAKE",
    "41PITTED TRACK", "41HIGH PINNACLE",
    "55ABOVE A GLACIER", "21HUGE FALLEN OAK",
    "11TURRET ROOM WITH A SLOT MACHINE", "11COBWEBBY ROOM",
    "31SAFE IN OGBAN'S CHAMBER", "31CUPBOARD IN A CORNER",
    "11NARROW PASSAGE", "16CAVE",
    "11WOODMAN'S HUT", "42SIDE OF A WOODED VALLEY",
    "21STREAM IN A VALLEY BOTTOM", "11DEEP DARK WOOD",
    "11SHADY HOLLOW", "34ANCIENT STONE CIRCLE",
    "16STABLE", "14ATTIC BEDROOM",
    "11DAMP WELL BOTTOM", "32TOPOF A DEEP WELL",
    "31BURNT-OUT CAMPFIRE", "16ORCHARD",
    "62END OF A BRIDGE", "62END OF A BRIDGE",
    "61CROSSROADS", "41WINDING ROAD",
    "11VILLAGE OF RUSTIC HOUSES", "11WHITE COTTAGE"
  ]
  marked_objects = [
    "3COINS", "1SHEET", "3BOOTS", "1HORSESHOE", "3APPLES", "1BUCKET", "4AXE", "1BOAT", "1PHIAL",
    "3REEDS", "1BONE", "1SHIELD", "3PLANKS", "1ROPE", "1RING", "1JUG", "1NET", "1SWORD",
    "1SILVER PLATE", "1UNIFORM", "1KEY", "3SEEDS", "1LAMP", "3BREAD", "1BROOCH", "3MATCHES",
    "2STONE OF DESTINY", "4APPLE"
  ]
  objects = [
    "BED", "CUPBOARD", "BRIDGE", "TREES", "SAIL", "KILN",
    "KETCH", "BRICKS", "WINDMILL", "SACKS", "OGBAN'S BOAR", "WHEEL",
    "PONY", "GRAVESTONES", "POOL", "GATES", "HANDLE", "HUT", "VINE", "INSCRIPTIONS", "TROLL", "RUBBLE",
    "HOUND", "FOUNTAIN", "CIRCLE", "MOSAICS", "BOOKS", "CASKS", "WELL", "WALLS", "RATS", "SAFE",
    "COBWEBS", "COIN", "BELL", "UP SILVER PLATE", "STONES", "KITCHENS", "GOBLET", "WINE",
    "GRARGS", "DOOR", "AWAKE", "GUIDE", "PROTECT", "LEAD", "HELP", "CHEST", "WATER",
    "STABLES", "SLUICE GATES", "POT", "STATUE", "PINNACLE", "MUSIC", "MAGIC WORDS",
    "MISTY POOL", "WELL BOTTOM", "OLD KILN", "MOUNTAIN HUT"
  ]
  sentence_pairs = [
    "IN", "A", "NEAR", "THE", "BY", "SOME", "ON", "AN", "", "", "AT", "A SMALL"
  ]
  exits = [
    "E", "ESW", "WE", "EW", "EW", "ESW", "ESW", "ES", "EW", "SW",
    "S", "N", "ES", "SW", "S", "NW", "N", "N", "ES", "NSW",
    "NS", "E", "NSW", "N", "NES", "EW", "W", "S", "NS", "N",
    "NES", "W", "NS", "$D", "NES", "SW", "E", "NW", "NS", "S",
    "NS", "E", "NSEW", "WU", "UD", "NS", "E", "SW", "NSE", "NW",
    "NE", "EW", "NSW", "E", "WN", "S", "E", "NEW", "NW", "S",
    "ES", "SW", "NES", "EW", "SW", "NE", "EW", "ESW", "SW", "ND",
    " ", "E", "NEW", "EW", "NEW", "EW", "EW", "NEW", "NEW", "WU"
  ]
  object_locations = [
    80, 70, 60, 69, 74, 72, 63, 52, 20, 11, 1, 14, 36, 54, 61, 21, 32, 10, 50,
    29, 59, 34, 13, 80, 30, 81, 47, 74
  ]
  f_data = [
    1, 2, 3, 4, 5, 9, 12, 13, 16, 17, 20, 21, 22
  ]
  $DATA = rooms + marked_objects + objects + sentence_pairs + exits + object_locations + f_data
end

def decode
  $Zstr=""
  for $I in 1..LEN($Rstr)
    $Cstr=MIDstr($Rstr,$I,1)
    if $Cstr<"A" then
      $Zstr=$Zstr+$Cstr
    else
      $object_location=$Cstr.ord-1
      if $object_location==64 then
        $object_location=90
      end
      $Zstr=$Zstr+CHRstr($object_location)
    end
  end
  $Rstr=$Zstr
end

def tunnels
  $Jstr="SSSSSSSS"
  $NG=0
  begin
    $MP=$D/2
    print_titles
    puts "YOU ARE LOST IN THE"
    puts "      TUNNELS"
    puts "WHICH WAY? (N,S,W OR E)"
    if $NG>15 then
      puts "(OR G TO GIVE UP!)"
    end
    puts
    puts $Wstr
    $Jstr=RIGHTstr($Jstr+RIGHTstr($Wstr,1),8)
    if $Wstr=="G" then
      $F[56]=1
      return
    end
    if $Jstr!=$Gstr[$MP] then
      $NG=$NG+1
    end
  end until !($Jstr!=$Gstr[$MP])
end

def print_titles
  system('clear')
  puts
  puts TAB($EL/2-9)+"MYSTERY OF SILVER"
  puts TAB($EL/2-9)+"    MOUNTAIN"
  puts "======================================"
  puts
  puts
end

def new_game
  for $I in 1..80
    $exits[$I]=mREAD
  end
  for $I in 1..$G
    $object_location[$I]=mREAD.to_i
  end
  for $I in 1..13
    $A=mREAD.to_i
    $F[$A]=1
  end
  $F[41]=INT(RND(1)*900)+100
  $F[42]=INT(RND(1)*3)+2
  $F[44]=4
  $F[57]=68
  $F[58]=54
  $F[59]=15
  $F[52]=INT(RND(1)*3)
  $room=77
  $Rstr="GOOD LUCK ON YOUR QUEST!"
  $Gstr[1]=""
  for $I in 1..8
    $Fstr=MIDstr($cmd_list,1+INT(RND(1)*4)*3,1)
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
end

def load_game
  get_filename
  read_file
  $room=$F[69]
  $Rstr="OK. CARRY ON"
end

def save_game
  $F[69]=$room
  get_filename
  write_file
  puts "BYE..."
  exit
end

def get_filename
  puts
  puts "PLEASE ENTER A FILE NAME"
  $filename=mINPUT
end

def read_file
  #READ DATA FILE
  puts "OK. SEARCHING FOR "+$filename
  File.open($filename, 'r') do |x|
    puts "OK. LOADING"
    $exits, $object_location, $F, $Gstr = JSON.parse(x.gets)
  end
end

def write_file
  #SAVE DATA FILE
  File.open($filename, 'w') do |x|
    puts "OK. SAVING"
    x.puts [$exits, $object_location, $F, $Gstr].to_json
  end
end

def format_description
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
    $LL=$LL+1
  end
  print MIDstr($Jstr,$LP,LEN($Jstr)-$LP)
end

def mREAD
  $DATA.shift
end

def TAB(len)
  ' '*len
end

def mINPUT
  print '?'
  gets.chomp
end

def RND(v)
  raise unless v==1
  rand
end

def INT(v)
  v.to_i
end

def MIDstr(str, start, len)
  start -= 1
  str[start...(start+len)]
end

def LEFTstr(str, len)
  str[0..(len-1)]
end

def RIGHTstr(str, len)
  str[-len..-1]
end

def VAL(str)
  str.to_i
end

def STRstr(num)
  num.to_s
end

def LEN(str)
  str.length
end

def noop
end

def CHRstr(value)
  value.chr
end

start
