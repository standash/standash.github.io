%% Copyright (C) 2018 Achim D. Brucker, https://www.brucker.ch
%%
%% License:
%%   This program can be redistributed and/or modified under the terms
%%   of the LaTeX Project Public License Distributed from CTAN
%%   archives in directory macros/latex/base/lppl.txt; either
%%   version 1 of the License, or any later version.
%%   OR
%%   The 2-clause BSD-style license.
%%
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{custom-style}%
  []

\PassOptionsToClass{\CurrentOption}{scrartcl}
\LoadClass[areasetadvanced,abstractoff,parskip=never,11pt,a4paper]{scrartcl}[]

\RequirePackage{ifthen}
\newboolean{ep@showinfo}
\setboolean{ep@showinfo}{true}
\DeclareOption{hideinfo}{\setboolean{ep@showinfo}{false}}

\ProcessOptions\relax
\usepackage{setspace}
\RequirePackage[T1]{fontenc}
\RequirePackage[scaled]{helvet}
\renewcommand*{\familydefault}{\sfdefault}
\RequirePackage{sfmath}
\RequirePackage{fontawesome}

\areaset
  {\dimexpr\the\paperwidth-4cm\relax}% calculate required \textwidth
  {\dimexpr\the\paperheight-4cm\relax}% calculate required \textheight
\addtolength{\topmargin}{15pt}
\addtolength{\footskip}{-15pt}

\RequirePackage{lastpage}
\RequirePackage{scrlayer-scrpage}
\RequirePackage{keycommand}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{todonotes}
\RequirePackage{booktabs}
\RequirePackage{multicol}
\RequirePackage{custom-style}

\RequirePackage[%
  doi=false%
  ,isbn=false%
  ,url=false%
  ,style=trad-abbrv%
  ,maxnames=3%
  ]{biblatex}%
\renewbibmacro*{byeditor+others}{%
  \setunit{\addcomma\space}%
  \ifnameundef{editor}
    {}
    {\usebibmacro{byeditor+othersstrg}%
     \setunit{\addspace}%
     \printnames[byeditor][1-1]{editor}%
     \clearname{editor}%
     \newunit}%
  \usebibmacro{byeditorx}%
  \usebibmacro{bytranslator+others}}

%\DefineBibliographyStrings{english}{
%  byeditor = {ed\adddotspace by},
%}

\RequirePackage[alwaysadjust]{paralist}
\RequirePackage{etoolbox}
\RequirePackage{hyperref}


\RedeclareSectionCommand[%
  style=section,%
  level=4,%
  indent=\z@,%
  beforeskip=0.50ex \@plus1ex \@minus.2ex,%
  afterskip=-0.2em,%
  tocstyle=subsection,%
  tocindent=7.0em,%
  tocnumwidth=4.1em%
]{paragraph}

\subject{\project}%
% Default header
\rohead[]{\ep@type}
\lohead{\ep@project}
% Default footer 
\cfoot[]{}
\ofoot[Page \thepage\ of \pageref{LastPage}]{Page \thepage\ of \pageref{LastPage}}
%
\pagestyle{scrheadings}

\newcommand{\alertstyle}{\bfseries\color{Maroon}}
\newcommand{\alert}[1]{{\alertstyle #1}}

\renewcommand{\maketitle}{%
  \centerline{\Large\ep@project}%
  \bigskip
  \centerline{\huge\bfseries \ep@type}%
  \medskip
  \thispagestyle{plain}
}

% Bibliography
\newcommand{\urlprefix}{}%

%%% twocolumn bibliography using Koma-Hooks (works only if no packages such 
%%% as biblatex or natbib are used that redefine thebibliography.
% \renewcommand{\bibfont}{\footnotesize} % or any other  appropriate font command
% \renewcommand*{\bib@beginhook}{\begin{multicols}{2}\footnotesize}%
% \renewcommand*{\bib@endhook}{\end{multicols}}%
%%%
%%% twocolumn bibliography using natbib 
% \setlength{\bibsep}{1pt} % or use whatever dimension you want
% \patchcmd{\thebibliography}
%   {\list}
%   {\begin{multicols}{2}\footnotesize\list}
%   {}
%   {}
% \appto{\endthebibliography}{\end{multicols}}

%% Setup for biblatex/biber
\newcommand{\applicantbibstyle}{\alertstyle}
\newcommand{\applicantbibstyledesc}{bold and maroon}

\newcommand{\applicantbibmark}{\faHome} \newcommand{\bibpretext}{The
  list of references contains works of the applicants as well as
  related works. The works co-authored by at least one of the
  applicants are marked with the symbol \applicantbibmark{} and
  printed in {\applicantbibstyle\applicantbibstyledesc}.}

\DeclareBibliographyCategory{applicant}
\AtEveryBibitem{%
  \ifcategory{applicant}%
  {\applicantbibstyle\applicantbibmark~}%
  {}%
}

%\renewcommand*{\bibfont}{\scriptsize}
\newcommand\twocolprintbibliography[1][0pt]{%
  \begingroup%
    \setlength{\multicolsep}{#1}%
    \setlength{\columnsep}{6pt}%
    \setstretch{0.85}%
    \setlength\bibitemsep{0pt}
    \setlength\bibnamesep{0pt}
    \setlength\bibinitsep{0pt}
    \setlength\biblabelsep{2pt}
    \begin{multicols}{2}[{\printbibheading\vspace{-.7\baselineskip}\noindent\bibpretext\\\vspace{-0.7\baselineskip}}]%
      \printbibliography[heading=none]%
    \end{multicols}%
   \endgroup}

\newcommand\singlecolprintbibliography{%
  \begingroup%
    \setstretch{0.85}%
    \setlength\bibitemsep{0pt}
    \setlength\bibnamesep{0pt}
    \setlength\bibinitsep{0pt}
    \setlength\biblabelsep{3pt}
    \printbibheading\noindent\bibpretext\\%
    \printbibliography[heading=none]%
  \endgroup%
}
% Info
\newcommand{\info}[2][]{%
\ifthenelse{\boolean{ep@showinfo}}%
  {\todo[color=green!20,inline,caption={},#1]{\footnotesize #2}}%
  {}
}


\newcommand{\citeapplicant}[1]{\cite{#1}\addtocategory{applicant}{#1}}

\addtokomafont{paragraph}{\itshape}
\renewenvironment{abstract}{\begin{addmargin}[6mm]{6mm}\itshape\textbf{\abstractname.}}{\end{addmargin}}
\endinput
