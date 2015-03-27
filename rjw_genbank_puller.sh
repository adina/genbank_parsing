#!/bin/bash

for i in {1..41}
do
	# first I'm making an index to pull a line out of my list of ids
	X=$i
	Y=p
	Z=$X$Y
	id=$(sed -n $Z list_of_ids)

	# now I'm downloading the info for that specific id
	curl "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=protein&id=$id&rettype=gp&retmode=text" > info.txt
	
	# I am making an object that I can pull out the line number that says ORGANISM
	# The taxonomic info I want lives in the two lines below the line that starts with ORGANISM
	output=$(grep -nr ORGANISM info.txt)
	
	# now I'm going to extract those lines that are the 1st and 2nd lines below ORGANISM
	line_num=$(echo $output | cut -f2 -d:)
	line_num=$(( $line_num + 1 ))
	L=$line_num$Y
	front=$(sed -n $L info.txt)
	line_num=$(( $line_num + 1 ))
	L=$line_num$Y
	back=$(sed -n $L info.txt)

	#sticking those two lines together as the full taxonomic entry
	combined=$front$back

	# I also want to get the function of the protein
	function_output=$(grep function= info.txt)
	func=$(echo $function_output | cut -f2 -d=)

	# combining everything
	entry=$id";"$combined";"$func

	echo $entry >> integrase_taxonomic_info.txt



done