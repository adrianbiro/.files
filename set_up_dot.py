#!/usr/bin/python3
import os

if os.getcwd() == os.path.expanduser("~"):
    print("Run from dot_files directory.")
    exit(1)

vim_targetdir = os.path.join(os.path.expanduser("~"), ".vim")
config_targetdir = os.path.join(os.path.expanduser("~"), ".config")
os.makedirs(vim_targetdir, exist_ok=True)
os.makedirs(config_targetdir, exist_ok=True)

renamed = []

for i in os.listdir():
    if i.startswith((".git", ".gitignore", "README.md", "set_up_dot.py", ".config", "dotvim", "mman")) or i.endswith((".swp", ".json")):
        continue
    src = os.path.abspath(i)
    #if i.startswith("pomoc.md"):
    #    dest = os.path.join(vim_targetdir, i)
    else:
        dest = os.path.join(os.path.expanduser("~"), i)
    if os.path.islink(dest):
        continue
    if os.path.isfile(dest) or os.path.isdir(dest):
        new_name = f'{dest}.bak'
        os.rename(dest, new_name)
        renamed.append(f'{dest} --> {new_name}')
    os.symlink(src, dest)
    print(f'Symlink created\n{src} --> {dest}')

#for i in os.listdir(config_targetdir):
#    dest = os.path.join(config_targetdir, i)
#    dest = config_targetdir
#    if os.path.islink(dest):
#        continue
#    if os.path.isfile(dest) or os.path.isdir(dest):
#        new_name = f'{dest}.bak'
#        os.rename(dest, new_name)
#        renamed.append(f'{dest} --> {new_name}')
#    os.symlink(src, dest)
#    print(f'Symlink created\n{src} --> {dest}')


if len(renamed) > 0:
    print("Backup files:")
    for i in renamed:
        print(i)
