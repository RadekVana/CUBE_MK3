// PRUSA iteration4
// Y belt holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org


//CUBE printer - mk3 modification by Radek Vana


/*****************************************************************************/
//includes
include <../_includes/MCAD-master/boxes.scad>;
/*****************************************************************************/
//variables
bot = [18,48,6];
top = [18,15,27];
belt_hole_w = 6.6;
belt_hole_h = 2.2;
belt_screw_head_d = 5.2;
belt_nut_d = 5.5;
belt_screw_body_d = 3.2;

mount_screw_head_d = 6.4;
mount_screw_body_d = 3.3;

$fn=50;
/*****************************************************************************/
//modules
module part()
{

    difference()
    {
        // base block
        union()
        {
            intersection()
            {
            translate([0,0,bot[2]/2]) cube(bot,true);
             rotate([0,90,0])roundedBox([bot[2]*2,bot[1],bot[0]], 5,true);
            }
            translate([0,0,top[2]/2]) rotate([0,90,0])roundedBox([top[2],top[1],top[0]], 5,true);
        }
    }
}

// mounting screw holes
module mount_screw(pos)
{
        hull()
        {
            translate([0, pos+0.5, -0.1]) cylinder( h=30, d = mount_screw_body_d);
            translate([0, pos-0.5, -0.1]) cylinder( h=30, d = mount_screw_body_d);
        }
        hull()
        {
            translate([0, pos+0.5, 3.5]) cylinder( h=7, d = mount_screw_head_d);
            translate([0, pos-0.5, 3.5]) cylinder( h=7, d = mount_screw_head_d);
        }
}

module belt_hole()
{
    pos = -3.7;
    translate([0,pos,0])
    {
        translate([-(top[0]+1)/2,0,0])rotate([0,90,0])cylinder(d=belt_screw_body_d, h=top[0]+1);//screw body
        wall = 3;//thickness of wall
        translate([-belt_hole_w/2-top[0]-wall,0,0])rotate([0,90,0])cylinder(d=belt_nut_d, h=top[0],$fn=6);//nut 
        translate([-top[0]/2-1/2,0,0])rotate([0,90,0])cylinder(d2=belt_nut_d, d1=belt_nut_d +3, h=1,$fn=6);//nut edge

        translate([-belt_hole_w/2,0,0])
        {
            rotate([0,90,0])cylinder(d=belt_screw_head_d, h=top[0]);//screw head
            scale([1,2,2*belt_hole_h/(belt_screw_head_d)])rotate([0,90,0])cylinder(d=belt_screw_head_d, h=belt_hole_w,$fn=6);//screw head inner edge
            

            translate([0,-belt_screw_head_d,-belt_screw_head_d/2])cube([belt_hole_w, belt_screw_head_d, belt_screw_head_d]);//hole out
        }
    }

    translate([-belt_hole_w/2,-belt_screw_head_d/2,-belt_hole_h/2])cube([belt_hole_w, top[1]+1, belt_hole_h]);
}

module y_belt_holder()
{
    difference()
    {
        part();
        translate([0,0,19])belt_hole();
        translate([0,0,7.1])mirror([0,1,0])belt_hole();
        mount_screw(19.5);
        mount_screw(-19.5);
    }
    

}

/*****************************************************************************/
//parts
 y_belt_holder();   
