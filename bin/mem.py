#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#  cpu.py
#  
#  Copyright 2017 William Bradley <tknomanzr@testbed>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  
import psutil

def main():

# Memory: used/total
    memory = psutil.virtual_memory()
    #print(str(round((memory[0] - memory[1]) / 1073741824, 1)) + "/" + str(round(memory[0] / 1073741824, 1)) + "GB ")
    #print(str(round( ((memory[0] - memory[1]) / memory[0]) * 100, 1)) + " % ")
    print(str(round( ( (memory[3] / memory[0]) * 100), 1)) + " % ")

if __name__ == "__main__":
    main()