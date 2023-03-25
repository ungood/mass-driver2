$fn = 64;

nozzle_diameter = 0.4;

// outer diameter of the tube we're using.
tube_diameter = 10.0;

// Tolerances to add to an inner diameter so it fits over
tight_fit = 0.2;
loose_fit = 0.4;

module tube(inner_diameter, outer_diameter, length){
    linear_extrude(length){
        difference(){
            circle(d = outer_diameter);
            circle(d = inner_diameter);
        }
    }
}



module base(inner_diameter, outer_diameter, thickness) {
    difference(){
        linear_extrude(thickness) {
            circle(d = outer_diameter);
        }
        linear_extrude(thickness + 1, center = true) {
            circle(d = inner_diameter);
        }
    }
}


// Makes one half of a magnet coil winder.
// Print 2 for a full winder
// Use a calculator to find the length and height to use:
// https://www.accelinstruments.com/Magnetic/Magnetic-field-calculator.html
module half_coil(coil_length, coil_height) {
    coil_diameter = tube_diameter + nozzle_diameter + loose_fit;
    base_diameter = coil_diameter + coil_height;
    length = coil_length / 2;
    
    base(coil_diameter, base_diameter, nozzle_diameter);    
    tube(coil_diameter, coil_diameter + nozzle_diameter, length);
}

half_coil(50, 5.513);