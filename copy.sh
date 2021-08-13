echo "What file needs copied?"
read file

for i in ./*/* #goes to each subdirectory


do
    if [ -d "$i" ] # if it's a directory
    then
        cp ${file}  "$i" # copies file
    fi
done
