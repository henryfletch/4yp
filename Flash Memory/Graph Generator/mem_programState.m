function y = mem_programState(x,Vp,deltaVp)

y(Vp < x) = 1/deltaVp;
y(x > (Vp+deltaVp)) = 0;

end