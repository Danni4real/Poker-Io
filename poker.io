name_list  := list("3","4","5","6","7","8","9","10","J","Q","K","A","2","B","R")
value_list := list( 1,  2,  3,  4,  5,  6,  7,  8,   9,  10, 11, 12, 20, 30, 40)
deck :=       list(1,1,1,1, 2,2,2,2, 3,3,3,3, 4,4,4,4, 5,5,5,5, 6,6,6,6, 7,7,7,7, 8,8,8,8, 9,9,9,9, 10,10,10,10, 11,11,11,11, 12,12,12,12, 20,20,20,20, 30, 40)

equalStateMachine := Map clone
nextStateMachine  := Map clone
otherStateMachine := Map clone
endStateList      := list("1","2","3","4","8","28","29","11","51","41","43","45","47","50")

equalStateMachine atPut("1","2")
equalStateMachine atPut("2","3")
equalStateMachine atPut("3","4")
equalStateMachine atPut("5","10")
equalStateMachine atPut("6","13")
equalStateMachine atPut("7","17")
equalStateMachine atPut("8","21")
equalStateMachine atPut("28","25")
equalStateMachine atPut("9","10")
equalStateMachine atPut("10","11")
equalStateMachine atPut("12","13")
equalStateMachine atPut("13","14")
equalStateMachine atPut("14","51")
equalStateMachine atPut("15","10")
equalStateMachine atPut("16","17")
equalStateMachine atPut("17","18")
equalStateMachine atPut("19","13")
equalStateMachine atPut("20","21")
equalStateMachine atPut("21","22")
equalStateMachine atPut("23","17")
equalStateMachine atPut("24","25")
equalStateMachine atPut("25","26")
equalStateMachine atPut("27","21")
equalStateMachine atPut("30","31")
equalStateMachine atPut("31","11")
equalStateMachine atPut("32","33")
equalStateMachine atPut("33","14")
equalStateMachine atPut("34","35")
equalStateMachine atPut("35","18")
equalStateMachine atPut("36","37")
equalStateMachine atPut("37","22")
equalStateMachine atPut("38","39")
equalStateMachine atPut("39","11")
equalStateMachine atPut("40","41")
equalStateMachine atPut("41","14")
equalStateMachine atPut("42","43")
equalStateMachine atPut("43","18")
equalStateMachine atPut("44","45")
equalStateMachine atPut("45","22")
equalStateMachine atPut("46","47")
equalStateMachine atPut("48","49")
equalStateMachine atPut("49","50")

nextStateMachine atPut("1","5")
nextStateMachine atPut("5","6")
nextStateMachine atPut("6","7")
nextStateMachine atPut("7","8")
nextStateMachine atPut("8","28")
nextStateMachine atPut("28","29")
nextStateMachine atPut("29","29")
nextStateMachine atPut("9","12")
nextStateMachine atPut("14","15")
nextStateMachine atPut("12","16")
nextStateMachine atPut("18","19")
nextStateMachine atPut("16","20")
nextStateMachine atPut("22","23")
nextStateMachine atPut("20","24")
nextStateMachine atPut("26","27")
nextStateMachine atPut("2","38")
nextStateMachine atPut("39","40")
nextStateMachine atPut("41","42")
nextStateMachine atPut("43","44")
nextStateMachine atPut("45","46")
nextStateMachine atPut("47","46")
nextStateMachine atPut("31","32")
nextStateMachine atPut("33","34")
nextStateMachine atPut("35","36")
nextStateMachine atPut("3","48")
nextStateMachine atPut("50","48")

otherStateMachine atPut("1","9")
otherStateMachine atPut("5","12")
otherStateMachine atPut("6","16")
otherStateMachine atPut("7","20")
otherStateMachine atPut("8","24")
otherStateMachine atPut("9","12")
otherStateMachine atPut("12","16")
otherStateMachine atPut("16","20")
otherStateMachine atPut("20","24")
otherStateMachine atPut("2","30")
otherStateMachine atPut("31","32")
otherStateMachine atPut("33","34")
otherStateMachine atPut("35","36")
otherStateMachine atPut("39","32")
otherStateMachine atPut("41","34")
otherStateMachine atPut("43","36")


SOLO := 1
PAIR := 100
TRES := 10000
BOMB := 1000000



shuffled_deck := list()


name2value := method(name, value_list at(name_list indexOf(name)))
value2name := method(value, name_list at(value_list indexOf(value)))

string2names := method(
                       string, 
                       tmp_list := Sequence clone appendSeq(string) replaceSeq("10","T") asList
                       while(
                             tmp_list indexOf("T") != nil, 
                             tmp_list atPut(tmp_list indexOf("T"), "10")
                             )
                       tmp_list                      
                       )

show_cards := method(
                     cards,
                     cards foreach(value, value2name(value) print)
                     "" println
                    )

shuffle := method(
                  shuffled_deck = list()
                  deck_copy := deck clone
                  while(
                       (deck_copy size) > 0, 
                       shuffled_deck append(deck_copy removeAt(Random value(deck_copy size) floor))
                       )
                  )

deal := method(
               mary_cards = list()
               john_cards = list()
               lord_cards = list()

               mary_cards appendSeq(shuffled_deck slice(0,17))
               john_cards appendSeq(shuffled_deck slice(17,34))
               lord_cards appendSeq(shuffled_deck slice(34,54))

               mary_cards = mary_cards sort
               john_cards = john_cards sort
               lord_cards = lord_cards sort
              )

wait_for_input := method(
                         cards_input := list()
                         input_string := File standardInput readLine
                         string2names(input_string) foreach(name, cards_input append(name2value(name)))
                         cards_input = cards_input sort
                         return cards_input
                         )


contain_cards := method(
                        cards,
                        cards_played := cards clone
                        cards_inhand_copy := call target clone
                        while(
                              cards_played size > 0, 
                              index := cards_inhand_copy indexOf(cards_played removeFirst)
                              if(index == nil, return false)
                              cards_inhand_copy removeAt(index)
                             )
                        true
                       )

remove_cards := method(
                        cards,
                        cards_played := cards clone
                        cards_inhand := call target
                        while(
                              cards_played size > 0, 
                              index := cards_inhand indexOf(cards_played removeFirst)
                              cards_inhand removeAt(index)
                             )
                      )

has_pattern := method(
                     cards,
                     if(cards at(0) == 30 and cards at(1) == 40, return true)
                     i := 0
                     state := "1" 
                     while( 
                           (i+1) < cards size,
                           loop(
                                if(cards at(i) == cards at(i+1),     state =  equalStateMachine at(state); break)
                                if(cards at(i) == cards at(i+1) - 1, state =  nextStateMachine at(state);  break)
                                                                     state =  otherStateMachine at(state); break
                           )
                           //"state:" print;state println
                           if(state == nil, return false)
                           i = i + 1
                          )
                      
                    if(endStateList contains(state), return true, return false)
                    )

sort_for_pattern := method(
                           cards,
                           cards_copy := cards clone
                           solo_list := list()
                           pair_list := list()
                           tres_list := list()
                           bomb_list := list()
                           while(
                                 cards_copy size > 0,
                                 loop(
                                      if(
                                         cards_copy size > 3 and cards_copy at(0) == cards_copy at(1) and cards_copy at(0) == cards_copy at(2) and cards_copy at(0) == cards_copy at(3), 
                                         bomb_list append(cards_copy at(0))
                                         cards_copy removeFirst
                                         cards_copy removeFirst
                                         cards_copy removeFirst
                                         cards_cocards_inputpy removeFirst
                                         break
                                        )
                                      if(
                                         cards_copy size > 2 and cards_copy at(0) == cards_copy at(1) and cards_copy at(0) == cards_copy at(2), 
                                         tres_list append(cards_copy at(0))
                                         cards_copy removeFirst
                                         cards_copy removeFirst
                                         cards_copy removeFirst
                                         break
                                        )
                                      if(
                                         cards_copy size > 1 and cards_copy at(0) == cards_copy at(1), 
                                         pair_list append(cards_copy at(0))
                                         cards_copy removeFirst
                                         cards_copy removeFirst
                                         break
                                        )
                                      solo_list append(cards_copy at(0))
                                      cards_copy removeFirst
                                      break
                                     )
                            )
                            while(
                                  solo_list size > 0, 
                                  cards_copy append(solo_list at(0))
                                  solo_list removeFirst
                            )
                            while(
                                  pair_list size > 0, 
                                  cards_copy append(pair_list at(0))
                                  cards_copy append(pair_list at(0))
                                  pair_list removeFirst
                            )
                            while(
                                  tres_list size > 0, 
                                  cards_copy append(tres_list at(0))
                                  cards_copy append(tres_list at(0))
                                  cards_copy append(tres_list at(0))
                                  tres_list removeFirst
                            )
                            while(
                                  bomb_list size > 0, 
                                  cards_copy append(bomb_list at(0))
                                  cards_copy append(bomb_list at(0))
                                  cards_copy append(bomb_list at(0))
                                  cards_copy append(bomb_list at(0))
                                  bomb_list removeFirst
                            )
                            return cards_copy
                           )


get_pattern := method(
                      cards,
                      if(cards at(0) == 30 and cards at(1) == 40, return BOMB)
                      cards_copy := cards clone
                      solo_list := list()
                      pair_list := list()
                      tres_list := list()
                      bomb_list := list()
                      
                      while(
                            cards_copy size > 0,
                            loop(
                                 if(
                                    cards_copy size > 3 and cards_copy at(0) == cards_copy at(1) and cards_copy at(0) == cards_copy at(2) and cards_copy at(0) == cards_copy at(3), 
                                    bomb_list append(cards_copy at(0))
                                    cards_copy removeFirst
                                    cards_copy removeFirst
                                    cards_copy removeFirst
                                    cards_copy removeFirst
                                    break
                                   )
                                 if(
                                    cards_copy size > 2 and cards_copy at(0) == cards_copy at(1) and cards_copy at(0) == cards_copy at(2), 
                                    tres_list append(cards_copy at(0))
                                    cards_copy removeFirst
                                    cards_copy removeFirst
                                    cards_copy removeFirst
                                    break
                                   )
                                 if(
                                    cards_copy size > 1 and cards_copy at(0) == cards_copy at(1), 
                                    pair_list append(cards_copy at(0))
                                    cards_copy removeFirst
                                    cards_copy removeFirst
                                    break
                                   )
                                 solo_list append(cards_copy at(0))
                                 cards_copy removeFirst
                                 break
                                )
                            )
                      return (solo_list size)*SOLO + (pair_list size)*PAIR + (tres_list size)*TRES + (bomb_list size)*BOMB
                     )

bigger_than := method(
                      cards,
                      cards_rival := call target clone
                      if((get_pattern(cards_rival)) == BOMB and (get_pattern(cards)) != BOMB, return true)
                      if(get_pattern(cards_rival) == get_pattern(cards) and (cards_rival clone removeLast) > (cards clone removeLast), return true, return false)
                     )

// main starts here
mary_cards := list()
john_cards := list()
lord_cards := list()
cards_input := list()
last_cards_input := nil
current_player_cards_inhand := nil
pass_count := 0


shuffle
deal


loop(
     loop(
          if(current_player_cards_inhand == nil,        current_player_cards_inhand = mary_cards; break)
          if(current_player_cards_inhand == lord_cards, current_player_cards_inhand = mary_cards; break)
          if(current_player_cards_inhand == mary_cards, current_player_cards_inhand = john_cards; break)
          if(current_player_cards_inhand == john_cards, current_player_cards_inhand = lord_cards; break)
         )

     loop(
          show_cards(current_player_cards_inhand)
          cards_input = wait_for_input
          if(cards_input size == 0 and pass_count == 2, "Finish your job!" println; continue)
          if(cards_input size == 0, pass_count = pass_count + 1;"pass" println;break, pass_count = 0)
          cards_input = sort_for_pattern(cards_input)
          if(has_pattern(cards_input) == false, "Not a pattern!" println; continue)
          //"pattern: " print; get_pattern(cards_input) println
          if(last_cards_input != nil and (cards_input bigger_than(last_cards_input) == false), "Play same pattern or play bigger!" println; continue)
          if(current_player_cards_inhand contain_cards(cards_input), current_player_cards_inhand remove_cards(cards_input);break)
          "Not in hand!" println
         )
     if(pass_count == 0, last_cards_input = cards_input)
     if(pass_count == 2, last_cards_input = nil)
     
     show_cards(current_player_cards_inhand)
    )


