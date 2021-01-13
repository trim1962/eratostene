program primi;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this }
  , costanti, mmx;

var
primo :array[1..maxnum]of longint;
fattori:array[1..maxnum]of longint;
divisori:array[1..maxnum]of longint;
N:longint;
Numero:longint;
i,j:longint;
maxprimi:longint;
t,p,q,o,x,w,g:text;
a0,f0,e0,a1,f1,e1:longint;
sa0,sf0,se0,sa1,sf1,se1,sc0:string;

{$IFDEF WINDOWS}{$R primi.rc}{$ENDIF}

begin
assign(t,'elencofattori.txt');
rewrite(t);
assign(p,'elencoprimi.txt');
rewrite(p);
assign(q,'primiamici.txt');
rewrite(q);
primo[1]:=1;
primo[2]:=2;
primo[3]:=3;
maxprimi:=3;
writeln('fattorizzazione');
  for j:=1 to maxnum do
         fattori[j]:=0;
{scomposizione in fattori}
for n:=4 to maxnum do
begin
writeln('fattorizzazione',' ',n);
     numero:=n;
     i:=2;
      j:=1;
      while j<= maxprimi do
      begin
fattori[j]:=0;
inc(j);
end;
     while (numero  <> 1)  do
     begin
     {$MMX+}
     {if ((numero div primo[i])* primo[i]= numero) then}
     if numero mod primo[i]=0 then
                  begin
                  numero:=numero div primo[i];
                  fattori[i]:=fattori[i]+1;
                  end
               else
               begin
               inc(i);
               end;
               if i>maxprimi then
                  begin
                inc(maxprimi);
                  primo[maxprimi]:=n;
                  numero:=1;
                  end;
     end;
 {$mmx-}
     for j:=2 to i do
      if fattori[j]<>0 then begin write (t,n,' ',primo[j],' ',fattori[j]);
       writeln(t);
       end;

end;
writeln('Stampa divisori 1');
for i:=1 to maxprimi do
writeln(p,primo[i]);
for i:=1 to maxprimi-1 do
if primo[i+1]-primo[i]=2 then writeln(q,primo[i],' ',primo[i+1],' ');
close(p);
close(t);
close(q);
writeln('Stampa divisori 2');
{stampa scomposizioni fattori su una sola linea}
assign(t,'elencofattori.txt');
 reset(t);
 assign(o,'fattori.txt');
 rewrite(o);
 assign(x,'sfattori.txt');
 rewrite(x);
a0:=0;
f0:=0;
e0:=0;
a1:=0;
f1:=0;
e1:=0;
readln(t,a0,e0,f0);
write(o,a0,'  ', e0,'  ',f0);
str(a0,sa0);
str(e0,se0);
str(f0,sf0);
sc0:= '$'+sa0+'='+se0+'^'+'{'+sf0+'}';
write(x,sc0);
while not eof(t) do
begin
readln(t,a1,e1,f1);
str(a1,sa1);
str(e1,se1);
str(f1,sf1);
if a0=a1 then
         begin
          write(o,'  ',e1,' ',f1);
          sc0:=se1+'^'+'{'+sf1+'}';
          write(x,sc0);
          a0:=a1;
          f0:=f1;
          e0:=e1;
          end
          else
          begin
          writeln(o);
          write(x,'$');
          writeln(x);
          sc0:='$'+sa1+'='+se1+'^'+'{'+sf1+'}';
          write(o,a1,'  ',e1,'  ',f1);
          write(x,sc0);
          a0:=a1;
          f0:=f1;
          e0:=e1;
          end;

end;
{write(o,'  ',';');}
close(o);
close(t);
close(x);
assign(w,'radiciarit.txt');
rewrite(w);
assign(g,'amici.txt');
rewrite(g);
writeln('Somma divisori');
for n:=1 to maxnum do
divisori[n]:=1;
{$mmx+}
for n:=2 to maxnum do
begin
    for i:=2 to maxnum do
     begin

          {if n mod i = 0 then}
          if n -(n div i)*i = 0 then
                  begin
                  if i <> n then
                  divisori[n]:=divisori[n]+i;
                  writeln(n,' ',i,' ',divisori[n]);
                  end;
     end;
end;
{$mmx-}
writeln('Somma divisori 2 fase');
writeln('numeri amici');
{$mmx+}
for n:=2 to maxnum do
begin
    for i:=2 to maxnum do
     begin
          if (divisori[n] = i)and (divisori[i]=n)  then
                  begin
                  if (divisori[n]<>0) and (n<>i) then
                  writeln(g,n,' ',i);
                  writeln(n,i);
                  end;
     end;
end;
{$mmx-}
close(g);

for n:=1 to maxnum do
writeln(w,n,' ',divisori[n]);
close(w);
assign(w,'radiciarit.txt');
rewrite(w);
writeln('numeri perfetti');
 for n:=2 to maxnum do
 if divisori[n]=n then
 writeln(w,' ',divisori[n]);
close(w);
end.

