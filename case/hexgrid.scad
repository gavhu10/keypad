// From https://www.thingiverse.com/thing:1296149 with modifications by gavhu10
//Bounding Box Length
bbl = 10;// 0.1
//Bounding Box Width
bbw = 10; // 0.1
//Bounding Box Height
bbh = 1.5; // 0.1
// Hex Corner Inside Diameter
hexDia=1; //0.1
//Wall Thickness
wall = 0.5; //0.1
// Corner Hole Dia vs Flats Hole Dia 
CornersNotFlats = true;
// Pair with NE Hex



module hex(hole, wall, thick){
    hole = hole;
    wall = wall;
    translate([0, 0, -0.1]) 
        rotate([0, 0, 30]) 
            cylinder(d = hole, h = thick + 0.2, $fn = 6);
}



module hexgrid(rows, height, holediameter, wallthickness) {
    a = (holediameter + (wallthickness/2))*sin(60); // spacing
    x_counter = 0;
    for(x = [0:(rows[0]-1) * 2]) {
        y_counter = 0;
        for(y = [0:(rows[1]-1)]) {
            x_counter = floor(x / 2);
            y_counter = floor(y / 2);
            echo(x_counter);
            echo(y_counter);
            
            
            
            x_coord = holediameter/2 + (x_counter * a);
            y_coord = holediameter/2 + (y_counter * a*sin(60)*2); 
            if (!(y % 2)) {
                translate([x_coord, y_coord, 0]) hex(holediameter, wallthickness, height);
            } else {
                translate([x_coord + a*cos(60), y_coord + a*sin(60), 0]) hex(holediameter, wallthickness, height);
            }
            

        }
    }
    echo("ID FlatDia", hexDia*cos(30));
    echo("Spacing", a);
        
}

// first arg is vector that defines the bounding box, length, width, height
// second arg in the 'diameter' of the holes. In OpenScad, this refers to the corner-to-corner diameter, not flat-to-flat
// this diameter is 2/sqrt(3) times larger than flat to flat
// third arg is wall thickness.  This also is measured that the corners, not the flats. 

hexgrid([5, 5], bbh, hexDia*(CornersNotFlats?1:1/cos(30)), wall);


echo("FlatDia",hexDia/(2/sqrt(3)));