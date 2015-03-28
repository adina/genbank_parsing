#bash isn't the right language I don't think
#don't try to do too many things in one program if you don't have to
#e.g., it's not a bad idea to have the genbank files somewhere too

python fetch-genomes.py list_of_ids genbanks
python parse-genbank.py genbanks/*gbk
