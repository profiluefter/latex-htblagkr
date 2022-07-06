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

% custom commands
\RequirePackage{xpatch}

% calibri font
\RequirePackage{fontspec}
\setmainfont{Calibri}

% german
\RequirePackage[ngerman]{babel}

% quotation marks
\RequirePackage{csquotes}

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

% Retain title and date so that it can be used in custom places
\RequirePackage{titling}

% custom metadata
% https://tex.stackexchange.com/a/239322/229138
\newtoks\location
\newtoks\discipline
\newtoks\schoolyear
\newtoks\supervisor

% custom author information
\NewDocumentCommand{\titlepageauthors}{}{}
\NewDocumentCommand{\affidavitauthors}{}{}
\RenewDocumentCommand{\author}{mmO{\vspace{5mm}}}{
    \makeatletter
    \g@addto@macro\titlepageauthors{#1, #2\\}
    \g@addto@macro\affidavitauthors{#1\\#3\\}
    \makeatother
}

% customize title
\RequirePackage{multicol}
\RequirePackage{graphicx}
\RenewDocumentCommand{\maketitle}{}{
    \clearpage

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

        \parbox[t][3.5cm][t]{13cm}{
            \begin{center}
                \fontsize{36pt}{26pt}\selectfont \textbf{\thetitle}
            \end{center}
        }
    \end{center}

    \setlength{\columnsep}{2cm}
    \begin{multicols}{2}

        \textbf{Ausgeführt von:} \\
        \titlepageauthors

        \columnbreak

        \textbf{Betreuerin/Betreuer:} \\
        \the\supervisor
    \end{multicols}

    \vspace{3cm}

    \the\location, am \thedate

    \clearpage

    \DefaultDiplPageStyle
}

% custom affidavit
\newcommand{\affidavit}{
    \clearpage
    \thispagestyle{empty}

    \textbf{Erklärung gemäß Prüfungsordnung}

    \enquote{Ich erkläre an Eides statt, dass ich die vorliegende Diplomarbeit selbstständig und ohne fremde Hilfe verfasst,  andere als die angegebenen Quellen und Hilfsmittel nicht benutzt und alle den benutzten Quellen wörtlich entnommenen Stellen als solche kenntlich gemacht habe.}

    \begin{multicols}{2}
        \the\location, \thedate

        \columnbreak

        Verfasserinnen/Verfasser:

        \affidavitauthors
    \end{multicols}

    \clearpage
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

\makeatletter
\At@startsection{\addtolength{\@tempskipa}{-\parskip}}
\xpatchcmd{\@xsect}{\vskip\@tempskipa}{\vskip\dimexpr\@tempskipa-\parskip\relax}{}{}
\makeatother