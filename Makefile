all: glossary.py index.py pattern.py protocol.py schema.py

bibliography/bibliography.html: bibliography/bibliography.bib bibliography/bibliography.md
	pandoc --natbib --filter pandoc-citeproc bibliography/bibliography.md \
	       --bibliography=bibliography/bibliography.bib \
	       --csl=bibliography/copernicus-publications.csl \
	       -o bibliography/bibliography.html

%.py: bibliography/bibliography.html
	python3 build/$@

gh-pages: all
	ghp-import --no-jekyll --push --force output

clean:
	rm -r output; rm bibliography/bibliography.html

.PHONY: pattern protocol schema gh-pages clean
