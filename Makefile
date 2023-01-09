###############################################
#
# Makefile
#
###############################################

.DEFAULT_GOAL := st

###############################################

st:
	open -a SourceTree .

test:
	open http://127.0.0.1:8000/docs/

server:
	python -m SimpleHTTPServer 8000
