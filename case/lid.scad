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
b_Y = 69;


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
        
        *translate([f_X, f_Y, DEPTH]) {
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
                    cylinder(LIP_DEPTH + TOP_DEPTH + 2, d=15);
            }
        }
        
        translate([2 + WALL, 2 + WALL, -1])
            linear_extrude(LIP_DEPTH + 4)
                square([b_X - 4, b_Y -4]);
            
    }
}

main();
 