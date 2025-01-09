menu @*#* {
  dclick:{
    if ($mouse.lb) {
      var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
      %mcnick = $remove($sline($active,1), @, ., +, %)
      %mcsock = $gettok($mouse.win, 1, 46)
      %mctmp = $len(%mcsock)
      dec %mctmp
      %mcname = $right(%mcsock, %mctmp)
      %mcsock = mcon. $+ %mcname
      %mcchan = $deltok($active, 1, 46)
      var %mcnewwin = @ $+ %mcname $+ . $+ %mcnick
      window -ek0 %mcnewwin
    }
  }
  $mcmenu.c(Инфо, $chr(32)):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock whois %mcnick
  }
  $mcmenu.c(Приват, $chr(32)):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    var %mcnewwin = @ $+ %mcname $+ . $+ %mcnick
    window -ek0 %mcnewwin
  }
  $mcmenu.c(-, $chr(32))
  $mcmenu.c(Оператор, $chr(32))
  .Дать Оп (+o):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock mode %mcchan +o %mcnick
  }
  .Забрать Оп (-o):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock mode %mcchan -o %mcnick
  }
  .Дать голос (+v):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock mode %mcchan +v %mcnick
  }
  .Забрать голос (-v):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock mode %mcchan -v %mcnick
  }
  .Дать овнера (+q):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock mode %mcchan +q %mcnick
  }
  .Забрать овнера (-q):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock mode %mcchan -q %mcnick
  }
  .-
  .Забанить (+b):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock mode %mcchan +b %mcnick
  }
  .Разбанить (-b):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock mode %mcchan -b %mcnick
  }
  .-
  .Кикнуть:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock kick %mcchan %mcnick
  }
  $mcmenu.c(CTCP, $chr(32))
  .Версия:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock privmsg %mcnick : $+ VERSION
    echo -a  $+ $colour(CTCP text) $+ VERSION -> %mcnick
  }
  .Время:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock privmsg %mcnick : $+ TIME
    echo -a  $+ $colour(CTCP text) $+ TIME -> %mcnick
  }
  .Пинг:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock privmsg %mcnick : $+ PING $ctime $+ 
    echo -a  $+ $colour(CTCP text) $+ PING $ctime -> %mcnick
  }
  .Другое...:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $?="CTCP:"
    sockwrite -n %mcsock privmsg %mcnick : $+ %mcchan
    echo -a  $+ $colour(CTCP text) $+ %mcchan -> %mcnick
  }
  $mcmenu.c(Slaps, $chr(32)):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock privmsg %mcchan  : $+ ACTION slaps %mcnick around a bit with a large trout
    echo -a  $+ $colour(action text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_nick_ [ $+ [ %mcsock ] ] slaps %mcnick around a bit with a large trout
  }
  $mcmenu.c(-, $chr(32)):
  $mcmenu.c(Обновить список, $chr(32)):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock names %mcchan 
  }
  $mcmenu.c($chr(32), Войти на канал)
  .$REGchan(1):mcjoin $REGchan(1)
  .$REGchan(2):mcjoin $REGchan(2)
  .$REGchan(3):mcjoin $REGchan(3)
  .$REGchan(4):mcjoin $REGchan(4)
  .$REGchan(5):mcjoin $REGchan(5)
  .$REGchan(6):mcjoin $REGchan(6)
  .$REGchan(7):mcjoin $REGchan(7)
  .$REGchan(8):mcjoin $REGchan(8)
  .$REGchan(9):mcjoin $REGchan(9)
  .-
  .$NRchan(1):mcjoin $NRchan(1)
  .$NRchan(2):mcjoin $NRchan(2)
  .$NRchan(3):mcjoin $NRchan(3)
  .$NRchan(4):mcjoin $NRchan(4)
  .$NRchan(5):mcjoin $NRchan(5)
  .$NRchan(6):mcjoin $NRchan(6)
  .$NRchan(7):mcjoin $NRchan(7)
  .$NRchan(8):mcjoin $NRchan(8)
  .$NRchan(9):mcjoin $NRchan(9)
  .$NRchan(10):mcjoin $NRchan(10)
  .$NRchan(11):mcjoin $NRchan(11)
  .$NRchan(12):mcjoin $NRchan(12)
  .$NRchan(13):mcjoin $NRchan(13)
  .$NRchan(14):mcjoin $NRchan(14)
  .$NRchan(15):mcjoin $NRchan(15)
  .$NRchan(16):mcjoin $NRchan(16)
  .$NRchan(17):mcjoin $NRchan(17)
  .$NRchan(18):mcjoin $NRchan(18)
  .$NRchan(19):mcjoin $NRchan(19)
  .$NRchan(20):mcjoin $NRchan(20)
  .$NRchan(21):mcjoin $NRchan(21)
  .-
  .Другой канал...:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock join $?="Имя канала?"
  }
  $mcmenu.c($chr(32), Сменить ник)
  .$REGnick(1):mcnick $REGnick(1)
  .$REGnick(2):mcnick $REGnick(2)
  .$REGnick(3):mcnick $REGnick(3)
  .$REGnick(4):mcnick $REGnick(4)
  .$REGnick(5):mcnick $REGnick(5)
  .$REGnick(6):mcnick $REGnick(6)
  .$REGnick(7):mcnick $REGnick(7)
  .$REGnick(8):mcnick $REGnick(8)
  .$REGnick(9):mcnick $REGnick(9)
  .-
  .$NRnick(1):mcnick $NRnick(1)
  .$NRnick(2):mcnick $NRnick(2)
  .$NRnick(3):mcnick $NRnick(3)
  .$NRnick(4):mcnick $NRnick(4)
  .$NRnick(5):mcnick $NRnick(5)
  .$NRnick(6):mcnick $NRnick(6)
  .$NRnick(7):mcnick $NRnick(7)
  .$NRnick(8):mcnick $NRnick(8)
  .$NRnick(9):mcnick $NRnick(9)
  .$NRnick(10):mcnick $NRnick(10)
  .$NRnick(11):mcnick $NRnick(11)
  .$NRnick(12):mcnick $NRnick(12)
  .$NRnick(13):mcnick $NRnick(13)
  .$NRnick(14):mcnick $NRnick(14)
  .$NRnick(15):mcnick $NRnick(15)
  .$NRnick(16):mcnick $NRnick(16)
  .$NRnick(17):mcnick $NRnick(17)
  .$NRnick(18):mcnick $NRnick(18)
  .$NRnick(19):mcnick $NRnick(19)
  .$NRnick(20):mcnick $NRnick(20)
  .$NRnick(21):mcnick $NRnick(21)
  .-
  .Другой...:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock nick $?="Ник?"
  }
  $mcmenu.c($chr(32), CTCP)
  .Версия:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock privmsg %mcchan : $+ VERSION
    echo -a  $+ $colour(CTCP text) $+ VERSION -> %mcchan
  }
  .Время:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock privmsg %mcchan : $+ TIME
    echo -a  $+ $colour(CTCP text) $+ TIME -> %mcchan
  }
  .Пинг:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock privmsg %mcchan : $+ PING $ctime
    echo -a  $+ $colour(CTCP text) $+ PING $ctime -> %mcchan
  }
  .Другое...:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    %mctmp = $?="CTCP:"
    sockwrite -n %mcsock privmsg %mcchan : $+ %mctmp
    echo -a  $+ $colour(CTCP text) $+ %mctmp -> %mchann
  }
  $mcmenu.c($chr(32), Away)
  .$strip($gettok($awayReasons(1),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(1)
  .$strip($gettok($awayReasons(2),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(2)
  .$strip($gettok($awayReasons(3),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(3)
  .$strip($gettok($awayReasons(4),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(4)
  .$strip($gettok($awayReasons(5),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(5)
  .$strip($gettok($awayReasons(6),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(6)
  .$strip($gettok($awayReasons(7),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(7)
  .$strip($gettok($awayReasons(8),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(8)
  .$strip($gettok($awayReasons(9),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(9)
  .$strip($gettok($awayReasons(10),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(10)
  .$strip($gettok($awayReasons(11),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(11)
  .$strip($gettok($awayReasons(12),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(12)
  .$strip($gettok($awayReasons(13),1- [ $+ [ %awayMsgWInd ] ] ,32)):mcgoneaway $awayReasons(13)
  .-
  .По другой причине:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 2, 46)
    %mctmp = $?="По причине?"
    sockwrite -n %mcsock away  : $+ %mctmp

    %ds_rtmp = %mcchan $+ .#*
    %ds_nroom = $window(%ds_rtmp, 0)

    :dsbeginrfind1
    if (%ds_nroom > 0) {
      %ds_troom = $window(%ds_rtmp, %ds_nroom)
      %mcchan = $deltok(%ds_troom, 1, 46)
      sockwrite -n %mcsock privmsg %mcchan :ACTION вышел в AWAY по причине %mctmp 
      echo %ds_troom  $+ $colour(action text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_nick_ [ $+ [ %mcsock ] ] вышел в AWAY по причине: %mctmp
      dec %ds_nroom
      goto dsbeginrfind1
    }
  }
  .-
  .Вернуться:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, ., +, %)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock away
  }
}

menu @*.Status {
  $mcmenu.c($chr(32), Войти на канал)
  .$REGchan(1):mcjoin $REGchan(1)
  .$REGchan(2):mcjoin $REGchan(2)
  .$REGchan(3):mcjoin $REGchan(3)
  .$REGchan(4):mcjoin $REGchan(4)
  .$REGchan(5):mcjoin $REGchan(5)
  .$REGchan(6):mcjoin $REGchan(6)
  .$REGchan(7):mcjoin $REGchan(7)
  .$REGchan(8):mcjoin $REGchan(8)
  .$REGchan(9):mcjoin $REGchan(9)
  .-
  .$NRchan(1):mcjoin $NRchan(1)
  .$NRchan(2):mcjoin $NRchan(2)
  .$NRchan(3):mcjoin $NRchan(3)
  .$NRchan(4):mcjoin $NRchan(4)
  .$NRchan(5):mcjoin $NRchan(5)
  .$NRchan(6):mcjoin $NRchan(6)
  .$NRchan(7):mcjoin $NRchan(7)
  .$NRchan(8):mcjoin $NRchan(8)
  .$NRchan(9):mcjoin $NRchan(9)
  .$NRchan(10):mcjoin $NRchan(10)
  .$NRchan(11):mcjoin $NRchan(11)
  .$NRchan(12):mcjoin $NRchan(12)
  .$NRchan(13):mcjoin $NRchan(13)
  .$NRchan(14):mcjoin $NRchan(14)
  .$NRchan(15):mcjoin $NRchan(15)
  .$NRchan(16):mcjoin $NRchan(16)
  .$NRchan(17):mcjoin $NRchan(17)
  .$NRchan(18):mcjoin $NRchan(18)
  .$NRchan(19):mcjoin $NRchan(19)
  .$NRchan(20):mcjoin $NRchan(20)
  .$NRchan(21):mcjoin $NRchan(21)
  .-
  .Другой канал...:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, .)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock join $?="Имя канала?"
  }
  $mcmenu.c($chr(32), Сменить ник)
  .$REGnick(1):mcnick $REGnick(1)
  .$REGnick(2):mcnick $REGnick(2)
  .$REGnick(3):mcnick $REGnick(3)
  .$REGnick(4):mcnick $REGnick(4)
  .$REGnick(5):mcnick $REGnick(5)
  .$REGnick(6):mcnick $REGnick(6)
  .$REGnick(7):mcnick $REGnick(7)
  .$REGnick(8):mcnick $REGnick(8)
  .$REGnick(9):mcnick $REGnick(9)
  .-
  .$NRnick(1):mcnick $NRnick(1)
  .$NRnick(2):mcnick $NRnick(2)
  .$NRnick(3):mcnick $NRnick(3)
  .$NRnick(4):mcnick $NRnick(4)
  .$NRnick(5):mcnick $NRnick(5)
  .$NRnick(6):mcnick $NRnick(6)
  .$NRnick(7):mcnick $NRnick(7)
  .$NRnick(8):mcnick $NRnick(8)
  .$NRnick(9):mcnick $NRnick(9)
  .$NRnick(10):mcnick $NRnick(10)
  .$NRnick(11):mcnick $NRnick(11)
  .$NRnick(12):mcnick $NRnick(12)
  .$NRnick(13):mcnick $NRnick(13)
  .$NRnick(14):mcnick $NRnick(14)
  .$NRnick(15):mcnick $NRnick(15)
  .$NRnick(16):mcnick $NRnick(16)
  .$NRnick(17):mcnick $NRnick(17)
  .$NRnick(18):mcnick $NRnick(18)
  .$NRnick(19):mcnick $NRnick(19)
  .$NRnick(20):mcnick $NRnick(20)
  .$NRnick(21):mcnick $NRnick(21)
  .-
  .Другой...:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, .)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock nick $?="Ник?"
  }
  $mcmenu.c($chr(32), -)
  $mcmenu.c($chr(32), Сервер)
  .Версия:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, .)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock VERSION
    echo -a  $+ $colour(CTCP text) $+ -> Server VERSION
  }
  .MOTD:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, .)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock MOTD
    echo -a  $+ $colour(CTCP text) $+ -> Server MOTD
  }
  .Время:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, .)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock TIME
    echo -a  $+ $colour(CTCP text) $+ -> Server TIME
  }
  .Связи:{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, .)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock LINKS
    echo -a  $+ $colour(CTCP text) $+ -> Server LINKS
  }
  $mcmenu.c($chr(32), Список каналов...):{
    var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
    %mcnick = $remove($sline($active,1), @, .)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    %mcchan = $deltok($active, 1, 46)
    sockwrite -n %mcsock list $?="Маска для вывода списка каналов:"
  }
}

menu @*.Channels {
  dclick:{
    if ($mouse.lb) {
      var %mcchan, %mcsock, %mctmp, %mcname
      %mcchan = $gettok($sline($active,1), 1, 9)
      %mcsock = $gettok($active, 1, 46)
      %mctmp = $len(%mcsock)
      dec %mctmp
      %mcname = $right(%mcsock, %mctmp)
      %mcsock = mcon. $+ %mcname
      sockwrite -n %mcsock join %mcchan
    }
  }
  $mcmenu.c(Войти на канал, $chr(32)):{
    var %mcchan, %mcsock, %mctmp, %mcname
    %mcchan = $gettok($sline($active,1), 1, 9)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    sockwrite -n %mcsock join %mcchan
  }
  $mcmenu.c(Список пользователей, $chr(32)):{
    var %mcchan, %mcsock, %mctmp, %mcname
    %mcchan = $gettok($sline($active,1), 1, 9)
    %mcsock = $gettok($active, 1, 46)
    %mctmp = $len(%mcsock)
    dec %mctmp
    %mcname = $right(%mcsock, %mctmp)
    %mcsock = mcon. $+ %mcname
    sockwrite -n %mcsock names %mcchan
  }
}

menu @*.* {
  -
  Очистить:/clear $active
}

alias mcmenu.c {
  return $iif($mouse.lb, $1, $2)
}

alias mcnick {
  var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
  %mcsock = $gettok($active, 1, 46)
  %mctmp = $len(%mcsock)
  dec %mctmp
  %mcname = $right(%mcsock, %mctmp)
  %mcsock = mcon. $+ %mcname
  sockwrite -n %mcsock nick $1
}

alias mcjoin {
  var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
  %mcsock = $gettok($active, 1, 46)
  %mctmp = $len(%mcsock)
  dec %mctmp
  %mcname = $right(%mcsock, %mctmp)
  %mcsock = mcon. $+ %mcname
  sockwrite -n %mcsock join $1
}

alias mcgoneaway {
  var %mcnick, %mcchan, %mcsock, %mctmp, %mcname
  %mcnick = $remove($sline($active,1), @, .)
  %mcsock = $gettok($active, 1, 46)
  %mctmp = $len(%mcsock)
  dec %mctmp
  %mcname = $right(%mcsock, %mctmp)
  %mcsock = mcon. $+ %mcname
  %mcchan = $deltok($active, 2, 46)
  %mctmp = $1-
  sockwrite -n %mcsock away  : $+ %mctmp

  %ds_rtmp = %mcchan $+ .#*
  %ds_nroom = $window(%ds_rtmp, 0)

  :dsbeginrfind1
  if (%ds_nroom > 0) {
    %ds_troom = $window(%ds_rtmp, %ds_nroom)
    %mcchan = $deltok(%ds_troom, 1, 46)
    sockwrite -n %mcsock privmsg %mcchan :ACTION вышел в AWAY по причине %mctmp 
    echo %ds_troom  $+ $colour(action text) $+ $chr(91) $+ $asctime(HH:nn) $+ $chr(93) %ds_nick_ [ $+ [ %mcsock ] ] вышел в AWAY по причине: %mctmp
    dec %ds_nroom
    goto dsbeginrfind1
  }
}
