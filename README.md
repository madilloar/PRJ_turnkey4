# PRJ_turnkey4
## 事前準備
### ホストOSでc3270エミュレータをインストールする
```
sudo apt-get install c3270
```

### ホストOSのxtermでHOMEキーとENDキーを使えるようにxterm_myを登録する
```
sudo tic xterm_my
```

### TeraTermでファンクションキーが使えるようにする
起動オプションで``/K=FUNCTION.CNF``を指定する。

## ビルド
```
docker-compose build
```

## mvs 起動
```
docker-compose up
```

## mvs 停止
TSOユーザで``READY``プロンプトにして
```
shutdown
```
で停止。

## TSOユーザ起動
```
./tso_user.sh
```
```
HERC01 CUL8TR
HERC02 CUL8TR
```


## 参考URL
ユーザマニュアル:
http://wotho.ethz.ch/tk4-/MVS_TK4-_v1.00_Users_Manual.pdf
