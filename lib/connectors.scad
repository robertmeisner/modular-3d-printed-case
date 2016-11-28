/**
* Dovetail shape used to cut a hole in the walls and generate a double sided dovetail connector 
*/
module dovetail(max_width = 5, min_width = 3, depth = 5, height = 20) {
  linear_extrude(height = height , convexity = 2) polygon(paths = [
    [0, 1, 2, 3, 0]
  ], points = [
    [-min_width / 2, 0],
    [-max_width / 2, depth],
    [max_width / 2, depth],
    [min_width / 2, 0]
  ]);
  echo("angle: ", atan((max_width/2-min_width/2)/depth));
}
/**
* Generates a double sided dovetail connector 
*/
module dovetailConnector(){
    union() {
        dovetail(max_width = 5 - clearance, min_width = 3 - clearance, depth = wallWidth, height = height/2 - indentHeight);
        mirror([0, 1, 0]) dovetail(max_width = 5 - clearance, min_width = 3 - clearance, depth = wallWidth, height = height/2 - indentHeight);
    }
}