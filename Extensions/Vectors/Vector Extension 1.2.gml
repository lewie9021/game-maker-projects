#define vector_init
//creates the main list containing all the created vectors. This is so that later on we can keep track
//of what has been removed aswell as allow us to clear the ram when the object has been removed.

created_vectors = ds_list_create();

#define vector_create
//creates a list containing the x and y components of the vector. We then append this to the main list of vectors.
//Lastly, the id of vector is then returned from the script.
//argument0 = x component
//argument1 = y component

var new_vector;

new_vector = ds_list_create()
ds_list_add(new_vector, argument0);
ds_list_add(new_vector, argument1);

ds_list_add(created_vectors, new_vector);

return new_vector;

#define vector_from_angle
//Creates a vector similar to vector_create however instead of providing the x and y components, we supply an angle.
//argument0 = angle

return vector_create(cos(argument0), sin(argument0));

#define vector_destroy
//Destroys the given vector aswell as removing it's position in the main vector list.
//argument0 = vector

ds_list_delete(created_vectors, ds_list_find_index(created_vectors, argument0))
ds_list_destroy(argument0);

#define vector_clear
//This clears all the vectors that have been created. Once executed, you will need to declare the vector_init script.


for (i = 0; i < ds_list_size(created_vectors); i += 1)
{
    ds_list_destroy(ds_list_find_value(created_vectors, i))
}
ds_list_destroy(created_vectors);

#define vector_update
//Modifies the vector to the given x and y components
//argument0 = vector
//argument1 = new x component
//argument2 = new y component

ds_list_replace(argument0, 0, argument1);
ds_list_replace(argument0, 1, argument2);

#define vector_set_mag
//First normalises and then rescales the vector to the given magniture given in the 2nd argument.
//argument0 = vector
//argument1 = magnitude


vector_normalise(argument0);
vector_update(argument0, vector_get_x(argument0) * argument1, vector_get_y(argument0) * argument1);

#define vector_get
//Copies the x and y components of 2nd vector given assigning them to the first vector.
//argument0 = vector;
//argument1 = dest;

ds_list_replace(argument1, 0, ds_list_find_value(argument0, 0));
ds_list_replace(argument1, 1, ds_list_find_value(argument0, 1));

#define vector_get_x
//returns the x component of the vector given
//argument0 = vector

return ds_list_find_value(argument0, 0);

#define vector_get_y
//returns the y component of the vector given
//argument0 = vector

return ds_list_find_value(argument0, 1);

#define vector_heading
//This function Calculates the angle of rotation for a vector and returns it in radians.
//argument0 = vector

var angle;

angle = arctan2(-(vector_get_y(argument0)), vector_get_x(argument0))
return -1*angle;

#define vector_rotate
//argument0 = vector
//argument1 = angle

var xx, yy;

xx = vector_get_x(argument0)*cos(argument1) - vector_get_y(argument0)*sin(argument1);
yy = vector_get_x(argument0)*sin(argument1) + vector_get_y(argument0)*cos(argument1);

vector_update(argument0, xx, yy);


/*  
public void rotate(float theta) {
    float xTemp = x;
    // Might need to check for rounding errors like with angleBetween function?
    x = x*PApplet.cos(theta) - y*PApplet.sin(theta);
    y = xTemp*PApplet.sin(theta) + y*PApplet.cos(theta);
  }

#define vector_angle_between
//argument0 = vector
//argument1 = vector

//cos0 = (u dot v) / (mag u * mag v)

var top, bottom;

top = vector_dot(argument0, argument1);
bottom = vector_get_mag(argument0) * vector_get_mag(argument1)
if (bottom == 0){return 0;}else{return arccos(top / bottom);}

#define vector_get_mag
//returns the magniture of the vector given
//argument0 = vector

return sqrt(sqr(ds_list_find_value(argument0, 0)) + sqr(ds_list_find_value(argument0, 1)));

#define vector_add
//This function takes the first vector and adds it to the second vector. You may also specify the destination
//vector in the 3rd argument however this is not required and will default to the first argument.
//argument0 = vector
//argument1 = vector
//argument2 = vector (optional)

var xx, yy, destination_vector;

if (argument_count < 3){destination_vector = argument0;}else{destination_vector = argument2;}
xx = ds_list_find_value(argument0, 0) + ds_list_find_value(argument1, 0);
yy = ds_list_find_value(argument0, 1) + ds_list_find_value(argument1, 1);

ds_list_replace(destination_vector, 0, xx);
ds_list_replace(destination_vector, 1, yy);

#define vector_sub
//This function takes the first vector and subtracts it from the second vector. You may also specify the destination
//vector in the 3rd argument however this is not required and will default to the first argument.
//argument0 = vector
//argument1 = vector
//argument2 = vector (optional)

var xx, yy, destination_vector;

if (argument_count < 3){destination_vector = argument0;}else{destination_vector = argument2;}
xx = ds_list_find_value(argument0, 0) - ds_list_find_value(argument1, 0);
yy = ds_list_find_value(argument0, 1) - ds_list_find_value(argument1, 1);

ds_list_replace(destination_vector, 0, xx);
ds_list_replace(destination_vector, 1, yy);

#define vector_mult
//This function takes the vector given in the first argument and multiplies it by the given scale factor.
//argument0 = vector
//argument0 = scale_factor

var xx, yy;

xx = ds_list_find_value(argument0, 0) * argument1;
yy = ds_list_find_value(argument0, 1) * argument1;

ds_list_replace(argument0, 0, xx);
ds_list_replace(argument0, 1, yy);

#define vector_div
//This function takes the vector given in the first argument and divides it by the given scale factor.
//argument0 = vector
//argument0 = scale_factor

var xx, yy;

xx = ds_list_find_value(argument0, 0) / argument1;
yy = ds_list_find_value(argument0, 1) / argument1;

ds_list_replace(argument0, 0, xx);
ds_list_replace(argument0, 1, yy);

#define vector_dot
//This function returns the angular relationship between the two given vectors.
//argument0 = vector
//argument1 = vector

var total_x, total_y;

total_x = ds_list_find_value(argument0, 0) *  ds_list_find_value(argument1, 0);
total_y = ds_list_find_value(argument0, 1) *  ds_list_find_value(argument1, 1);

return (total_x + total_y);

#define vector_random
//This function updates the given vector to have a random x and y component between -1 and 1.
//In order for this vector to be more useful, it should be scaled to an appropriate length as
//it's currently normalised.
//argument0 = vector

vector_update(argument0, random_range(-1, 1), random_range(-1, 1));

#define vector_dist
//This function returns the distance between the two given vectors.
//argument0 = vector
//argument1 = vector

var total_x, total_y;

total_x = ds_list_find_value(argument0, 0) -  ds_list_find_value(argument1, 0);
total_y = ds_list_find_value(argument0, 1) -  ds_list_find_value(argument1, 1);

return sqrt(sqr(total_x) + sqr(total_y));

#define vector_normalise
//This function takes the vector supplied and normalises it. This keeps the direction but will make both the x and
//y components of the vector scale to values between -1 and 1. This then makes it easier to scale it up to a
//desired length.
//argument0 = vector

var mag;

mag = vector_get_mag(argument0);

if (mag > 0)
{
    ds_list_replace(argument0, 0, ds_list_find_value(argument0, 0) / mag);
    ds_list_replace(argument0, 1, ds_list_find_value(argument0, 1) / mag);
}

#define vector_limit
//This function limits the length the vector can scale up to
//argument0 = vector
//argument1 = limit

if (vector_get_mag(argument0) > argument1)
{
    vector_normalise(argument0);
    vector_mult(argument0, argument1);
}

#define vector_draw
//argument0 = vector
//argument1 = vector
//argument2 = color
//argument3 = scale
//argument4 = relative

var xx, yy, mag;

mag = vector_get_mag(argument1);

xx = ds_list_find_value(argument1, 0);
yy = ds_list_find_value(argument1, 1);

if (argument3 != 0)
{
    if (mag > 0)
    {
        xx = ds_list_find_value(argument1, 0) / mag;
        yy = ds_list_find_value(argument1, 1) / mag;
    }
    xx *= argument3;
    yy *= argument3;
}

draw_set_color(argument2);
if (argument4)
{
    draw_line(vector_get_x(argument0), vector_get_y(argument0), xx + vector_get_x(argument0), yy + vector_get_y(argument0))
}
else
{
    draw_line(vector_get_x(argument0), vector_get_y(argument0), vector_get_x(argument1), vector_get_y(argument1))
}

