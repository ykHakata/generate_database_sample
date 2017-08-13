use strict;
use warnings;
use utf8;
use Getopt::Long;
use File::Temp;
use Data::Dumper;

my $conf = +{ files => \@ARGV, };

my $self = __PACKAGE__->new($conf);

# データベース作成
$self->_generate_database();

# データベーススキーマー作成
$self->_generate_schema_sqlite3();

# サンプルデーター読み込み
# $self->_import_sample_data_sqlite3();

sub new {
    my $class = shift;
    my $self  = shift;
    if ( !ref $self ) {
        $self = +{};
    }
    return bless $self, $class;
}

sub get_files {
    my $self = shift;
    return $self->{files};
}

sub _generate_database {
    my $self  = shift;
    my $files = $self->get_files;

    # ファイル指定がない場合はそのまま終了
    return if !scalar @{$files};
    my $db_file = $files->[0];
    my $db_file_fh = IO::File->new( $db_file, '>' )
        or die "can't open '$db_file': $!";
    $db_file_fh->close;
    return;
}

sub _generate_schema_sqlite3 {
    my $self = shift;

    my $files = $self->get_files;

    # ファイル指定がない場合はそのまま終了
    return if !scalar @{$files};
    my $db     = $files->[0];
    my $schema = $files->[1];
    die 'not existence schema file' if !-e $schema;

    # 例: sqlite3 ./db/test.db < ./db/schema.sql
    my $cmd = "sqlite3 $db < $schema";

    # system コマンドは失敗すると true になる
    system $cmd and die "Couldn'n run: $cmd ($!)";
    return;
}

__END__
