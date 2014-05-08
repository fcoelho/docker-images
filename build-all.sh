#!/bin/bash

for dir in *; do
	(cd $dir && make || tput setaf 1 && echo FUDEOOOOOOO && tput sgr0)
done

