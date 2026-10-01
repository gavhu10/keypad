b_X = 67;
b_Y = 112;

WALL = 1.5;
LIP = 2;


esp_WIDTH = 31;
usb_WIDTH = 21;

TOP_HEIGHT = 8;
BOTTOM_HEIGHT = 7;

CASE_BOTTOM = 2;


difference() {

    linear_extrude(TOP_HEIGHT + BOTTOM_HEIGHT)
        square(
            [b_X + (WALL * 2),
            b_Y + (WALL * 2)]
            );

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
    
}