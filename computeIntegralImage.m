function [ii] = computeIntegralImage(image)
%i use cumsum since it is more efficient
%cumsum(cumsum()) helps in quickly calculating the integral image
ii = cumsum(cumsum(image,2),1);
end