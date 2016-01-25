function drawArrow(x,y,varargin)

coder.extrinsic('quiver')

quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0,varargin{:} )


end

