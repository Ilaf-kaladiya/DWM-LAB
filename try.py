l=int(input())
w=int(input())

h=int(input())


if(1<=l,w,h<=1000):
    if(w==l and h==l):
        print("accepted")
    if(w<l or h<l):
        print("change")
    if(w>l or h>l):
        print("crop")

