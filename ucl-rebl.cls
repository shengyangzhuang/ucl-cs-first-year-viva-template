\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ucl-rebl}

% -------------------------------------------------
% Base class + options
% -------------------------------------------------
\RequirePackage{xifthen}
\newboolean{nonumbering}
\newboolean{address}
\newboolean{copyright}
\newboolean{confidential}
\newboolean{linenumbers}

\setboolean{confidential}{false} % default
\setboolean{linenumbers}{false} % default is off

\DeclareOption{nonumbering}{\setboolean{nonumbering}{true}}
\DeclareOption{address}{\setboolean{address}{true}}
\DeclareOption{copyright}{\setboolean{copyright}{true}}
\DeclareOption{confidential}{\setboolean{confidential}{true}}
\DeclareOption{linenumbers}{\setboolean{linenumbers}{true}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions
\LoadClass{extarticle}
% -------------------------------------------------
% Page layout
% -------------------------------------------------
\RequirePackage[
  left=2.2cm,
  right=2.2cm,
  top=3cm,
  bottom=3cm,
  headheight=40pt,
  headsep=20pt,
  a4paper
]{geometry}
\setlength{\columnsep}{15pt} % Distance between the two columns of text
%\setlength{\parindent}{0pt}
\setlength{\parskip}{0.5\baselineskip}

\RequirePackage{graphicx}
\RequirePackage{wrapfig}
\RequirePackage{float}
\RequirePackage{svg}

\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup{skip=10pt, font=small}
\captionsetup[figure]{labelfont=bf}

\RequirePackage{enumerate}
\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}

\RequirePackage[explicit]{titlesec}
\RequirePackage{bibentry}
\RequirePackage{mdframed}
\RequirePackage{needspace}
\RequirePackage{soul}
\RequirePackage{kvoptions}
\RequirePackage[english]{babel}
\RequirePackage{enumitem}

% Tables
\RequirePackage{booktabs}    % \toprule \midrule \bottomrule
\RequirePackage{tabularx}    % X column
\RequirePackage{array}       % >{\...} column modifiers
\RequirePackage{arydshln}    % \hdashline
\RequirePackage{colortbl}    % \arrayrulecolor

% ORCID (icon + hover tooltip)
\RequirePackage{orcidlink}

% Line numbering for reviewer
\RequirePackage{lineno}

% Figure drawing
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta, positioning}

% Colors + links
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{hyperref}
\hypersetup{
  colorlinks = true,
  linkcolor  = MidnightBlue,
  urlcolor   = MidnightBlue,
  citecolor  = MidnightBlue,
  unicode    = true
}

% Header / footer
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

% Author formatting (authblk)
\RequirePackage{authblk}
\setcounter{Maxaffil}{0}               % no superscript numbers by default
\setlength{\affilsep}{0.2em}           % space between author and affiliation blocks
\renewcommand\Authfont{\normalfont\bfseries\fontsize{9}{13}\selectfont}
\renewcommand\Affilfont{\normalfont\fontsize{8}{10}\selectfont}
\makeatletter
\renewcommand\AB@affilsepx{\protect\\ \protect\Affilfont}
\makeatother
\renewcommand\Authands{ and }

% Confidential text
\newcommand{\internalonly}{\hl{Confidential---Do not share or forward externally}}


% -------------------------------------------------
% Bibliography using bibtex
% -------------------------------------------------
\addto{\captionsenglish}{\renewcommand{\refname}{References}}
\newcommand{\citeas}[1]{\Needspace*{8\baselineskip}\noindent\bibentry{#1}}
% Uncomment the next line if you want the numbered refs to be "1." instead of "[1]".
%\makeatletter \renewcommand\@biblabel[1]{#1.} \makeatother

% -------------------------------------------------
% Custom font styles (title, header, footer)
% -------------------------------------------------
\newcommand{\titlefont}{\color{black}\normalfont\bfseries\fontsize{21}{23}\selectfont}
\newcommand{\headerfont}{\normalfont\sffamily\fontsize{8}{10}\selectfont}
\newcommand{\footerfont}{\normalfont\fontsize{8}{10}\selectfont}

% -------------------------------------------------
% Keywords
% -------------------------------------------------
\newcommand{\keywordstitlefont}{\bfseries\fontsize{8}{10}\selectfont}
\newcommand{\keywordsfont}{\itshape\fontsize{10}{12}\selectfont}
\newcommand{\keywords}[1]{%
  \par\vspace{0.75\baselineskip}%
  {\keywordstitlefont Keywords: }{\keywordsfont #1}\par
}
% -------------------------------------------------
% Subjects
% -------------------------------------------------
\newcommand{\subjectstitlefont}{\bfseries\fontsize{8}{10}\selectfont}
\newcommand{\subjectsfont}{\itshape\fontsize{10}{12}\selectfont}
\newcommand{\subjects}[1]{%
  \par\vspace{0.75\baselineskip}%
  {\subjectstitlefont Subjects: }{\subjectsfont #1}\par
}

% -------------------------------------------------
% Metadata: logo, corresponding author, date
% -------------------------------------------------
\makeatletter

% Logo file (user: \uselogo{path/to/logo.pdf or .png})
\newcommand{\uselogo}[1]{\gdef\@uselogo{#1}}
\newcommand{\@uselogo}{}   % default: no logo

% Corresponding author (user: \setcorresponding{...})
\newcommand{\setcorresponding}[1]{\gdef\@corresponding{#1}}
\newcommand{\@corresponding}{}  % default: none

% Copyright
\newcommand{\setcopyright}[1]{\gdef\@copyrighttext{#1}}
\newcommand{\@copyrighttext}{} % default empty

% Date in header (user can \renewcommand{\paperdate}{<custom>})
\newcommand{\paperdate}{\today}

% Institutional logos under affiliations
\newcommand{\instlogos}[1]{\gdef\@instlogos{#1}}
\newcommand{\@instlogos}{} % default: empty


% -------------------------------------------------
% Custom \maketitle
%   - Title centered, bold, large
%   - Authors + affiliations centered
% -------------------------------------------------
\renewcommand{\maketitle}{%
  \bgroup\setlength{\parindent}{0pt}%
  \begin{center}
    {\Large \bfseries \@title\par}%
    \vskip11pt
    {\normalsize \@author\par}%
    \vskip15pt% 
    \ifx\@instlogos\@empty
    \else
      {\@instlogos\par}
      \vskip20pt
    \fi
  \end{center}
  \egroup
  %
  \hypersetup{
    pdftitle  = {\@title},
    pdfauthor = {\@author}
  }%
  \thispagestyle{uclreblfirst}%
}
\makeatother

\makeatletter
% -------------------------------------------------
% Fancy page styles: with logo and grey lines
% -------------------------------------------------
\pagestyle{fancy}

% First page style (logo + date + corresponding author)
\fancypagestyle{uclreblfirst}{%
  \fancyhf{}%
  % Header: logo left, date right
  \fancyhead[L]{%
    \ifx\@uselogo\@empty
      % no logo
    \else
      \@uselogo
    \fi
  }%  
  \fancyhead[R]{%
    \headerfont\itshape \paperdate
    \ifthenelse{\boolean{confidential}}{\\ \footerfont \internalonly}{}%
  }%
  % Footer: corresponding author left, page number right
  \fancyfoot[L]{%
    \footerfont
    \ifx\@corresponding\@empty
      % no corresponding author
    \else
      \itshape Corresponding author: \@corresponding\\
    \fi
    \ifx\@copyrighttext\@empty
      % no copyright line
    \else
      \normalfont \@copyrighttext
    \fi
}
  \fancyfoot[R]{%
    \footerfont Page \thepage\ of \pageref{LastPage}
  }%
}

% Subsequent pages (logo in header, page number in footer)
\fancypagestyle{uclrebl}{%
  \fancyhf{}%
  \fancyhead[L]{%
    \ifx\@uselogo\@empty
    \else
      \@uselogo
    \fi
  }%
  \fancyhead[R]{}%
  \fancyfoot[L]{%
    \ifthenelse{\boolean{confidential}}{\footerfont \internalonly}{\footerfont\bfseries\relax}%
}
  \fancyfoot[R]{%
    \footerfont Page \thepage\ of \pageref{LastPage}
  }%
}

% Use uclrebl for all non-first pages
\pagestyle{uclrebl}

% -------------------------------------------------
% Colored header/footer rules (grey), done ONCE to avoid recursion
% -------------------------------------------------
\makeatletter
\renewcommand{\headrulewidth}{1pt}
\renewcommand{\footrulewidth}{1pt}
\let\OldHeadRule\headrule
\let\OldFootRule\footrule
\renewcommand{\headrule}{\color{gray}\OldHeadRule}
\renewcommand{\footrule}{\color{gray}\OldFootRule}
\makeatother

% Number pages in arabic
\pagenumbering{arabic}

\makeatother

% -------------------------------------------------
% Table settings
% -------------------------------------------------
% Vertically centered column types
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}m{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}m{#1}}

% Vertically centered X column for tabularx
\newcolumntype{Y}{>{\raggedright\arraybackslash}m{\linewidth}}


% --- style knobs (tune to taste) ---
\renewcommand{\arraystretch}{1.15}
\setlength{\tabcolsep}{6pt}

% dashed line appearance (arydshln)
\setlength{\dashlinedash}{0.6pt}
\setlength{\dashlinegap}{1.6pt}
\setlength{\arrayrulewidth}{0.35pt} % thickness of dashed rule
\arrayrulecolor{gray!55}            % light dashed rules

% -------------------------------------------------
% Line numbering for reviewer
% -------------------------------------------------
\ifthenelse{\boolean{linenumbers}}{
  \AtBeginDocument{\linenumbers}
}{
  % Otherwise, do nothing
}

% Optional: Customize the look of the line numbers
\renewcommand\linenumberfont{\normalfont\tiny\sffamily\color{gray}}


% =====================================================================
%  Appendix A: Detailed Project Schedule
%  -------------------------------------------------------------------
%  PREAMBLE REQUIREMENTS (add to the main preamble, after \usepackage{pdfpages}):
%
%    \usepackage{pgfgantt}     % Gantt chart (loads TikZ)
%    \usepackage{pdflscape}    % rotated landscape page (use lscape if not pdfTeX)
%    \usepackage{adjustbox}    % scales the chart to fit whatever geometry the class uses
%
%    \definecolor{cfound}{HTML}{3F6FB5}  % Year 1 / foundations       (blue)
%    \definecolor{ctail} {HTML}{C2662B}  % Ch.5 CheetahTailLab        (orange)
%    \definecolor{ctrans}{HTML}{2E8B74}  % Ch.6 cross-embodiment      (teal)
%    \definecolor{cwrite}{HTML}{6D5C9E}  % thesis, training, outputs  (purple)
%    \definecolor{cmile} {HTML}{B03A48}  % UCL progress reviews       (red)
%
%  TIME AXIS: 48 monthly slots, 1 = Oct 2025 ... 48 = Sep 2029.
%    Q1 = Oct-Dec, Q2 = Jan-Mar, Q3 = Apr-Jun, Q4 = Jul-Sep.
%  To shift the programme, change only the four \gantttitle year labels and
%  the month indices; index = (year-2025)*12 + (month-9) for Oct 2025 = 1.
% =====================================================================