package Dancer::Debug;

# ABSTRACT: Extend Plack::Middleware::Debug with some specific panels for Dancer

use strict;
use warnings;
our $VERSION = '0.01';

1;


__END__
=pod

=head1 NAME

Dancer::Debug - Extend Plack::Middleware::Debug with some specific panels for Dancer

=head1 VERSION

version 0.01

=head1 SYNOPSIS

You can activate the panels in your development configuration file:

    plack_middlewares:
      Debug:
        - panels
        -
          - Parameters
          - Dancer::Version
          - Dancer::Settings
          - Dancer::Logger

or in your app.psgi:

    $handler = builder {
        enable "Debug",
            panels => [qw/Dancer::Settings Dancer::Logger Parameters Dancer::Version/];
        $handler;
    };

=head1 DESCRIPTION

Dancer::Debug extends L<Plack::Middleware::Debug> with some specific panels for Dancer.

=head1 AUTHOR

  franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by franck cuny.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

