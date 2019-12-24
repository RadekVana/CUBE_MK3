//CUBE printer - mk3 PSU holder by Radek Vana

/*****************************************************************************/
//includes
include <../_includes/MCAD-master/boxes.scad>;
include <../_includes/mounting.scad>;
/*****************************************************************************/
//variables
PSU_SCREW_D = 4;
PSU_SCREW_HEAD_D = 7.2;

profile_extra_cut = 0.1;
edge = 5;
profile_len = 15;

cut_sz = PROFILE_SZ+profile_extra_cut*2;
wall = 10;

screw_wall = 4;    
PSU_screw_wall = 4.5; 
$fn=50;
/*****************************************************************************/
//modules

module PSU_screw_hole(head_len, body_len)
{
    
    translate([0,0,-0.1-body_len])cylinder(d = PSU_SCREW_D + 0.2, h = body_len + 0.2);
    translate([0,0,0])cylinder(d = PSU_SCREW_HEAD_D + 0.5, h = head_len + 0.1);
}



module part()
{
    difference()
    {
        union()
        {
            translate([0, wall - edge/2,      -(wall/2 + edge)])cube([profile_len,edge,edge*2+PROFILE_SZ+wall], true);
            translate([0, -cut_sz/2 + wall/2, -PROFILE_SZ/2   ])rotate([0,90,0])roundedBox([PROFILE_SZ+wall,PROFILE_SZ+wall,profile_len], edge,true);//wall around profile
        }
        translate([0, -cut_sz/2,                       -PROFILE_SZ/2           ])cube  ([profile_len+1,cut_sz,cut_sz],true);//profile cut
        translate([0, -profile_extra_cut-PROFILE_SZ/2, +screw_wall             ])profile_screw_hole_short(edge);
        translate([0, -profile_extra_cut-PROFILE_SZ/2, -screw_wall - PROFILE_SZ])mirror([0,0,1])profile_screw_hole_short(edge);
        translate([0,  PSU_screw_wall,                 -PROFILE_SZ/2           ])rotate([90,0,0])PSU_screw_hole(PSU_screw_wall+0.5,wall);
        translate([0,   wall - edge,                   wall/2 + edge           ])rotate([0,90,0])cylinder(r = edge, h = profile_len+1,center =true);
        translate([0,   wall - edge,     -(wall/2 + edge + PROFILE_SZ)         ])rotate([0,90,0])cylinder(r = edge, h = profile_len+1,center =true);
        
    }
}

 /*****************************************************************************/
//parts 
part();
  
    