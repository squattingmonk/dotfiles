" adjust syntax highlighting for LaTeX parts
" inline formulas:
syntax region Statement oneline matchgroup=Delimiter start="\$" end="\$"

" environments:
syntax region Statement matchgroup=Delimiter start="\\begin{.*}" end="\\end{.*}" contains=Statement

" commands:
syntax region Statement matchgroup=Delimiter start="{" end="}" contains=Statement
