p1=http://10.20.4.80/Andy/vn_rwd.git
p2=http://10.20.4.80/alex/vn_backend.git
p3=http://10.20.4.80/alex/kk_frontend.git
p4=http://10.20.4.80/alex/kk_backend.git

echo "Choose an option to do git clone:"
echo 1.$p1
echo 2.$p2
echo 3.$p3
echo 4.$p4
echo e.exit

printf "Please type a number:"
read input

case $input in
1) git clone $p1;;
2) git clone $p2;;
3) git clone $p3;;
4) git clone $p4;;
e) echo bye bye && exit;;
*) printf "Error : incorrect input \n" && sh gitclone.sh;;
esac
