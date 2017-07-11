#!/bin/bash

email=
until [ "$email" != "" ]; do
    echo "enter email: "
    read email
done

filename=
until [ "$filename" != "" ]; do
    echo "enter filename: "
    read filename
done

pasphrase=
until [ "$pasphrase" != "" ]; do
    echo "enter pasphrase: "
    read pasphrase
done

ssh-keygen -t rsa -b 4096 -C $email -N $pasphrase -f ~/.ssh/$filename
ssh-add ~/.ssh/$filename
