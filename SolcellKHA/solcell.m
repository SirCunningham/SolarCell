format long
data = load('UtanLjus0.txt');
U = data(:, 2);
I = data(:, 3);
initials = rand(1, 2)
options = optimset('Display', 'iter')
params = fminsearch(@diode, initials, options, U, I);

data2 = load('VaxelIntro0.txt');
T = data2(:, 1);
II = data2(:, 3);
xlabel('Time [ms]')
ylabel('Current [A]')
plot(T, II, '-')
xlabel('Time [ms]')
ylabel('Current [A]')
figure;

plot(U, I)
xlabel('Voltage [V]')
ylabel('Current [A]')

f = @(x) params(1)*(1-exp(-x/params(2)));
hold on
xs = min(U):0.01:max(U);
plot(xs, f(xs), 'r')
legend('measured values', 'fitted curve');

%ideality factor n
e = 1.60217657 * 10^(-19);
Isat = params(1);
Vsat = params(2);
kb = 1.3806488*10^(-23);
T= 300;
n = Vsat*e/(kb*T);
%-----
% colors = cell(11, 1);
% colors{1}='r';
% colors{2}='k';
% colors{3}='b';
% colors{4}='y';
% colors{5}='g';
% colors{6}='c';
% colors{7}='k';
% colors{8}='m';
% colors{9}='r';
% colors{10}='g';
% colors{11}='b';

xss = cell(11,1);
xss{1}='Ljus1250.txt';
xss{2}='Ljus1750.txt';
xss{3}='Ljus2250.txt';
xss{4}='Ljus2750.txt';
xss{5}='Ljus3250.txt';
xss{6}='Ljus3750.txt';
xss{7}='Ljus4250.txt';
xss{8}='Ljus4750.txt';
xss{9}='Ljus5250.txt';
xss{10}='Ljus5750.txt';
xss{11}='Ljus6250.txt';
figure;
hold on
xlabel('Voltage [V]')
ylabel('Power [W]')
maxpowers = [0,0,0,0,0,0,0,0,0,0,0];
colors = hsv(12);
for i=1:11
    data = load(xss{i});
    U1 = data(:, 2);
    U2 = U1(3: 5: end);
    P = data(:, 6);
    P2 = P(3: 5: end);
    maxpowers(i)= max(P2)
    plot(U2, P2, 'color',colors(i,:))
    hold on
end
legend('12.5 cm', '17.5 cm', '22.5 cm', '27.5 cm', '32.5 cm', '37.5 cm', '42.5 cm', '47.5 cm', '52.5 cm', '57.5 cm', '62.5 cm')

figure
hold on
xlabel('Voltage [V]')
ylabel('Current [I]')
for i=1:11
    data = load(xss{i});
    U1 = data(:, 2);
    U2 = U1(3: 5: end);
    I1 = data(:, 4);
    I2 = I1(3: 5: end);
    plot(U2, I2, 'color', colors(i, :))
    hold on
end
legend('12.5 cm', '17.5 cm', '22.5 cm', '27.5 cm', '32.5 cm', '37.5 cm', '42.5 cm', '47.5 cm', '52.5 cm', '57.5 cm', '62.5 cm')
d = [0.125, 0.175, 0.225, 0.275, 0.325, 0.375, 0.425, 0.475, 0.525, 0.575, 0.625];
figure;
params2 = fminsearch(@diodedist, initials, options, d, maxpowers)
g = @(x) params(1)./(x+params(2)).^2;
hold on
xlabel('f(d)/f(0)');
ylabel('P_{max} [W]')
plot(g(d)/g(0), maxpowers, '*r')
p = polyfit(g(d)/g(0), maxpowers, 1)
xs = 0:0.01:0.1;
ys = polyval(p, xs);
plot(xs, ys)
%p_max = k/(r+x0)^2 ; k=1.7601E-06; x0 = 0.049754