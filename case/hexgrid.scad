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



module hex(hole, wall){
    hole = hole;
    wall = wall;
    rotate([0, 0, 30]) 
        circle(d = hole, $fn = 6);
}



module hexgrid(rows, holediameter, wallthickness) {
    a = (holediameter + (wallthickness/2))*sin(60); // spacing
    x_counter = 0;
    for(x = [0:(rows[0]-1) * 2]) {
        y_counter = 0;
        for(y = [0:(rows[1]-1)]) {
            x_counter = floor(x / 2);
            y_counter = floor(y / 2);
            
            
            
            x_coord = holediameter/2 + (x_counter * a);
            y_coord = holediameter/2 + (y_counter * a*sin(60)*2); 
            if (!(y % 2)) {
                translate([x_coord, y_coord, 0]) hex(holediameter, wallthickness);
            } else {
                translate([x_coord + a*cos(60), y_coord + a*sin(60), 0]) hex(holediameter, wallthickness);
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

#hexgrid([5, 5], 10, 5);

square(10.8253 *  0.866025 * 5);


echo("FlatDia",hexDia/(2/sqrt(3)));