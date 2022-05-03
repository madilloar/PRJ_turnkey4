# turnkey4 mvs38j docker project

まずは、このプロジェクトを``git clone``します。

```
git clone https://github.com/madilloar/PRJ_turnkey4.git
```

## 事前準備
### ホストOSでc3270エミュレータをインストールする
```
sudo apt-get install c3270
```

### ホストOSのxtermでHOMEキーとENDキーを使えるようにxterm_myを登録する
```
sudo tic xterm_my.src
```

### TeraTermでファンクションキーが使えるようにする
``TeraTerm_VT220.CNF``ファイルを``ttermpro.exe``と同じフォルダに置きます。
そして、``ttermpro.exe``の起動引数に``/K=TeraTerm_VT220.CNF``を指定します。

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
https://wotho.ethz.ch/tk4-/MVS_TK4-_v1.00_Users_Manual.pdf
