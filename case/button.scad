HEIGHT = 5;
ABOVE_BUTTON_HEIGHT = 2;
DIAM = 13.5;


$fn = 50;

module cap() {
  
    difference() {
        linear_extrude(HEIGHT) circle(DIAM/2);
        translate([0, 0, ABOVE_BUTTON_HEIGHT])
            linear_extrude(ABOVE_BUTTON_HEIGHT + HEIGHT) square(4, center=true);
    }
}


cap();