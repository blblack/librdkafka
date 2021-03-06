#!/usr/bin/env perl
#

#
# Generate linker script to only expose symbols of the public API
#

open(IN, "<rdkafka.h") or die("Failed to open rdkafka.h: $!\n");

@funcs = ();
while (<IN>) {
    push(@funcs, $2) if /^(\S+.*\s+\**)?(rd_kafka_\S+)\s+\(/;
}
close(IN);

print "# Automatically generated by lds-gen.pl - DO NOT EDIT\n";
print "{\n global:\n";
foreach my $f (sort @funcs) {
    print "    $f;\n";
}

print " local:\n    *;\n};\n";
