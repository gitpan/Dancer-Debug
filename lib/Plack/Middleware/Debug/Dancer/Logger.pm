package Plack::Middleware::Debug::Dancer::Logger;
BEGIN {
  $Plack::Middleware::Debug::Dancer::Logger::VERSION = '0.02';
}

# ABSTRACT: Log message from you Dancer's application

use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);
use Dancer::Logger;
use Class::Method::Modifiers qw(install_modifier);

# XXX Not thread/Coro/AE safe. Should use $c->env or something
my $psgi_env;
install_modifier 'Dancer::Logger', 'around', 'warning' => sub {
    my $orig = shift;
    my $self = shift;
    _add_log( 'warning', $_[0] );
    $self->$orig(@_);
};

install_modifier 'Dancer::Logger', 'around', 'error' => sub {
    my $orig = shift;
    my $self = shift;
    _add_log( 'error', $_[0] );
    $self->$orig(@_);
};

install_modifier 'Dancer::Logger', 'around', 'debug' => sub {
    my $orig = shift;
    my $self = shift;
    _add_log( 'debug', $_[0] );
    $self->$orig(@_);
};

sub _add_log {
    my ( $level, $msg ) = @_;
    push @{ $psgi_env->{'plack.middleware.dancer_log'} }, $level, $msg;
}

sub run {
    my ( $self, $env, $panel ) = @_;
    $psgi_env = $env;

    return sub {
        my $res = shift;

        $panel->title('Dancer::Logger');
        $panel->nav_subtitle('Dancer::Logger');
        my $logs = delete $env->{'plack.middleware.dancer_log'};
        $panel->content( sub { $self->render_list_pairs($logs) } );
        $psgi_env = undef;
    };
}

1;


__END__
=pod

=head1 NAME

Plack::Middleware::Debug::Dancer::Logger - Log message from you Dancer's application

=head1 VERSION

version 0.02

=head1 SYNOPSIS

To activate this panel:

    plack_middlewares:
      Debug:
        - panels
        -
          - Dancer::Logger

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by franck cuny.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

