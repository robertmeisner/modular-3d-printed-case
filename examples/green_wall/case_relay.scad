// global variables
include <../../lib/globals.scad>;
// common functions
include <../../lib/functions.scad>;
// dovetail connector
include <../../lib/connectors.scad> ;

plugHoleWidth=9.4+clearance;
plugHoleZ=height-indentHeight-(13+clearance);
holderMargin=2;
buttonHoleWidth=7.5;
buttonHoleIndentMargin=(13-buttonHoleWidth)/2;
buttonHoleIndentWidth=1;
buttonHolderDepth=4;
buttonHoleY=7;
    
union(){
    difference() {
        // build the case and move it to inner 0,0 position
        //width,height add 0.001 to remove OpenSCAD's zero-width artifacts
        union(){
            translate([width / 2, depth / 2, 0]) caseBody();
            // add plug holder
            translate([0,depth/2-holderMargin,0]) 
                difference(){
                    cube([8,plugHoleWidth+2*holderMargin,plugHoleZ+6]);
                    translate([0,holderMargin,0]) cube([8,plugHoleWidth,height-2]);
                    translate([2.5/2,0,plugHoleZ]) rotate([-90,0,0]) cylinder(h=plugHoleWidth+2*holderMargin,d=2.5);
                }
           // add button holder cube
            translate([0,buttonHoleY-2*buttonHoleIndentMargin,0]) cube([buttonHolderDepth,buttonHoleWidth+4*buttonHoleIndentMargin,height-indentHeight]);
        }
        // Add square holes
        squareHoles = [
            //button hole
            [[-wallWidth, buttonHoleWidth, height-indentHeight-14],[wallWidth+buttonHolderDepth+0.001, 7.1, 14+indentHeight]],// usb port
            //button slide space 
            //we have to make our wall thinner in order to be able to press the button
             [[-wallWidth+1.5, buttonHoleY-buttonHoleIndentMargin, height-indentHeight-14],[buttonHolderDepth+clearance, buttonHoleWidth+2*buttonHoleIndentMargin, 14+indentHeight]],
             
            //power plug hole
            [[-wallWidth, depth/2,  plugHoleZ],[wallWidth+000.1, plugHoleWidth, height]]
        ];
        for (i = squareHoles) color("red") translate(i[0]) cube(i[1]);
    }
    
}

/* BUILD CASE'S COVER 
move it to inner 0,0 position and move upward
*/
translate([width / 2, depth / 2,height+capOffset])  caseCover();