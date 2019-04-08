import numpy as np
pageno=int(input("Enter total number of pages"))

links=[]
for i in range(0,pageno):
	L=[]
	for j in range(0,pageno):
		L.append(int(input('Type 1 if there is a link from page '+str(i+1)+' To page '+str(j+1))))
	links.append(L)

outBound=[]
count=0
for i in range(len(links)):
	for j in range(len(links[i])):
		if(links[i][j]==1):
			count+=1
		if(j==len(links[i])-1):
			outBound.append(count)
	count=0

M=np.zeros((pageno,pageno))
for i in range(0,pageno):
	for j in range(0,pageno):
		if(links[j][i]==1):
			M[i][j]=1/outBound[j]

col=np.ones((pageno,1))

r=np.full((pageno,1),1/pageno)

print(r)



