% potentially interesting:
%   - https://www.ctan.org/pkg/smartdiagram (powerpoint style smartart)
%   - https://tex.stackexchange.com/a/533239/229138 (plantuml diagrams)
%   - https://www.overleaf.com/learn/how-to/Writing_Markdown_in_LaTeX_Documents (markdown in latex)
%   - https://mirror.ctan.org/macros/latex/contrib/microtype/ (to make documents look good or something)

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
\RequirePackage{xparse}

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

% =================
% HEADER AND FOOTER
% =================

% setup header and footer
% https://tex.stackexchange.com/a/283744/229138
\RequirePackage[headsepline, footsepline, singlespacing=true]{scrlayer-scrpage}

% remove number from header
\renewcommand*{\sectionmarkformat}{}

% https://tex.stackexchange.com/a/225277/229138
\automark{section}

\NewDocumentCommand{\DefaultDiplPageStyle}{}{
    \clearpairofpagestyles
    \ohead{\headmark}

    \ifoot{\@title}
    \ofoot{\pagemark}
}
\DefaultDiplPageStyle

% normal font in footer
\setkomafont{pagefoot}{\normalfont\fontsize{9pt}{9pt}}
\setkomafont{pagehead}{\normalfont\fontsize{9pt}{9pt}}

% ====================
% CUSTOM TITLE COMMAND
% ====================

% overwrite title to add an optional argument for the title on the title page
\RequirePackage{ifthen}
\newcommand{\titlepagetitle}{}
\RenewDocumentCommand{\title}{O{}m}{
    \renewcommand{\@title}{#2}
    \ifthenelse{\equal{#1}{}}
        {\renewcommand{\titlepagetitle}{#2}}
        {\renewcommand{\titlepagetitle}{#1}}
}

% ===============
% CUSTOM METADATA
% ===============

% https://tex.stackexchange.com/a/239322/229138
\newtoks\location
\newtoks\discipline
\newtoks\schoolyear
\newtoks\supervisor
\newtoks\partnercompany

% =====================
% CUSTOM AUTHOR COMMAND
% =====================

\newcommand{\titlepageauthors}{}
\newcommand{\affidavitauthors}{}
\newcommand{\abstractauthors}{}

\RenewDocumentCommand{\author}{mmO{\vspace{3cm}}}{
    \ifthenelse {\equal{\titlepageauthors}{}}
        {\renewcommand{\titlepageauthors}{#1, #2}}
        {\g@addto@macro\titlepageauthors{\\#1, #2}}

    \g@addto@macro\affidavitauthors{
        \normalsize#3
        \ifthenelse{\equal{#3}{\vspace{3cm}}}{}{\newline}
        \vspace{-1cm}
        \hrule
        \small#1 \\
        \vspace{1cm} \\
    }

    \ifthenelse {\equal{\abstractauthors}{}}
        {\renewcommand{\abstractauthors}{#1}}
        {\g@addto@macro\abstractauthors{\newline #1}}
}

% TODO: set pdf metadata, see docs of https://ctan.org/pkg/hyperref section 5.7

% =================
% CUSTOM TITLE PAGE
% =================

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
                \fontsize{36pt}{26pt}\selectfont \textbf{\titlepagetitle}
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

    \vspace{4cm}

    \the\location, am \@date

    \clearpage

    \DefaultDiplPageStyle
}

% =========
% AFFIDAVIT
% =========

\NewDocumentCommand{\affidavit}{}{
    \clearpage
    \thispagestyle{empty}

    \textbf{Erklärung gemäß Prüfungsordnung}

    \enquote{Ich erkläre an Eides statt, dass ich die vorliegende Diplomarbeit selbstständig und ohne fremde Hilfe verfasst,  andere als die angegebenen Quellen und Hilfsmittel nicht benutzt und alle den benutzten Quellen wörtlich entnommenen Stellen als solche kenntlich gemacht habe.}

    \begin{multicols}{2}
        \the\location, \@date

        \columnbreak

        Verfasserinnen/Verfasser:

        \affidavitauthors
    \end{multicols}

    \clearpage
}

% ===========================
% CUSTOM ABSTRACT ENVIRONMENT
% ===========================

\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{booktabs}
\RequirePackage{tabularx}

\NewDocumentCommand{\createcustomabstractcommand}{m}{
    \expandafter\NewDocumentCommand\csname #1\endcsname{ m m }{
        \expandafter\NewDocumentCommand\csname #1DE\endcsname{}{##1}
        \expandafter\NewDocumentCommand\csname #1EN\endcsname{}{##2}
    }
}

\NewDocumentCommand{\begincustomabstract}{}{
    \createcustomabstractcommand{task}
    \createcustomabstractcommand{implementation}
    \createcustomabstractcommand{results}
    \createcustomabstractcommand{overviewpicture}
    \createcustomabstractcommand{awardparticipation}
    \createcustomabstractcommand{accessibility}
}

\newcommand{\customabstractheader}{
    \begin{tabularx}{\textwidth}{|p{4cm}|X p{6.5cm}|}
        \hline

        \multirow{2}{4cm}{\includegraphics[width=4cm]{gkr-logo}} &               & \vspace{1mm} \fontsize{14pt}{8pt}\selectfont \textbf{HTBLA Grieskirchen} \newline \\

        \cline{2-3}

        & Fachrichtung: & \textbf{\the\discipline}\newline                                                  \\

        \hline
    \end{tabularx}
}

\NewDocumentCommand{\customabstractsimpletable}{m m}{
    \begin{tabularx}{\textwidth}{|p{5cm}|X|}
        \hline
        \textbf{#1} & #2 \\
        \hline
    \end{tabularx}% this comment is important, otherwise spacing is inconsistent
}

\NewDocumentCommand{\endcustomabstract}{}{
    \clearpage
    \pagestyle{empty}
    \singlespacing

    \customabstractheader

    \begin{center}
        \fontsize{18pt}{18pt}\selectfont \textbf{DIPLOMARBEIT} \\
        \fontsize{14pt}{14pt}\selectfont \textbf{DOKUMENTATION}
    \end{center}

    \begin{tabularx}{\textwidth}{|p{5cm}|X|}
        \hline
        \textbf{Namen der \newline Verfasser/innen} & \abstractauthors    \\
        \hline
        \textbf{Jahrgang \newline Schuljahr}        & \the\schoolyear     \\
        \hline
        \textbf{Thema der Diplomarbeit}             & \@title             \\
        \hline
        \textbf{Kooperationspartner}                & \the\partnercompany \\
        \hline
    \end{tabularx}

    \customabstractsimpletable{Aufgabenstellung}{\taskDE}

    \customabstractsimpletable{Realisierung}{\implementationDE}

    \customabstractsimpletable{Ergebnisse}{\resultsDE}

    \clearpage

    \customabstractheader

    \customabstractsimpletable{Typische Grafik, Foto etc.\newline(mit Erläuterung)}{\overviewpictureDE}

    \customabstractsimpletable{Teilnahme an Wettbewerben, Auszeichnungen}{\awardparticipationDE}

    \customabstractsimpletable{Möglichkeiten der Einsichtnahme in die Arbeit}{\accessibilityDE}

    \begin{tabularx}{\textwidth}{|p{5cm}|X|X|}
        \hline
        \textbf{Approbation \newline (Datum/Unterschrift)} & \scriptsize Prüferin/Prüfer & \scriptsize Direktorin/Direktor \\
        \hline
    \end{tabularx}

    \clearpage
}

\RenewDocumentEnvironment{abstract}{}{\begincustomabstract}{\endcustomabstract}

% ===============
% SECTION SPACING
% ===============

% TODO: fix this
% TODO: fix calibri not used in heading
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
\At@startsection{\addtolength{\@tempskipa}{-\parskip}}
\xpatchcmd{\@xsect}{\vskip\@tempskipa}{\vskip\dimexpr\@tempskipa-\parskip\relax}{}{}