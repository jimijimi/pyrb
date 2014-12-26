This is a minimal script/application using the roto.rb module

The project folder contains two STL files samples:

pyramid.stl               - original STL file before the rotation.

pyramid_transformed_x.stl - STL geometry after the rotation around the x axys.

USAGE:

	(1) copy the script to the working folder.
	
	(2) Go to line 100 and edit the name of the STL file to open
	
	(3) Go to line 101 and edit the name of the transformed( rotated ) geometry.
	
	(4) Go to tine 102 and edit the angle of rotation
	
	(5) Go to line 103 and edit the axys of rotation. Currently "x", "y" and "z" are supported.
	
	(6) Run the script at the command line $ ruby pyr.rb < enter >   

	
LIMITATIONS:

	(1) For the moment only ASCII files are supported. Binary file will later be implemented
	
	(2) Script error checking is minimal. So be careful.
	
TODO:
	
	(1) Implement a command line interface.
	
	(2) Add an arbitrary axys of rotation option.
	
	(3) Add error checking.
	
	(4) Add support to binary STL files.


