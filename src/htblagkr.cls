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
    bottom=3.5cm,
    head=25pt,
    foot=25pt
]{geometry}
\setlength{\voffset}{1cm}


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

% setup heading
% https://tex.stackexchange.com/a/283744/229138
\RequirePackage[headsepline, footsepline, singlespacing=true]{scrlayer-scrpage}

% remove number from header
\renewcommand*{\sectionmarkformat}{}

% https://tex.stackexchange.com/a/225277/229138
\automark{section}

\NewDocumentCommand{\DefaultDiplPageStyle}{}{
    \clearpairofpagestyles
    \ohead{\headmark}

    \ifoot{\thetitle}
    \ofoot{\pagemark}
}
\DefaultDiplPageStyle

% normal font in footer
\setkomafont{pagefoot}{\normalfont\fontsize{9pt}{9pt}}
\setkomafont{pagehead}{\normalfont\fontsize{9pt}{9pt}}

% Retain title so that it can be used in the footer
\RequirePackage{titling}

% custom metadata
% https://tex.stackexchange.com/a/239322/229138
\newtoks\location
\newtoks\discipline
\newtoks\schoolyear
\newtoks\supervisor

% customize title
\RequirePackage{multicol}
\RequirePackage{graphicx}
\RenewDocumentCommand{\maketitle}{}{
    \clearpairofpagestyles
    \ihead{
        \includegraphics{gkr-logo}
    }
    \chead{
        \fontsize{15pt}{15pt}\selectfont \textbf{HTBLA Grieskirchen} \\
        \normalsize 4710 Grieskirchen, Parzer Schulstraße 1
    }
    \ohead{
        \includegraphics{htl-logo}
    }
    \ifoot{Abgabevermerk: \\ Datum:}
    \ofoot{
        \\
        Betreuerin/Betreuer:
    }

    \begin{center}
        \fontsize{12pt}{12pt}\selectfont \textbf{Fachrichtung \the\discipline}

        \vspace{2cm}

        \fontsize{11pt}{11pt}\selectfont \textbf{Schuljahr \the\schoolyear}

        \vspace{3cm}

        \fontsize{30pt}{30pt}\selectfont \textbf{DIPLOMARBEIT}

        \fontsize{16pt}{16pt}\selectfont Gesamtprojekt

        \parbox[t][4cm][t]{13cm}{
            \begin{center}
                \fontsize{36pt}{36pt}\selectfont \textbf{\thetitle}
            \end{center}
        }
    \end{center}

    \setlength{\columnsep}{2cm}
    \begin{multicols}{2}

        \textbf{Ausgeführt von:} \\
        \theauthor

        \columnbreak

        \textbf{Betreuerin/Betreuer:} \\
        \the\supervisor
    \end{multicols}

    \vspace{4cm}

    \the\location, am \thedate

    \clearpage

    \DefaultDiplPageStyle
}

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