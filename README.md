# UCL Computer Science First-Year PhD Viva Report Template

This repository provides a LaTeX starting point for drafting a first-year PhD
viva or progress-review report. Replace the bracketed metadata and drafting
prompts in `main.tex`, adapt the chapter structure to your project, and remove
unused sections and appendices before submission.

## Contents

- `main.tex` — report structure, title page, prompts, and example planning tables.
- `refs.bib` — empty BibTeX file ready for your references.
- `ucl-rebl.cls` — the local document class used for the page layout and styling.

The chapter headings are a suggested structure, not a prescribed report
format. This is not an official UCL form or guarantee of compliance with current
departmental requirements. Confirm the expected content, length, submission
arrangements, and formatting with your supervisor or the department.

## Build

From this directory, compile with `latexmk`:

```sh
latexmk -pdf main.tex
```

The document uses BibTeX and numeric citations by default. Add entries to
`refs.bib`, then cite them with `\citep{citation-key}` for parenthetical
citations or `\citet{citation-key}` when the author name is part of the
sentence. Re-run the build after adding or changing references.

Put figures and supplementary files in project-relative folders, for example
`figures/` and `appendices/`, and use relative paths in LaTeX. The figure and
PDF-inclusion examples in `main.tex` are commented out until you provide files.

The template is non-confidential by default. Add the `confidential` option to
the document class only if that marking is appropriate:

```tex
\documentclass[confidential]{ucl-rebl}
```

Remove the gray drafting prompts and replace all bracketed placeholders before
circulating or submitting the report.