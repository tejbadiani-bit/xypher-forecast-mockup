#!/usr/bin/env python3
"""src/index.html + data/real.json -> data/index.plain.html (gitignored). encrypt.js then writes the gate to index.html."""
import json,os
H=os.path.dirname(os.path.abspath(__file__))
s=open(os.path.join(H,'src','index.html')).read()
d=json.load(open(os.path.join(H,'data','real.json')))
tp=os.path.join(H,'data','targets.json')
d['targets']=json.load(open(tp)) if os.path.exists(tp) else {}
assert '/*REAL_DATA*/null' in s
s=s.replace('/*REAL_DATA*/null',json.dumps(d,separators=(',',':')).replace('</','<\\/'))
open(os.path.join(H,'data','index.plain.html'),'w').write(s)
print('built data/index.plain.html',round(len(s)/1024),'KB')
