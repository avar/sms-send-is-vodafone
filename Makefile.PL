use utf8;
use inc::Module::Install;

name 'SMS-Send-IS-Vodafone';

author 'Ævar Arnfjörð Bjarmason <avar@cpan.org>';

abstract_from 'Vodafone.pm';
license_from  'Vodafone.pm';
version_from  'Vodafone.pm';

# Vodafone.pm
requires 'SMS::Send::Driver' => '0.04';
requires 'LWP::UserAgent';
requires 'HTTP::Cookies';

# t/
build_requires 'Test::More' => 0; # 5.007003

tests 't/*.t';

auto_install;
WriteAll;
