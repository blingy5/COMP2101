#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

read num1
read num2
read num3
sum=$((num1 + num2 + num3))
product=$((num1 * num2 * num3))


cat <<EOF
The sum of all numbers is $sum
The product of all numbers is $product
EOF
