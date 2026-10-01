use <hexgrid.scad>

$fn = 100;

HOLE_R = 7;

TOP_OFFSET = 7.8 + HOLE_R;
SIDE_OFFSET = 5 + HOLE_R;

X_GAP = 21.75;
Y_GAP = 20.4;

WALL = 1.5;
TRIM_OFFSET = 10;


LIP_DEPTH = 3.1;
TOP_DEPTH = 5;

CURVE = 3;

b_X = 67;
b_Y = 111.8;

usb_WIDTH = 21;
esp_WIDTH = 31;
esp_CENTER = 89;

GRILL_GAP = 5;
GRILL_BAR = 8;
GRILL_AMOUNT = 5;
GRILL_SLANT = 15;
GRILL_OFFSET = 3;

GRILL_SIZE_X = 60;
GRILL_SIZE_Y = 40;
GRILL_X = 70;

module flat(x, y, size) {
    translate([x/2, y/2, 0]) sphere(r=size);
    translate([-x/2, y/2, 0]) sphere(r=size);
    translate([-x/2, -y/2, 0]) sphere(r=size);
    translate([x/2, -y/2, 0]) sphere(r=size);
}

module _block() {
    size = CURVE;
    f_X = b_X + (WALL * 2);
    f_Y = b_Y + (WALL * 2);
    
    DEPTH = TOP_DEPTH + LIP_DEPTH;
    
    difference() {
        translate([f_X/2, f_Y/2, 0]) {
            hull() {
                translate([0, 0, DEPTH - size]) 
                    flat(f_X - size*2, f_Y - size*2, size);
                
                translate([0, 0, -size]) 
                    flat(f_X - size*2, f_Y - size*2, size);
            }
        }
        
        translate([-1, -1, -size*2 - 1]) linear_extrude(size*2 + 1) 
            square([f_X + 2, f_Y + 2]);
    }
}

module _holes() {
    translate([WALL, WALL, 0]) for(x = [0:2]){
        for(y = [0:2]) {
            translate([
            SIDE_OFFSET + (x * X_GAP),
            TOP_OFFSET + (y * Y_GAP),
            -1])
                cylinder(LIP_DEPTH + TOP_DEPTH + 2, d=12.2);
        }
    }
}

module _lip_maker(diff) {
    translate([0, 0, -1]) difference() {
        linear_extrude(LIP_DEPTH + 1) 
            translate([diff, diff, 0])
                square([b_X + TRIM_OFFSET, b_Y + TRIM_OFFSET]);
        translate([WALL, WALL, -1])
            linear_extrude(LIP_DEPTH + 2)
                square([b_X, b_Y]);
    }
}

module _esp_hole() {
    translate([2 + WALL, 2 + WALL, -1])
            linear_extrude(LIP_DEPTH + 4)
                square([b_X - 4, b_Y - 4]);
                
        translate(
        [b_X - WALL, (WALL + b_Y - 2) - (usb_WIDTH + 14 - 2), -1]
        ) {
            linear_extrude(1 + LIP_DEPTH + 1.5)
                square([10, usb_WIDTH]);
        }
        
        translate(
        [b_X - WALL, (WALL + b_Y - 2) - (esp_WIDTH + 9 - 2), -1]
        ) {
            linear_extrude(1 + LIP_DEPTH)
                square([10, esp_WIDTH]);
    }
}

module main() {
    diff = - (TRIM_OFFSET - WALL)/2;
    difference() {
        _block();
        
        _lip_maker(diff);
        
        _holes();
        
        _esp_hole();
        
        pattern_hex();
            
    }
}


module pattern_hex() {
    width = 10.8 * 0.87 * 4;
    //translate([(b_X - GRILL_SIZE_X)/2 + WALL, GRILL_X, 0])
    translate([44, esp_CENTER -(width/2), 10])
        rotate([180, 0, 180])
        linear_extrude(10)
             hexgrid([3, 4], 10, 5);
    

}


// BUTTONS
//#translate([35, 90, 0]) linear_extrude(15) square([8, 6]);

// TEXT
//#translate([28, 105, 0]) linear_extrude(15) square([25, 4.5]);

// LED
//#translate([48, 80, 0]) linear_extrude(15) square(5);

main();



 