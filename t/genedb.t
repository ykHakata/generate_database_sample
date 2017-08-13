use strict;
use warnings;
use utf8;
use Test::More;
use File::Temp;
use Data::Dumper;
use FindBin;

# system コマンドは失敗すると true になる
# コマンド実行に成功
subtest 'success cmd' => sub {
    my $val = system 'perl genedb.pl';
    is( $val, 0, 'system start' );
};

# コマンド実行に失敗
subtest 'fail cmd' => sub {
    my $val = system 'perl genedb.p';
    isnt( $val, 0, 'system start' );
};

# データベースファイル作成
subtest 'database file' => sub {
    subtest 'success create' => sub {

        # DB ファイルを作成する場所
        my $dir   = $FindBin::Bin;
        my $tmdir = File::Temp->newdir(
            DIR     => $dir,
            CLEANUP => 1,
        );

        my $db_file     = $tmdir . '/test.db';
        my $schema_file = $dir . '/schema.sql';
        my $csv_file    = $dir . '/sample.csv';

        # ファイルが存在しないことの確認
        ok( !-e $db_file, 'db file' );

        _start_genedb( $db_file, $schema_file, $csv_file );

        # ファイル存在確認
        ok( -e $db_file, 'db file' );

        my $schema_fh = IO::File->new( $schema_file, '<' )
            or die "can't open '$schema_file': $!";
        my @schema_text_org = $schema_fh->getlines;
        $schema_fh->close;

        shift @schema_text_org;
        my $schema_text;
        map { $schema_text .= $_ } @schema_text_org;
        my $schema_text_cmd = `sqlite3 $db_file .schema`;

        # データベーススキーマー作成
        is( $schema_text, $schema_text_cmd, 'schema text' );
    };
};


# サンプルデーター読み込み

# 完成形の DB ファイルの中身を検証

# テスト用実行コマンド
# $ genedb ./db/test.db ./db/schema.sql ./db/sample.csv
sub _start_genedb {
    my $db_file     = shift || '';
    my $schema_file = shift || '';
    my $csv_file    = shift || '';
    my $cmd = qq{perl genedb.pl $db_file $schema_file $csv_file};
    my $val = system $cmd;
    is( $val, 0, 'system start' );
}

done_testing;

__END__
