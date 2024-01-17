%ImageOut = rotate(ImageIn, Theta)
%
%Rotates the Image by Theta degrees.

function [Out] =  rotate(In, Theta)

%Work out Width and Height of Source image
width=size(In,1);
height=size(In,2);

%Work out the centre point of the image, since we want to rotate about this point.
cp = [round(size(In,1)/2), round(size(In,2)/2)];

%The forward transformation matrix
tm = [ cos(Theta), -sin(Theta) ;
       sin(Theta), cos(Theta) ]

%Calculate the reverse mapping by matrix inversion
rtm = inv (tm);

for y=1:height
 for x=1:width
  p =[x,y];			%Point on the destination image
  tp = round(rtm*(p-cp)'+cp');	%Calculate nearest corresponding point on the source image
  if tp(1)<1 | tp(2)<1 | tp(1)>width | tp(2)>height
   Out(x,y)=0;			%If we are outside the bounds of the image set to black
  else
   Out(x,y)=In(tp(1),tp(2));	%Else use the source image
  end
 end
end