require 'json'

LINE_LENGTH = 39

def start
  setup
  while true
    catch(:redraw) do
      main
    end
  end
end

def main
  print_titles
  $LL=0
  preposition=prepositions[VAL(LEFTstr(current_room_description,1))]+" "+determiners[VAL(MIDstr(current_room_description,2,1))]+" "
  $Jstr=$response_message+". "+"YOU ARE "+preposition+RIGHTstr(current_room_description,LEN(current_room_description)-2)+" "
  format_description
  $Jstr=""
  marked_objects.each_with_index do |object_str, i|
    i = i + 1
    determiner=determiners[VAL(LEFTstr(object_str,1))]
    object_str = strip_leading(object_str)
    if $F[i]==0 && $object_location[i]==$room then
      $Jstr=$Jstr+" "+determiner+" "+object_str+","
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
  for i in 1..LEN($exits[$room])
    print MIDstr($exits[$room],i,1)+","
  end
  puts
  puts
  $response_message="PARDON?"
  puts "======================================"
  puts
  puts
  puts "WHAT WILL YOU DO NOW "
  cmd_string=mINPUT
  if cmd_string=="SAVE GAME" then
    save_game
  end
  $VB=0
  $B=0
  $Vstr, $Tstr = cmd_string.split(' ', 2)
  $Vstr ||= ""
  $Tstr ||= ""
  while LEN($Vstr)<3
    $Vstr=$Vstr+"O"
  end
  if $Vstr=="PLAY" then
    $Vstr="BLO"
  end
  cmd_start=LEFTstr($Vstr,3)
  for i in 1..($cmd_list.length/3)
    if MIDstr($cmd_list,i*3-2,3)==cmd_start then
      $VB=i
      break
    end
  end
  $F[36]=0
  begin
    objects.each_with_index do |object_str, i|
      i = i + 1
      if $Tstr==object_str then
        $B=i
        break
      end
    end
    if $B==0 && $F[36]==0 && $Tstr!="" then
      $Tstr=$Tstr+"S"
      $F[36]=1
    end
  end until !($B==0 && $F[36]==0 && $Tstr!="")
  if $VB==0 then
    $VB=($cmd_list.length/3)+1
  end
  if $Tstr=="" then
    $response_message="I NEED TWO WORDS"
  end
  if $VB>($cmd_list.length/3) then
    $response_message="TRY SOMETHING ELSE"
  end
  if $VB>($cmd_list.length/3) && $B==0 then
    $response_message="YOU CANNOT "+cmd_string
  end
  if !($B>marked_objects.size || $B==0) then
    if !($VB==8 || $VB==9 || $VB==14 || $VB==17 || $VB==44 || $VB>54) then
      if $VB<($cmd_list.length/3) && $object_location[$B]!=0 then
        $response_message="YOU DO NOT HAVE THE "+$Tstr
        Kernel.throw :redraw
      end
    end
  end
  if $room==56 && $F[35]==0 && $VB!=37 && $VB!=53 then
    $response_message=words(1)+" HAS GOT YOU!"
    Kernel.throw :redraw
  end
  if !($VB==44 || $VB==47 || $VB==19 || $VB==57 || $VB==49) then
    if $room==48 && $F[63]==0 then
      $response_message=words(9)
      Kernel.throw :redraw
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
        $response_message="YOU SANK!"
      end
    end
    if $room==56 && $F[35]==0 && $object_location[10]!=0 then
      $response_message=words(1)+" GETS YOU!"
      $F[56]=1
    end
    if $F[56]==0 then
      Kernel.throw :redraw
    end
    print_titles
    puts $response_message
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

def go(direction=$VB)
  if direction==5 then
    direction=1
  end
  if direction==6 then
    direction=3
  end
  if !(!(($room==75 && direction==2) || ($room==76 && direction==4)) || $F[64]==1) then
    $response_message=decode("B USPMM TUPQT ZPV DSPTTJOH")
    return
  end
  if $F[64]==1 then
    $F[64]=0
  end
  if !($F[51]==1 || $F[29]==1) then
    if $F[55]==1 then
      $F[56]=1
      $response_message="GRARGS HAVE GOT YOU!"
      return
    end
    if $room==29 && $F[48]==0 then
      $response_message="GRARGS WILL SEE YOU!"
      return
    end
    if $room==73 || $room==42 || $room==9 || $room==10 then
      $response_message=words(3)
      $F[55]=1
      return
    end
  end
  if $object_location[8]==0 && (($room==52 && direction==2) || ($room==31 && direction!=3)) then
    $response_message="THE BOAT IS TOO HEAVY"
    return
  end
  if $object_location[8]!=0 && (($room==52 && direction==4) || ($room==31 && direction==3)) then
    $response_message="YOU CANNOT SWIM"
    return
  end
  if $room==52 && $object_location[8] && direction==4 && $F[30]==0 then
    $response_message="NO POWER!"
    return
  end
  if $room==41 && direction==3 && $F[31]==0 then
    $response_message=decode("UIF CPBU JT TJOLJOH!")
    return
  end
  if $room==33 && direction==1 && $F[32]==0 then
    $response_message="OGBAN'S BOAR BLOCK YOUR PATH"
    return
  end
  if (($room==3 && direction==2) || ($room==4 && direction==4)) && $F[45]==0 then
    $response_message=words(5)
    return
  end
  if $room==35 && $object_location[13]!=$room then
    $response_message="THE ICE IS BREAKING!"
    return
  end
  if $room==5 && (direction==2 || direction==4) then
    tunnels(direction)
  end
  if $room==4 && direction==4 then
    $response_message="PASSAGE IS TOO STEEP"
    return
  end
  if $room==7 && direction==2 && $F[46]==0 then
    $response_message="A HUGE HOUND BARS YOUR WAY"
    return
  end
  if ($room==38 || $room==37) && $F[50]==0 then
    $response_message=decode("JU JT UPP EBSL")
    return
  end
  if $room==49 && direction==2 && $F[54]==0 then
    $response_message="MYSTERIOUS FORCES HOLD YOU BACK"
    return
  end
  if $room==49 && direction==3 && $F[68]==0 then
    $response_message="YOU MEET OGBAN!!!"
    $F[56]=1
    return
  end
  if $room==38 && $F[65]==0 then
    $response_message="RATS NIBBLE YOUR ANKLES"
    return
  end
  if $room==58 && (direction==1 || direction==4) && $F[66]==0 then
    $response_message="YOU GET CAUGHT IN THE WEBS!"
    return
  end
  if $room==48 && direction==4 && $F[70]==0 then
    $response_message="THE DOOR DOES NOT OPEN"
    return
  end
  if $room==40 && $F[47]==1 then
    $F[68]=1
  end
  if $room==37 && direction==4 && $exits[37]=="EW" then
    $room=67
    $response_message="THE PASSAGE WAS STEEP!"
    return
  end
  if $room==29 && direction==3 then
    $F[48]=1
    $F[20]=0
  end
  if $room==8 && direction==2 then
    $F[46]=0
  end
  om=$room
  for i in 1..LEN($exits[$room])
    exit_direction=MIDstr($exits[om],i,1)
    if (exit_direction=="N" || exit_direction=="U") && direction==1 then
      $room=$room-10
    end
    if exit_direction=="E" && direction==2 then
      $room=$room+1
    end
    if (exit_direction=="S" || exit_direction=="D") && direction==3 then
      $room=$room+10
    end
    if exit_direction=="W" && direction==4 then
      $room=$room-1
    end
  end
  $response_message="OK"
  if $room==om then
    $response_message="YOU CANNOT GO THAT WAY"
  end
  if ((om==75 && direction==2) || (om==76 && direction==4)) then
    $response_message="OK. YOU CROSSED"
  end
  if $F[29]==1 then
    $F[39]=$F[39]+1
  end
  if $F[39]>5 && $F[29]==1 then
    $response_message=decode("CPPUT IBWF XPSO PVU")
    $F[29]=0
    $object_location[3]=81
  end
end

def inventory
  $response_message="OK"
  $F[49]=0
  print "YOU HAVE "
  marked_objects.each_with_index do |object_str, i|
    i = i+1
    object_str = strip_leading(object_str)
    if i==1 && $object_location[1]==0 && $F[44]==1 then
      object_str="COIN"
    end
    if !(i==marked_objects.size && $object_location[5]==0) then
      if $object_location[i]==0 then
        print object_str+","
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
    $response_message="HOW?"
    return
  end
  if $H==4177 || $H==5177 then
    $B=16
    fill
    return
  end
  if $B==38 then
    $response_message="TOO HEAVY!"
    return
  end
  if $B==4 && $F[43]==0 then
    $response_message="IT IS FIRMLY NAILED ON!"
    return
  end
  carried_object_count=0
  for i in 1..(marked_objects.size-1)
    if $object_location[i]==0 then
      carried_object_count=carried_object_count+1
    end
  end
  if carried_object_count>13 then
    $response_message="YOU CANNOT CARRY ANYMORE"
    return
  end
  if $B>marked_objects.size then
    $response_message="YOU CANNOT GET THE "+$Tstr
    return
  end
  if $B==0 then
    return
  end
  if $object_location[$B]!=$room then
    $response_message="IT IS NOT HERE"
  end
  if $F[$B]==1 then
    $response_message="WHAT "+$Tstr+"?"
  end
  if $object_location[$B]==0 then
    $response_message="YOU ALREADY HAVE IT"
  end
  if $object_location[$B]==$room && $F[$B]==0 then
    $object_location[$B]=0
    $response_message="YOU HAVE THE "+$Tstr
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
  $response_message="YOU SEE WHAT YOU MIGHT EXPECT!"
  if $B>0 then
    $response_message="NOTHING SPECIAL"
  end
  if $B==46 || $B==88 then
    enter
  end
  if $H==8076 then
    $response_message="IT IS EMPTY"
  end
  if $H==8080 then
    $response_message="AHA!"
    $F[1]=0
  end
  if $H==7029 then
    $response_message="OK"
    $F[2]=0
  end
  if $B==20 then
    $response_message=decode("NBUDIFT JO QPDLFU")
    $object_location[26]=0
  end
  if $H==1648 then
    $response_message="THERE ARE SOME LETTERS '"+$tunnel_maze_directions[2]+"'"
  end
  if $H==7432 then
    $response_message=decode("UIFZ BSF BQQMF USFFT")
    $F[5]=0
  end
  if $H==2134 || $H==2187 then
    $response_message="OK"
    $F[16]=0
  end
  if $B==35 then
    $response_message="IT IS FISHY!"
    $F[17]=0
  end
  if $H==3438 then
    $response_message="OK"
    $F[22]=0
  end
  if $H==242 then
    $response_message="A FADED INSCRIPTION"
  end
  if ($H==1443 || $H==1485) && $F[33]==0 then
    $response_message=decode("B HMJNNFSJOH GSPN UIF EFQUIT")
  end
  if ($H==1443 || $H==1485) && $F[33]==1 then
    $response_message="SOMETHING HERE..."
    $F[12]=0
  end
  if $H==2479 || $H==2444 then
    $response_message="THERE IS A HANDLE"
  end
  if $B==9 then
    $response_message=decode("UIF MBCFM SFBET 'QPJTPO'")
  end
  if $H==4055 then
    examine_sub
  end
  if $H==2969 && $F[49]==1 then
    $response_message="VERY UGLY!"
  end
  if $H==7158 || $H==7186 then
    $response_message="THERE ARE LOOSE BRICKS"
  end
  if $room==49 then
    $response_message="VERY INTERESTING!"
  end
  if $B==52 || $B==82 || $B==81 then
    $response_message="INTERESTING!"
  end
  if $H==6978 then
    $response_message="THERE IS A WOODEN DOOR"
  end
  if $H==6970 then
    $response_message="YOU FOUND SOMETHING"
    $F[4]=0
  end
  if $H==2066 then
    $response_message="A LARGE CUPBOARD IN THE CORNER"
  end
  if $H==6865 || $H==6853 then
    $response_message="THERE ARE NINE STONES"
  end
  if $H==248 then
    $response_message=decode("A GBEFE XPSE - 'N S I T'")
  end
end

def give
  if $room==64 then
    $response_message="HE GIVES IT BACK!"
  end
  if $H==6425 then
    give_ring
  end
  if $room==75 || $room==76 then
    $response_message="HE DOES NOT WANT IT"
  end
  if $B==62 && $F[44]==0 then
    $response_message="YOU HAVE RUN OUT!"
  end
  if ($H==7562 || $H==7662) && $F[44]>0 && $object_location[1]==0 then
    $response_message="HE TAKES IT"
    $F[64]=1
  end
  if $F[64]==1 then
    $F[44]=$F[44]-1
  end
  if $B==1 then
    $response_message="HE TAKES THEM ALL!"
    $object_location[1]=81
    $F[64]=1
    $F[44]=0
  end
  if $H==2228 && $object_location[5]==81 then
    $response_message=words(0)+"NORTH"
    $object_location[28]=81
    $room=12
  end
  if ($H==2228 && $object_location[5]==81) || $H==225 then
    $response_message=words(0)+"NORTH"
    $room=12
  end
  if ($H==1228 && $object_location[5]==81) || $H==125 then
    $response_message=words(0)+"SOUTH"
    $room=12
  end
  if $room==7 || $room==33 then
    $response_message="HE EATS IT!"
    $object_location[$B]=81
  end
  if $H==711 then
    $F[46]=1
    $response_message="HE IS DISTRACTED"
  end
  if $H==385 || $H==3824 then
    $response_message="THEY SCURRY AWAY"
    $object_location[$B]=81
    $F[65]=1
  end
end

def say
  $response_message="YOU SAID IT"
  if $B==84 then
    $response_message="YOU MUST SAY THEM ONE BY ONE!"
    return
  end
  if $room!=47 || $B<71 || $B>75 || $object_location[27]!=0 then
    return
  end
  if $B==71 && $F[60]==0 then
    $response_message=words(7)
    $F[60]=1
    return
  end
  if $B==72 && $F[60]==1 && $F[61]==0 then
    $response_message=words(8)
    $F[61]=1
    return
  end
  if $B==($F[52]+73) && $F[60]==1 && $F[61]==1 then
    $F[62]=1
    return
  end
  $response_message="THE WRONG SACRED WORD!"
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
    $response_message=decode("ZPV BSF JOWJTJCMF")
    $F[55]=0
  end
  if $B==20 then
    $F[51]=1
    $response_message=decode("ZPV BSF EJTHVJTFE")
    $F[55]=0
  end
end

def tie
  if $B==2 || $B==14 then
    $response_message="NOTHING TO TIE IT TO!"
  end
  if $H==7214 then
    $response_message="IT IS TIED"
    $object_location[14]=72
    $F[53]=1
  end
  if $H==722 then
    $response_message="OK"
    $F[40]=1
    $object_location[2]=72
  end
end

def climb
  if $H==1547 && $F[38]==1 then
    $response_message="ALL RIGHT"
    $room=16
  end
  if $B==14 || $B==2 then
    $response_message="NOT ATTACHED TO ANYTHING!"
  end
  if $H==5414 && $object_location[14]==54 then
    $response_message="YOU ARE AT THE TOP"
  end
  if $H==7214 && $F[53]==1 then
    $response_message="GOING DOWN"
    $room=71
  end
  if $H==722 && $F[40]==1 then
    $room=71
    $response_message="IT IS TORN"
    $object_location[2]=81
    $F[40]=0
  end
  if $H==7114 && $F[53]==1 then
    $object_location[14]=71
    $F[53]=0
    $response_message="IT FALLS DOWN-BUMP!"
  end
end

def use
  if $H==522 then
    $response_message="OK"
    $F[30]=1
  end
  if $B==1 || $B==62 || $B==5 || $B==28 || $B==11 || $B==24 then
    give
  end
  if $H==416 then
    $response_message=decode("ZPV IBWF LFQU BGMPBU")
    $F[31]=1
    return
  end
  if $H==4116 then
    $response_message="IT IS NOT BIG ENOUGH!"
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
    $response_message="OK"
  end
  if $H==6030 then
    $response_message="OK"
    $F[3]=0
  end
  if $H==2444 || $H==1870 then
    $response_message="YOU ARE NOT STRONG ENOUGH"
  end
  if $H==3756 then
    $response_message="A PASSAGE!"
    $exits[37]="EW"
  end
  if $H==5960 then
    open_sub
  end
  if $H==6970 then
    $response_message="IT FALLS OFF ITS HINGES"
  end
  if $H==4870 then
    $response_message="IT IS LOCKED"
  end
end

def burn
  if $B>marked_objects.size then
    $response_message="IT DOES NOT BURN"
  end
  if $B==26 then
    $response_message="YOU LIT THEM"
  end
  if $H==3826 then
    $response_message="NOT BRIGHT ENOUGH"
  end
  if ($B==23 || $H==6970) && $object_location[26]!=0 then
    $response_message=decode("OP NBUDIFT")
  end
  if $B==23 && $object_location[26]==0 then
    $response_message="A BRIGHT "+$Vstr
    $F[50]=1
  end
  if $H==6970 && $object_location[26]==0 then
    $F[43]=1
    $response_message="IT HAS TURNED TO ASHES"
  end
end

def fill
  if ($B==16 || $B==6) && ($room==41 || $room==51) then
    $response_message="YOU CAPSIZED!"
    $F[56]=1
  end
  if $H==6516 && $object_location[16]==0 then
    $response_message="IT IS NOW FULL"
    $F[34]=1
  end
  if $H==656 then
    $response_message="IT LEAKS OUT!"
  end
end

def plant
  if $B!=22 || $room!=15 then
    $response_message="DOES NOT GROW!"
    return
  end
  $response_message="OK"
  $F[34]=1
end

def water
  if $B==22 && $F[37]==1 && $F[34]==1 then
    $response_message=decode(words(2))
    $F[38]=1
  end
end

def swing
  if $B==7 || $B==18 then
    $response_message="THWACK!"
  end
  if $H==5818 then
    $response_message="YOU CLEARED THE WEBS"
    $F[66]=1
  end
  if $H==187 then
    $response_message="THE DOOR BROKE!"
    $exits[18]="NS"
    $exits[28]="NS"
  end
  if $H==717 then
    $response_message="YOU BROKE THROUGH"
    $exits[71]="N"
  end
end

def empty
  if $B==16 then
    $B=22
    water
  end
  if $H==499 then
    $response_message="WHERE?"
  end
end

def enter
  if $H==4337 then
    go(2)
    return
  end
  if $room==36 then
    $response_message="YOU FOUND SOMETHING"
    $F[13]=0
  end
end

def cross
  if $room==76 then
    go(4)
    return
  end
  if $room==75 then
    go(2)
  end
end

def remove
  if ($B==3 && $F[29]==1) then
    $response_message="TAKEN OFF"
    $F[29]=0
  end
  if ($B==20 && $F[51]==1) then
    $response_message="OK"
    $F[51]=0
  end
  if $B==36 || $B==50 then
    move
  end
end

def feed
  if $H==3859 || $H==3339 || $H==1241 || $H==2241 || $H==751 then
    $response_message="WITH WHAT?"
  end
end

def turn
  if $H==2340 then
    $response_message="IT GOES ROUND"
  end
  if $H==2445 then
    $response_message=decode("UIF HBUFT PQFQ, UIF QPPM FNQUJFT")
    $F[33]=1
  end
end

def dive
  if $room==14 || $room==51 then
    $response_message="YOU HAVE DROWNED"
    $F[56]=1
  end
end

def bail
  $response_message="HOW?"
end

def drop
  if $B==0 || $B>marked_objects.size then
    return
  end
  $object_location[$B]=$room
  $response_message="DONE"
  if $H==418 || $H==518 then
    $response_message="YOU DROWNED!"
    $F[56]=1
  end
  if $B==8 && $F[30]==1 then
    $object_location[2]=$room
  end
  if $B==16 && $F[34]==1 then
    $response_message="YOU LOST THE WATER!"
    $F[34]=0
  end
  if $B==2 && $F[30]==1 then
    $F[30]=0
  end
end

def insert
  if $B==62 && $F[44]==0 then
    $response_message="YOU DO NOT HAVE ANY"
  end
  if $H==5762 && $object_location[1]==0 && $F[44]>0 then
    insert_sub
  end
end

def throw
  if $B==0 || $B>marked_objects.size then
    return
  end
  $response_message="DID NOT GO FAR!"
  $object_location[$B]=$room
  if $H==3317 then
    $response_message=decode("ZPV DBVHIU UIF CPBS")
    $F[32]=1
  end
end

def make
  if $B==10 then
    $response_message=decode("B OJDF UVOF")
  end
  if $H==5233 then
    $response_message="WHAT WITH?"
  end
  if $B==83 then
    $response_message="HOW, O MUSICAL ONE?"
  end
  if $H==5610 then
    $F[35]=1
    $response_message=words(1)+" IS FREE!"
    $exits[56]="NS"
  end
end

def eat
  if $B==0 || $B>marked_objects.size then
    return
  end
  if $B==5 || $B==24 then
    $response_message="YUM YUM!"
    $object_location[$B]=81
  end
end

def move
  if $room==4 && $B==50 then
    $F[45]=1
    $response_message="YOU REVEALED A STEEP PASSAGE"
  end
  if $room==3 && $B==50 then
    $response_message="YOU CANNOT MOVE RUBBLE FROM HERE"
  end
  if $H==7136 then
    $response_message="THEY ARE WEDGED IN!"
  end
end

def into
  if ($B==67 || $B==68) && $object_location[9]==0 && $room==49 then
    $response_message="OK"
    $F[47]=1
  end
end

def ring
  if $room!=27 || $B!=63 then
    return
  end
  begin puts
    puts "HOW MANY TIMES?"
    number_of_rings=mINPUT
    if number_of_rings==0 then
      puts "A NUMBER"
    end
  end until number_of_rings>0
  if number_of_rings==$F[42] then
    $response_message="A ROCK DOOR OPENS"
    $exits[27]="EW"
    return
  end
  $response_message=decode("ZPV IBWF NJTUSFBUFE UIF CFMM!")
  $F[56]=1
end

def cut
  if $H==5861 then
    $H=5818
    swing
  end
end

def hold
  if ($H==4864 || $H==4819) && $object_location[19]==0 then
    $response_message=decode(words(6))
    $F[63]=1
  end
  if $B==27 then
    take
  end
end

def pay
  if $H==7549 || $H==7649 then
    $response_message="WHAT WITH?"
  end
  if $B==1 || $B==62 then
    give
  end
end

def unlock
  if $H==4870 && $object_location[21]==0 then
    $response_message="THE KEY TURNS!"
    $F[70]=1
  end
end

def break
  if $H==1870 then
    $response_message="HOW?"
  end
end

def reflect
  if $room==48 then
    $response_message="HOW?"
  end
end

def drink
  $response_message="ARE YOU THIRSTY?"
end

def give_ring
  $response_message="HE TAKES IT AND SAYS '"+STRstr($F[42])+" RINGS ARE NEEDED'"
  $object_location[25]=81
end

def insert_sub
  $F[44]=$F[44]-1
  $response_message="A NUMBER APPEARS - "+STRstr($F[41])
  if $F[44]==0 then
    $object_location[1]=81
  end
end

def open_sub
  puts
  $response_message=decode("XIBU JT UIF DPEF")
  puts $response_message
  cn=mINPUT
  $response_message="WRONG!"
  if cn==$F[41] then
    $response_message="IT OPENS"
    $F[21]=0
  end
end

def examine_sub
  tmp = $room
  $room=$F[$F[52]+57]
  desc = current_room_description
  $room = tmp
  $response_message=words(4)+RIGHTstr(desc,LEN(desc)-2)
end

def current_room_description
  rooms[$room-1]
end

def strip_leading(str)
  str[1..-1]
end

def pause
  puts "PRESS return TO CONTINUE"
  mINPUT
end

def prepositions
  [ nil, "IN", "NEAR", "BY", "ON", "", "AT" ]
end

def determiners
  [ nil, "A", "THE", "SOME", "AN", "", "A SMALL" ]
end

def words(i)
  [
    "HE LEADS YOU ",
    "THE GHOST OF THE GOBLIN GUARDIAN",
    "B MBSHF WJOF HSPXT JO TFDPOET!",
    "A GRARG PATROL APPROACHES",
    "MAGIC WORDS LIE AT THE CROSSROADS, THE FOUNTAIN AND THE ",
    "A PILE OF RUBBLE BLOCKS YOUR PATH",
    "XV SFGMFDUFE UIF XJABSET HMSBF! IF JT EFBE",
    "THE MOUNTAIN RUMBLES!",
    "TOWERS FALL DOWN!",
    "THE WIZARD HAS YOU IN HIS GLARE"
  ][i]
end

def setup
  $F=Array.new(70+1,0)
  $tunnel_maze_directions=Array.new(2+1,'')
  $cmd_list="NOOEOOSOOWOOUOODOOINVGETTAKEXAREAGIVSAYPICWEATIECLIRIGUSEOPE"
  $cmd_list=$cmd_list+"LIGFILPLAWATSWIEMPENTCROREMFEETURDIVBAILEATHRINSBLODROEATMOV"
  $cmd_list=$cmd_list+"INTRINCUTHOLBURPOISHOUNLWITDRICOUPAYMAKBRESTEGATREF"
  print_titles
  puts "DO YOU WANT TO"
  puts
  puts "   1. START A NEW GAME"
  puts "OR 2. CONTINUE A SAVED GAME"
  begin
    puts
    puts
    puts "TYPE IN EITHER 1 OR 2"
    selection=mINPUT.to_i
  end until !(selection!=1 && selection!=2)
  if selection==1 then
    new_game
  end
  if selection==2 then
    load_game
  end
end

def rooms
  [
    "11HALF-DUG GRAVE", "12GOBLIN GRAVEYARD",
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
    "31SILVER BELL IN THE ROCK", "12DUNGEONS OF THE PALACE",
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
    "11DAMP WELL BOTTOM", "32TOP OF A DEEP WELL",
    "31BURNT-OUT CAMPFIRE", "16ORCHARD",
    "62END OF A BRIDGE", "62END OF A BRIDGE",
    "61CROSSROADS", "41WINDING ROAD",
    "11VILLAGE OF RUSTIC HOUSES", "11WHITE COTTAGE"
  ]
end

def objects
  marked_objects.map{ |str| strip_leading(str)} + [
    "BED", "CUPBOARD", "BRIDGE", "TREES", "SAIL", "KILN",
    "KETCH", "BRICKS", "WINDMILL", "SACKS", "OGBAN'S BOAR", "WHEEL",
    "PONY", "GRAVESTONES", "POOL", "GATES", "HANDLE", "HUT", "VINE", "INSCRIPTIONS", "TROLL", "RUBBLE",
    "HOUND", "FOUNTAIN", "CIRCLE", "MOSAICS", "BOOKS", "CASKS", "WELL", "WALLS", "RATS", "SAFE",
    "COBWEBS", "COIN", "BELL", "UP SILVER PLATE", "STONES", "KITCHENS", "GOBLET", "WINE",
    "GRARGS", "DOOR", "AWAKE", "GUIDE", "PROTECT", "LEAD", "HELP", "CHEST", "WATER",
    "STABLES", "SLUICE GATES", "POT", "STATUE", "PINNACLE", "MUSIC", "MAGIC WORDS",
    "MISTY POOL", "WELL BOTTOM", "OLD KILN", "MOUNTAIN HUT"
  ]
end

def marked_objects
  [
    "3COINS", "1SHEET", "3BOOTS", "1HORSESHOE", "3APPLES", "1BUCKET", "4AXE", "1BOAT", "1PHIAL",
    "3REEDS", "1BONE", "1SHIELD", "3PLANKS", "1ROPE", "1RING", "1JUG", "1NET", "1SWORD",
    "1SILVER PLATE", "1UNIFORM", "1KEY", "3SEEDS", "1LAMP", "3BREAD", "1BROOCH", "3MATCHES",
    "2STONE OF DESTINY", "4APPLE"
  ]
end


def decode(coded_string)
  decoded_string=""
  for i in 1..LEN(coded_string)
    char=MIDstr(coded_string,i,1)
    if char<"A" then
      decoded_string=decoded_string+char
    else
      $object_location=char.ord-1
      if $object_location==64 then
        $object_location=90
      end
      decoded_string=decoded_string+CHRstr($object_location)
    end
  end
  return decoded_string
end

def tunnels(direction)
  $Jstr="SSSSSSSS"
  number_of_goes=0
  begin
    mp=direction/2
    print_titles
    puts "YOU ARE LOST IN THE"
    puts "      TUNNELS"
    puts "WHICH WAY? (N,S,W OR E)"
    if number_of_goes>15 then
      puts "(OR G TO GIVE UP!)"
    end
    puts
    way = mINPUT
    $Jstr=RIGHTstr($Jstr+RIGHTstr(way,1),8)
    if way=="G" then
      $F[56]=1
      return
    end
    if $Jstr!=$tunnel_maze_directions[mp] then
      number_of_goes=number_of_goes+1
    end
  end until !($Jstr!=$tunnel_maze_directions[mp])
end

def print_titles
  system('clear')
  puts
  puts TAB(LINE_LENGTH/2-9)+"MYSTERY OF SILVER"
  puts TAB(LINE_LENGTH/2-9)+"    MOUNTAIN"
  puts "======================================"
  puts
  puts
end

def load_initial_state
  $exits = [ nil,
    "E", "ESW", "WE", "EW", "EW", "ESW", "ESW", "ES", "EW", "SW",
    "S", "N", "ES", "SW", "S", "NW", "N", "N", "ES", "NSW",
    "NS", "E", "NSW", "N", "NES", "EW", "W", "S", "NS", "N",
    "NES", "W", "NS", "D", "NES", "SW", "E", "NW", "NS", "S",
    "NS", "E", "NSEW", "WU", "UD", "NS", "E", "SW", "NSE", "NW",
    "NE", "EW", "NSW", "E", "WN", "S", "E", "NEW", "NW", "S",
    "ES", "SW", "NES", "EW", "SW", "NE", "EW", "ESW", "SW", "ND",
    " ", "E", "NEW", "EW", "NEW", "EW", "EW", "NEW", "NEW", "WU"
  ]
  $object_location = [ nil,
    80, 70, 60, 69, 74, 72, 63, 52, 20, 11, 1, 14, 36, 54, 61, 21, 32, 10, 50,
    29, 59, 34, 13, 80, 30, 81, 47, 74
  ]
  $F[1..13] = [
    1, 2, 3, 4, 5, 9, 12, 13, 16, 17, 20, 21, 22
  ]
end

def setup_tunnle_maze
  $tunnel_maze_directions[1]=""
  for i in 1..8
    direction_forward=MIDstr($cmd_list,1+INT(RND(1)*4)*3,1)
    $tunnel_maze_directions[1]=$tunnel_maze_directions[1]+direction_forward
    if direction_forward=="N" then
      direction_back="S"
    end
    if direction_forward=="S" then
      direction_back="N"
    end
    if direction_forward=="E" then
      direction_back="W"
    end
    if direction_forward=="W" then
      direction_back="E"
    end
    $tunnel_maze_directions[2]=direction_back+$tunnel_maze_directions[2]
  end
end

def new_game
	load_initial_state
  $F[41]=INT(RND(1)*900)+100
  $F[42]=INT(RND(1)*3)+2
  $F[44]=4
  $F[57]=68
  $F[58]=54
  $F[59]=15
  $F[52]=INT(RND(1)*3)
  $room=77
  $response_message="GOOD LUCK ON YOUR QUEST!"
	setup_tunnle_maze
end

def load_game
  read_file(get_filename)
  $room=$F[69]
  $response_message="OK. CARRY ON"
end

def save_game
  $F[69]=$room
  write_file(get_filename)
  puts "BYE..."
  exit
end

def get_filename
  puts
  puts "PLEASE ENTER A FILE NAME"
  mINPUT
end

def read_file(filename)
  #READ DATA FILE
  puts "OK. SEARCHING FOR "+filename
  File.open(filename, 'r') do |x|
    puts "OK. LOADING"
    $exits, $object_location, $F, $tunnel_maze_directions = JSON.parse(x.gets)
  end
end

def write_file(filename)
  #SAVE DATA FILE
  File.open(filename, 'w') do |x|
    puts "OK. SAVING"
    x.puts [$exits, $object_location, $F, $tunnel_maze_directions].to_json
  end
end

def format_description
  ls=1
  lp=1
  for i in 1..LEN($Jstr)
    if MIDstr($Jstr,i,1)==" " && $LL>$line_length then
      puts MIDstr($Jstr,lp,ls-lp)
      $LL=i-ls
      lp=ls+1
    end
    if MIDstr($Jstr,i,1)==" " then
      ls=i
    end
    $LL=$LL+1
  end
  print MIDstr($Jstr,lp,LEN($Jstr)-lp)
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
