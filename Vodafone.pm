package SMS::Send::IS::Vodafone;
use strict;

use SMS::Send::Driver ();
use LWP::UserAgent ();
use HTTP::Cookies ();

our $VERSION = '0.02';

our @ISA = 'SMS::Send::Driver';

sub new
{
    my ($pkg) = @_;

    my $ua = LWP::UserAgent->new(
        agent      => sprintf("%s/%s", __PACKAGE__, $VERSION),
        cookie_jar => {},
    );

    bless \$ua => $pkg;
}

sub send_sms
{
    my ($self, %arg) = @_;

    # Input longer than 100 chars will fail anyway
    if (length $arg{text} > 100) {
        require Carp;
        Carp::croak("text length limit is 100 characters");
    }

    # Don't request a cookie from the main page if we have it cached
    unless ($$self->cookie_jar and $$self->cookie_jar->as_string) {
        my $res = $$self->get('http://vodafone.is');

        return unless $res->is_success;
    }

    # We have a cookie, query the sending script
    my $uri = URI->new('http://vodafone.is/sms-kubbur/redirect.php');

    # Construct GET parameters
    $uri->query_form(
        phone => $arg{to},
        text  => $arg{text},
        ref   => 'http://vodofone.is/',
        rnd   => time + rand,
    );

    my $res = $$self->get($$uri,
        Referer => 'http://vodafone.is',
    );

    $res->is_success;
}

1;

__END__

=head1 NAME

SMS::Send::IS::Vodafone - SMS::Send driver for vodafone.is

=head1 SYNOPSIS

    use SMS::Send;

    my $sender = SMS::Send->new("IS::Vodafone");

    my $ok = $ender->send_sms(
        to   => '6811337',
        text => 'Y hlo thar',
    );

    if ($ok) {
        print "Yay SMS\n";
    } else {
        print "Oh noes failure\n";
    }

=head1 DESCRIPTION

A regional L<SMS::Send> driver for Iceland that deliers messages via
L<http://vodafone.is>. Vodafone only supports ending sms messages to
its own users, see L<SMS::Send::IS::Vit> for sending SMS to
SE<iacute>minn users.

=head1 AUTHOR

E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avar@cpan.org>

=head1 LICENSE

Copyright 2007-2008 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
