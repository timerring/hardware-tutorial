%plot_rect_function
function [y] = prf(x,duty,n)
%输入为自变量x和占空比duty和周期n
%输出为y，并绘制图像（周期矩形脉冲）
y=(square(2*pi*x/n,duty)+1)/2;
plot(x,y);
ylim([0,2]);
end

