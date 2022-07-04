% potentially interesting:
%   - https://www.ctan.org/pkg/smartdiagram (powerpoint style smartart)
%   - https://tex.stackexchange.com/a/533239/229138 (plantuml diagrams)
%   - https://www.overleaf.com/learn/how-to/Writing_Markdown_in_LaTeX_Documents (markdown in latex)

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{htblagkr}[2022/06/23 Diplomarbeitsvorlage HTBLA Grieskirchen]

% defaults
\LoadClass[
    11pt, % = default
    a4paper, % = default
    parskip=half-
]{scrartcl}

% setup paper margins
\RequirePackage[
    left=3.5cm,
    right=2.5cm,
    top=2.5cm,
    bottom=2.5cm,
    head=25pt, % not sure what this does but scrlayer-scrpage wants it (console warning)
    foot=25pt % same reason as above but actually moves the footer up which is closer to the template
]{geometry}

% TODO: fix header and footer being in required page border
% see geometry package docs here: https://texdoc.org/serve/geometry.pdf/0

% calibri font
\RequirePackage{fontspec}
\setmainfont{Calibri}

% german
\RequirePackage[ngerman]{babel}

% replaced by class option parskip
%\RequirePackage{parskip}

% enable /paragraph to be numbered
% https://stackoverflow.com/a/543370/8719698
\setcounter{secnumdepth}{4}

% make /paragraph a proper heading
% https://tex.stackexchange.com/a/579778/229138
\RedeclareSectionCommands[
    beforeskip=.75\baselineskip plus 1ex minus -0.2ex,
    runin=false,
    afterskip=0.33\baselineskip,
    font=\bfseries,
    afterindent=false
]{paragraph,subparagraph}

% double space between lines
% https://www.overleaf.com/learn/latex/Articles/How_to_change_paragraph_spacing_in_LaTeX#The_setspace_package
\RequirePackage[doublespacing]{setspace}

% Retain title so that it can be used in the footer
\RequirePackage{titling}

% TODO: customize title
% see docs here: https://texdoc.org/serve/titling.pdf/0

% custom location metadata
% https://tex.stackexchange.com/a/239322/229138
\newtoks\location

% setup heading
% https://tex.stackexchange.com/a/283744/229138
\RequirePackage[headsepline, footsepline, singlespacing=true]{scrlayer-scrpage}

% remove number from header
\renewcommand*{\sectionmarkformat}{}

% https://tex.stackexchange.com/a/225277/229138
\automark{section}
\clearpairofpagestyles
\ohead{\headmark}

\ifoot{\thetitle}
\ofoot{\pagemark}

% normal font in footer
\setkomafont{pagefoot}{\normalfont\fontsize{9}{9}}
\setkomafont{pagehead}{\normalfont\fontsize{9}{9}}

% font spacing
% TODO: fix this
% https://texwelt.de/fragen/21544/koma-script-abstande-bei-uberschriften-exakt-einstellen-welche-werte-sind-notwendig
\RedeclareSectionCommand[
    beforeskip=18bp,
    afterskip=12bp
]{section}
\RedeclareSectionCommand[
    beforeskip=18bp,
    afterskip=12bp
]{subsection}
\RedeclareSectionCommand[
    beforeskip=18bp,
    afterskip=12bp
]{subsubsection}
\RedeclareSectionCommand[
    beforeskip=12bp,
    afterskip=12bp
]{paragraph}

\RequirePackage{xpatch}
\makeatletter
\At@startsection{\addtolength{\@tempskipa}{-\parskip}}
\xpatchcmd{\@xsect}{\vskip\@tempskipa}{\vskip\dimexpr\@tempskipa-\parskip\relax}{}{}
\makeatother