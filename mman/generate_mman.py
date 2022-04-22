#!/usr/bin/python3
from datetime import datetime
from datetime import date
import sys

TEMPLATE = '''
.\\" Manpage for {topic}
.\\" Contact {author} to correct errors or typos.
.TH {topic} 1 "{date}" "0.1" "{topic} man page"
.SH NAME
.B {topic}
\\- Commentary for collection of
.SS SYNOPSIS
\\fB \\fR

.TP
 DESCRIPTION

.SS SEE ALSO


.SH NAME
.B
\\-
.SS SYNOPSIS
\\fB \\fR
.TP
.\\fB \\fR
.TP
\\fB \\fR
.TP
.B
[\\fI\\, $1, $2 \\/\\fR]
.TP
.SS DESCRIPTION

.SS SEE ALSO



.SH AUTHOR
{author}
.SH BUGS
I'm the bug.
.SH SEE ALSO

.PP
.br
<{url}>
.br
'''

if len(sys.argv) > 1:
    DATA = {
            "topic": sys.argv[1],
            "author": "Adrián Bíro",
            "date": date.today().strftime("%d %B %Y"),
            "url": "https://github.com/adrianbiro/.files"
            }

    complete = TEMPLATE.format(**DATA)
    file_name = f"{DATA['topic']}.groff"
    with open(file_name, 'w') as f:
        f.write(complete)
else:
    print(f'Run with name for man page as argument:\n\t{sys.argv[0]} man_page_name')


