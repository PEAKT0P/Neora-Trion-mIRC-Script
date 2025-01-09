alias perf {
  %ds_string = $1-

  %ds_tmp = $numtok(%ds_string, 32)
  %ds_desc = $deltok($gettok(%ds_string, %ds_tmp, 32), 1, 46)
  %ds_string = $deltok(%ds_string, %ds_tmp, 32)
  %ds_string = $remove(%ds_string, $chr(13), $chr(10))

  %ds_raw = $gettok(%ds_string, 2, 32)

  ; echo -a ------ %ds_string

  if ($gettok(%ds_string, 1, 32) == PING) {
    %ds_serv = $gettok(%ds_string, 2, 32)
    %ds_tmp = $len(%ds_serv)
    dec %ds_tmp
    %ds_serv = $right(%ds_serv, %ds_tmp)
    sockwrite -n mcon. $+ %ds_desc PONG %ds_serv
    echo @ $+ %ds_desc $+ .Status  $+ $colour(info text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) - ТУТ? АГА!
    return
  }

  if (%ds_raw == 001) {
    window -g2 @ $+ %ds_desc $+ .Status
    echo @ $+ %ds_desc $+ .Status  $+ $colour(info2 text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) - Соединение %ds_desc установлено
    %ds_serv = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_serv)
    dec %ds_tmp
    %ds_serv = $right(%ds_serv, %ds_tmp)
    %ds_serv_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] = %ds_serv
    echo @ $+ %ds_desc $+ .Status  $+ $colour(info2 text) $+ - Имя обслуживающего Вас сервера: %ds_serv
    return
  }

  if (%ds_raw == 002) {
    window -g2 @ $+ %ds_desc $+ .Status
    echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ -
    echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ - Информация о сети:
    %ds_tstr = $deltok(%ds_string, 1-3, 32)
    %ds_tmp = $len(%ds_tstr)
    dec %ds_tmp
    %ds_tstr = $right(%ds_serv, %ds_tmp)
    echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ - %ds_tstr
    return
  }

  if (%ds_raw == 003 || %ds_raw == 251 || %ds_raw == 255 || %ds_raw == 265 || %ds_raw == 266) {
    %ds_tstr = $deltok(%ds_string, 1-3, 32)
    %ds_tmp = $len(%ds_tstr)
    dec %ds_tmp
    %ds_tstr = $right(%ds_tstr, %ds_tmp)
    window -g2 @ $+ %ds_desc $+ .Status
    echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ - %ds_tstr
    if (%ds_setIRCX_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] == 1) {
      sockwrite -n mcon. $+ %ds_desc IRCX
    }
    return
  }

  if (%ds_raw == 372) {
    if (%ds_showMOTD_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] == 1) {
      %ds_tstr = $deltok(%ds_string, 1-3, 32)
      %ds_tmp = $len(%ds_tstr)
      dec %ds_tmp
      %ds_tstr = $right(%ds_tstr, %ds_tmp)
      window -g2 @ $+ %ds_desc $+ .Status
      echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ - %ds_tstr
    }
    return
  }

  if (%ds_raw == 375) {
    if (%ds_showMOTD_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] == 1) {
      %ds_tstr = $deltok(%ds_string, 1-3, 32)
      window -g2 @ $+ %ds_desc $+ .Status
      echo  @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ -
      echo  @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ - Сообщение дня:
    }
    return
  }

  if (%ds_raw == 004 || %ds_raw == 252 || %ds_raw == 253 || %ds_raw == 254) {
    %ds_tstr = $deltok(%ds_string, 1-3, 32)
    window -g2 @ $+ %ds_desc $+ .Status
    echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ - %ds_tstr
    return
  }

  if (%ds_raw == 376) {
    %ds_started_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] = 0
    if (%ds_showMOTD_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] == 1) {
      %ds_tstr = $deltok(%ds_string, 1-3, 32)
      window -g2 @ $+ %ds_desc $+ .Status
      echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ - Конец сообщения дня
    }
    return
  }

  if (%ds_raw == 433) {
    if (  %ds_started_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] == 1) {
      if (%ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] == %ds_nick1_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ]) {
        echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ === Оба выбранных Вами ника уже заняты
        sockwrite -n mcon. $+ %ds_desc QUIT
        return
      }
      echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ === Ник %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] занят, регистрация под ником %ds_nick1_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ]
      %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] = %ds_nick1_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ]
      sockwrite -n mcon. $+ %ds_desc NICK %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ]
      return
    }
    else {
      echo -a  $+ $colour(normal text) $+ === Ник $gettok(%ds_string, 4, 32) занят
      return
    }
  }

  if (%ds_raw == 401) {
    echo -a  $+ $colour(normal text) $+ === Нет такого ника или канала: $gettok(%ds_string, 4, 32)
    return
  }

  if (%ds_raw == 311) {
    %ds_tnick = $gettok(%ds_string, 4, 32)
    echo -a  $+ $colour(normal text) $+ === Информация об: 5 $+ %ds_tnick
    echo -a  $+ $colour(normal text) $+ = Пользователь: $+ 5           $gettok(%ds_string, 5, 32)
    echo -a  $+ $colour(normal text) $+ = Хост (ИП) юзера: $+ 5 $gettok(%ds_string, 6, 32)
    echo -a  $+ $colour(normal text) $+ = Реальное имя: 5 $+ $deltok(%ds_string, 1, 58)
    return
  }

  if (%ds_raw == 312) {
    echo -a  $+ $colour(normal text) $+ = Обслуживается сервером: 5 $+ $gettok(%ds_string, 5, 32) 2 $+ ( $+ 5 $+ $deltok(%ds_string, 1, 58) $+ 2 $+ )
    return
  }

  if (%ds_raw == 301) {
    echo -a  $+ $colour(normal text) $+ = Находится в эвэе по причине: $+ 5 $deltok(%ds_string, 1, 58)
    return
  }

  if (%ds_raw == 302) {
    %ds_tmp = $deltok(%ds_string, 1, 58)
    %ds_tnick = $gettok(%ds_tmp, 1, 61)
    %ds_tmess = $deltok(%ds_tmp, 1, 61)
    echo -a  $+ $colour(normal text) $+ === Хост юзера $+ 5 %ds_tnick $+ 2 $+ : $+ 5 %ds_tmess
    return
  }

  if (%ds_raw == 307) {
    echo -a  $+ $colour(normal text) $+ = Пользователь АВТОРИЗОВАН под этим ником
    return
  }

  if (%ds_raw == 319) {
    echo -a  $+ $colour(normal text) $+ = Находится в комнатах: 5 $+ $deltok(%ds_string, 1, 58)
    return
  }

  if (%ds_raw == 317) {
    %ds_tmp = $gettok(%ds_string, 5, 32)
    %ds_tstr = $int($calc(%ds_tmp / 3600))
    if (%ds_tstr < 10) {
      %ds_tstr = 0 $+ %ds_tstr
    }
    %ds_tnick = $int($calc((%ds_tmp - (%ds_tstr * 3600)) / 60))
    if (%ds_tnick < 10) {
      %ds_tnick = 0 $+ %ds_tnick
    }
    %ds_troom = $calc(%ds_tmp - (%ds_tstr * 3600) - (%ds_tnick * 60))
    if (%ds_troom < 10) {
      %ds_troom = 0 $+ %ds_troom
    }
    echo -a  $+ $colour(normal text) $+ = Зашел в чат: $asctime($gettok(%ds_string, 6, 32), dddd dd/mm/yyyy  HH:nn:ss)
    echo -a  $+ $colour(normal text) $+ = Бездействует в течении: %ds_tstr $+ : $+ %ds_tnick $+ : $+ %ds_troom
    return
  }

  if (%ds_raw == 421) {
    echo -a  $+ $colour(info2 text) $+ === Неизвестная команда: 5 $+ $gettok(%ds_string, 4, 32)
    return
  }

  if (%ds_raw == 318) {
    echo -a  $+ $colour(normal text) $+ === Конец ИНФО на: 5 $+ $gettok(%ds_string, 4, 32)
    return
  }

  if (%ds_raw == 321) {
    %ds_troom = @ $+ %ds_desc $+ .Channels
    if ($window(%ds_troom, 0) > 0) {
      window -c %ds_troom
    }
    window -lk0S -t30,40 %ds_troom
    aline %ds_troom  $+ $colour(info text) Название канала $+ $chr(9) $+  $+ $colour(info text) Юзеров $+ $chr(9) $+  $+ $colour(info text) Топик канала
    %ds_troom = @ $+ %ds_desc $+ .Status
    echo %ds_troom *** Начало вывода списка каналов...
    return
  }

  if (%ds_raw == 322) {
    %ds_troom = @ $+ %ds_desc $+ .Channels
    if ($window(%ds_troom, 0) < 1) {
      window -lk0S -t30,40 %ds_troom
      aline %ds_troom  $+ $colour(info text) Название канала $+ $chr(9) $+  $+ $colour(info text) Юзеров $+ $chr(9) $+  $+ $colour(info text) Топик канала
    }
    %ds_tnick = $gettok(%ds_string, 5, 32)
    %ds_tmp = $gettok(%ds_string, 4, 32)
    %ds_tmess = $gettok(%ds_string, 2, 58)
    aline %ds_troom %ds_tmp $+ $chr(9) $+ %ds_tnick $+ $chr(9) $+ %ds_tmess
    return
  }

  if (%ds_raw == 323) {
    %ds_troom = @ $+ %ds_desc $+ .Channels
    aline %ds_troom ============================== $+ $chr(9)  КОНЕЦ  $chr(9) $+ ====================================================================================
    %ds_troom = @ $+ %ds_desc $+ .Status
    echo %ds_troom *** Вывод списка каналов закончен
    return
  }

  if (%ds_raw == 306) {
    %ds_tmess = $deltok(%ds_string, 1, 58)
    echo -a *** Вы вышли в режим AWAY
    return
  }

  if (%ds_raw == 305) {
    %ds_rtmp = @ $+ %ds_desc $+ .#*
    %ds_nroom = $window(%ds_rtmp, 0)

    :dsbeginrfind1
    if (%ds_nroom > 0) {
      %ds_troom = $window(%ds_rtmp, %ds_nroom)
      %ds_tmess = $deltok(%ds_troom, 1, 46)
      sockwrite -n mcon. $+ %ds_desc privmsg %ds_tmess :ACTION вернулся из режима AWAY 
      echo %ds_troom  $+ $colour(action text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] вернулся из режима AWAY
      dec %ds_nroom
      goto dsbeginrfind1
    }
    return
  }

  if (%ds_raw == 403) {
    %ds_troom = $gettok(%ds_string, 4, 32)
    echo -a  $+ $colour(normal text) $+ *** Нет такого канала:  $+ $colour(highlight text) $+ %ds_troom
    return
  }

  if (%ds_raw == 482) {
    %ds_troom = $gettok(%ds_string, 4, 32)
    echo -a  $+ $colour(normal text) $+ *** Вы не имеете статус ОПа на канале  $+ $colour(highlight text) $+ %ds_troom
    return
  }

  if (%ds_raw == 351) {
    %ds_tmess = $deltok(%ds_string, 1-3, 32)
    echo -a  $+ $colour(normal text) $+ *** Версия сервера:  $+ $colour(highlight text) $+ %ds_tmess
    return
  }

  if (%ds_raw == 391) {
    %ds_tmess = $deltok(%ds_string, 1, 58)
    echo -a  $+ $colour(normal text) $+ *** Время сервера:  $+ $colour(highlight text) $+ %ds_tmess
    return
  }

  if (%ds_raw == 364) {
    %ds_tmess = $deltok(%ds_string, 1-3, 32)
    echo -a  $+ $colour(normal text) $+ *** Текущий сервер связан с сервером:  $+ $colour(highlight text) $+ %ds_tmess
    return
  }

  if (%ds_raw == 365) {
    echo -a  $+ $colour(normal text) $+ *** Конец списка связанных серверов
    return
  }

  if (%ds_raw == 800) {
    %ds_tstr = $deltok(%ds_string, 1-3, 32)
    window -g2 @ $+ %ds_desc $+ .Status
    echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ === IRCX включен
    echo @ $+ %ds_desc $+ .Status  $+ $colour(normal text) $+ -
    return
  }

  if (%ds_raw == 353) {
    %ds_tstr = $deltok(%ds_string, 1-4, 32)
    %ds_troom = $gettok(%ds_tstr, 1, 32)
    %ds_tnicks = $deltok(%ds_tstr, 1, 58)
    %ds_rtmp = @ $+ %ds_desc $+ . $+ %ds_troom
    if ($window(%ds_rtmp, 0) < 1) {
      %ds_rtmp = @ $+ %ds_desc $+ .Status
      echo %ds_rtmp  $+ $colour(normal text) $+ === Пользователи на канале %ds_troom : %ds_tnicks
      window -g2 %ds_rtmp
      return
    }
    if (%ds_names_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] != 1) {
      %ds_names_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] = 1
      %ds_tmp = $line(%ds_rtmp, 0, 1)
      dline -l %ds_rtmp 1- $+ %ds_tmp
      .timer 1 1 unset %ds_names_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ]
    }
    %ds_tmp = $numtok(%ds_tnicks, 32)

    while (%ds_tmp > 0) {
      %ds_tnick = $gettok(%ds_tnicks, %ds_tmp, 32)
      window -g2 %ds_rtmp
      aline -l %ds_rtmp %ds_tnick
      dec %ds_tmp
    }
    return
  }

  if (%ds_raw == 366) {
    unset %ds_names_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ]
    return
  }

  if (%ds_raw == 332) {
    %ds_tstr = $deltok(%ds_string, 1-3, 32)
    %ds_troom = $gettok(%ds_tstr, 1, 32)
    %ds_tmsg = $deltok(%ds_tstr, 1, 58)
    echo @ $+ %ds_desc $+ . $+ %ds_troom $iif(%ActivSkinName != noskin, $mcskn.see.topic,  $+ $colour(normal text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Топик комнаты:  $+ $colour(topic text) $+ %ds_tmsg)
    titlebar @ $+ %ds_desc $+ . $+ %ds_troom %ds_tmsg
    return
  }

  if (%ds_raw == 333) {
    %ds_tstr = $deltok(%ds_string, 1-3, 32)
    %ds_troom = $gettok(%ds_tstr, 1, 32)
    %ds_tnick = $gettok(%ds_tstr, 2, 32)
    %ds_tmsg = $gettok(%ds_tstr, 3, 32)
    echo @ $+ %ds_desc $+ . $+ %ds_troom $iif(%ActivSkinName != noskin, $mcskn.who.topic,  $+ $colour(normal text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Топик установлен пользователем: %ds_tnick в $asctime(%ds_tmsg, dddd dd/mm/yyyy - HH:nn:ss))
    return
  }

  if (%ds_raw == 328) {
    %ds_troom = $gettok(%ds_string, 4, 32)
    %ds_tmsg = $deltok(%ds_string, 1, 58)
    echo @ $+ %ds_desc $+ . $+ %ds_troom  $+ $colour(normal text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Официальный сайт комнаты:  $+ $colour(topic text) $+ %ds_tmsg
    return
  }

  if (%ds_raw == INVITE) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tmp = $gettok(%ds_tnick, 2, 33)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)
    %ds_troom = $gettok(%ds_string, 2, 58)
    echo -a $iif(%ActivSkinName != noskin, $mcskn.invite,  $+ $colour(join text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) ===  $+ $colour(highlight text) $+ %ds_tnick  $+ $colour(normal text) $+ приглашает Вас на канал  $+ $colour(highlight text) $+ %ds_troom)
    return
  }

  if (%ds_raw == DATA) {
    %ds_tnick = $gettok(%ds_string, 3,32)
    %ds_troom = $gettok(%ds_string, 2, 58)
    echo -a $iif(%ActivSkinName != noskin, $mcskn.invite,  $+ $colour(join text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) ===  $+ $colour(highlight text) $+ %ds_tnick  $+ $colour(normal text) $+ приглашает Вас на канал  $+ $colour(highlight text) $+ %ds_troom)
    return
  }

  if (%ds_raw == JOIN) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tmp = $gettok(%ds_tnick, 2, 33)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)
    %ds_troom = $gettok(%ds_string, 2, 58)

    if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
      window -aek0l15S @ $+ %ds_desc $+ . $+ %ds_troom $gettok($readini $mircdirmirc.ini fonts fchannel,1,46) $gettok($readini $mircdirmirc.ini fonts fchannel,2-,46)
      window -g2 @ $+ %ds_desc $+ . $+ %ds_troom
      echo @ $+ %ds_desc $+ . $+ %ds_troom $iif(%ActivSkinName != noskin, $mcskn.join.me,  $+ $colour(join text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) === Вы вошли в комнату)
    }
    else {
      window -g2 @ $+ %ds_desc $+ . $+ %ds_troom
      aline -l @ $+ %ds_desc $+ . $+ %ds_troom %ds_tnick
      echo @ $+ %ds_desc $+ . $+ %ds_troom $iif(%ActivSkinName != noskin, $mcskn.join,  $+ $colour(join text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) === В комнату входит %ds_tnick < $+ %ds_tmp $+ >)
    }
    return
  }

  if (%ds_raw == NICK) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)

    %ds_mess = $gettok(%ds_string, 2, 58)

    %ds_rtmp = @ $+ %ds_desc $+ .#*
    %ds_nroom = $window(%ds_rtmp, 0)

    :dsbeginrfind1
    if (%ds_nroom > 0) {
      %ds_troom = $window(%ds_rtmp, %ds_nroom)

      %ds_tmp = $line(%ds_troom, 0, 1)

      :dsbeginfind1
      %ds_ntmp = $line(%ds_troom, %ds_tmp, 1)
      if (%ds_ntmp == %ds_tnick || %ds_ntmp == $chr(46) $+ %ds_tnick || %ds_ntmp == $chr(64) $+ %ds_tnick) {
        rline -l %ds_troom %ds_tmp %ds_mess
        if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
          window -g2 %ds_troom
          echo %ds_troom $iif(%ActivSkinName != noskin, $mcskn.nick.selfme,  $+ $colour(nick text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) === Вы сменили ник на %ds_mess)
        }
        else {
          window -g2 %ds_troom
          echo %ds_troom $iif(%ActivSkinName != noskin, $mcskn.nick,  $+ $colour(nick text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) === %ds_tnick сменил ник на %ds_mess)
        }
      }
      else {
        dec %ds_tmp
        if (%ds_tmp > 0) { goto dsbeginfind1 }
      }
      dec %ds_nroom
      goto dsbeginrfind1
    }
    if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
      %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] = %ds_mess
    }
    %ds_tmp = @ $+ %ds_desc $+ . $+ %ds_tnick
    if ($window(%ds_tmp, 0) > 0) { /renwin %ds_tmp @ $+ %ds_desc $+ . $+ %ds_mess }
    return
  }

  if (%ds_raw == PRIVMSG) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)

    %ds_troom = $gettok(%ds_string, 3, 32)
    %ds_mess = $deltok(%ds_string, 1, 58)

    if ($left(%ds_troom, 1) == $chr(35)) {
      if ($left(%ds_tnick, 1) == $chr(35)) {
        echo @ $+ %ds_desc $+ . $+ %ds_troom  $+ $colour(nick text) $+ - %ds_tnick  %ds_mess
        window -g1 @ $+ %ds_desc $+ . $+ %ds_troom
      }
      else {
        if ($left(%ds_mess, 1) == $chr(1)) {
          %ds_mess = $gettok(%ds_mess, 1, 1)
          if ($gettok(%ds_mess, 1, 32) == ACTION) {
            %ds_mess = $deltok(%ds_mess, 1, 32)
            echo @ $+ %ds_desc $+ . $+ %ds_troom  $+ $colour(action text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick %ds_mess
            window -g1 @ $+ %ds_desc $+ . $+ %ds_troom
          }
          else {
            echo @ $+ %ds_desc $+ . $+ %ds_troom  $+ $colour(other text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) < $+ %ds_tnick $+ > %ds_mess
            window -g1 @ $+ %ds_desc $+ . $+ %ds_troom
          }
        }
        else {  
          echo @ $+ %ds_desc $+ . $+ %ds_troom  $+ $colour(other text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) < $+ %ds_tnick $+ > %ds_mess
          window -g1 @ $+ %ds_desc $+ . $+ %ds_troom
        }
      }
    }
    else {
      if (%ds_troom == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ]) {
        if ($left(%ds_mess, 1) == $chr(1)) {
          %ds_mess = $gettok(%ds_mess, 1, 1)
          if ($gettok(%ds_mess, 1, 32) == ACTION) {
            %ds_mess = $deltok(%ds_mess, 1, 32)
            %ds_troom = @ $+ %ds_desc $+ . $+ %ds_tnick
            if ($window(%ds_troom, 0) < 1) {
              echo -a $iif(%ActivSkinName != noskin, $mcskn.open,  $+ $colour(highlight text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) === Приват от %ds_tnick)
              window -ek0n %ds_troom
            }
            echo %ds_troom  $+ $colour(action text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick %ds_mess
            window -g1 %ds_troom
            return
          }
          echo -a  $+ $colour(ctcp text) $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Запрос на СТСР от %ds_tnick --- < %ds_mess >
        }
        else {
          %ds_troom = @ $+ %ds_desc $+ . $+ %ds_tnick
          if ($window(%ds_troom, 0) < 1) {
            echo -a $iif(%ActivSkinName != noskin, $mcskn.open,  $+ $colour(highlight text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) === Приват от %ds_tnick)
            window -ek0n %ds_troom
          }
          echo %ds_troom  $+ $colour(other text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) < $+ %ds_tnick $+ > %ds_mess
          window -g1 %ds_troom
        }
      }
    }
    return
  }

  if (%ds_raw == NOTICE) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)
    %ds_tmess = $deltok(%ds_string, 1, 58)

    if (%ds_tnick == %ds_serv_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ]) {
      if (%ds_showMOTD_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] == 1) {
        echo -a  $+ $colour(notice text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Сервер: %ds_tmess
      }
      return
    }
    if ($left(%ds_tmess, 1) == $chr(1)) {
      %ds_tmess = $gettok(%ds_string, 2, 1)
      %ds_tstr = $gettok(%ds_tmess, 1, 32)
      %ds_tmess = $deltok(%ds_tmess, 1, 32)

      echo -a  $+ $colour(ctcp text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отвечает на %ds_tstr $+ : %ds_tmess
    }
    else {
      echo -a  $+ $colour(notice text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick сообщает: %ds_tmess
    }

    return
  }

  if (%ds_raw == TOPIC) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)

    %ds_tstr = $deltok(%ds_string, 1-2, 32)
    %ds_troom = $gettok(%ds_tstr, 1, 32)
    %ds_tmess = $deltok(%ds_tstr, 1, 58)

    echo @ $+ %ds_desc $+ . $+ %ds_troom $iif(%ActivSkinName != noskin, $mcskn.topic,  $+ $colour(normal text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93)  $+ $colour(topic text) $+ %ds_tnick сменил топик на: %ds_tmess)
    titlebar @ $+ %ds_desc $+ . $+ %ds_troom %ds_tmess
    window -g1 @ $+ %ds_desc $+ . $+ %ds_troom

    return
  }

  if (%ds_raw == PART) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)

    %ds_troom = $gettok(%ds_string, 3, 32)

    %ds_tmess = $deltok(%ds_string, 1, 58)

    if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
      window -c @ $+ %ds_desc $+ . $+ %ds_troom
    }
    else {
      %ds_rtmp = @ $+ %ds_desc $+ . $+ %ds_troom
      %ds_tmp = $line(%ds_rtmp, 0, 1)

      :dsbeginfind
      %ds_ntmp = $line(%ds_rtmp, %ds_tmp, 1)
      if (%ds_ntmp == %ds_tnick || %ds_ntmp == $chr(46) $+ %ds_tnick || %ds_ntmp == $chr(64) $+ %ds_tnick) {
        window -g2 %ds_rtmp
        dline -l %ds_rtmp %ds_tmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.part,  $+ $colour(part text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) === Комнату покинул(а) %ds_tnick с сообщением: %ds_tmess)
      }
      else {
        dec %ds_tmp
        if (%ds_tmp > 0) { goto dsbeginfind }
      }
    }
    return
  }

  if (%ds_raw == QUIT) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)

    %ds_tmess = $deltok(%ds_string, 1, 58)

    %ds_rtmp = @ $+ %ds_desc $+ .#*
    %ds_nroom = $window(%ds_rtmp, 0)

    :dsbeginrfind
    if (%ds_nroom > 0) {
      %ds_troom = $window(%ds_rtmp, %ds_nroom)

      %ds_tmp = $line(%ds_troom, 0, 1)

      :dsbeginfind
      %ds_ntmp = $line(%ds_troom, %ds_tmp, 1)
      if (%ds_ntmp == %ds_tnick || %ds_ntmp == $chr(46) $+ %ds_tnick || %ds_ntmp == $chr(64) $+ %ds_tnick) {
        window -g2 %ds_troom
        dline -l %ds_troom %ds_tmp
        echo 2 %ds_troom $iif(%ActivSkinName != noskin, $mcskn.quit,  $+ $colour(quit text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) 5 $+ %ds_tnick $+ 2 вышел из чата с сообщением: %ds_tmess)
      }
      else {
        dec %ds_tmp
        if (%ds_tmp > 0) { goto dsbeginfind }
      }
      dec %ds_nroom
      goto dsbeginrfind
    }
    return
  }

  if (%ds_raw == MODE) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)

    %ds_troom = $gettok(%ds_string, 3, 32)
    %ds_tmode = $gettok(%ds_string, 4, 32)
    %ds_rtmp = @ $+ %ds_desc $+ . $+ %ds_troom
    %ds_rstat = @ $+ %ds_desc $+ .Status


    if (%ds_troom == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
      if (%ds_tmode == :+i) {
        window -g2 %ds_rstat
        echo 2 %ds_rstat  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Включен режим невидимости
        return
      }
      if (%ds_tmode == :-i) {
        window -g2 %ds_rstat
        echo 2 %ds_rstat  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Выключен режим невидимости
        return
      }
    }

    %ds_tnick2 = $gettok(%ds_string, 5, 32)
 
    %ds_tmp = $line(%ds_rtmp, 0, 1)
    :dsbeginfind
    %ds_ntmp = $line(%ds_rtmp, %ds_tmp, 1)
    if (%ds_ntmp == %ds_tnick2 || %ds_ntmp == $chr(46) $+ %ds_tnick2 || %ds_ntmp == $chr(64) $+ %ds_tnick2 || %ds_ntmp == $chr(43) $+ %ds_tnick2 || %ds_ntmp == $chr(37) $+ %ds_tnick2) {
    }
    else {
      dec %ds_tmp
      if (%ds_tmp > 0) { goto dsbeginfind }
    }

    if (%ds_tmp == 0) { return }
    if (%ds_tmode == +o) {
      rline -l %ds_rtmp %ds_tmp @ $+ %ds_tnick2
      if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        if (%ds_tnick == %ds_tnick2) {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.op.selfme,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы взяли себе ОП)
        }
        else {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.op.meto,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы дали ОП пользователю %ds_tnick2)
        }
      }
      elseif (%ds_tnick2 == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.op.me,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал Вам ОП)
      }
      elseif (%ds_tnick == %ds_tnick2) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.op.self,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал себе ОП)
      }
      else {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.op,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал ОП пользователю %ds_tnick2)
      }
      return
    }

    if (%ds_tmode == +q) {
      rline -l %ds_rtmp %ds_tmp . $+ %ds_tnick2
      if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        if (%ds_tnick == %ds_tnick2) {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.ow.selfme,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы взяли себе ОВНЕРА)
        }
        else {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.ow.meto,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы дали ОВНЕРА пользователю %ds_tnick2)
        }
      }
      elseif (%ds_tnick2 == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.ow.me,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал Вам ОВНЕРА)
      }
      elseif (%ds_tnick == %ds_tnick2) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.ow.self,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал себе ОВНЕРА)
      }
      else {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.ow,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал ОВНЕРА пользователю %ds_tnick2)
      }
      return
    }

    if (%ds_tmode == -o) {
      rline -l %ds_rtmp %ds_tmp %ds_tnick2
      if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        if (%ds_tnick == %ds_tnick2) {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deop.selfme,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы отобрали у себя ОП)
        }
        else {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deop.meto,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы отобрали ОП у пользователя %ds_tnick2)
        }
      }
      elseif (%ds_tnick2 == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deop.me,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал у Вас ОП)
      }
      elseif (%ds_tnick == %ds_tnick2) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deop.self,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал у себя ОП)
      }
      else {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deop,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал ОП у пользователя %ds_tnick2)
      }
      return
    }

    if (%ds_tmode == -q) {
      rline -l %ds_rtmp %ds_tmp %ds_tnick2
      if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        if (%ds_tnick == %ds_tnick2) {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deown.selfme,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы отобрали у себя ОВНЕРА)
        }
        else {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deown.meto,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы отобрали ОВНЕРА у пользователя %ds_tnick2)
        }
      }
      elseif (%ds_tnick2 == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deown.me,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал у Вас ОВНЕРА)
      }
      elseif (%ds_tnick == %ds_tnick2) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deown.self,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал у себя ОВНЕРА)
      }
      else {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.deown,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал ОВНЕРА у пользователя %ds_tnick2)
      }
      return
    }

    if (%ds_tmode == +v) {
      rline -l %ds_rtmp %ds_tmp $chr(43) $+ %ds_tnick2
      if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        if (%ds_tnick == %ds_tnick2) {
          window -g2 %ds_rtmp
          aline 2 %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.voise.selfme,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы дали себе право голоса)
        }
        else {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.voice.meto,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы дали право голоса пользователю %ds_tnick2)
        }
      }
      elseif (%ds_tnick2 == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.voice.me,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал Вам право голоса)
      }
      elseif (%ds_tnick == %ds_tnick2) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.voice.self,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал себе право голоса)
      }
      else {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.voice,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick дал право голоса пользователю %ds_tnick2)
      }
      return
    }

    if (%ds_tmode == -v) {
      rline -l %ds_rtmp %ds_tmp %ds_tnick2
      if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        if (%ds_tnick == %ds_tnick2) {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.devoice.selfme,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы отобрали у себя право голоса)
        }
        else {
          window -g2 %ds_rtmp
          echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.devoice.meto,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы отобрали право голоса у пользователя %ds_tnick2)
        }
      }
      elseif (%ds_tnick2 == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.devoice.me,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал у Вас право голоса)
      }
      elseif (%ds_tnick == %ds_tnick2) {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.devoice.self,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал у себя право голоса)
      }
      else {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.devoice,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick отобрал право голоса у пользователя %ds_tnick2)
      }
      return
    }

    return
  }

  if (%ds_raw == KICK) {
    %ds_tnick = $gettok(%ds_string, 1, 32)
    %ds_tmp = $len(%ds_tnick)
    dec %ds_tmp
    %ds_tnick = $right(%ds_tnick, %ds_tmp)
    %ds_tnick = $gettok(%ds_tnick, 1, 33)

    %ds_troom = $gettok(%ds_string, 3, 32)
    %ds_tnick2 = $gettok(%ds_string, 4, 32)
    %ds_tmess = $gettok(%ds_string, 2, 58)

    %ds_rtmp = @ $+ %ds_desc $+ . $+ %ds_troom
    %ds_rstat = @ $+ %ds_desc $+ .Status

    %ds_tmp = $line(%ds_rtmp, 0, 1)
    :dsbeginfind
    %ds_ntmp = $line(%ds_rtmp, %ds_tmp, 1)
    if (%ds_ntmp == %ds_tnick2 || %ds_ntmp == $chr(46) $+ %ds_tnick2 || %ds_ntmp == $chr(64) $+ %ds_tnick2) {
    }
    else {
      dec %ds_tmp
      if (%ds_tmp > 0) { goto dsbeginfind }
    }
    if (%ds_tmp == 0) { return }

    dline -l %ds_rtmp %ds_tmp
    if (%ds_tnick == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
      if (%ds_tnick == %ds_tnick2) {
        window -g2 %ds_rstat
        echo %ds_rstat $iif(%ActivSkinName != noskin, $mcskn.kick.selfme,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы кикнули себя из румы %ds_troom ( $+ %ds_tmess $+ ))
        window -c %ds_rtmp
      }
      else {
        window -g2 %ds_rtmp
        echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.kick.meto,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) Вы кикнули пользователя %ds_tnick2 ( $+ %ds_tmess $+ ))
      }
    }
    elseif (%ds_tnick2 == %ds_nick_ [ $+ [ mcon. [ $+ [ %ds_desc ] ] ] ] ) {
      window -g2 %ds_rstat
      echo %ds_rstat $iif(%ActivSkinName != noskin, $mcskn.kick.me,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick кикнул Вас из румы %ds_troom ( $+ %ds_tmess $+ ))
      window -c %ds_rtmp
    }
    elseif (%ds_tnick == %ds_tnick2) {
      window -g2 %ds_rtmp
      echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.kick.self,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick кикнул сам себя из румы %ds_troom ( $+ %ds_tmess $+ ))
    }
    else {
      window -g2 %ds_rtmp
      echo %ds_rtmp $iif(%ActivSkinName != noskin, $mcskn.kick,  $+ $colour(mode text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_tnick кикнул пользователя %ds_tnick2 из румы %ds_troom ( $+ %ds_tmess $+ ))
    }
    return
  }

  %ds_rstat = @ $+ %ds_desc $+ .Status
  window -g2 %ds_rstat
  echo %ds_rstat  $+ $colour(highlight text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) === %ds_string

}
