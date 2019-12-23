// PRUSA iteration4
// Y motor holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

//CUBE printer - mk3 modification by Radek Vana

/*****************************************************************************/
//includes
include <../_includes/MCAD-master/boxes.scad>;
include <../_includes/mounting.scad>;
/*****************************************************************************/
//variables
top_screw_to_top_of_profile = 10;

top_motor_screw_y_pos = 5.5;
bot_motor_screw_y_pos = 36.5;
top_motor_screw_z_pos = 41.5;
bot_motor_screw_z_pos = top_motor_screw_z_pos - 31;

profile_extra_cut = 0.1;
base = [8,42,47];//1mm wider than original
edge = 5;
profile_len = 15;

cut_sz = PROFILE_SZ+profile_extra_cut*2;
wall = 5;
len = profile_len;
lenR = len + base[0] + edge;//edge will be cut

screw_wall = 4;    
screw_x_pos = 7;

y_suppport_max=25;
x_suppport_max=profile_len- edge;
$fn=50;
/*****************************************************************************/
//modules

module motor_screw_hole(y,z)
{
    len = 5;//lenght of screw body in material
    head_d = 6.3;
    body_d = 3.3;
    translate([-0.5, y,z]) rotate([0,90,0]) cylinder( h=base[0]+1, d = body_d);         
    translate([-len, y,z]) rotate([0,90,0]) cylinder( h=base[0],   d = head_d);       
}


module y_motor_holder()
{
    difference()
    {
        // base body
        union()
        {
            cube(base);
            hull()
            {
                
                translate([0,               0,              top_motor_screw_z_pos-top_screw_to_top_of_profile])sphere(edge);
                translate([0,               0,              top_motor_screw_z_pos-top_screw_to_top_of_profile-PROFILE_SZ])sphere(edge);
                translate([0,               y_suppport_max, top_motor_screw_z_pos-top_screw_to_top_of_profile-PROFILE_SZ])sphere(edge);
                translate([-x_suppport_max, 0,              top_motor_screw_z_pos-top_screw_to_top_of_profile-PROFILE_SZ])sphere(edge);
                translate([-x_suppport_max, 0,              top_motor_screw_z_pos-top_screw_to_top_of_profile])sphere(edge);
            }
        }
        // shape cuts
        translate([-0.5-profile_len,21,  26]) rotate([0,90,0]) cylinder( h=base[0]+1 +profile_len , r=11.5);   
        translate([-0.5-profile_len,21.5,15]) cube([base[0]+1+profile_len,base[1],base[2]]);
        
        // lower motor screw
        motor_screw_hole(bot_motor_screw_y_pos, bot_motor_screw_z_pos);
       
        // upper motor screw    
        motor_screw_hole(top_motor_screw_y_pos, top_motor_screw_z_pos);        
 
        // corners
        translate([-16,21.5,42]) rotate([45,0,0]) cube([60,10,10]);        
        translate([-16,39.5,-7]) rotate([45,0,0]) cube([60,20,10]);        
        translate([-16,44.5,10]) rotate([45,0,0]) cube([60,20,20]);  
    }
}




module profile()
{

    
    //translate([0,-PROFILE_SZ/2-wall,0]) 
    translate([0,-cut_sz/2,0]) 
    difference()
    {
        union(){
            translate([-lenR/2+base[0]+edge ,wall/2,0])roundedBox([lenR,PROFILE_SZ+wall,PROFILE_SZ+wall*2], edge,false);//wall around profile
            
        }
        translate([-edge/2+base[0]+edge ,wall/2,0])cube([edge,PROFILE_SZ+wall,PROFILE_SZ+wall*2],true);//cut 1 side to be printable without supports

       
    }
}

module dot()
{
    cube([base[0],profile_extra_cut,profile_extra_cut]); 
}

module part()
{
    difference()
    {
        union()
        {
            y_motor_holder();    

            translate([0,0,top_motor_screw_z_pos-top_screw_to_top_of_profile-PROFILE_SZ/2]) profile();

            hull()
            {
                //profile_extra_cut == dot_sz
                translate([0,0,base[2]-profile_extra_cut])dot();
                translate([0,-PROFILE_SZ,top_motor_screw_z_pos-top_screw_to_top_of_profile+profile_extra_cut])dot();
                translate([0,0,          top_motor_screw_z_pos-top_screw_to_top_of_profile+profile_extra_cut])dot();
            }
            hull()
            {
                //profile_extra_cut == dot_sz
                dot();
                translate([0,-PROFILE_SZ,top_motor_screw_z_pos-top_screw_to_top_of_profile-2*profile_extra_cut-PROFILE_SZ])dot();
                translate([0,0,          top_motor_screw_z_pos-top_screw_to_top_of_profile-2*profile_extra_cut-PROFILE_SZ])dot();
            }
        }

        translate([0,0,top_motor_screw_z_pos-top_screw_to_top_of_profile-PROFILE_SZ/2])translate([0,-cut_sz/2,0]) cube([100,cut_sz,cut_sz],true);//profile cut

        translate([-screw_x_pos, -profile_extra_cut-PROFILE_SZ/2, top_motor_screw_z_pos-top_screw_to_top_of_profile+screw_wall             ])profile_screw_hole_short(edge);
        translate([-screw_x_pos, -profile_extra_cut-PROFILE_SZ/2, top_motor_screw_z_pos-top_screw_to_top_of_profile-screw_wall - PROFILE_SZ])mirror([0,0,1])profile_screw_hole_short(edge);
        translate([-screw_x_pos,  screw_wall,                     top_motor_screw_z_pos-top_screw_to_top_of_profile-PROFILE_SZ/2           ])rotate([-90,0,0])profile_screw_hole_short(y_suppport_max);
    }
}

 /*****************************************************************************/
//parts 

part();


//import("y-motor-holder.stl");   
    