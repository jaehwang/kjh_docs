#slides=rest cont-delivery
slides=rest continuous-delivery clojure-java google agile-agile dsl

rerun = "(There were undefined references|Rerun to get (cross-references|the bars) right)"

all: report.pdf presentation.pdf

report.pdf: report.tex $(slides:%=slide-%.pdf)
	pdflatex report.tex
	(egrep -q $(rerun) report.log && pdflatex report.tex) || true

presentation.pdf: presentation.tex $(slides:%=slide-%.tex)
	pdflatex presentation.tex
	(egrep -q $(rerun) presentation.log && pdflatex presentation.tex) || true

slide-%.pdf: slidebase.tex slide-%.tex
	cp $(@:slide-%.pdf=slide-%.tex) slidecontent.tex
	pdflatex slidebase.tex $@
	mv slidebase.pdf $@

clean:
	rm -rf slidecontent.tex
	rm -rf *.aux *.log *.nav *.out *.pdf *.snm *.toc
