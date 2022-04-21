#!/usr/bin/python3
import os
import gzip
import shutil

def make_gz():
    """Creates gzip archives and places them in the default location for users' man pages."""
    man_location = "/usr/local/man/man1/"
    os.makedirs(man_location, exist_ok=True)
    man_list = []
    for i in os.listdir():
        if i.endswith(".groff"):
            file_name, file_extension = os.path.splitext(i)
            man_list.append(file_name)
            f_out_name  = os.path.join(man_location, f"{file_name}.1.gz")
            with open(i, 'rb') as f_in:
                with gzip.open(f_out_name, 'wb') as f_out:
                    shutil.copyfileobj(f_in, f_out)
    if len(man_list) > 0:
        print("Man pages generated,try:")
        for i in man_list:
            print(f'\tman {i}')
    else:
        print("No man pages created!")

def main():
    """Check if it is run with elevated privileges."""
    if os.getuid() == 0:
        make_gz()
    else:
        print("Run with sudo!")

if __name__ == "__main__":
    main()



