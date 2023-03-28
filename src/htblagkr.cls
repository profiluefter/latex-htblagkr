% potentially interesting:
%   - https://www.ctan.org/pkg/smartdiagram (powerpoint style smartart)
%   - https://tex.stackexchange.com/a/533239/229138 (plantuml diagrams)
%   - https://www.overleaf.com/learn/how-to/Writing_Markdown_in_LaTeX_Documents (markdown in latex)
%   - https://mirror.ctan.org/macros/latex/contrib/microtype/ (to make documents look good or something)

% TODO: prefix all internal commands and add an at character so that they won't conflict and can't be used unknowingly

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
% consolas for codeblocks, monospaced Calibri is an experience...
\setmonofont{Consolas}

% german
\RequirePackage[ngerman]{babel}

% minted for syntax highlighting
% has to be loaded before csquotes
\RequirePackage{minted}

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

% set page numbering for pages before the content to roman numerals
\pagenumbering{Roman}

% necessary to make the title in the footer optional
\newcommand{\@istitleset}{false}

% to only show the page number on the first page actually containing content
\newcommand{\@ispagenumberactive}{false}

\NewDocumentCommand{\DefaultDiplPageStyle}{}{
    \clearpairofpagestyles
    \ohead{\headmark}

    \ifoot{\ifthenelse{\equal{\@istitleset}{true}}{\@title}{}}
    \ofoot{\ifthenelse{\equal{\@ispagenumberactive}{true}}{\pagemark}{}}
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
    \renewcommand{\@istitleset}{true}
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

        \parbox[t][6.5cm][t]{13cm}{
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

    \vspace{1.5cm}

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

% TODO: rename all variables to this format
\NewDocumentCommand{\htblagkr@abstract@headingDE@discipline}{}{Fachrichtung}
\NewDocumentCommand{\htblagkr@abstract@headingEN@discipline}{}{Department}
\NewDocumentCommand{\htblagkr@abstract@headingDE@thesis}{}{DIPLOMARBEIT}
\NewDocumentCommand{\htblagkr@abstract@headingEN@thesis}{}{DIPLOMA THESIS}
\NewDocumentCommand{\htblagkr@abstract@headingDE@documentation}{}{DOKUMENTATION}
\NewDocumentCommand{\htblagkr@abstract@headingEN@documentation}{}{Documentation}
\NewDocumentCommand{\htblagkr@abstract@headingDE@author}{}{Namen der \newline Verfasser/innen}
\NewDocumentCommand{\htblagkr@abstract@headingEN@author}{}{Author(s)}
\NewDocumentCommand{\htblagkr@abstract@headingDE@schoolyear}{}{Jahrgang \newline Schuljahr}
\NewDocumentCommand{\htblagkr@abstract@headingEN@schoolyear}{}{Form \newline Academic year}
\NewDocumentCommand{\htblagkr@abstract@headingDE@topic}{}{Thema der Diplomarbeit}
\NewDocumentCommand{\htblagkr@abstract@headingEN@topic}{}{Topic}
\NewDocumentCommand{\htblagkr@abstract@headingDE@partnercompany}{}{Kooperationspartner}
\NewDocumentCommand{\htblagkr@abstract@headingEN@partnercompany}{}{Co-operation partners}
\NewDocumentCommand{\htblagkr@abstract@headingDE@task}{}{Aufgabenstellung}
\NewDocumentCommand{\htblagkr@abstract@headingEN@task}{}{Assignment of tasks}
\NewDocumentCommand{\htblagkr@abstract@headingDE@implementation}{}{Realisierung}
\NewDocumentCommand{\htblagkr@abstract@headingEN@implementation}{}{Realisation}
\NewDocumentCommand{\htblagkr@abstract@headingDE@results}{}{Ergebnisse}
\NewDocumentCommand{\htblagkr@abstract@headingEN@results}{}{Results}
\NewDocumentCommand{\htblagkr@abstract@headingDE@overviewpicture}{}{Typische Grafik, Foto etc.\newline(mit Erläuterung)}
\NewDocumentCommand{\htblagkr@abstract@headingEN@overviewpicture}{}{Illustrative graph, photo\newline(incl. explanation)}
\NewDocumentCommand{\htblagkr@abstract@headingDE@awardparticipation}{}{Teilnahme an Wettbewerben, Auszeichnungen}
\NewDocumentCommand{\htblagkr@abstract@headingEN@awardparticipation}{}{Participation in competitions\newline Awards}
\NewDocumentCommand{\htblagkr@abstract@headingDE@accessibility}{}{Möglichkeiten der Einsichtnahme in die Arbeit}
\NewDocumentCommand{\htblagkr@abstract@headingEN@accessibility}{}{Accessibility of\newline diploma thesis}
\NewDocumentCommand{\htblagkr@abstract@headingDE@approval}{}{Approbation}
\NewDocumentCommand{\htblagkr@abstract@headingEN@approval}{}{Approval}
\NewDocumentCommand{\htblagkr@abstract@headingDE@datesignature}{}{Datum/Unterschrift}
\NewDocumentCommand{\htblagkr@abstract@headingEN@datesignature}{}{date/signature}
\NewDocumentCommand{\htblagkr@abstract@headingDE@examiner}{}{Prüfer/Prüferin}
\NewDocumentCommand{\htblagkr@abstract@headingEN@examiner}{}{Examiner}
\NewDocumentCommand{\htblagkr@abstract@headingDE@headofdepartment}{}{Direktor/Direktorin}
\NewDocumentCommand{\htblagkr@abstract@headingEN@headofdepartment}{}{Head of College/Department}

\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{tabularx}

\NewDocumentCommand{\createcustomabstractcommand}{m}{
    \expandafter\NewDocumentCommand\csname #1\endcsname{ m m }{
        \expandafter\NewDocumentCommand\csname #1DE\endcsname{}{##1}
        \expandafter\NewDocumentCommand\csname #1EN\endcsname{}{##2}
    }
}

\NewDocumentCommand{\begincustomabstract}{}{
    \createcustomabstractcommand{customtitle}
    \createcustomabstractcommand{task}
    \createcustomabstractcommand{implementation}
    \createcustomabstractcommand{results}
    \createcustomabstractcommand{overviewpicture}
    \createcustomabstractcommand{awardparticipation}
    \createcustomabstractcommand{accessibility}
}

\NewDocumentCommand{\customabstractheader}{m}{
    \begin{tabularx}{\textwidth}{|p{4cm}|X p{6.5cm}|}
        \hline

        \multirow{2}{4cm}{\includegraphics[width=4cm]{gkr-logo}} &               & \vspace{1mm} \fontsize{14pt}{8pt}\selectfont \textbf{HTBLA Grieskirchen} \newline \\

        \cline{2-3}

        & \csname htblagkr@abstract@heading#1@discipline\endcsname: & \textbf{\the\discipline}\newline                                                  \\

        \hline
    \end{tabularx}
}

\NewDocumentCommand{\customabstractmiddlecell}{m m}{
    \parbox[c][#1][c]{9cm}{#2}
}
\NewDocumentCommand{\customabstractsimpletable}{m m m}{
    \begin{tabularx}{\textwidth}{|p{5cm}|X|}
        \hline
        \textbf{#1} & \customabstractmiddlecell{#3}{#2} \\
        \hline
    \end{tabularx}% this comment is important, otherwise spacing is inconsistent
}

\NewDocumentCommand{\customabstractpage}{m}{
    \clearpage
    \singlespacing

    \clearpairofpagestyles
    \chead{\customabstractheader{#1}}
    \KOMAoptions{headsepline=0pt, footsepline=0pt}

    \begin{center}
        \fontsize{18pt}{18pt}\selectfont \textbf{\csname htblagkr@abstract@heading#1@thesis\endcsname} \\
        \fontsize{14pt}{14pt}\selectfont \textbf{\csname htblagkr@abstract@heading#1@documentation\endcsname}
    \end{center}

    \begin{tabularx}{\textwidth}{|m{5cm}|X|}
        \hline
        \textbf{\csname htblagkr@abstract@heading#1@author\endcsname} & \customabstractmiddlecell{15mm}{\abstractauthors}    \\
        \hline
        \textbf{\csname htblagkr@abstract@heading#1@schoolyear\endcsname}        & \customabstractmiddlecell{10mm}{\the\schoolyear}     \\
        \hline
        \textbf{\csname htblagkr@abstract@heading#1@topic\endcsname}             & \customabstractmiddlecell{15mm}{\csname customtitle#1\endcsname}             \\
        \hline
        \textbf{\csname htblagkr@abstract@heading#1@partnercompany\endcsname}                & \customabstractmiddlecell{20mm}{\the\partnercompany} \\
        \hline
    \end{tabularx}

    \customabstractsimpletable{\csname htblagkr@abstract@heading#1@task\endcsname}{\csname task#1\endcsname}{4.5cm}

    \customabstractsimpletable{\csname htblagkr@abstract@heading#1@implementation\endcsname}{\csname implementation#1\endcsname}{4.5cm}

    \customabstractsimpletable{\csname htblagkr@abstract@heading#1@results\endcsname}{\csname results#1\endcsname}{5.5cm}

    \clearpage

    \customabstractsimpletable{\csname htblagkr@abstract@heading#1@overviewpicture\endcsname}{\csname overviewpicture#1\endcsname}{16.5cm}

    \customabstractsimpletable{\csname htblagkr@abstract@heading#1@awardparticipation\endcsname}{\csname awardparticipation#1\endcsname}{2cm}

    \customabstractsimpletable{\csname htblagkr@abstract@heading#1@accessibility\endcsname}{\csname accessibility#1\endcsname}{2cm}

    \begin{tabularx}{\textwidth}{|p{5cm}|X|X|}
        \hline
        \textbf{\csname htblagkr@abstract@heading#1@approval\endcsname \newline (\csname htblagkr@abstract@heading#1@datesignature\endcsname)} & \scriptsize \csname htblagkr@abstract@heading#1@examiner\endcsname \vspace{1cm} & \scriptsize \csname htblagkr@abstract@heading#1@headofdepartment\endcsname \vspace{1cm} \\
        \hline
    \end{tabularx}

    \clearpage
}

\NewDocumentCommand{\endcustomabstract}{}{
    \customabstractpage{DE}
    \customabstractpage{EN}
}

\RenewDocumentEnvironment{abstract}{}{\begincustomabstract}{\endcustomabstract}

% =================
% TABLE OF CONTENTS
% =================

% TODO: align toc heading to the right

% toc on own page
\g@addto@macro\tableofcontents{\clearpage}

% make toc clickable
\RequirePackage[hidelinks]{hyperref}

% options from scrguide.pdf page 75
\KOMAoptions{toc=bibliography, toc=listof, sectionentrydots=true}

% see scrguide.pdf page 415 table 15.1
\RequirePackage{tocbasic}
\DeclareTOCStyleEntry[
    entryformat=\normalfont\bfseries\fontsize{13pt}{13pt}\selectfont,
    numsep=2em, % doesn't work???
    dynnumwidth=false
]{tocline}{section}
\DeclareTOCStyleEntry[
    entryformat=\normalfont\fontsize{11pt}{11pt}\selectfont,
    numsep=2em,
    dynnumwidth=false
]{tocline}{subsection}
\DeclareTOCStyleEntry[
    entryformat=\normalfont\fontsize{10pt}{10pt}\selectfont,
    numsep=2em,
    dynnumwidth=false
]{tocline}{subsubsection}

\renewcommand\@dotsep{0.5}

% =======
% FIGURES
% =======
% see scrguide.pdf chapter 3.20 page 135

% use abbreviated prefixes
\KOMAoptions{listof=entryprefix}
\renewcaptionname{ngerman}{\figurename}{Abb.}
% only exists if loaded outside (e.g. when using LyX and defining naustrian language) so ignore if language is not loaded
\defcaptionname{naustrian}{\figurename}{Abb.}

% center all figures
\g@addto@macro\@floatboxreset\centering

% ========
% GLOSSARY
% ========
\RequirePackage[abbreviations, nogroupskip, nonumberlist, automake=immediate]{glossaries-extra}
\setabbreviationstyle{short-long}
\renewcommand{\abbreviationsname}{Abkürzungen}

\makeglossaries

% run makeglossaries-lite after the glossary is created
% process running code stolen from https://www.overleaf.com/learn/latex/Articles/Using_LuaTeX_to_run_tools_and_utilities_installed_on_Overleaf%E2%80%99s_servers
\RequirePackage{luacode}
\directlua{
    function runcommand(cmd)
        texio.write_nl("Running command: " .. cmd)
        local return_code = os.execute(cmd)

        if return_code == nil then
            texio.write_nl("!!! COMMAND EXECUTION NOT ENABLED IN LUATEX !!!")
            texio.write_nl("!!! COMMAND EXECUTION NOT ENABLED IN LUATEX !!!")
            texio.write_nl("Please pass the --shell-escape parameter to luatex!")
            texio.write_nl("!!! COMMAND EXECUTION NOT ENABLED IN LUATEX !!!")
            texio.write_nl("!!! COMMAND EXECUTION NOT ENABLED IN LUATEX !!!")
        end

        texio.write_nl("Command finished with return code " .. return_code)
    end

    local filename = "\jobname"

    function makeglossaries()
% Used for debugging
%        texio.write_nl("Content of " .. filename .. ".acn:")
%        local acn = assert(io.open(filename .. ".acn","r"))
%        local acn_content = assert(acn:read("*a"))
%        acn:close()
%        texio.write_nl(acn_content)

        runcommand("makeglossaries-lite " .. filename)
    end

    id,error=luatexbase.add_to_callback("finish_pdffile", makeglossaries, "makeglossaries")
    if error then
        texio.write_nl("Error adding callback: " .. error)
    end
}

% make second argument of \newabbreviation optional
\NewDocumentCommand{\newabbreviationshort}{O{}mm}{
    \ifthenelse{\equal{#1}{}}
    {\newabbreviation{#2}{#2}{#3}}
    {\newabbreviation{#1}{#2}{#3}}
}

% make \newglossaryentry more LyX-friendly
\NewDocumentCommand{\newglossaryentryshort}{O{}mm}{
    \ifthenelse{\equal{#1}{}}
    {\newglossaryentry{#2}{name={#2},description={#3}}}
    {\newglossaryentry{#1}{name={#2},description={#3}}}
}

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

% forces the font to really be Calibri instead of Latin Modern
\addtokomafont{section}{\rmfamily\bfseries\fontsize{16pt}{18pt}\selectfont}
\addtokomafont{subsection}{\rmfamily\bfseries\fontsize{14pt}{18pt}\selectfont}
\addtokomafont{subsubsection}{\rmfamily\bfseries\fontsize{12pt}{18pt}\selectfont}
\addtokomafont{paragraph}{\rmfamily\bfseries\fontsize{11pt}{12pt}\selectfont}

% begin new page for each section
% https://tex.stackexchange.com/a/606812/229138
\AddToHook{cmd/section/before}{\clearpage}

\RequirePackage{regexpatch}

% not sure what this does anymore
\At@startsection{\addtolength{\@tempskipa}{-\parskip}}
\xpatchcmd{\@xsect}{\vskip\@tempskipa}{\vskip\dimexpr\@tempskipa-\parskip\relax}{}{}

% switch page numbering on use of first numbered heading
% command to patch taken from https://tex.stackexchange.com/a/235968/229138
\xapptocmd{\@sect}{
    % enable page numbering if invoked the first time
    \ifthenelse{\equal{\@ispagenumberactive}{false}}
    {
        \renewcommand{\@ispagenumberactive}{true}
        \pagenumbering{arabic}
    }
    {} % endif
}
{} % ignore patch success
{
    \ClassWarning{htblagkr}{Patching of section command failed}
}

% ==========
% CODEBLOCKS
% ==========

\setminted{
    autogobble,
    breaklines,
    linenos,
    tabsize=4,
    fontsize=\footnotesize,
    breakbefore={.},
    breakafter={\_);, \{&},
    python3=true % highlight as if it is python3 instead of python2, python2 shouldn't be used anymore anyways
}

\NewDocumentCommand{\remapmintedlanguage}{mm}{
    \makeatletter
    \xpatchcmd{\minted@configlang}{\def \minted@lang {##1}}{\ifthenelse{\equal{##1}{#1}}{\def \minted@lang {#2}}{\def \minted@lang {##1}}}
    {} % ignore patch success
    {
        \ClassError{htblagkr}{Patching of minted@configlang failed. Cannot remap language}{This is an internal error.}
    }
    \makeatother
}

% prevent red boxes created by syntax errors
% can't test this right now however because I couldn't actually produce a syntax error
% https://tex.stackexchange.com/a/343506/229138
\AtBeginEnvironment{minted}{\renewcommand{\fcolorbox}[4][]{#4}}
