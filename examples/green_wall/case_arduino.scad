// global variables
include <../../lib/globals.scad>;
// common functions
include <../../lib/functions.scad> ;
// common functions
include <../../lib/connectors.scad> ;

pcbScrewPositions = [
    [13.97, 2.54, wallWidth],
    [15.24, 50.8, wallWidth],
    [66.2, 35.56, wallWidth],//66.6
    [66.2, 7.62, wallWidth]//66.4
];
difference() {
  union() {
      translate([width / 2, depth / 2, 0]) caseBody();
      // add 
      for (i = pcbScrewPositions) {
        translate([i[0], i[1], i[2]]) cylinder(h = 2.5, r1 = 5.5 / 2, r2 = 4.5 / 2);
        translate([i[0], i[1], i[2] + 2.5]) cylinder(h = 3, r = 1.2); 
      }
    }
    //two dimensional array where squareXHole[i][0] is cube's position [x,y,z] and squareXHole[i][1] are cube's dimensions [x,y,z]
  squareXHole = [
    [
      [-wallWidth, 31.7, wallWidth + 1],
      [wallWidth + 0.001, 11.43 + 2, 10.8 + 2 + 50]
    ], // usb port
    [
      [-wallWidth, 3.3, wallWidth + 3],
      [wallWidth + 0.001, 8.9 + 2, 10.8 + 2 + 50]
    ] // power plug
  ];
  //width,height add 0.001 to remove OpenSCAD's zero-width wall-when-difference same width artifact
  for (i = squareXHole) color("red") translate(i[0]) cube(i[1]);
}
 
/* BUILD CASE'S COVER */
capOffset = 50;
translate([width / 2, depth / 2, height + capOffset]) {
  difference() {
    caseCover();
    /* LCD screen in the cover */
    lcdWidth = 27;
    lcdHeight = 19.11;
    lcdDepth = 2;
    linear_extrude(wallWidth + indentHeight, convexity = 10) square([lcdHeight + clearance, lcdWidth + clearance], center = true);
    // cut space for pins and taśma we move it up to the LCD
    for (i = [-1, 1])
      translate([i * (lcdHeight / 2 + 2), 0, 0]) linear_extrude(indentHeight + 2, convexity = 10) square([4 + clearance, 10.5 + clearance], center = true);
    // lcd holes
    for (i = [
        [-1, 1],
        [1, -1],
        [-1, -1],
        [1, 1]
      ])
      translate([i[0] * (27.16 / 2 - 2), i[1] * (27.22 / 2 - 2), 0]) linear_extrude(2 + indentHeight, convexity = 10) circle(d = 2.5);

  }

}

// add arduino model
 *color("yellow") translate([26.2, -8.3, 37.6]) rotate([0, 0, -90]) import ("../../assets/Arduino.ipt.stl", convexity = 3);