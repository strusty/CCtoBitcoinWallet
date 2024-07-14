#!/usr/bin/perl
use strict;
use warnings;
use feature qw(say);
use Bitcoin::Crypto::Key::ExtPrivate;

# get the input values
print "Enter the credit card number: ";
my $cc_number = <STDIN>;
chomp $cc_number;

print "Enter the expiration (MM/YY): ";
my $expiration = <STDIN>;
chomp $expiration;

print "Enter the CVV code: ";
my $cvv = <STDIN>;
chomp $cvv;

print "Enter your first name: ";
my $first_name = <STDIN>;
chomp $first_name;

print "Enter your middle name: ";
my $middle_name = <STDIN>;
chomp $middle_name;

print "Enter your last name: ";
my $last_name = <STDIN>;
chomp $last_name;

print "Enter a one-word password: ";
my $password = <STDIN>;
chomp $password;

print "Enter your PIN code: ";
my $pin = <STDIN>;
chomp $pin;

# combine the values
my $entropy = $cc_number . $expiration . $cvv . $first_name . $middle_name . $last_name . $password . $pin;

# create the extended private key
my $master_key = Bitcoin::Crypto::Key::ExtPrivate->from_seed($entropy);
my $derived_key = $master_key->derive_key("m/0'");

# get the basic private and public keys
my $priv = $derived_key->get_basic_key();
my $pub = $priv->get_public_key();

# print the results
say "Private key: " . $priv->to_wif();
say "Public key: " . $pub->to_hex();
say "Address: " . $pub->get_segwit_address();
