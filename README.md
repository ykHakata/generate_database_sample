# NAME

genedb - generate database sample データベースへサンプルデータを作成

# SYNOPSIS

```
genedb file1 file2 file3
```

# DESCRIPTION

```
web アプリを開発する際に、データベースのデータを初期化したい場合がある
テストコード実行時や別の環境でアプリ開発する場合の初期データーの作成時など
作成するテーブルが一つの場合は簡単だが、複数のテーブル、複数のデータになると
多少手間が必要になる、今まではその都度過去のコードを参考に web アプリの中で動く
コマンドラインアプリを作っていたが、共通利用できるようにロジックをまとめた

2017年8月
```

# OPTIONS

# SETUP

```
(sqlite3 が使えることの確認)
$ which sqlite3
/usr/bin/sqlite3

(任意のディレクトリにサンプルスキーマー、データを準備)
$ cd ~/db/
$ ls -l
total 0
-rw-r--r--@ 1 yk  staff  0  8 11 23:59 sample.csv
-rw-r--r--@ 1 yk  staff  0  8 11 23:58 schema.sql
```

スキーマーの例: `schema.sql`

```sql
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    login_id        TEXT,
    password        TEXT,
    authority       INTEGER,
    deleted         INTEGER,
    create_ts       TEXT,
    modify_ts       TEXT
);
```

データの例: `sample.csv`

```
ID,ログインID,ログインパスワード,管理者権限,削除フラグ,登録日時,修正日時
id,login_id,password,authority,deleted,create_ts,modify_ts
1,sample.data.system@gmail.com,hackerz,1,0,2016-01-08 12:24:12,2016-01-08 12:24:12
2,sample.data.sudo@gmail.com,sudo,2,0,2016-01-08 12:24:12,2016-01-08 12:24:12
3,sample.data.admin@gmail.com,admin,3,0,2016-01-08 12:24:12,2016-01-08 12:24:12
4,sample.data.general@gmail.com,general,4,0,2016-01-08 12:24:12,2016-01-08 12:24:12
5,sample.data.guest@gmail.com,guest,5,0,2016-01-08 12:24:12,2016-01-08 12:24:12
```

# EXAMPLES

```
(データベース名を test.db に指定)
$ genedb ./db/test.db ./db/schema.sql ./db/sample.csv
```

# SEE ALSO

# HISTORY
