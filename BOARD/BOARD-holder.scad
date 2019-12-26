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
_pos = sqrt((hole_distance)*(hole_distance)/2);
echo(str("_pos = ", _pos));
pos = sqrt((_pos)*(_pos)/2);
echo(str("pos = ", pos));
_arm_len = sqrt( (base_width/2+hole_distance)*(base_width/2+hole_distance)/2 );
echo(str("_arm_len = ", _arm_len));
arm_len = sqrt((_arm_len)*(_arm_len)/2);
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
    translate([0, 0, +(base_width)/2])
        hull()
        {
            rotate([0,45,0]) translate([arm_len,0,arm_len])cylinder(d = 10,h = 0.1);
            translate([-(PROFILE_SZ)/2,0,-base_width/2])mount();
        }
}


module connection()
{
    translate([0, 0, +(base_width)/2])
    rotate([0,45,0])  translate([arm_len,0,arm_len+0.1])cylinder(d1 = 10,d2=5,h = 3);
}


module arms()
{
    arm();
    connection();
    rotate([0,-90,0])mirror([0,0,1])
    {
        arm();
        connection();
    }
}


module board_screw_hole
(
    d        = 3.2,     
    nut_d1   = 6.4,
    nut_d2   = 7,
    nut_len  = 10, 
    body_len = 20
)
{


    translate([0,0,-0.1-body_len])cylinder(d = d, h = body_len + 0.2);
    translate([0,0,0])cylinder(d1 = nut_d1, d2 = nut_d2, h = nut_len + 0.1, $fn = 6);
}

 /*****************************************************************************/
//parts 

difference()
{
    nut_hole = 2;
    arms();
    translate([-PROFILE_SZ/2,0,screw_wall])profile_screw_hole_short(base_width);
    rotate([0,90,0])translate([PROFILE_SZ/2,0,screw_wall])profile_screw_hole_short(base_width);

    rotate([0,45,0])  translate([pos,0,+pos+nut_hole]) mirror([0,0,1])board_screw_hole();
    mirror([0,0,1])rotate([0,135,0])  translate([pos,0,+pos+nut_hole]) mirror([0,0,1])board_screw_hole();
}
