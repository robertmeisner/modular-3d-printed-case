// global variables
include <../../lib/globals.scad>;
// common functions
include <../../lib/functions.scad> ;
// common functions
include <../../lib/connectors.scad> ;

// build body
caseBody();
 
capOffset = 50;
translate([0,0,capOffset]) caseCover();

for (i = [1 / 5, 2 / 5, 3 / 5, 4 / 5]) color("red") translate([(width * i), (1.2* depth + depthSpace + wallWidth)]) rotate([0, 0, 180]) { 
      dovetailConnector();
  }