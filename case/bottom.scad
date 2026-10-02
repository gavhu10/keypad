$fn = 100;


b_X = 67;
b_Y = 112;



WALL = 1.5;
LIP = 2;


CURVE = 3;


esp_WIDTH = 31;
usb_WIDTH = 21;

TOP_HEIGHT = 8;
BOTTOM_HEIGHT = 7;

CASE_BOTTOM = 2;

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
    
    DEPTH = TOP_HEIGHT + BOTTOM_HEIGHT;
    
    difference() {
        translate([f_X/2, f_Y/2, 0]) {
            hull() {
                translate([0, 0, DEPTH + size]) 
                    flat(f_X - size*2, f_Y - size*2, size);
                
                translate([0, 0, size]) 
                    flat(f_X - size*2, f_Y - size*2, size);
            }
        }
        
        translate([-1, -1, DEPTH]) linear_extrude(size*2 + 1) 
            square([f_X + 2, f_Y + 2]);
    }
}


difference() {

    _block();

    translate([WALL, WALL, BOTTOM_HEIGHT]) { 
        linear_extrude(TOP_HEIGHT + 2)    
            square(
                [b_X, b_Y]
            );
    }

    translate(
    [LIP + WALL,
    LIP + WALL,
    CASE_BOTTOM]) {
        linear_extrude(BOTTOM_HEIGHT + 2)
            square(
            [b_X - (LIP * 2),
            b_Y - (LIP * 2)]);
    }

    translate(
    [WALL,
    WALL + 9,
    CASE_BOTTOM]) {
        linear_extrude(BOTTOM_HEIGHT + 2)
            square([10, esp_WIDTH]);
    }
    
    translate(
    [-1,
    WALL + 14,
    BOTTOM_HEIGHT + 6]) {
        linear_extrude(3.2)
            square([WALL + 2, usb_WIDTH]);
    }

    
    
    translate([-1.25, 27, 3.5])
    rotate([90, 0, 90])
    linear_extrude(2)
    scale([0.5, 0.5, 0.5])
        import("bi--usb-symbol.svg");
    
    
}

