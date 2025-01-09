alias nrmconn {
  var  %ds_firc = $1,  %ds_descr = $2, %ds_nick = $3, %ds_opts = $4, %ds_razd, %ds_iport, %ds_ihost
  %ds_ihost = $gettok(%ds_firc, 1, 58)
  %ds_iport = $gettok(%ds_firc, 2, 58)
  if ($sock(mcon. $+ %ds_descr).status != $null) {
    echo -a *** Multi Connect: —оединение с таким названием уже создано!
    return
  }
  %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_descr ] ] ] ] = $gettok(%ds_nick,1, 59)
  %ds_nick1_ [ $+ [ mcon. [ $+ [ %ds_descr ] ] ] ] = $gettok(%ds_nick,2, 59)
  %ds_ident_ [ $+ [ mcon. [ $+ [ %ds_descr ] ] ] ] = $gettok(%ds_nick,3, 59)
  %ds_setIRCX_ [ $+ [ mcon. [ $+ [ %ds_descr ] ] ] ] = $mid(%ds_opts, 2, 1)
  %ds_ircx_ [ $+ [ mcon. [ $+ [ %ds_descr ] ] ] ] = 0
  %ds_setINV_ [ $+ [ mcon. [ $+ [ %ds_descr ] ] ] ] = $mid(%ds_opts, 1, 1)
  %ds_showMOTD_ [ $+ [ mcon. [ $+ [ %ds_descr ] ] ] ] = $mid(%ds_opts, 3, 1)
  %ds_started_ [ $+ [ mcon. [ $+ [ %ds_descr ] ] ] ] = 1
  ; =====================================================
  sockopen mcon. $+ %ds_descr %ds_ihost %ds_iport
  if ($sockerr>0) { echo -a *** Multi Connect: ќшибка открыти¤ соединени¤ с %ds_descr ! | return }
  echo -a *** Multi Connect: —оединение с IRC-сервером %ds_ihost ...
}


on 1:sockopen:mcon.*:{
  if ($sockerr > 0) { echo -a *** Multi Connect: ќшибка соединени¤ с $sockname ! | sockclose $sockname | return }
  %ds_sock = $gettok($sockname, 2, 46)
  window -aek0S @ $+ $deltok($sockname, 1, 46) $+ .Status $gettok($readini $mircdirmirc.ini fonts fstatus,1,46) $gettok($readini $mircdirmirc.ini fonts fstatus,2-,46)
  echo @ $+ $deltok($sockname, 1, 46) $+ .Status - –егистраци¤ на IRC-сервере под ником < %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_sock ] ] ] ] >...
  window -g2 @ $+ $deltok($sockname, 1, 46) $+ .Status
  sockwrite -n $sockname NICK %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_sock ] ] ] ]
  sockwrite -n $sockname USER %ds_ident_ [ $+ [ $sockname ] ] localhost localhost : NEO-RA (R)MultiConnect v1.0
}


on 1:sockclose:mcon.*:{
  var %ds_win, %ds_tmp, %ds_winname
  %ds_tmp = @ $+ $deltok($sockname, 1, 46) $+ .*
  %ds_win = $window(%ds_tmp, 0)
  :beginclose
  %ds_winname = $window(%ds_tmp, %ds_win)
  echo %ds_winname $chr(91) $+ $asctime(HH:nn) $+ $chr(93) ==== —оединение было прервано удаленным сервером
  window -g2 %ds_winname
  dec %ds_win
  if (%ds_win > 0) goto beginclose
  sockclose $sockname
}


on 1:sockread:mcon.*:{
  var %ds_temp
  if ($sockerr > 0) { echo -a *** Multi Connect: ќшибка чтени¤ данных из соединени¤ $sockname ! | return }
  :nextread
  sockread %ds_temp
  if ($sockbr == 0) return
  if (%ds_temp == $null) goto nextread
  ;  echo -a ::::::::::: %ds_temp
  perf %ds_temp $sockname
  goto nextread
}

on 1:input:@:{
  var %ds_inpstr, %ds_sock, %ds_tmp, %ds_troom, %ds_desc
  %ds_inpstr = $1-
  %ds_sock = $gettok($active, 1, 46)
  %ds_tmp = $len(%ds_sock)
  dec %ds_tmp
  %ds_sock = mcon. $+ $right(%ds_sock, %ds_tmp)
  if ($sock(%ds_sock, 0) < 1) { return }
  %ds_troom = $deltok($active, 1, 46)

  if ($left($1-, 1) == /) {
    if ($upper($left($1-, 3)) == /ME) {
      sockwrite -n %ds_sock PRIVMSG %ds_troom : $+ ACTION $2- $+ 
      echo $active  $+ $colour(action text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) < $+ %ds_nick_ [ $+ [ %ds_sock ] ] $+ > $2-
      halt
    }
    %ds_tmp = $len(%ds_inpstr)
    dec %ds_tmp
    %ds_inpstr = $right(%ds_inpstr, %ds_tmp)
    sockwrite -n %ds_sock %ds_inpstr
  }
  else {
    if (%ds_troom == Status) {
      echo -a *** Multi Connect: ¬ы не на канале!
    }
    else {
      sockwrite -n %ds_sock PRIVMSG %ds_troom : $+ %ds_inpstr
      echo $active  $+ $colour(own text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) < $+ %ds_nick_ [ $+ [ %ds_sock ] ] $+ > %ds_inpstr
    }
  }
  halt
}

on 1:close:@:{
  %ds_sock = $gettok($target, 1, 46)
  %ds_tmp = $len(%ds_sock)
  dec %ds_tmp
  %ds_sock = mcon. $+ $right(%ds_sock, %ds_tmp)
  %ds_troom = $deltok($target, 1, 46)

  if (%ds_troom == Status) {
    if ($sock(%ds_sock) != $null) {
      sockwrite -n %ds_sock QUIT :NeoRa Trion %lastversion (MultiConnection) - http://www.neora.ru
      echo -s *** Multi Connect: —оединение $deltok($ds_sock, 1, 46) было закрыто пользователем
      sockclose %ds_sock
    }
  }
  else {
    if ($left(%ds_troom, 1) == $chr(35)) {
      if ($sock(%ds_sock) != $null) {
        sockwrite -n %ds_sock PART %ds_troom :NeoRa Trion 1.0 (MultiConnection) - http://www.neora.ru
      }
    }
  }
  halt
}
