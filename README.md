# vagrant-stns-sample

VagrantでSTNSを使ったサーバ・クライアントのサンプルです。

## Usage

`vagrant up` でサーバとクライアントが立ち上がります。

```
vagrant up
```

サーバとクライアントは以下となっています。

- 以下の構成とします。
  - STNSサーバ
    - ホスト名：stns-server.example.internal
    - IPアドレス：10.240.0.100/24
  - STNSクライアント
    - ホスト名：stns-client.example.internal
    - IPアドレス：10.240.0.101/24
- 名前解決はvagrant-hostsupdater、vagrant-hostmanagerを使って、ホストからもゲスト間でも行えるようにしてあります。

鍵ペア＋グループ・ユーザ設定を作成します。

```
$ cd sample
$ ssh-keygen.sh
```

グループ・ユーザ設定ファイルが作成されるので、STNSサーバの/etc/stns/conf.dにアップロードします。

SNTSサーバを再起動

```
$ sudo systemctl restart stns
```

以下でログインを確認します。

```
ssh -i sample-keys/XXX.id_rsa XXX@stns-client.example.internal
```

