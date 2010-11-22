#slides=rest cont-delivery
slides=rest continuous-delivery clojure-java google agile-agile dsl qcon \
       pretotype cloud swapping-engine lambda clojure-concurrent

rerun = "(There were undefined references|Rerun to get (cross-references|the bars) right)"

all: report.pdf presentation.pdf

report.pdf: report.tex $(slides:%=slide-%.pdf) references.bib report.bbl
	pdflatex report.tex
	bibtex report
	(egrep -q $(rerun) report.log && pdflatex report.tex) || true

presentation.pdf: presentation.tex $(slides:%=slide-%.tex) references.bib
	pdflatex presentation.tex
	(egrep -q $(rerun) presentation.log && pdflatex presentation.tex) || true

slide-%.pdf: slidebase.tex slide-%.tex
	cp $(@:slide-%.pdf=slide-%.tex) slidecontent.tex
	pdflatex slidebase.tex $@
	mv slidebase.pdf $@

clean:
	rm -rf slidecontent.tex
	rm -rf *.aux *.log *.nav *.out *.pdf *.snm *.toc *.rel *.vrb
	rm -rf *~
