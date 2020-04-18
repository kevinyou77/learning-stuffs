#!/bin/bash

#comment 
echo "hello world"

#variable
myName="kevin"
#constant
declare -r NUM=2

#you can use cat here too
cat << END
 this line
  is printed by cat
END
 
#functions
 getDate() {
   date
 } 
  
 getDate

echo "hello, $myName"

getTwoSum() {

    local firstArg=$1
    local secondArg=$2

    local sum=$((firstArg+secondArg))

    echo $sum
}

#note don't add the parameter as the same name as fields inside function,
#bash will think it's the same hence the recursion
firstNum=2
secondNum=3
sum=$(getTwoSum firstNum secondNum)
echo "the sum is $sum"

read -p "how old are you? " age
#conditonals
# [[  ]] used for logic checks, newer version of [], [ ] has less features and more portable
# (( )) used for arithmetic
# refs https://stackoverflow.com/questions/2188199/how-to-use-double-or-single-brackets-parentheses-curly-braces
if [[ $age > 16 ]]
then
    echo "you are 16 yo"
elif [[ $age == 15 || $age == 14 ]]
then
    echo "you are 14 or 15 yo"
else
    echo "idk how old u are"
fi

# run bash commands
# if samp_file is created, run it in VIM
# you can use || too, 
# touch samp_file && vim samp_file

# if samp_file doesn't exist, make it, then vim it
# -d to check if directory available or not
# [ -d samp_dir ] || mkdir samp_dir

# testing values
str1="kevin"

if [[ "$str1" ]]
then
    echo "not null"
fi

# -z means check if the string has value or not ("")
if [[ -z "$str1" ]]
then
    echo "no value"
fi

# check for file values
fileOne="./file_one"
fileTwo="./file_two"

# -e check if file exist
if [[ -e "$fileOne" ]]
then
    echo "file one exists"
else
    echo "file one doesnt exist"
fi

# use regex, have to use [[ ]] since [[ ]] is "extended version" of []
# you can use -sp to hide input
read -p "validate date: " date

pat="^[0-9]{8}$"

if [[ date =~ pat ]]
then
    echo "valid date"
else
    echo "invalid date"
fi

# IFS = internal field separator, used to separate fields on inputs like read -p
OIFS="$IFS"

IFS=","
read -p "enter two values separated by comma, " numberOne numberTwo

numberOne=${$numberOne//[[:blank:]]/}
numberTwo=${numberTwo//[[:blank:]]/}
sum=$((numberOne+numberTwo))
echo "$numberOne + $numberTwo = $sum"

# revert back to original ifs
IFS="$OIFS"

# parameter expansion
sample_string="my neighbour has a cat"
echo "${sample_string//cat/dog}"

# default conditionals
kevin="kevin"
# if var kevin doesnt exist, print thereisnokevin
echo "${kevin:=Theresnokevin}"

# switch case

read -p "how old are you? (again with switch)" ageSwitch

case $ageSwitch in
[0-4])
	echo "you're a baby lol"
	;;
5)
	echo "kindergarten"
	;;
*)
	echo "default case"
	;;
esac

# looping

numToLoop=1
while [[ $numToLoop < 10 ]]
do
	echo "loopzzz"
	numToLoop=$((numToLoop + 1))
done

numToUntil=0
until [[ $numToUntil > 10 ]] 
do
	echo "until tumoro"
	numToUntil=$((numToUntil+1))
done

#traditional for loop
for (( i=0; i < 10; i=i+1 ))
do
	echo $i
done

#arrays
fav_nums=(1 3 5 6 22)
fav_nums[1]
fav_nums[2]=1.232
echo "${fav_nums[2]}"

for i in ${fav_nums[*]}
do
	echo "$i fav"
done

#array length
echo "${#fav_nums[@]}"

# sort fav_nums
sorted_nums=($(for i in "${fav_nums[@]}"; do echo $i; done | sort))

