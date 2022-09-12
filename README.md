# turnkey4 mvs38j docker project

wsl2で以下を試してます。
まずは、このプロジェクトを``git clone``します。

```
git clone https://github.com/madilloar/PRJ_turnkey4.git
```

## ホストOSでc3270エミュレータをインストールする
```
sudo apt-get install c3270
```

## ホストOSでHOMEキーとENDキーを使えるようにxterm_myを登録する
```
sudo tic xterm_my.src
```

## ビルド
```
docker-compose build
```

## mvs 起動
```
docker-compose up -d
```

## mvsの実行状況をlogで確認
```
docker exec -it prj_turnkey4_turnkey4_1 bash -c 'tail -f /opt/turnkey4/log/3033.log'
```

これがログに出たら起動完了。
```
HHC01603I *
HHC01603I *                           ************   ****  *****          ||
HHC01603I *                           **   **   **    **    **           |||
HHC01603I *                           **   **   **    **   **           ||||
HHC01603I *                                **         **  **           || ||
HHC01603I *        |l      _,,,---,,_      **         ** **           ||  ||
HHC01603I * ZZZzz /,'.-'`'    -.  ;-;;,    **         ****           ||   ||
HHC01603I *      |,4-  ) )-,_. ,( (  ''-'  **         *****         ||    ||
HHC01603I *     '---''(_/--'  `-')_)       **         **  **       ||     ||    ||||||||||
HHC01603I *                                **         **   **      |||||||||||  Update 08
HHC01603I *       The MVS 3.8j             **         **    **            ||
HHC01603I *     Tur(n)key System           **         **     **           ||
HHC01603I *                              ******      ****     ***       ||||||
HHC01603I *
HHC01603I *            TK3 created by Volker Bandke       vbandke@bsp-gmbh.com
HHC01603I *            TK4- update by Juergen Winkelmann  winkelmann@id.ethz.ch
HHC01603I *                     see TK4-.CREDITS for complete credits
HHC01603I *
HHC02264I Script 5: file scripts/tk4-.rc processing ended
```

## TSOユーザ起動
起動を確認したら、TSOユーザでLOGONします。

次のコマンドを打つと、
```
./tso_user.sh
```

下記のように表示されます。

```
Terminal   CUU0C1                                                 Date  11.09.22
                                                                  Time  09:12:13

                           ************   ****  *****          ||
                           **   **   **    **    **           |||
                           **   **   **    **   **           ||||
                                **         **  **           || ||
        |l      _,,,---,,_      **         ** **           ||  ||
 ZZZzz /,'.-'`'    -.  ;-;;,    **         ****           ||   ||
      |,4-  ) )-,_. ,( (  ''-'  **         *****         ||    ||
     '---''(_/--'  `-')_)       **         **  **       ||     ||    ||||||||||
                                **         **   **      |||||||||||
       The MVS 3.8j             **         **    **            ||
     Tur(n)key System           **         **     **           ||
                              ******      ****     ***       ||||||

            TK3 created by Volker Bandke       vbandke@bsp-gmbh.com
            TK4- update by Juergen Winkelmann  winkelmann@id.ethz.ch
                     see TK4-.CREDITS for complete credits

                              MVS 3.8j Level 8505

Logon ===>
                                                            RUNNING  TK4-
```

``Logon ===>``プロンプトのところで``HERC01``と入力します。

`` ENTER CURRENT PASSWORD FOR HERC01-``とパスワード要求が来ますので、``CUL8TR``と入力します。

すると、次のように表示されますので、

```
 ENTER CURRENT PASSWORD FOR HERC01-

 HERC01 LOGON IN PROGRESS AT 09:15:57 ON SEPTEMBER 11, 2022
 NO BROADCAST MESSAGES
 *****************************************************************************
 *                                                                           *
 *                                                                           *
 *                    Welcome to the TSO system on TK4-                      *
 *                    =================================                      *
 *                                                                           *
 *                                                                           *
 *****************************************************************************
 ***
```

``Enter``キーを押下します。すると、次のように表示されますので、

```
                |l      _,,,---,,_
          ZZZzz /,`.-'`'    -.  ;-;;,
               |,4-  ) )-,_. ,( (  `'-'
              '---''(_/--'  :-')_)

 "Little else matters than to write good code."
 - Karl Lehenbauer

 Another bit of wisdom from the fortune cookie jar

 ***
```

``Enter``キーを押下します。すると、次のように表示されたら、OKです。

```
 Terminal  CUU0C1                                                 Date  11.09.22
 System    TK4-                                                   Time  09:18:16
 TSO User  HERC01

 Option ===> 1

               The MVS 3.8j Tur(n)key System
        TK4- Version 1.00 Update 08 -- MVS PUT 8505

                      TSO Applications


      1  RFE        "SPF like" productivity tool
      2  RPF        "SPF like" productivity tool
      3  IM         IMON/370 system monitor
      4  QUEUE      spool browser
      5  HELP       general TSO help
      6  UTILS      information on utilities and commands available
      7  TERMTEST   verify 3270 terminal capabilities

                    Enter X to Terminate

  PF3=Terminate
```

あらかじめ用意されているTSOユーザ。

```
HERC01 CUL8TR
HERC02 CUL8TR
```

## mvs 停止
F3キーをどんどん押していくと、``READY``プロンプトにします。

```
        ******************************************************
        *** TSO Applications Menu terminated.              ***
        *** Enter TSOAPPLS at the READY prompt to restart. ***
        ******************************************************
 READY
```

ここで、``shutdown``と入力し、``Enter``キーを押下します。

```
 READY
shutdown
 JOB SHUTDOWN(JOB00001) SUBMITTED
 READY
```

``mvsの実行状況をlogで確認``でログを表示しているとわかりますが、次のログが最後に表示されて終了です。

```
09.23.40           $HASP085 JES2 TERMINATION COMPLETE
```

## COBOLプログラムを作って、Hello World!を試す
COBOLプログラムとそれをコンパイル＆リンクするJCLの``hello.jcl``を``hercsub``perlスクリプトを使って、mvsのポート3050に流し込んでSUBMITします。

```
./hercsub localhost:3505 hellocob.jcl
```

mvsのlogに次が出ていると思います。

```
HHC01040I 0:000C COMM: client <unknown>, ip 172.18.0.1 connected to device 3505
HHC01206I 0:000C Card: client <unknown>, ip 172.18.0.1 disconnected from device 3505
11.17.39 JOB    2  $HASP100 COBOL    ON READER1     MADILLOAR
11.17.39 JOB    2  IEF677I WARNING MESSAGE(S) FOR JOB COBOL    ISSUED
11.17.39 JOB    2  $HASP373 COBOL    STARTED - INIT  1 - CLASS A - SYS TK4-
11.17.39 JOB    2  IEF403I COBOL - STARTED - TIME=11.17.39
11.17.39 JOB    2  +Hello World!
11.17.39 JOB    2  IEF404I COBOL - ENDED - TIME=11.17.39
11.17.39 JOB    2  $HASP395 COBOL    ENDED
11.17.39           $HASP309    INIT  1 INACTIVE ******** C=A
11.17.39 JOB    2  $HASP150 COBOL    ON PRINTER1       370 LINES
11.17.39           $HASP160 PRINTER1 INACTIVE - CLASS=A
11.17.39 JOB    2  $HASP250 COBOL    IS PURGED
11.29.52 STC   28  $HASP150 MF1      ON PRINTER1       211 LINES
11.29.52           $HASP160 PRINTER1 INACTIVE - CLASS=A
11.29.52 STC   28  IRB101I MF/1 REPORT AVAILABLE FOR PRINTING
```
## 参考URL
ユーザマニュアル:
https://wotho.ethz.ch/tk4-/MVS_TK4-_v1.00_Users_Manual.pdf

## TeraTermでファンクションキーが使えるようにする
``TeraTerm_VT220.CNF``ファイルを``ttermpro.exe``と同じフォルダに置きます。
そして、``ttermpro.exe``の起動引数に``/K=TeraTerm_VT220.CNF``を指定します。

