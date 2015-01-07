require 'json'

class MOSM

  LINE_LENGTH = 39

  def start
    setup
    while true
      catch(:redraw) do
        main
      end
    end
  end

  private
  def main
    print_titles
    preposition=prepositions[VAL(LEFTstr(current_room_description,1))]+" "+determiners[VAL(MIDstr(current_room_description,2,1))]+" "
    desc1 = game_state.response_message+". "+"YOU ARE "+preposition+RIGHTstr(current_room_description,LEN(current_room_description)-2)+" "
    desc2=""
    marked_objects.each_with_index do |object_str, i|
      i = i + 1
      determiner=determiners[VAL(LEFTstr(object_str,1))]
      object_str = strip_leading(object_str)
      if game_state.f[i]==0 && game_state.object_locations[i]==game_state.room then
        desc2=desc2+" "+determiner+" "+object_str+","
      end
    end
    if game_state.room==29 && game_state.f[48]==0 then
      desc2=desc2+" GRARGS FEASTING,"
    end
    if game_state.room==29 && game_state.f[48]==1 then
      desc2=desc2+" A SLEEPING GRARG,"
    end
    if game_state.room==12 || game_state.room==22 then
      desc2=desc2+" A PONY,"
    end
    if game_state.room==64 then
      desc2=desc2+" A HERMIT,"
    end
    if game_state.room==18 && game_state.exits[18]=="N" then
      desc2=desc2+" AN OAK DOOR,"
    end
    if game_state.room==59 && game_state.f[68]==1 then
      desc2=desc2+" OGBAN (DEAD),"
    end
    if desc2!="" then
      desc2=", YOU CAN SEE"+desc2
    end
    desc2=desc2+" AND YOU CAN GO "
    puts format_description(desc1.strip + desc2 + game_state.exits[game_state.room].split(//).join(','))
    puts
    game_state.response_message="PARDON?"
    puts "======================================"
    puts
    puts
    puts "WHAT WILL YOU DO NOW "
    cmd_string=mINPUT
    if cmd_string=="SAVE GAME" then
      game_state.save_game
    end
    game_state.command_id=0
    game_state.object=0
    game_state.command, game_state.object_name = cmd_string.split(' ', 2)
    game_state.command ||= ""
    game_state.object_name ||= ""
    while LEN(game_state.command)<3
      game_state.command=game_state.command+"O"
    end
    if game_state.command=="PLAY" then
      game_state.command="BLO"
    end
    cmd_start=LEFTstr(game_state.command,3)
    for i in 1..(cmd_list.length/3)
      if MIDstr(cmd_list,i*3-2,3)==cmd_start then
        game_state.command_id=i
        break
      end
    end
    game_state.f[36]=0
    begin
      objects.each_with_index do |object_str, i|
        i = i + 1
        if game_state.object_name==object_str then
          game_state.object=i
          break
        end
      end
      if game_state.object==0 && game_state.f[36]==0 && game_state.object_name!="" then
        game_state.object_name=game_state.object_name+"S"
        game_state.f[36]=1
      end
    end until !(game_state.object==0 && game_state.f[36]==0 && game_state.object_name!="")
    if game_state.command_id==0 then
      game_state.command_id=(cmd_list.length/3)+1
    end
    if game_state.object_name=="" then
      game_state.response_message="I NEED TWO WORDS"
    end
    if game_state.command_id>(cmd_list.length/3) then
      game_state.response_message="TRY SOMETHING ELSE"
    end
    if game_state.command_id>(cmd_list.length/3) && game_state.object==0 then
      game_state.response_message="YOU CANNOT "+cmd_string
    end
    if !(game_state.object>marked_objects.size || game_state.object==0) then
      if !(game_state.command_id==8 || game_state.command_id==9 || game_state.command_id==14 || game_state.command_id==17 || game_state.command_id==44 || game_state.command_id>54) then
        if game_state.command_id<(cmd_list.length/3) && game_state.object_locations[game_state.object]!=0 then
          game_state.response_message="YOU DO NOT HAVE THE "+game_state.object_name
          Kernel.throw :redraw
        end
      end
    end
    if game_state.room==56 && game_state.f[35]==0 && game_state.command_id!=37 && game_state.command_id!=53 then
      game_state.response_message=words(1)+" HAS GOT YOU!"
      Kernel.throw :redraw
    end
    if !(game_state.command_id==44 || game_state.command_id==47 || game_state.command_id==19 || game_state.command_id==57 || game_state.command_id==49) then
      if game_state.room==48 && game_state.f[63]==0 then
        game_state.response_message=words(9)
        Kernel.throw :redraw
      end
    end
    send([:go,:go,:go,:go,:go,:go,:inventory,:take,:take,:examine,:examine,:give,:say,
      :pick,:wear,:tie,:climb,:make,:use,:open,:burn,:fill,:plant,:water,:swing,:empty,
      :enter,:cross,:remove,:feed,:turn,:dive,:bail,:drop,:throw,:insert,:make,:drop,:eat,
      :move,:into,:ring,:cut,:hold,:burn,:into,:hold,:unlock,:use,:drink,:examine,:pay,
      :make,:break,:take,:take,:reflect,:noop][game_state.command_id-1])
    if !(game_state.f[62]==1) then
      if game_state.room==41 then
        game_state.f[67]==game_state.f[67]+1
        if game_state.f[67]==10 then
          game_state.f[56]=1
          game_state.response_message="YOU SANK!"
        end
      end
      if game_state.room==56 && game_state.f[35]==0 && game_state.object_locations[10]!=0 then
        game_state.response_message=words(1)+" GETS YOU!"
        game_state.f[56]=1
      end
      if game_state.f[56]==0 then
        Kernel.throw :redraw
      end
      print_titles
      puts game_state.response_message
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

  def go(direction=game_state.command_id)
    if direction==5 then
      direction=1
    end
    if direction==6 then
      direction=3
    end
    if !(!((game_state.room==75 && direction==2) || (game_state.room==76 && direction==4)) || game_state.f[64]==1) then
      game_state.response_message=decode("B USPMM TUPQT ZPV DSPTTJOH")
      return
    end
    if game_state.f[64]==1 then
      game_state.f[64]=0
    end
    if !(game_state.f[51]==1 || game_state.f[29]==1) then
      if game_state.f[55]==1 then
        game_state.f[56]=1
        game_state.response_message="GRARGS HAVE GOT YOU!"
        return
      end
      if game_state.room==29 && game_state.f[48]==0 then
        game_state.response_message="GRARGS WILL SEE YOU!"
        return
      end
      if game_state.room==73 || game_state.room==42 || game_state.room==9 || game_state.room==10 then
        game_state.response_message=words(3)
        game_state.f[55]=1
        return
      end
    end
    if game_state.object_locations[8]==0 && ((game_state.room==52 && direction==2) || (game_state.room==31 && direction!=3)) then
      game_state.response_message="THE BOAT IS TOO HEAVY"
      return
    end
    if game_state.object_locations[8]!=0 && ((game_state.room==52 && direction==4) || (game_state.room==31 && direction==3)) then
      game_state.response_message="YOU CANNOT SWIM"
      return
    end
    if game_state.room==52 && game_state.object_locations[8] && direction==4 && game_state.f[30]==0 then
      game_state.response_message="NO POWER!"
      return
    end
    if game_state.room==41 && direction==3 && game_state.f[31]==0 then
      game_state.response_message=decode("UIF CPBU JT TJOLJOH!")
      return
    end
    if game_state.room==33 && direction==1 && game_state.f[32]==0 then
      game_state.response_message="OGBAN'S BOAR BLOCK YOUR PATH"
      return
    end
    if ((game_state.room==3 && direction==2) || (game_state.room==4 && direction==4)) && game_state.f[45]==0 then
      game_state.response_message=words(5)
      return
    end
    if game_state.room==35 && game_state.object_locations[13]!=game_state.room then
      game_state.response_message="THE ICE IS BREAKING!"
      return
    end
    if game_state.room==5 && (direction==2 || direction==4) then
      tunnels(direction)
    end
    if game_state.room==4 && direction==4 then
      game_state.response_message="PASSAGE IS TOO STEEP"
      return
    end
    if game_state.room==7 && direction==2 && game_state.f[46]==0 then
      game_state.response_message="A HUGE HOUND BARS YOUR WAY"
      return
    end
    if (game_state.room==38 || game_state.room==37) && game_state.f[50]==0 then
      game_state.response_message=decode("JU JT UPP EBSL")
      return
    end
    if game_state.room==49 && direction==2 && game_state.f[54]==0 then
      game_state.response_message="MYSTERIOUS FORCES HOLD YOU BACK"
      return
    end
    if game_state.room==49 && direction==3 && game_state.f[68]==0 then
      game_state.response_message="YOU MEET OGBAN!!!"
      game_state.f[56]=1
      return
    end
    if game_state.room==38 && game_state.f[65]==0 then
      game_state.response_message="RATS NIBBLE YOUR ANKLES"
      return
    end
    if game_state.room==58 && (direction==1 || direction==4) && game_state.f[66]==0 then
      game_state.response_message="YOU GET CAUGHT IN THE WEBS!"
      return
    end
    if game_state.room==48 && direction==4 && game_state.f[70]==0 then
      game_state.response_message="THE DOOR DOES NOT OPEN"
      return
    end
    if game_state.room==40 && game_state.f[47]==1 then
      game_state.f[68]=1
    end
    if game_state.room==37 && direction==4 && game_state.exits[37]=="EW" then
      game_state.room=67
      game_state.response_message="THE PASSAGE WAS STEEP!"
      return
    end
    if game_state.room==29 && direction==3 then
      game_state.f[48]=1
      game_state.f[20]=0
    end
    if game_state.room==8 && direction==2 then
      game_state.f[46]=0
    end
    old_room = game_state.room
    exit_map = {
      'N' => 1,
      'U' => 1,
      'E' => 2,
      'S' => 3,
      'D' => 3,
      'W' => 4
    }
    game_state.exits[game_state.room].split(//).each do |exit_direction|
      game_state.room = game_state.room - 10 if exit_map[exit_direction] == direction && direction == 1
      game_state.room = game_state.room + 1  if exit_map[exit_direction] == direction && direction == 2
      game_state.room = game_state.room + 10 if exit_map[exit_direction] == direction && direction == 3
      game_state.room = game_state.room - 1  if exit_map[exit_direction] == direction && direction == 4
    end
    game_state.response_message="OK"
    if game_state.room==old_room then
      game_state.response_message="YOU CANNOT GO THAT WAY"
    end
    if ((old_room==75 && direction==2) || (old_room==76 && direction==4)) then
      game_state.response_message="OK. YOU CROSSED"
    end
    if game_state.f[29]==1 then
      game_state.f[39]=game_state.f[39]+1
    end
    if game_state.f[39]>5 && game_state.f[29]==1 then
      game_state.response_message=decode("CPPUT IBWF XPSO PVU")
      game_state.f[29]=0
      game_state.object_locations[3]=81
    end
  end

  def inventory
    game_state.response_message="OK"
    game_state.f[49]=0
    print "YOU HAVE "
    marked_objects.each_with_index do |object_str, i|
      i = i+1
      object_str = strip_leading(object_str)
      if i==1 && game_state.object_locations[1]==0 && game_state.f[44]==1 then
        object_str="COIN"
      end
      if !(i==marked_objects.size && game_state.object_locations[5]==0) then
        if game_state.object_locations[i]==0 then
          print object_str+","
          game_state.f[49]=1
        end
      end
    end
    if game_state.f[49]==0 then
      puts "NOTHING"
    end
    puts
    pause
  end

  def take
    if game_state.room_and_object==6577 then
      game_state.response_message="HOW?"
      return
    end
    if game_state.room_and_object==4177 || game_state.room_and_object==5177 then
      game_state.object=16
      fill
      return
    end
    if game_state.object==38 then
      game_state.response_message="TOO HEAVY!"
      return
    end
    if game_state.object==4 && game_state.f[43]==0 then
      game_state.response_message="IT IS FIRMLY NAILED ON!"
      return
    end
    carried_object_count=0
    for i in 1..(marked_objects.size-1)
      if game_state.object_locations[i]==0 then
        carried_object_count=carried_object_count+1
      end
    end
    if carried_object_count>13 then
      game_state.response_message="YOU CANNOT CARRY ANYMORE"
      return
    end
    if game_state.object>marked_objects.size then
      game_state.response_message="YOU CANNOT GET THE "+game_state.object_name
      return
    end
    if game_state.object==0 then
      return
    end
    if game_state.object_locations[game_state.object]!=game_state.room then
      game_state.response_message="IT IS NOT HERE"
    end
    if game_state.f[game_state.object]==1 then
      game_state.response_message="WHAT "+game_state.object_name+"?"
    end
    if game_state.object_locations[game_state.object]==0 then
      game_state.response_message="YOU ALREADY HAVE IT"
    end
    if game_state.object_locations[game_state.object]==game_state.room && game_state.f[game_state.object]==0 then
      game_state.object_locations[game_state.object]=0
      game_state.response_message="YOU HAVE THE "+game_state.object_name
    end
    if game_state.object==28 then
      game_state.object_locations[5]=81
    end
    if game_state.object==5 then
      game_state.object_locations[28]=0
    end
    if game_state.object_locations[4]==0 && game_state.object_locations[12]==0 && game_state.object_locations[15]==0 then
      game_state.f[54]=1
    end
    if game_state.object==8 && game_state.f[30]==1 then
      game_state.object_locations[2]=0
    end
    if game_state.object==2 then
      game_state.f[30]=0
    end
  end

  def examine
    game_state.response_message="YOU SEE WHAT YOU MIGHT EXPECT!"
    if game_state.object>0 then
      game_state.response_message="NOTHING SPECIAL"
    end
    if game_state.object==46 || game_state.object==88 then
      enter
    end
    if game_state.room_and_object==8076 then
      game_state.response_message="IT IS EMPTY"
    end
    if game_state.room_and_object==8080 then
      game_state.response_message="AHA!"
      game_state.f[1]=0
    end
    if game_state.room_and_object==7029 then
      game_state.response_message="OK"
      game_state.f[2]=0
    end
    if game_state.object==20 then
      game_state.response_message=decode("NBUDIFT JO QPDLFU")
      game_state.object_locations[26]=0
    end
    if game_state.room_and_object==1648 then
      game_state.response_message="THERE ARE SOME LETTERS '"+game_state.tunnel_maze_directions[2]+"'"
    end
    if game_state.room_and_object==7432 then
      game_state.response_message=decode("UIFZ BSF BQQMF USFFT")
      game_state.f[5]=0
    end
    if game_state.room_and_object==2134 || game_state.room_and_object==2187 then
      game_state.response_message="OK"
      game_state.f[16]=0
    end
    if game_state.object==35 then
      game_state.response_message="IT IS FISHY!"
      game_state.f[17]=0
    end
    if game_state.room_and_object==3438 then
      game_state.response_message="OK"
      game_state.f[22]=0
    end
    if game_state.room_and_object==242 then
      game_state.response_message="A FADED INSCRIPTION"
    end
    if (game_state.room_and_object==1443 || game_state.room_and_object==1485) && game_state.f[33]==0 then
      game_state.response_message=decode("B HMJNNFSJOH GSPN UIF EFQUIT")
    end
    if (game_state.room_and_object==1443 || game_state.room_and_object==1485) && game_state.f[33]==1 then
      game_state.response_message="SOMETHING HERE..."
      game_state.f[12]=0
    end
    if game_state.room_and_object==2479 || game_state.room_and_object==2444 then
      game_state.response_message="THERE IS A HANDLE"
    end
    if game_state.object==9 then
      game_state.response_message=decode("UIF MBCFM SFBET 'QPJTPO'")
    end
    if game_state.room_and_object==4055 then
      examine_sub
    end
    if game_state.room_and_object==2969 && game_state.f[49]==1 then
      game_state.response_message="VERY UGLY!"
    end
    if game_state.room_and_object==7158 || game_state.room_and_object==7186 then
      game_state.response_message="THERE ARE LOOSE BRICKS"
    end
    if game_state.room==49 then
      game_state.response_message="VERY INTERESTING!"
    end
    if game_state.object==52 || game_state.object==82 || game_state.object==81 then
      game_state.response_message="INTERESTING!"
    end
    if game_state.room_and_object==6978 then
      game_state.response_message="THERE IS A WOODEN DOOR"
    end
    if game_state.room_and_object==6970 then
      game_state.response_message="YOU FOUND SOMETHING"
      game_state.f[4]=0
    end
    if game_state.room_and_object==2066 then
      game_state.response_message="A LARGE CUPBOARD IN THE CORNER"
    end
    if game_state.room_and_object==6865 || game_state.room_and_object==6853 then
      game_state.response_message="THERE ARE NINE STONES"
    end
    if game_state.room_and_object==248 then
      game_state.response_message=decode("A GBEFE XPSE - 'N S I T'")
    end
  end

  def give
    if game_state.room==64 then
      game_state.response_message="HE GIVES IT BACK!"
    end
    if game_state.room_and_object==6425 then
      give_ring
    end
    if game_state.room==75 || game_state.room==76 then
      game_state.response_message="HE DOES NOT WANT IT"
    end
    if game_state.object==62 && game_state.f[44]==0 then
      game_state.response_message="YOU HAVE RUN OUT!"
    end
    if (game_state.room_and_object==7562 || game_state.room_and_object==7662) && game_state.f[44]>0 && game_state.object_locations[1]==0 then
      game_state.response_message="HE TAKES IT"
      game_state.f[64]=1
    end
    if game_state.f[64]==1 then
      game_state.f[44]=game_state.f[44]-1
    end
    if game_state.object==1 then
      game_state.response_message="HE TAKES THEM ALL!"
      game_state.object_locations[1]=81
      game_state.f[64]=1
      game_state.f[44]=0
    end
    if game_state.room_and_object==2228 && game_state.object_locations[5]==81 then
      game_state.response_message=words(0)+"NORTH"
      game_state.object_locations[28]=81
      game_state.room=12
    end
    if (game_state.room_and_object==2228 && game_state.object_locations[5]==81) || game_state.room_and_object==225 then
      game_state.response_message=words(0)+"NORTH"
      game_state.room=12
    end
    if (game_state.room_and_object==1228 && game_state.object_locations[5]==81) || game_state.room_and_object==125 then
      game_state.response_message=words(0)+"SOUTH"
      game_state.room=12
    end
    if game_state.room==7 || game_state.room==33 then
      game_state.response_message="HE EATS IT!"
      game_state.object_locations[game_state.object]=81
    end
    if game_state.room_and_object==711 then
      game_state.f[46]=1
      game_state.response_message="HE IS DISTRACTED"
    end
    if game_state.room_and_object==385 || game_state.room_and_object==3824 then
      game_state.response_message="THEY SCURRY AWAY"
      game_state.object_locations[game_state.object]=81
      game_state.f[65]=1
    end
  end

  def say
    game_state.response_message="YOU SAID IT"
    if game_state.object==84 then
      game_state.response_message="YOU MUST SAY THEM ONE BY ONE!"
      return
    end
    if game_state.room!=47 || game_state.object<71 || game_state.object>75 || game_state.object_locations[27]!=0 then
      return
    end
    if game_state.object==71 && game_state.f[60]==0 then
      game_state.response_message=words(7)
      game_state.f[60]=1
      return
    end
    if game_state.object==72 && game_state.f[60]==1 && game_state.f[61]==0 then
      game_state.response_message=words(8)
      game_state.f[61]=1
      return
    end
    if game_state.object==(game_state.f[52]+73) && game_state.f[60]==1 && game_state.f[61]==1 then
      game_state.f[62]=1
      return
    end
    game_state.response_message="THE WRONG SACRED WORD!"
    game_state.f[56]=1
  end

  def pick
    if game_state.object==5 || game_state.object==10 then
      take
    end
  end

  def wear
    if game_state.object==3 then
      game_state.f[29]=1
      game_state.response_message=decode("ZPV BSF JOWJTJCMF")
      game_state.f[55]=0
    end
    if game_state.object==20 then
      game_state.f[51]=1
      game_state.response_message=decode("ZPV BSF EJTHVJTFE")
      game_state.f[55]=0
    end
  end

  def tie
    if game_state.object==2 || game_state.object==14 then
      game_state.response_message="NOTHING TO TIE IT TO!"
    end
    if game_state.room_and_object==7214 then
      game_state.response_message="IT IS TIED"
      game_state.object_locations[14]=72
      game_state.f[53]=1
    end
    if game_state.room_and_object==722 then
      game_state.response_message="OK"
      game_state.f[40]=1
      game_state.object_locations[2]=72
    end
  end

  def climb
    if game_state.room_and_object==1547 && game_state.f[38]==1 then
      game_state.response_message="ALL RIGHT"
      game_state.room=16
    end
    if game_state.object==14 || game_state.object==2 then
      game_state.response_message="NOT ATTACHED TO ANYTHING!"
    end
    if game_state.room_and_object==5414 && game_state.object_locations[14]==54 then
      game_state.response_message="YOU ARE AT THE TOP"
    end
    if game_state.room_and_object==7214 && game_state.f[53]==1 then
      game_state.response_message="GOING DOWN"
      game_state.room=71
    end
    if game_state.room_and_object==722 && game_state.f[40]==1 then
      game_state.room=71
      game_state.response_message="IT IS TORN"
      game_state.object_locations[2]=81
      game_state.f[40]=0
    end
    if game_state.room_and_object==7114 && game_state.f[53]==1 then
      game_state.object_locations[14]=71
      game_state.f[53]=0
      game_state.response_message="IT FALLS DOWN-BUMP!"
    end
  end

  def use
    if game_state.room_and_object==522 then
      game_state.response_message="OK"
      game_state.f[30]=1
    end
    if game_state.object==1 || game_state.object==62 || game_state.object==5 || game_state.object==28 || game_state.object==11 || game_state.object==24 then
      give
    end
    if game_state.room_and_object==416 then
      game_state.response_message=decode("ZPV IBWF LFQU BGMPBU")
      game_state.f[31]=1
      return
    end
    if game_state.room_and_object==4116 then
      game_state.response_message="IT IS NOT BIG ENOUGH!"
      return
    end
    if game_state.object==18 || game_state.object==7 then
      swing
    end
    if game_state.object==13 then
      drop
    end
    if game_state.object==19 then
      hold
    end
    if game_state.object==10 then
      make
    end
    if game_state.object==16 || game_state.object==6 then
      fill
    end
  end

  def open
    if game_state.object==76 || game_state.object==38 then
      examine
    end
    if game_state.room_and_object==2030 then
      game_state.f[9]=0
      game_state.response_message="OK"
    end
    if game_state.room_and_object==6030 then
      game_state.response_message="OK"
      game_state.f[3]=0
    end
    if game_state.room_and_object==2444 || game_state.room_and_object==1870 then
      game_state.response_message="YOU ARE NOT STRONG ENOUGH"
    end
    if game_state.room_and_object==3756 then
      game_state.response_message="A PASSAGE!"
      game_state.exits[37]="EW"
    end
    if game_state.room_and_object==5960 then
      open_sub
    end
    if game_state.room_and_object==6970 then
      game_state.response_message="IT FALLS OFF ITS HINGES"
    end
    if game_state.room_and_object==4870 then
      game_state.response_message="IT IS LOCKED"
    end
  end

  def burn
    if game_state.object>marked_objects.size then
      game_state.response_message="IT DOES NOT BURN"
    end
    if game_state.object==26 then
      game_state.response_message="YOU LIT THEM"
    end
    if game_state.room_and_object==3826 then
      game_state.response_message="NOT BRIGHT ENOUGH"
    end
    if (game_state.object==23 || game_state.room_and_object==6970) && game_state.object_locations[26]!=0 then
      game_state.response_message=decode("OP NBUDIFT")
    end
    if game_state.object==23 && game_state.object_locations[26]==0 then
      game_state.response_message="A BRIGHT "+game_state.command
      game_state.f[50]=1
    end
    if game_state.room_and_object==6970 && game_state.object_locations[26]==0 then
      game_state.f[43]=1
      game_state.response_message="IT HAS TURNED TO ASHES"
    end
  end

  def fill
    if (game_state.object==16 || game_state.object==6) && (game_state.room==41 || game_state.room==51) then
      game_state.response_message="YOU CAPSIZED!"
      game_state.f[56]=1
    end
    if game_state.room_and_object==6516 && game_state.object_locations[16]==0 then
      game_state.response_message="IT IS NOW FULL"
      game_state.f[34]=1
    end
    if game_state.room_and_object==656 then
      game_state.response_message="IT LEAKS OUT!"
    end
  end

  def plant
    if game_state.object!=22 || game_state.room!=15 then
      game_state.response_message="DOES NOT GROW!"
      return
    end
    game_state.response_message="OK"
    game_state.f[34]=1
  end

  def water
    if game_state.object==22 && game_state.f[37]==1 && game_state.f[34]==1 then
      game_state.response_message=decode(words(2))
      game_state.f[38]=1
    end
  end

  def swing
    if game_state.object==7 || game_state.object==18 then
      game_state.response_message="THWACK!"
    end
    if game_state.room_and_object==5818 then
      game_state.response_message="YOU CLEARED THE WEBS"
      game_state.f[66]=1
    end
    if game_state.room_and_object==187 then
      game_state.response_message="THE DOOR BROKE!"
      game_state.exits[18]="NS"
      game_state.exits[28]="NS"
    end
    if game_state.room_and_object==717 then
      game_state.response_message="YOU BROKE THROUGH"
      game_state.exits[71]="N"
    end
  end

  def empty
    if game_state.object==16 then
      game_state.object=22
      water
    end
    if game_state.room_and_object==499 then
      game_state.response_message="WHERE?"
    end
  end

  def enter
    if game_state.room_and_object==4337 then
      go(2)
      return
    end
    if game_state.room==36 then
      game_state.response_message="YOU FOUND SOMETHING"
      game_state.f[13]=0
    end
  end

  def cross
    if game_state.room==76 then
      go(4)
      return
    end
    if game_state.room==75 then
      go(2)
    end
  end

  def remove
    if (game_state.object==3 && game_state.f[29]==1) then
      game_state.response_message="TAKEN OFF"
      game_state.f[29]=0
    end
    if (game_state.object==20 && game_state.f[51]==1) then
      game_state.response_message="OK"
      game_state.f[51]=0
    end
    if game_state.object==36 || game_state.object==50 then
      move
    end
  end

  def feed
    if game_state.room_and_object==3859 || game_state.room_and_object==3339 || game_state.room_and_object==1241 || game_state.room_and_object==2241 || game_state.room_and_object==751 then
      game_state.response_message="WITH WHAT?"
    end
  end

  def turn
    if game_state.room_and_object==2340 then
      game_state.response_message="IT GOES ROUND"
    end
    if game_state.room_and_object==2445 then
      game_state.response_message=decode("UIF HBUFT PQFQ, UIF QPPM FNQUJFT")
      game_state.f[33]=1
    end
  end

  def dive
    if game_state.room==14 || game_state.room==51 then
      game_state.response_message="YOU HAVE DROWNED"
      game_state.f[56]=1
    end
  end

  def bail
    game_state.response_message="HOW?"
  end

  def drop
    if game_state.object==0 || game_state.object>marked_objects.size then
      return
    end
    game_state.object_locations[game_state.object]=game_state.room
    game_state.response_message="DONE"
    if game_state.room_and_object==418 || game_state.room_and_object==518 then
      game_state.response_message="YOU DROWNED!"
      game_state.f[56]=1
    end
    if game_state.object==8 && game_state.f[30]==1 then
      game_state.object_locations[2]=game_state.room
    end
    if game_state.object==16 && game_state.f[34]==1 then
      game_state.response_message="YOU LOST THE WATER!"
      game_state.f[34]=0
    end
    if game_state.object==2 && game_state.f[30]==1 then
      game_state.f[30]=0
    end
  end

  def insert
    if game_state.object==62 && game_state.f[44]==0 then
      game_state.response_message="YOU DO NOT HAVE ANY"
    end
    if game_state.room_and_object==5762 && game_state.object_locations[1]==0 && game_state.f[44]>0 then
      insert_sub
    end
  end

  def throw
    if game_state.object==0 || game_state.object>marked_objects.size then
      return
    end
    game_state.response_message="DID NOT GO FAR!"
    game_state.object_locations[game_state.object]=game_state.room
    if game_state.room_and_object==3317 then
      game_state.response_message=decode("ZPV DBVHIU UIF CPBS")
      game_state.f[32]=1
    end
  end

  def make
    if game_state.object==10 then
      game_state.response_message=decode("B OJDF UVOF")
    end
    if game_state.room_and_object==5233 then
      game_state.response_message="WHAT WITH?"
    end
    if game_state.object==83 then
      game_state.response_message="HOW, O MUSICAL ONE?"
    end
    if game_state.room_and_object==5610 then
      game_state.f[35]=1
      game_state.response_message=words(1)+" IS FREE!"
      game_state.exits[56]="NS"
    end
  end

  def eat
    if game_state.object==0 || game_state.object>marked_objects.size then
      return
    end
    if game_state.object==5 || game_state.object==24 then
      game_state.response_message="YUM YUM!"
      game_state.object_locations[game_state.object]=81
    end
  end

  def move
    if game_state.room==4 && game_state.object==50 then
      game_state.f[45]=1
      game_state.response_message="YOU REVEALED A STEEP PASSAGE"
    end
    if game_state.room==3 && game_state.object==50 then
      game_state.response_message="YOU CANNOT MOVE RUBBLE FROM HERE"
    end
    if game_state.room_and_object==7136 then
      game_state.response_message="THEY ARE WEDGED IN!"
    end
  end

  def into
    if (game_state.object==67 || game_state.object==68) && game_state.object_locations[9]==0 && game_state.room==49 then
      game_state.response_message="OK"
      game_state.f[47]=1
    end
  end

  def ring
    if game_state.room!=27 || game_state.object!=63 then
      return
    end
    begin puts
      puts "HOW MANY TIMES?"
      number_of_rings=mINPUT
      if number_of_rings==0 then
        puts "A NUMBER"
      end
    end until number_of_rings>0
    if number_of_rings==game_state.f[42] then
      game_state.response_message="A ROCK DOOR OPENS"
      game_state.exits[27]="EW"
      return
    end
    game_state.response_message=decode("ZPV IBWF NJTUSFBUFE UIF CFMM!")
    game_state.f[56]=1
  end

  def cut
    if game_state.room_and_object==5861 then
      game_state.object=18
      swing
    end
  end

  def hold
    if (game_state.room_and_object==4864 || game_state.room_and_object==4819) && game_state.object_locations[19]==0 then
      game_state.response_message=decode(words(6))
      game_state.f[63]=1
    end
    if game_state.object==27 then
      take
    end
  end

  def pay
    if game_state.room_and_object==7549 || game_state.room_and_object==7649 then
      game_state.response_message="WHAT WITH?"
    end
    if game_state.object==1 || game_state.object==62 then
      give
    end
  end

  def unlock
    if game_state.room_and_object==4870 && game_state.object_locations[21]==0 then
      game_state.response_message="THE KEY TURNS!"
      game_state.f[70]=1
    end
  end

  def break
    if game_state.room_and_object==1870 then
      game_state.response_message="HOW?"
    end
  end

  def reflect
    if game_state.room==48 then
      game_state.response_message="HOW?"
    end
  end

  def drink
    game_state.response_message="ARE YOU THIRSTY?"
  end

  def give_ring
    game_state.response_message="HE TAKES IT AND SAYS '"+STRstr(game_state.f[42])+" RINGS ARE NEEDED'"
    game_state.object_locations[25]=81
  end

  def insert_sub
    game_state.f[44]=game_state.f[44]-1
    game_state.response_message="A NUMBER APPEARS - "+STRstr(game_state.f[41])
    if game_state.f[44]==0 then
      game_state.object_locations[1]=81
    end
  end

  def open_sub
    puts
    game_state.response_message=decode("XIBU JT UIF DPEF")
    puts game_state.response_message
    cn=mINPUT
    game_state.response_message="WRONG!"
    if cn==game_state.f[41] then
      game_state.response_message="IT OPENS"
      game_state.f[21]=0
    end
  end

  def examine_sub
    tmp = game_state.room
    game_state.room=game_state.f[game_state.f[52]+57]
    desc = current_room_description
    game_state.room = tmp
    game_state.response_message=words(4)+RIGHTstr(desc,LEN(desc)-2)
  end

  def current_room_description
    rooms[game_state.room-1]
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

  def cmd_list
    "NOOEOOSOOWOOUOODOOINVGETTAKEXAREAGIVSAYPICWEATIECLIRIGUSEOPE" +
    "LIGFILPLAWATSWIEMPENTCROREMFEETURDIVBAILEATHRINSBLODROEATMOV" +
    "INTRINCUTHOLBURPOISHOUNLWITDRICOUPAYMAKBRESTEGATREF"
  end

  def setup
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
      game_state.new_game
    end
    if selection==2 then
      game_state.load_game
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
        game_state.object_locations=char.ord-1
        if game_state.object_locations==64 then
          game_state.object_locations=90
        end
        decoded_string=decoded_string+CHRstr(game_state.object_locations)
      end
    end
    return decoded_string
  end

  def tunnels(direction)
    directions="SSSSSSSS"
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
      directions=RIGHTstr(directions+RIGHTstr(way,1),8)
      if way=="G" then
        game_state.f[56]=1
        return
      end
      if directions!=game_state.tunnel_maze_directions[mp] then
        number_of_goes=number_of_goes+1
      end
    end until !(directions!=game_state.tunnel_maze_directions[mp])
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

  def format_description(desc)
    desc.split(' ').inject(['']) do |lines, word|
      lines << '' if lines.last.length >= LINE_LENGTH
      lines.last << ' ' + word
      lines
    end.map(&:strip)
  end

  def noop
  end

  def game_state
    @state ||= GameState.new
  end

end

class GameState

  attr_accessor :room, :object, :object_name, :response_message, :f, :exits, :object_locations,
                          :tunnel_maze_directions, :command, :command_id

  def initialize
    self.f = Array.new(70+1,0)
    self.tunnel_maze_directions = Array.new(2+1,'')
  end

  def load_initial_state
    self.exits = [ nil,
      "E", "ESW", "WE", "EW", "EW", "ESW", "ESW", "ES", "EW", "SW",
      "S", "N", "ES", "SW", "S", "NW", "N", "N", "ES", "NSW",
      "NS", "E", "NSW", "N", "NES", "EW", "W", "S", "NS", "N",
      "NES", "W", "NS", "D", "NES", "SW", "E", "NW", "NS", "S",
      "NS", "E", "NSEW", "WU", "UD", "NS", "E", "SW", "NSE", "NW",
      "NE", "EW", "NSW", "E", "WN", "S", "E", "NEW", "NW", "S",
      "ES", "SW", "NES", "EW", "SW", "NE", "EW", "ESW", "SW", "ND",
      " ", "E", "NEW", "EW", "NEW", "EW", "EW", "NEW", "NEW", "WU"
    ]
    self.object_locations = [ nil,
      80, 70, 60, 69, 74, 72, 63, 52, 20, 11, 1, 14, 36, 54, 61, 21, 32, 10, 50,
      29, 59, 34, 13, 80, 30, 81, 47, 74
    ]
    self.f[1..13] = [
      1, 2, 3, 4, 5, 9, 12, 13, 16, 17, 20, 21, 22
    ]
  end

  def setup_tunnel_maze
    self.tunnel_maze_directions[1]=""
    for i in 1..8
      direction_forward = %w{N E S W}.sample
      self.tunnel_maze_directions[1]=self.tunnel_maze_directions[1]+direction_forward
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
      self.tunnel_maze_directions[2]=direction_back+self.tunnel_maze_directions[2]
    end
  end

  def new_game
    load_initial_state
    self.f[41]=INT(RND(1)*900)+100
    self.f[42]=INT(RND(1)*3)+2
    self.f[44]=4
    self.f[57]=68
    self.f[58]=54
    self.f[59]=15
    self.f[52]=INT(RND(1)*3)
    self.room=77
    self.response_message="GOOD LUCK ON YOUR QUEST!"
    setup_tunnel_maze
  end

  def load_game
    read_file(get_filename)
    self.room=self.f[69]
    self.response_message="OK. CARRY ON"
  end

  def save_game
    self.f[69]=self.room
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
      self.exits, self.object_locations, self.f, self.tunnel_maze_directions = JSON.parse(x.gets)
    end
  end

  def write_file(filename)
    #SAVE DATA FILE
    File.open(filename, 'w') do |x|
      puts "OK. SAVING"
      x.puts [self.exits, self.object_locations, self.f, self.tunnel_maze_directions].to_json
    end
  end

  def room_and_object
    VAL(STRstr(room)+STRstr(object))
  end

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

def CHRstr(value)
  value.chr
end

MOSM.new.start
