# uncompyle6 version 3.9.2
# Python bytecode version base 2.7 (62211)
# Decompiled from: Python 3.10.12 (main, Nov  6 2024, 20:22:13) [GCC 11.4.0]
# Embedded file name: listrip_TABv2.py
# Compiled at: 2017-06-07 18:41:48
infile = open('numbers.txt', 'r+')
data = ''
for line in infile:
    if line.startswith('>'):
        new_line = line.replace('\n', '\t')
        data = data + '\n' + new_line
    else:
        data = data + line.strip()

infile.write(data)
infile.close()

# okay decompiling listrip_TABv2.pyc
