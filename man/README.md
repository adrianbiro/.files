# custom man pages

```bash
gzip mbashrc.1
cp mbashrc.1.gz /usr/local/man/man1/mbashrc.1.gz
```
to see while editing
```bash
groff -Tascii -man mbashrc.groff | less
```
or
```bash
man ./mbashrc.groff
```
