{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,R+,S+,V+,X-}
{$M 16384,0,655360}
program eratostene;
var
i,n,t,m,nmax:longint;
a: array [0..30000] of integer;
begin
nmax:=30000;
for i:=1 to nmax do
a[i]:=i;
i:=2;
n:=2;
 while i< nmax do
 begin
  while n < nmax do
  begin
  while a[n]=0 do n:=n+1;
   t:=i*a[n];

   if t<= nmax then a[t]:=0
    else n:=nmax;
  n:=n+1
  end;
  n:=2;
i:=i+1;
end;
m:=0;
n:=0;
for i:=2 to nmax do
if a[i]<>0 then
begin
m:=m+1;
if a[i-2]<>0 then
begin
 n:=n+1;
 writeln(a[i-2],'  ',a[i],' numeri amici ',n);
 end;
end;
end.
