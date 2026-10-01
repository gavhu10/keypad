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


module _curve_mold(r, length) {
    translate([r, r, 0]) {
        rotate([0, 0, 180]) {
            linear_extrude(length) {
                difference() {
                    translate([0.1, 0.1, 0]) square(r + 1);
                    circle(r=r);
                }
            }
        }
    }
}

module _block() {
    f_X = b_X + (WALL * 2);
    f_Y = b_Y + (WALL * 2);
    
    DEPTH = TOP_DEPTH + LIP_DEPTH;
    
    difference() {
        linear_extrude(DEPTH)
            square([b_X + (WALL * 2), b_Y + (WALL * 2)]);
            
        translate([0, 0, DEPTH]) {
            rotate([-90, 0, 0]) _curve_mold(CURVE, f_Y+1);
        }
        
        translate([f_X, 0, DEPTH]) {
            rotate([-90, 0, 90]) _curve_mold(CURVE, f_X);
        }
        
        translate([f_X, f_Y, DEPTH]) {
            rotate([-90, 90, 90]) _curve_mold(CURVE, f_X);
        }
        
        translate([f_X, 0, DEPTH]) {
            rotate([0, 90, 90]) _curve_mold(CURVE, f_Y+1);
        }
            
    }
}


module main() {
    diff = - (TRIM_OFFSET - WALL)/2;
    difference() {
        _block();
        
        translate([0, 0, -1]) difference() {
            linear_extrude(LIP_DEPTH + 1) 
                translate([diff, diff, 0])
                    square([b_X + TRIM_OFFSET, b_Y + TRIM_OFFSET]);
            translate([WALL, WALL, -1])
                linear_extrude(LIP_DEPTH + 2)
                    square([b_X, b_Y]);
        }
        
        translate([WALL, WALL, 0]) for(x = [0:2]){
            for(y = [0:2]) {
                translate([
                SIDE_OFFSET + (x * X_GAP),
                TOP_OFFSET + (y * Y_GAP),
                -1])
                    cylinder(LIP_DEPTH + TOP_DEPTH + 2, d=12.2);
            }
        }
        
        translate([2 + WALL, 2 + WALL, -1])
            linear_extrude(LIP_DEPTH + 4)
                square([b_X - 4, b_Y - 4]);
                
        translate(
        [b_X - WALL, (WALL + b_Y - 2) - (usb_WIDTH + 14), -1]
        ) {
            linear_extrude(1 + LIP_DEPTH + 1.5)
                square([10, usb_WIDTH]);
        }
        
        translate(
        [b_X - WALL, (WALL + b_Y - 2) - (esp_WIDTH + 9), -1]
        ) {
            linear_extrude(1 + LIP_DEPTH)
                square([10, esp_WIDTH]);
        }
                
        //pattern_grill();
        
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

module pattern_grill() {
    translate([(b_X - GRILL_SIZE_X)/2 + WALL, GRILL_X, 0]) 
        difference() {
            _grill(LIP_DEPTH + TOP_DEPTH + 1);
            linear_extrude(LIP_DEPTH + TOP_DEPTH + 1) 
                difference() {
                    translate([-20, -20, 0]) 
                        square([GRILL_SIZE_X + 40, GRILL_SIZE_Y + 40]);
                    square([GRILL_SIZE_X, GRILL_SIZE_Y]);
                }
        }
}

module _grill(_height) {
    for(i = [0:GRILL_AMOUNT]) {
        translate([(i * (GRILL_GAP + GRILL_BAR)) + GRILL_OFFSET, -5, 0, ])
            linear_extrude(_height) 
                rotate([0, 0, GRILL_SLANT])
                    square([GRILL_GAP, GRILL_SIZE_Y + 20]);
    }
}


// BUTTONS
#translate([35, 90, 0]) linear_extrude(15) square([8, 6]);

// TEXT
#translate([28, 105, 0]) linear_extrude(15) square([25, 4.5]);

// LED
#translate([48, 80, 0]) linear_extrude(15) square(5);

main();



 