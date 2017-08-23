A = [17, 24, 1, 8, 15; 23, 5, 7, 14, 16; 4, 6, 13, 20, 22; 10, 12, 16, 21, 3; 11, 18, 25, 2, 9];
h = [8, 1, 6; 3, 5, 7; 4, 9, 2];

%Change the kernel matrix to single array
window = [8,1,6,3,5,7,4,9,2];
rotatewindow = [2,9,4,7,5,3,6,1,8];
b = zeros(1,9);
c = zeros(1,9);
ImConvolution = zeros(5,5);
ImMin = zeros(5,5);
ImMax = zeros(5,5);
Coro = 0;

for i = 1:5
    for j = 1:5
        Coro = 0;
        for k = 1:9
            switch k
                case 1
                    x = i - 1;
                    y = j - 1;
                    if(x <= 0 || y <= 0)
                        b(k) = 0;
                    else
                        b(k) = A(x,y);
                    end
                case 2
                    x = i - 1;
                    if(x <= 0)
                        b(k) = 0;
                    else
                        b(k) = A(x,j);
                    end
                case 3
                    x = i - 1;
                    y = j + 1;
                    if(x <= 0 || y > 5)
                        b(k) = 0;
                    else
                        b(k) = A(x,y);
                    end
                case 4
                    y = j - 1;
                    if(y <= 0)
                        b(k) = 0;
                    else
                        b(k) = A(i,y);
                    end
                case 5
                    b(k) = A(i,j);
                case 6
                    y = j + 1;
                    if(y > 5)
                        b(k) = 0;
                    else
                        b(k) = A(i,y);
                    end
                case 7
                    x = i + 1;
                    y = j - 1;
                    if(x > 5 || y <= 0)
                        b(k) = 0;
                    else
                        b(k) = A(x,y);
                    end
                 case 8
                    x = i + 1;
                    if(x > 5)
                        b(k) = 0;
                    else
                        b(k) = A(x,j);
                    end
                  case 9
                    x = i + 1;
                    y = j + 1;
                    if(x > 5 || y > 5)
                        b(k) = 0;
                    else
                        b(k) = A(x,y);
                    end
                otherwise
            end
            
            c(k) = b(k) * rotatewindow(k);
            b(k) = b(k) * window(k);
            
            
            Coro = Coro + c(k);
            
            
            
        end
        ImMin(i,j) = min(b);
        ImMax(i,j) = max(b);
        ImConvolution(i,j) = Coro;
    end
end