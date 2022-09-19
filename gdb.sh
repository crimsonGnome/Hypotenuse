#!/bin/bash

#Program: Hypotenuse
#Author: Joseph Eggers

#Purpose: script file to run the program files together.
#Clear any previously compiled outputs
rm *.o
rm *.lis
rm *.out

echo "compile driver.cpp using the g++ compiler standard 2017"
gcc -c -Wall -m64 -no-pie -o driver.o hypotenuse.c -std=c11 -g

echo "Assemble Hypotenuse.asm"
nasm -f elf64 -l Hypotenuse.lis -o Hypotenuse.o hypotenuse.asm -g -gdwarf

echo "Link object files using the gcc Linker standard 2017"
gcc -m64 -no-pie -o final.out Hypotenuse.o driver.o -std=c11 -g

echo "Run the Float Comparator Program:"
gdb ./final.out

rm *.o
rm *.lis
rm *.out