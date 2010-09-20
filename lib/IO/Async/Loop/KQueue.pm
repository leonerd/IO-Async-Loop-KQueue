package IO::Async::Loop::KQueue;

use strict;
use warnings;
use Carp;

use IO::KQueue;
use base qw( IO::Async::Loop );

use constant API_VERSION => '0.24';

=head1 NAME

L<IO::Async::Loop::KQueue> - use C<IO::Async> with C<kqueue>

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use IO::Async::Loop::KQueue;
    
    my $loop = IO::Async::Loop::KQueue->new();
    
    $loop->add( IO::Async::Signal->new(
        name => '',
	on_receipt => sub { ... },
    ) );

=head1 METHODS

=head2 new

=cut

sub new
{
	my $class = shift;
	my ( %args ) = @_;

	my $kq = IO::KQueue->new() or croak "Cannot create kqueue handle - $!";

	my $self = $class->SUPER::__new( %args );
	$self->{kqueue} = $kq;

	return $self;
}

# Overrides
sub watch_io
{
	my $self = shift;
	my %params = @_;

	$self->__watch_io( %params );

	my $handle = $params{handle};
	my $fd = $handle->fileno;

	my $curmask = $self->{masks}->{$fd} || 0;

	my $mask = $curmask;

	#TODO GOTTA DO MORE HACKING HERE
	
}

=head1 AUTHOR

Squeeks, C<< <squeek at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-io-async-loop-kqueue at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=IO-Async-Loop-KQueue>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc IO::Async::Loop::KQueue

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=IO-Async-Loop-KQueue>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/IO-Async-Loop-KQueue>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/IO-Async-Loop-KQueue>

=item * Search CPAN

L<http://search.cpan.org/dist/IO-Async-Loop-KQueue/>

=back


=head1 ACKNOWLEDGEMENTS

Paul Evans (LeoNerd) for convincing me on IRC to do this.

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Squeeks.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of IO::Async::Loop::KQueue