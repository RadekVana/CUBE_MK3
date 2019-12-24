//CUBE printer - mk3 BOARD holder by Radek Vana

/*****************************************************************************/
//includes
include <../_includes/MCAD-master/boxes.scad>;
include <../_includes/mounting.scad>;
/*****************************************************************************/
//variables
screw_wall = 4;    

hole_distance = 61;
base_width = 5;
//c^2 = 2*a^2
//a = sqrt(c^2 / 2)
pos = sqrt((hole_distance/2)*(hole_distance/2)/2);
arm_len = sqrt( ((base_width+hole_distance)/2)*((base_width+hole_distance)/2)/2 );

$fn=50;
/*****************************************************************************/
//modules

module mount()
{
    rotate_extrude(convexity = 10, $fn = 50)
    {
        intersection()
        {
            translate([PROFILE_SZ/2-base_width, 0, 0]) circle(r = base_width, $fn = 50);
            square([PROFILE_SZ/2, base_width]);
        }
        square([PROFILE_SZ/2 - base_width, base_width]);
    }
}

module arm()
{
    //translate([-(PROFILE_SZ)/2, 0, +(PROFILE_SZ+base_width)/2])
    translate([0, 0, +(base_width)/2])
        hull()
        {
            rotate([0,45,0])  translate([arm_len,0,arm_len])cylinder(d = 10,h = 0.1);
            translate([-(PROFILE_SZ)/2,0,-base_width/2])mount();
            //cylinder(d = PROFILE_SZ, h = base_width, center = true);
        }
}

module arms()
{
    arm();
    rotate([0,-90,0])mirror([0,0,1])arm();
}
 /*****************************************************************************/
//parts 
///part();



difference()
{
    arms();
    translate([-PROFILE_SZ/2,0,screw_wall])profile_screw_hole_short(base_width);
    rotate([0,90,0])translate([PROFILE_SZ/2,0,screw_wall])profile_screw_hole_short(base_width);
}


rotate([0,45,0])  translate([pos,0,+pos]) cylinder(d = 4, h = 20);