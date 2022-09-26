# CurrencyConverter
This is a very simple app which would show account balances of different currencies which can be converter by the user to another currency via API. Here are some of the constraints and features - 
1. there may be a commission fee for the currency conversion operation. The first five currency conversions are free of charge but afterwards currency conversions are charged 0.7% of the currency being traded. The commission fee should be displayed in the message that appears after the conversion.
2. The application supports only EUR, USD, JPY currencies and initial state should be 1000.00 EUR, 0.00 USD, 0 JPY.
3. There is a possibility of expanding the calculation of a more flexible commission. It is possible to come up with various new rules, for example - every tenth conversion is free, conversion of up to 200 Euros is free of charge etc.

# Architecure
For design pattern, MVVM should be used and also SOLID architecture would be a must as we need to create scope for future requirements. Here is a top level view of the architecture 
![Presentation1](https://user-images.githubusercontent.com/51700181/191883862-c1ae04a2-bbc8-4c97-ac52-9d0745c28970.jpg)

# Solution overview