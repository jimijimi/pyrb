# simple rotation application using the rotorb module
# Copyright (c) 2014, 2015 Jaime Ortiz
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as 
# published by the Free Software Foundation; either version 2, or 
# (at your option ) any later version.  
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc.
# 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
#
# December 24, 2014
# rotates a given ASCII STL file around any of the coordinates axes
# this code has been released under the GPL v2
# See license file (LICENSE)enclosed for more information.

require "../rotorb/roto.rb"

def pass
end

def computeNormal( triangle )
	a = Roto.vectorSum( triangle[ 0 ], Roto.vectorScaling( -1.0, triangle[1] ) )
	b = Roto.vectorSum( triangle[ 2 ], Roto.vectorScaling( -1.0, triangle[1] ) )
	u = Roto.vectorNormalized( a )
	v = Roto.vectorNormalized( b )
	normal = Roto.vectorNormalized( Roto.vectorCrossProduct( u, v ) )
end

def facetBlock( normal, triangle )
	text = "\tfacet normal #{normal[0]} #{normal[1]} #{normal[2]}\n"
	text += "\t\touter loop\n"
	text += "\t\t\tvertex #{triangle[0][0]} #{triangle[0][1]} #{triangle[0][2]}\n"
	text += "\t\t\tvertex #{triangle[1][0]} #{triangle[1][1]} #{triangle[1][2]}\n"
	text += "\t\t\tvertex #{triangle[2][0]} #{triangle[2][1]} #{triangle[2][2]}\n"
	text += "\t\tend loop\n"
	text += "\tendfacet\n"
end

def saveToFile( text, file_name, mode )
	file_to_save = open( file_name, mode )
	file_to_save.write( text )
end

def rotateGeometry( file_content, axys, angle_deg )
	text = ""
	i = 0
	vertex = []
	triangle = []
	loop do
		this_line = file_content.readline
		if  this_line.include? "endsolid"
			text += this_line.chomp.strip
			text += "\n"
			break
		elsif this_line.include? "vertex"
			a = this_line.chomp.split
			vertex[0] = a[1].to_f
			vertex[1] = a[2].to_f
			vertex[2] = a[3].to_f
			if axys == "x"
				vertex_rotated = Roto.rotateX( vertex, angle_deg )
			elsif axys == "y"
				vertex_rotated = Roto.rotateY( vertex, angle_deg )
			else
				vertex_rotated = Roto.rotateZ( vertex, angle_deg )
			end
			#
			triangle.push( vertex_rotated )
			i += 1
			#
			if i == 3
				normal = computeNormal( triangle )
				text += facetBlock( normal, triangle )
				triangle = []
				i = 0
			end
		elsif this_line.include? "normal"
			pass
		elsif this_line.include? "color"
			text += "\t"
			text += this_line.chomp.strip
			text += "\n"
		else
			if this_line.include? "solid"
				text += this_line.chomp.strip
				text += "\n"
			end
		end
	end
	return text
end
#
file_name = "pyramid.stl"
transformed_file_name = "pyramid_transformed_x.stl" 
angle_deg = 90
axys_of_rotation = "x"
#
file_content = open( file_name )
text = rotateGeometry( file_content, axys_of_rotation, angle_deg )
saveToFile( text, transformed_file_name , "w" )


