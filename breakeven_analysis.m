%{
Problem Statement: We have been asked by the zoo perform a breakeven analysis 
on construction methods, different materials, and determine the expected return 
on investment. We have to consider operational costs (variable costs),construction costs
(fixed costs), and the revenue. Revenue will change based on the response
of the people towards the zoo. 

Variables:
BET: Break even time 
c_cost: construction costs (Needed to build the new enclosure)
choice: variable name for menu for selecting options between three
construction materials
donations: expected donations to the zoo per week
E_cost: Energy cost
F_C: Fixed cost
L_cost: Labor cost
LF_cost: Landfill Cost
M_cost: Maintainence Cost
O_T_D: One time donation to breakeven in seven months
Profit: Profit for the years specified
Revenue: Revenue for the years specified
Revenue_per_year: Revenue per year
RV: Revenue per week
SA: Surface area
t: Years vector
T_C: Total costs
ticket_price: price of a ticket
V_C: Variable costs
VC_PW: variable costs per week
visitors: number of visitors at the zoo per week
WPY: Weeks per year
years: number of years to include in the analysis
BEP= Amount of Revenue and cost at break-even point [$]
%}

close all; clear; clc

%Materials and construction cost cell array
c_cost = {'Concrete', 16, 30, 96000, 900, 5, 5; 'Wood', 23, 53, 115000, 800, 12, 11; 'Adobe', 18, 42, 68000, 600, 6, 5};

%Defining menu 
choice = menu('Select a material', c_cost{:,1});

%Surface Area
SA = 3000;

%Calculating fixed cost
F_C = (c_cost{choice, 2}/12 * SA * c_cost{choice, 3}) + c_cost{choice, 4} + (c_cost{choice, 5} * c_cost{choice, 6} * c_cost{choice, 7});

%Variable cost input
E_cost = input('Enter energy cost [$/week]: ');
L_cost = input('Enter labour cost [$/week]: ');
M_cost = input('Enter maintenance cost [$/week]: ');
LF_cost = input('Enter landfill cost [$/week]: ');
WPY = input('How many weeks per year will the zoo operate: ');
years = input('How many years should the analysis include: ');

%Revenue input
ticket_price = input('Enter price of admission per person [$/person] : ');
visitors = input('Enter the number of people that will visit per week: ');
donations = input('Enter expected donations to the zoo per week [$/week]: ');

%Calculating variable costs per week
VC_PW = E_cost + L_cost + M_cost + LF_cost;

%Calculating variable costs per year
V_C = VC_PW * WPY;

%Creating a vector for number of years from opening day
t = 0:years;

%Calculating total cost vector for user input years 
T_C = V_C * t + F_C;

%Calculating Revenue per week
RV = (ticket_price * visitors) + donations;

%Calculating Revenue per year
Revenue_per_year = RV * WPY;

%Creating Revenue vector for user-inputted years
Revenue = Revenue_per_year * t;

%Calculating Profit vector for user inputted years
Profit = Revenue -  T_C;

%Breakeven Time in months
BET = F_C * 12/(Revenue_per_year - V_C);

%One time donation required to breakeven in seven months 
O_T_D = F_C+ (V_C - Revenue_per_year)*7/12;

%Calculating Price at break-even point
BEP=Revenue_per_year * BET/12;

fprintf('\n\nMaterial: %s\n\n', c_cost{choice,1})
fprintf('\tOperating %.0f weeks per year will generate per year:\n', WPY)
fprintf('\t\tRevenue:\t $%.0f\n\t\tCost:\t $%.0f\n', Revenue_per_year, V_C)
fprintf('\tThe break-even time is %.2f months\n', BET)
fprintf('\tThe total profit after %.0f years is $%.3E\n\n', years, Profit(length(Profit)))
fprintf('It will take a one-time donation of $%.2f to breakeven in seven months\n', O_T_D)

%Proper plot
figure('color', 'w')
plot(t, Revenue,'b-', t, T_C, 'r-')
hold on
plot(BET/12, BEP, 'ko', 'markerfacecolor','k')
grid on
legend('Revenue','Cost','Break-even point','Location','NW')
xlabel('Time after opening day (t) [years]')
ylabel('Amount (M) [$]')
title('Break-even analysis for new fencing material')

%Second plot
figure('color', 'w')
plot(t, Profit, 'g-', BET/12, 0, 'bo', 'markerfacecolor','b')
xlabel('Time after opening day (t) [years]')
ylabel('Amount (M) [$]')
title('Profit gained from using new fence with time')
legend('Profit','Break-even point','Location','NW')
grid on
