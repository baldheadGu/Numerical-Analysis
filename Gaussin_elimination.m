%列主元高斯消去法求解线性方程组

clear;clc;

syms n i j k q max %数组维度n，标号i,j,k,q，比大小max
syms S %过渡向量S
syms A b A_bar%系数矩阵A 向量b
syms x %x向量

%初始化数组
A = [0];
b = [0];
S = [0];
x = [0];

% 输入系数矩阵A的数据
A=input('输入系数矩阵A(例如：A=[1,2;3,4])：');

%输入向量b的数据
b=input('输入向量b(例如：b=[1;2;3])：');

%行方向获取数组维度
n=size(A,1);

%选主元，消元过程
max=0.;
for k=1:n-1
    max=A(k,k);
    
    %选主元
    for i=k+1:n
        if abs(A(i,k)) >= abs(max)
            max=A(i,k); 
            q=i;
        else
            q=k;
        end
    end
    
    %主元位置如果不变，则开始消元
    if q == k
        %消元循环
        for i=k+1:n %从第k+1行开始消元
            A(i,k)=A(i,k)/A(k,k); %要消成0的位置上直接存比例因子
            for j=k+1:n %当前这行除了要消成0的，剩下的元素（即从k+2列开始）要做减法
                A(i,j)=A(i,j)-A(i,k)*A(k,j);
            end
            b(i)=b(i)-A(i,k)*b(k); %对列向量b也要做相应减法
           
        end
    else
        %如果主元位置改变，进行以下操作
        %交换方程位置，系数矩阵A和向量b
        for j=k:n
            S(k,j)=A(k,j);%原向量数据存入过渡向量
            A(k,j)=A(q,j);%主元向量数据覆盖原向量
            A(q,j)=S(k,j);%过渡向量覆盖原主元向量
        end
        S(k)=b(k);
        b(k)=b(q);
        b(q)=S(k);
        
        %消元循环
        for i=k+1:n
            A(i,k)=A(i,k)/A(k,k); 
            for j=k+1:n
                A(i,j)=A(i,j)-A(i,k)*A(k,j);
            end
            b(i)=b(i)-A(i,k)*b(k);
        end
     end
    
end

disp("消元后的矩阵：")
A_bar = [A,b];
disp(A_bar);

%回代过程
x(n) = b(n)/A(n,n);
for k=n-1:-1:1
    S(k)=b(k);
    for j=k+1:n
        S(k)=S(k)-A(k,j)*x(j);
    end
    x(k)=S(k)/A(k,k);
end

disp("解:");
disp(x);