/**
* Base module building a case's cover.
*/
module caseCover() {
  difference() {
    // create cover box
    linear_extrude(wallWidth + indentHeight, convexity = 10) {
      offset(r = wallWidth)
      square([width, depth + (2 * depthSpace)], true);
    };
    // cut the indent to slide a body in
    linear_extrude(indentHeight, convexity = 10) square([width + wallWidth + clearance, depth + 2 * depthSpace + wallWidth + clearance], center = true);
    // cut the screw holes
    for (i = [
        [-1, 1],
        [1, -1],
        [-1, -1],
        [1, 1]
      ])
      translate([i[0] * (width / 2 - depthSpace / 2), i[1] * (depth / 2 + depthSpace / 2), 0]) linear_extrude(wallWidth + indentHeight, convexity = 10) circle(d = 2.5);
  }
}

/**
* Base module building a case's body.
* See globals.scad for global vars used to configure measurements of a case.
*/
module caseBody() {
  difference() {
    //build a box
    linear_extrude(height, convexity = 10) {
      offset(r = wallWidth)
      square([width, depth + (2 * depthSpace)], true);
    };
    // cut a working area space
    translate([0, 0, wallWidth]) linear_extrude(height, convexity = 10) square([width, depth], true);
    // cut a space on the sides of the working area
    // can be used to hold an excess wires
    for (i = [-1, 1])
      translate([0, i * (depth / 2 + depthSpace / 2), wallWidth]) linear_extrude(height, convexity = 10) square([width - 2 * depthSpace, depthSpace], true);
    // add the screw holes
    for (i = [
        [-1, 1],
        [1, -1],
        [-1, -1],
        [1, 1]
      ])
      translate([i[0] * (width / 2 - depthSpace / 2), i[1] * (depth / 2 + depthSpace / 2), height - 4 / 5 * height]) linear_extrude(4 / 5 * height, convexity = 10) circle(d = 2.5);
  
    // cut an indent at the upper edge of the box
    color("green") translate([0, 0, height - indentHeight])
    linear_extrude(indentHeight, convexity = 10) difference() {
      offset(r = wallWidth) square([width, depth + 2 * depthSpace], center = true);
      square([width + wallWidth, depth + 2 * depthSpace + wallWidth], center = true);
    }

    // dovetail on sides used to join cases together
    // See connectors.scad for modules used to create connectors
    for (i = [1 / 5, 2 / 5, 3 / 5, 4 / 5]) color("red") translate([(width * i), (-depthSpace - wallWidth), height / 2]) translate([-width / 2, -depth / 2, 0]) dovetail(max_width = 5, min_width = 3, depth = wallWidth + 0.001, height = height/2);
    for (i = [1 / 5, 2 / 5, 3 / 5, 4 / 5]) color("red") translate([(width * i), (depth + depthSpace + wallWidth), height / 2]) translate([-width / 2, -depth / 2, 0]) rotate([0, 0, 180]) dovetail(max_width = 5, min_width = 3, depth = wallWidth + 0.001, height = height/2);

  }
}