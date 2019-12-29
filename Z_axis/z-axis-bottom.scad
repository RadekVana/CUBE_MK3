// PRUSA iteration4
// Z axis bottom holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

//CUBE printer - mk3 Z motor holder by Radek Vana

/*****************************************************************************/
//includes
include <../_includes/MCAD-master/boxes.scad>;
include <../_includes/mounting.scad>;
/*****************************************************************************/
//variables
motor_sz = FRONT_PROFILE_LEN - MK3_Z_TRAPESOID_DIST;
echo(str("motor_sz = ", motor_sz));
assert(motor_sz > 42.5, "motor cannot fit");

wall_sz    = 7;
side_wall  = 10;
edge       = 1.5;
top_plate  = [motor_sz + 2* side_wall, motor_sz + 2 * PROFILE_SZ,wall_sz];
side_plate = [side_wall, motor_sz, wall_sz+PROFILE_SZ];
trapesoid_rod_dist = -17;

motor_scr_dist = 31;
motor_scr_half_dist = motor_scr_dist/2;


body_r = 1.65;
head_r = 3.2; 


$fn = $preview ? 32 : 64;

/*****************************************************************************/
//modules
module z_bottom_base()
{
    translate([0,0,top_plate[2]/2])roundedBox(top_plate, edge, true);

    translate([+(top_plate[0]-side_plate[0])/2,0,side_plate[2]/2])roundedBox(side_plate, edge);
    translate([-(top_plate[0]-side_plate[0])/2,0,side_plate[2]/2])roundedBox(side_plate, edge);
}


module z_rod_holder()
{
    difference() 
    {
        translate([ 0,  trapesoid_rod_dist, -0.1])      cylinder(h = wall_sz-1.4, r=4.05);
        translate([-6, -5-20, 5.45-0.22]) cube([5,20,5]);
        translate([1,  -5-20, 5.45-0.22]) cube([5,20,5]);    
    }    
        
    translate([-1, trapesoid_rod_dist-1, 4.5])  cube([2,10,3]) ;
    translate([0,  trapesoid_rod_dist, -2.1])   cylinder(h = 2.6, r1=6, r2=4);
    translate([-1, trapesoid_rod_dist, 0.5])    cube([2,10,8]); // it's bit up because it helps with printing
}

module _scr_print_helper(angle, z)
{
    rotate([0,0,angle]) translate([0,+body_r + head_r/2, z]) cube([2*head_r, head_r, 2], center = true);
}

module _scr()
{
    cylinder(h = wall_sz + 1, r = body_r);
    translate([0, 0, -1.5]) cylinder(h = 2, r1=4.5, r2 = head_r);

    difference()
    {
        translate([0,0,-0.1]) cylinder(h = 2.9, r=head_r);

        _scr_print_helper(  0,3.2);
        _scr_print_helper(180,3.2);
        _scr_print_helper(+90,3.5);
        _scr_print_helper(-90,3.5);
    } 
}

module motor_mounting()
{
    translate([ motor_scr_half_dist, motor_scr_half_dist,0]) _scr();
    translate([ motor_scr_half_dist,-motor_scr_half_dist,0]) _scr();
    translate([-motor_scr_half_dist, motor_scr_half_dist,0]) _scr();
    translate([-motor_scr_half_dist,-motor_scr_half_dist,0]) _scr();

    // motor opening
    cylinder(h = wall_sz + 2, r=11.2);
    translate([0,0,-1])cylinder(h = 2, r2=11.2, r1=12);
}


/*****************************************************************************/
//parts 
difference()
{
    z_bottom_base();
    z_rod_holder();
    motor_mounting();

    translate([+motor_sz/2, +(motor_sz/2 + PROFILE_SZ/2), -1]) cylinder(d = PROFILE_SCREW_D + 0.2, h = wall_sz + 2);
    translate([+motor_sz/2, -(motor_sz/2 + PROFILE_SZ/2), -1]) cylinder(d = PROFILE_SCREW_D + 0.2, h = wall_sz + 2);
    translate([-motor_sz/2, +(motor_sz/2 + PROFILE_SZ/2), -1]) cylinder(d = PROFILE_SCREW_D + 0.2, h = wall_sz + 2);
    translate([-motor_sz/2, -(motor_sz/2 + PROFILE_SZ/2), -1]) cylinder(d = PROFILE_SCREW_D + 0.2, h = wall_sz + 2);
            
}












