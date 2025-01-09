dialog nrmconn {
  title "NEO-RA MultiConnect"
  option dbu
  size -1 -1 220 130
  button "Закрыть",10, 160 117 50 10, cancel
  button "Соединиться с сервером",99, 67 95 142 12, ok
  box "IRC сервер", 101, 5 5 210 108
  text "IRC сервер:порт :", 102, 10 17 55 10, right
  combo 103, 67 16 90 60, drop
  text "Имя соединения :", 104, 10 29 55 10, right
  edit "", 105, 67 28 90 11
  text "Ident :", 116, 10 42 55 10, right
  edit "", 117, 67 41 90 11
  text "Ваш ник :", 106, 10 55 55 10, right
  edit "", 107, 67 54 90 11
  text "Альтернативный ник :", 108, 7 68 58 10, right
  edit "", 109, 67 67 90 11
  check "Включить 'невидимость'", 110, 67 82 75 11
  check "IRCX", 111, 145 82 25 11
  check "MOTD", 112, 175 82 25 11
  button "Добавить", 113, 165 16 42 12
  button "Изменить", 114, 165 29 42 12
  button "Удалить", 115, 165 42 42 12
}
on 1:dialog:nrmconn:init:0: {
  var %tmp, %tmp1, %iname, %iport, %pname, %pport, %string, %nick1, %nick2
  %tmp = 1
  :begirc
  %string = $readini -n mconn.ini IRC s [ $+ [ %tmp ] ]
  if (%string == $null) { goto endirc }
  tokenize 59 %string
  did -a $dname 103 $1 $+ : $+ $2 
  inc %tmp
  goto begirc
  :endirc
  %tmp = $readini -n mconn.ini LAST irc
  did -c $dname 103 %tmp
  %string = $readini -n mconn.ini IRC s [ $+ [ %tmp ] ]
  tokenize 59 %string
  %tmp1 = $7
  did -a $dname 105 $3
  did -a $dname 107 $4
  did -a $dname 109 $5
  did -a $dname 117 $6
  if ($left(%tmp1, 1) == 1) {
    did -c $dname 110
  }
  if ($mid(%tmp1, 2, 1) == 1) {
    did -c $dname 111
  }
  if ($mid(%tmp1, 3, 1) == 1) {
    did -c $dname 112
  }
}
on 1:dialog:nrmconn:sclick:*: {
  ;;;;;    IRC SERVER CHANGE
  if ($did == 103) {
    %tmp = $did(103).sel
    did -c $dname 103 %tmp
    %string = $readini -n mconn.ini IRC s [ $+ [ %tmp ] ]
    tokenize 59 %string
    %tmp1 = $7
    did -r $dname 105,107,109,117
    did -a $dname 105 $3
    did -a $dname 107 $4
    did -a $dname 109 $5
    did -a $dname 117 $6
    if ($left(%tmp1, 1) == 1) {
      did -c $dname 110
    }
    else {
      did -u $dname 110
    }
    if ($mid(%tmp1, 2, 1) == 1) {
      did -c $dname 111
    }
    else {
      did -u $dname 111
    }
    if ($mid(%tmp1, 3, 1) == 1) {
      did -c $dname 112
    }
    else {
      did -u $dname 112
    }
  }
  ;;;;;    OK PRESSED
  if ($did == 99) {
    writeini mconn.ini LAST irc $did(103).sel
    %iname = $did(103)
    %nick1 = $did(107)
    %nick2 = $did(109)
    %ident = $did(117)
    %string = $did(105)
    %tmp = 0
    if ($did(110).state == 1) {
      inc %tmp 1000
    }
    if ($did(111).state == 1) {
      inc %tmp 100
    }
    if ($did(112).state == 1) {
      inc %tmp 10
    }
    nrmconn %iname %string %nick1 $+ ; $+ %nick2 $+ ; $+ %ident %tmp
  }
  ;;;;;    ADD PRESSED
  if ($did == 113) {
    unset %chnging_addr
    /dialog -m nrmcadd nrmcadd
  }
  ;;;;; CHANGE PRESSED
  if ($did == 114) {
    %chnging_addr = $did(103).sel
    /dialog -m nrmcadd nrmcadd
    did -i nrmcadd 103 1 $did(103,0)
    did -i nrmcadd 105 1 $did(105,0)
    did -i nrmcadd 107 1 $did(107,0)
    did -i nrmcadd 109 1 $did(109,0)
    did -i nrmcadd 116 1 $did(117,0)
    if ($did(110).state == 1) { did -c nrmcadd 110 }
    if ($did(111).state == 1) { did -c nrmcadd 111 }
    if ($did(112).state == 1) { did -c nrmcadd 112 }
    did -i nrmcadd 113 1 Изменить
  }
  ;;;;;;DEL PRESSED
  if ($did == 115) {
    var %lastsel = $did(103).sel
    if ($ini($mircdir\mconn.ini,IRC,0) == $did(103).sel) {
      remini $shortfn($mircdir) $+ mconn.ini IRC s [ $+ [ $did(103).sel ] ]
      did -r $dname 103,105,107,109,117
      goto delend
    }
    else {  
      var %serv_lines = $ini($mircdir\mconn.ini,IRC,0)
      var %ind_lines = 0
      :nextReWrite
      inc %ind_lines
      if ($calc(%ind_lines + $did(103).sel) > %serv_lines) {
        remini $shortfn($mircdir) $+ mconn.ini IRC s [ $+ [ %serv_lines ] ]
        did -r $dname 103,105,107,109,117
        goto delend
        halt
      }
      writeini $shortfn($mircdir) $+ mconn.ini IRC s [ $+ [ $calc($did(103).sel + %ind_lines - 1) ] ] $&
        $readini $mircdir\mconn.ini IRC s [ $+ [ $calc($did(103).sel + %ind_lines) ] ]
      goto nextReWrite
    }
    :delend
    if ($ini($mircdir\mconn.ini,IRC,0) == 0) { halt }
    var %tmp, %tmp1
    %tmp = 1
    :begirc
    %string = $readini -n mconn.ini IRC s [ $+ [ %tmp ] ]
    if (%string == $null) { goto endirc }
    tokenize 59 %string
    did -a $dname 103 $1 $+ : $+ $2 
    inc %tmp
    goto begirc
    :endirc
    if (%lastsel == 1) { %tmp = 1 }
    if (%lastsel > 1) { %tmp = %lastsel - 1 }
    did -c $dname 103 %tmp
    %string = $readini -n mconn.ini IRC s [ $+ [ %tmp ] ]
    tokenize 59 %string
    %tmp1 = $7
    did -a $dname 105 $3
    did -a $dname 107 $4
    did -a $dname 109 $5
    did -a $dname 117 $6
    if ($left(%tmp1, 1) == 1) {
      did -c $dname 110
    }
    if ($mid(%tmp1, 2, 1) == 1) {
      did -c $dname 111
    }
    if ($mid(%tmp1, 3, 1) == 1) {
      did -c $dname 112
    }
  }
}
; ==========================================================================================================================================
dialog nrmcadd {
  title "NEO-RA MultiConnect - добавление IRC-сервера"
  option dbu
  size -1 -1 158 106
  button "Добавить", 113, 63 92 44 12, disable, ok
  button "Отмена",100, 110 92 42 12, cancel
  box "IRC сервер", 101, 2 2 155 87
  text "IRC сервер:порт :", 102, 5 12 55 10, right
  edit "",103, 62 10 90 11
  text "Имя соединения :", 104, 5 25 55 10, right
  edit "", 105, 62 23 90 11
  text "Ident :",115, 5 37 55 10, right 
  edit "",116, 62 36 90 11
  text "Ваш ник :", 106, 5 51 55 10, right
  edit "", 107, 62 49 90 11
  text "Альтернативный ник :",108, 4 64 57 10, right
  edit "", 109, 62 62 90 11
  check "Включить ''невидимость''", 110, 15 76 75 11
  check "IRCX", 111, 95 76 25 11
  check "MOTD", 112, 125 76 60 11
}
on 1:dialog:nrmcadd:edit:*: {
  if ($did(103) != $null && $did(105) != $null && $did(107) != $null && $did(109) != $null && $did(116) != $null) { did -e $dname 113 }
  if ($did(103) == $null || $did(105) == $null || $did(107) == $null || $did(109) == $null || $did(116) == $null) { did -b $dname 113 }
  if ($chr(58) !isin $did(103)) { did -b $dname 113 }
  else { did -e $dname 113 }
}
on 1:dialog:nrmcadd:sclick:*: {
  if ($did == 110 || $did == 111 || $did == 112) && ($did(103) != $null && $did(105) != $null && $did(107) != $null && $did(109) != $null && $did(116) != $null) && ($chr(58) isin $did(103)) { did -e $dname 113 }
  if ($did == 113) {
    var %PreString1 = $gettok($did(103),1,58) $+ ; $+ $gettok($did(103),2,58) $+ ; $+ $did(105) $+ ; $+ $did(107) $+ ; $+ $did(109) $+ ; $+ $did(116)
    var %PreString2 = $did(110).state $+ $did(111).state $+ $did(112).state
    var %FinalString = %PreString1 $+ ; $+ %PreString2
    if (%chnging_addr != $null) { writeini $shortfn($mircdir) $+ mconn.ini IRC s [ $+ [ %chnging_addr ] ] %FinalString | nrmconn_init_sl }
    else { writeini $shortfn($mircdir) $+ mconn.ini IRC s [ $+ [ $calc($ini($mircdir\mconn.ini,IRC,0) + 1) ] ] %FinalString | nrmconn_init_sl }
  }
}
alias nrmconn_init_sl {
  did -r nrmconn 103,105,107,109,117 | did -u nrmconn 110,111,112
  var %tmp, %tmp1
  %tmp = 1
  :begirc
  %string = $readini -n mconn.ini IRC s [ $+ [ %tmp ] ]
  if (%string == $null) { goto endirc }
  tokenize 59 %string
  did -a nrmconn 103 $1 $+ : $+ $2 
  inc %tmp
  goto begirc
  :endirc
  if (%chnging_addr != $null) { %tmp = %chnging_addr }
  else { %tmp = $ini($mircdir\mconn.ini,IRC,0) }
  did -c nrmconn 103 %tmp
  %string = $readini -n mconn.ini IRC s [ $+ [ %tmp ] ]
  tokenize 59 %string
  %tmp1 = $7
  did -a nrmconn 105 $3
  did -a nrmconn 107 $4
  did -a nrmconn 109 $5
  did -a nrmconn 117 $6
  if ($left(%tmp1, 1) == 1) {
    did -c nrmconn 110
  }
  if ($mid(%tmp1, 2, 1) == 1) {
    did -c nrmconn 111
  }
  if ($mid(%tmp1, 3, 1) == 1) {
    did -c nrmconn 112
  }
}
