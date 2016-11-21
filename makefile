SHELL := /usr/bin/env bash

# configure engine
## LaTeX engine
### LaTeX workflow: pdf; xelatex; lualatex
latexmkEngine := pdf

### pandoc workflow: pdflatex; xelatex; lualatex
pandocEngine := pdflatex

# main targets
document := Sujet

## LaTeX workflow
latexmkTeX := $(addsuffix .tex, $(document))
latexmkPDF := $(addsuffix .pdf, $(document))

## pandoc workflow
pandocMD := $(addsuffix .md, $(document))
pandocTeX := $(addsuffix .tex, $(document))
pandocPDF := $(addsuffix .pdf, $(document))

# command line arguments
pandocArgCommon := -f markdown+autolink_bare_uris-fancy_lists --normalize -S -V linkcolorblue -V citecolor=blue -V urlcolor=blue -V toccolor=blue --latex-engine=$(pandocEngine) -M date="`date "+%B %e, %Y"`"

## MD
pandocArgMD := -f markdown+abbreviations+autolink_bare_uris+markdown_attribute+mmd_header_identifiers+mmd_link_attributes+mmd_title_block+tex_math_double_backslash-latex_macros-auto_identifiers -t markdown+raw_tex-native_spans-simple_tables-multiline_tables-grid_tables-latex_macros --normalize -s --wrap=none --column=999 --atx-headers --reference-location=block --file-scope

## TeX/PDF
### LaTeX workflow
latexmkArg := -$(latexmkEngine)
pandocArgFragment := $(pandocArgCommon)

### pandoc workflow
pandocArgStandalone := $(pandocArgFragment) --toc-depth=1 -s -N


## TeX/PDF (make workbook.tex requires workbook.yml to be the first)
preamble := 


# Main Targets ###############################################################
## LaTeX workflow
latexmk: $(latexmkPDF) $(latexmkTeX)

## pandoc workflow
pandoc: $(pandocPDF) $(pandocTeX)
md: $(pandocMD)

## commonly used
all: latexmk pandoc md
travis: $(latexmkPDF) $(pandocPDF)

# cleaning generated files
## clean everthing but PDF output
clean:
	latexmk -c -f $(latexmkTeX) $(pandocTeX)
	rm -f $(latexmkTeX) $(pandocTeX) 
## clean everything
Clean:
	latexmk -C -f $(latexmkTeX) $(pandocTeX)
	rm -f $(latexmkTeX) $(pandocTeX)

# Making dependancies ########################################################

# Building the final products

## LaTeX workflow
### TeX to PDF: $(latexmkPDF)
%.pdf: %.tex $(MD2TeX)
	latexmk $(latexmkArg) $<

### md to TeX: $(pandocTeX)
%.tex: %.md $(preamble)
	pandoc $(pandocArgStandalone) -o $@ $<

### md to PDF: $(pandocPDF)
%.pdf: %.md $(preamble)
	pandoc $(pandocArgStandalone) -o $@ $<
