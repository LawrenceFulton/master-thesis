# ############################################################################
#     www.  //        //''                         //    '' //''//''          
#    //''' //' //'// //' '''// ////   //''' //''' //'// // //' //' //'// //'' 
#   ///// //  ///// //  ///// // //  ///// //    // // // //  //  ///// //    
#  ,,,// /// //,,, //  //,// // //, ,,,// //,,, // // // //  //  //,,, // .de 
# ############################################################################
#       author: Stefan Schiffer <stefan.schiffer@itec.rwth-aachen.de>
#      license: this work can be redistributed under the terms of the GPLv2
#  description: Generic Makefile for LaTeX files
# ############################################################################

## MAIN ###################

PREFIX = thesis
FOLDER = itec-thesis-template

## #################################### ##
##  VARIABLES                           ##
## #################################### ##

## FILES ##################

TEXFILE = $(PREFIX).tex
#
DVIFILE = $(PREFIX).dvi
PSFILE  = $(PREFIX).ps
PDFFILE = $(PREFIX).pdf
# AUX/LOG
AUXFILE = $(PREFIX).aux
LOGFILE = $(PREFIX).log
# INDEX
IDXFILE = $(PREFIX).idx
# GLOSSARY/NOMENCLATURE
NOMFILE = $(PREFIX).nlo
NLSFILE = $(PREFIX).nls
NLGFILE = $(PREFIX).nlg
# BIBLIOGRAPHY
BBLFILE = $(PREFIX).bbl
BLGFILE = $(PREFIX).blg
#
TARFILE = $(PREFIX).tar
TGZFILE = $(PREFIX).tgz
TBZFILE = $(PREFIX).tbz
ZIPFILE = $(PREFIX).zip

RMFILES = *~ *.toc *.idx *.ilg *.ind *.bbl *.blg *.out *.aux *.nlg *.nlo *.nls \
	  *.tmp *.log *.lot *.lof *.adx *.and *.abb *.ldx $(TARFILE)

## OPTIONS ################

SILENT = @

## COMMANDS ###############

MAKE        = make -s
LATEX       = latex
BIBTEX      = bibtex
MAKEIDX     = makeindex
DVIPS       = dvips
DVIPSFLAGS  = -Ppdf -G0
DVIPDF      = dvipdf
PS2PDF      = ps2pdf
PS2PDFFLAGS = -sPAPERSIZE=a4 -dCompatibilityLevel=1.3 -dEmbedAllFonts=true
PSNUP       = psnup
PDFLATEX    = pdflatex -file-line-error
PDF2PS      = pdf2ps
PDF2PSFLAGS = #-paper "A4"

## VIEW ###################

VIEWDVI     = xdvi
VIEWDVI_OPT = -geometry 676x920-0+0
VIEWPS      = gv
VIEWPS_OPT  = -geometry 676x920-0+0
VIEWPDF     = xpdf
VIEWPDF_OPT = -geometry 676x920-0+0

## TOOLS ##################

TAR      = tar -cvf
UNTAR    = tar -xvf
TGZ      = tar -czvf
UNTGZ    = tar -xzvf
TBZ2     = tar -cjvf
UNTBZ2   = tar -xjvf
ZIP      = zip
UNZIP    = unzip

RM       = rm
RMF      = rm -f
RMRF     = rm -rf
DBG      = echo
MSG      = echo

## COLORS #################

RESET       = tput sgr0
#
BLACK       = tput setaf 0
BLACK_BG    = tput setab 0
DARKGREY    = tput setaf 0; tput bold
RED         = tput setaf 1
RED_BG      = tput setab 1
LIGHTRED    = tput setaf 1; tput bold
GREEN       = tput setaf 2
GREEN_BG    = tput setab 2
LIME        = tput setaf 2; tput bold
BROWN       = tput setaf 3
BROWN_BG    = tput setab 3
YELLOW      = tput setaf 3; tput bold
BLUE        = tput setaf 4
BLUE_BG     = tput setab 4
BRIGHTBLUE  = tput setaf 4; tput bold
PURPLE      = tput setaf 5
PURPLE_BG   = tput setab 5
PINK        = tput setaf 5; tput bold
CYAN        = tput setaf 6
CYAN_BG     = tput setab 6
BRIGHTCYAN  = tput setaf 6; tput bold
LIGHTGREY   = tput setaf 7
LIGHTGREYBG = tput setab 7
WHITE       = tput setaf 7; tput bold

## NAMED-HELPER ###########

MENU  = $(CYAN)
ITEM  = $(BRIGHTCYAN)
DONE  = $(CYAN)
CHECK = $(GREEN)
ERROR = $(RED)

## #################################### ##
##  R U L E S                           ##
## #################################### ##

all: dofullpdf
# wall

pdf: dofullpdf

## ##################### ##
##  USAGE                ##
## ##################### ##

info:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- INFO --                                                            "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "  This is a generic LaTeX Makefile. (use 'usage' for possible targets)  "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    It supports the classic dvi->ps->pdf-chain as well as pdflatex      "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "                     Copyright (C) Stefan Schiffer .de                  "; $(RESET)
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

usage:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- USAGE --                                                           "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "                                                                        "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "  * general:                                                            "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - clean      => remove all generated/temporary/bak-files            "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - dobibtex   => run bibtex on TEX-file                              "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - domakeidx  => run makeindex                                       "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "  * pdflatex-based:                                                     "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - dopdflatex => compile TEX-file with pdflatex                      "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - dopdf2ps   => convert PDF-file to PS-file                         "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "  * display:                                                            "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - viewdvi    => display DVI-file ($(VIEWDVI)) "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - viewps     => display  PS-file ($(VIEWPS))  "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - viewpdf    => display PDF-file ($(VIEWPDF)) "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "  * tools:                                                              "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - tar        => create tarball of complete directory         "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - tgz        => create gzipped tarball of complete directory "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "    - tbz2       => create bzip2ed tarball of complete directory "; $(RESET)
	$(SILENT) $(MENU); $(MSG) "                                                                        "; $(RESET)
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

## ##################### ##
##  PDFLATEX (PDF)       ##
## ##################### ##

short:
	$(SILENT) $(MAKE) dopdflatex

dofullpdf:
	$(SILENT) $(MAKE) dopdflatex
	$(SILENT) #$(MAKE) domakeidx
	$(SILENT) $(MAKE) dobibtex
	$(SILENT) $(MAKE) dopdflatex
	$(SILENT) $(MAKE) dopdflatex
	$(SILENT) $(MAKE) dopdflatex

dopubown:
	$(SILENT) $(MAKE) dobibown
	$(SILENT) $(MAKE) dobibths

dopdflatex:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Creating '$(PDFFILE)' via $(PDFLATEX)"; $(RESET)
	$(SILENT) $(PDFLATEX) $(TEXFILE)
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

dopdf2ps:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Running '$(PDF2PS)' on '$(PDFFILE)'"; $(RESET)
	$(SILENT) $(PDF2PS) $(PDF2PSFLAGS) $(PDFFILE)
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)


## ##################### ##
##  CHAPTERS             ##
## ##################### ##

chap_%: chap_%.tex
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Running '$<' for '$@'"; $(RESET)
	$(SILENT) $(MAKE) PREFIX=$@ dopdflatex
	$(SILENT) $(MAKE) PREFIX=$@ dobibtex
	$(SILENT) $(MAKE) PREFIX=$@ dopdflatex
	$(SILENT) $(MAKE) PREFIX=$@ dopdflatex
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)


## ##################### ##
##  Releases             ##
## ##################### ##

release-thesis: 
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Building release version of the whole thesis"; $(RESET)
	$(SILENT) make
	$(SILENT) $(ITEM); $(MSG) "  -- Generating (size-)optimized version with ghostscript"; $(RESET)
	$(SILENT) gs -q -dOptimize=true -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -sOutputFile=release/thesis.opt.pdf thesis.pdf -c quit
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

release-printest:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Building printing test ..."; $(RESET)
	$(SILENT) pdftk thesis.pdf cat 52-53 55-55 70-70 output thesis-printest.pdf
	$(SILENT) $(ITEM); $(MSG) "  -- Generating (size-)optimized version with ghostscript"; $(RESET)
	$(SILENT) gs -q -dOptimize=true -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -sOutputFile=thesis-printest.opt.pdf thesis-printest.pdf -c quit
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

release-abstract-en:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Building release of abstract"; $(RESET)
	$(SILENT) pdftk thesis.pdf cat 3-3 output thesis-abstract-en.pdf
	$(SILENT) $(ITEM); $(MSG) "  -- Generating (size-)optimized version with ghostscript"; $(RESET)
	$(SILENT) gs -q -dOptimize=true -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -sOutputFile=thesis-abstract-en.opt.pdf thesis-abstract-en.pdf -c quit
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

release-abstract-de:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Building release of abstract"; $(RESET)
	$(SILENT) pdftk thesis.pdf cat 3-3 output thesis-abstract-de.pdf
	$(SILENT) $(ITEM); $(MSG) "  -- Generating (size-)optimized version with ghostscript"; $(RESET)
	$(SILENT) gs -q -dOptimize=true -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -sOutputFile=thesis-abstract-de.opt.pdf thesis-abstract-de.pdf -c quit
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

release-abstract:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Building release of abstract"; $(RESET)
	$(SILENT) pdftk thesis.pdf cat 3-3 5-5 output thesis-abstract.pdf
	$(SILENT) $(ITEM); $(MSG) "  -- Generating (size-)optimized version with ghostscript"; $(RESET)
	$(SILENT) gs -q -dOptimize=true -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -sOutputFile=thesis-abstract.opt.pdf thesis-abstract.pdf -c quit
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

## ##################### ##
##  GENERAL              ##
## ##################### ##

dobibtex:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Running bibtex on '$(PREFIX)'"; $(RESET)
	$(SILENT) $(BIBTEX) $(PREFIX) 
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

dobibown:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Running bibtex on '$(PREFIX)'"; $(RESET)
	$(SILENT) $(BIBTEX) O 
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

dobibths:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Running bibtex on '$(PREFIX)'"; $(RESET)
	$(SILENT) $(BIBTEX) T
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

domakeidx:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Running makeindex on '$(IDXFILE)'"; $(RESET)
	$(SILENT) $(MAKEIDX) $(IDXFILE) 
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

domakenom:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Running makeindex on '$(NOMFILE)'"; $(RESET)
	$(SILENT) $(MAKEIDX) $(NOMFILE) -s nomencl.ist -o $(NLSFILE) -t $(NLGFILE)
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)


## ##################### ##
##  WARNINGS             ##
## ##################### ##

wall: warntex warn2do

warntex:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- grep LaTeX/pdfTeX Warnings in '$(TEXFILE)' ..."; $(RESET)
	$(SILENT) $(LATEX) $(TEXFILE) | grep -i -A 1 'tex warning' \
			&& ($(ERROR); $(MSG) -e "  -> please take care of the above TeX-warnings\n"; $(RESET)) \
			|| ($(CHECK); $(MSG) " =) TeX generated NO warnings"; $(RESET))
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

warn2do:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(MSG) ""
	$(SILENT) $(ITEM); $(MSG) "  -- list todo/tbc/chk/..."; $(RESET)
	$(SILENT) grep -in '\\tbc\|\\todo\|\\chk\|\\rework' *.tex | grep -iv "newcommand\|def\|\:%" \
			&& ($(ERROR); $(MSG) -e "  -> please correct above todos"; $(RESET)) \
			|| ($(CHECK); $(MSG) "  =) no todo/check-thing found"; $(RESET))
	$(SILENT) $(MSG) ""
	$(SILENT) $(ITEM); $(MSG) "  -- '\\ref','\\cite' without leading '~' ..."; $(RESET)
	$(SILENT) grep -in '\\ref\|\\cite' *.tex | grep -v '\~\|\:%' \
			&& ($(ERROR); $(MSG) "  -> please insert missing '~' before each '\\ref','\\cite' listed above"; $(RESET)) \
			|| ($(CHECK); $(MSG) "  =) no missing '~' before '\ref' or '\cite' found"; $(RESET))
	$(SILENT) $(MSG) ""
	$(SILENT) $(ITEM); $(MSG) "  -- 'e.g.' without following '~' ..."; $(RESET)
	$(SILENT) grep -in 'e\.g\.' *.tex | grep -v '\~\|\:%' \
			&& ($(ERROR); $(MSG) -e "  -> please insert missing '~' after all 'e.g.' listed above"; $(RESET)) \
			|| ($(CHECK); $(MSG) "  =) no missing '~' after 'e.g.' found"; $(RESET))
	$(SILENT) $(MSG) ""
	$(SILENT) $(ITEM); $(MSG) "  -- 'i.e.' without following '~' ..."; $(RESET)
	$(SILENT) grep -in 'i\.e\.' *.tex | grep -v '\~\|\:%' \
			&& ($(ERROR); $(MSG) -e "  -> please insert missing '~' after all 'i.e.' listed above"; $(RESET)) \
			|| ($(CHECK); $(MSG) "  =) no missing '~' after 'i.e.' found"; $(RESET))
	$(SILENT) $(MSG) ""
	$(SILENT) $(ITEM); $(MSG) "  -- 'et al.' without following '~' ..."; $(RESET)
	$(SILENT) grep -in 'et al\.' *.tex | grep -v '\~\|\:%' \
			&& ($(ERROR); $(MSG) -e "  -> please insert missing '~' after all 'et al.' listed above"; $(RESET)) \
			|| ($(CHECK); $(MSG) "  =) no missing '~' after 'et al.' found"; $(RESET))
	$(SILENT) $(MSG) ""
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

## ##################### ##
##  ARCHIVE              ##
## ##################### ##

tar:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Creating tarball '$(TARFILE)'"; $(RESET)
	$(SILENT) $(TAR) $(TARFILE) -C.. $(FOLDER) 
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

tgz:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Creating gzipped tarball '$(TGZFILE)'"; $(RESET)
	$(SILENT) $(TGZ) $(TGZFILE) -C.. $(FOLDER) 
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

tbz2:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Creating bzip2ed tarball '$(TBZFILE)'"; $(RESET)
	$(SILENT) $(TBZ2) $(TBZFILE) -C.. $(FOLDER) 
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

untar:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Deflating tarball '$(TARFILE)'"; $(RESET)
	$(SILENT) $(UNTAR) $(TARFILE) -C.. 
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

zip:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Creating zipfile '$(ZIPFILE)'"; $(RESET)
	$(SILENT) $(ZIP) -r release/$(ZIPFILE) .gitignore Makefile *.tex *.bib *.sty code/ data/ figs/ imgs/ pics/
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)

zip-old:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- Creating zipfile '$(ZIPFILE)'"; $(RESET)
	$(SILENT) $(ZIP) -r release/$(ZIPFILE) ../$(FOLDER)/.gitignore ../$(FOLDER)/Makefile ../$(FOLDER)/*.tex ../$(FOLDER)/*.bib ../$(FOLDER)/*.sty ../$(FOLDER)/code/ ../$(FOLDER)/data/ ../$(FOLDER)/figs/ ../$(FOLDER)/imgs/ ../$(FOLDER)/pics/
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)


## ##################### ##
##  CLEANING             ##
## ##################### ##

clean:
	$(SILENT) $(MENU); $(MSG) " -----------------------------------------------------------------------"; $(RESET)
	$(SILENT) $(ITEM); $(MSG) "  -- CLEANING UP ..."; $(RESET)
	$(SILENT) $(RMF) $(RMFILES)
	$(SILENT) $(DONE); $(MSG) " ------------------------------------------------------------- done. ---"; $(RESET)



# ############################################################################
#                                                                  END OF FILE
# ############################################################################
