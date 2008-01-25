use ExtUtils::MakeMaker;

WriteMakefile(
    NAME		  => 'SMS::Send::IS::Vodafone',
    AUTHOR        => 'Ævar Arnfjörð Bjarmason <avar@cpan.org>',
    ABSTRACT_FROM => 'Vodafone.pm',
    VERSION_FROM  => 'Vodafone.pm',
    LICENSE       => 'perl',
    PREREQ_PM     => {
        # Vodafone.pm
        'SMS::Send::Driver' => '0.04',
        'LWP::UserAgent'    => 0,
        'HTTP::Cookies'     => 0,

        # t/
        'Test::More' => 0,
    },
);
