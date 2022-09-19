//****************************************************************************************************************************
//Program name: "Hypotenuse".  This program takes in the user input of height and width in float and calculates the hypotenuse
// Copyright (C) 2021 Joseph Eggers.                                                                             *
//                                                                                                                           *
//This file is part of the software program "Hypotenuse".                                                                   *
//hypotenuse is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License   *
//version 3 as published by the Free Software Foundation.                                                                    *
//hypotenuse is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied          *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Joseph Eggers
//  Author email: joseph.eggers@csu.fullerton.edu
//
//Program information
//  Program name: Joseph Eggers
//  Programming languages: One modules in C and one module in X86
//  Date program began: 2022 Sep 14
//  Date of last update: 2022 Sep 17
//  Files in this program: hypotenuse.c, pythagoras.asm
//  Status: Finished.
//
//Purpose
//  Show how to input and output floating point (64-bit) numbers.
//
//This file
//   File name: hypotenuse.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o driver.o hypotenuse.c -std=c11
//   Link: gcc -m64 -no-pie -o final.out Hypotenuse.o driver.o -std=c11
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

extern double pythagoras();

int main(int argc, char* argv[])
{
  double p = 0.0;
  printf("Welcome to the Hypotenuse program maintained by Joseph Eggers.\n");
  printf("If errrors are discovered please report them to Joseph Eggers @eggersjoseph23@gmail.com. At crimsongnome.com the customer comes first.\n");
  p = pythagoras();
  printf("The main function has received this number %.15lf and has decided to keep it.\n", p);
  printf("An inter zero will be returned to the operating system. Bye.\n");
  return 0;
}
