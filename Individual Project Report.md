# Individual Project Report

## Data Preprocessing

First, we use python script to download the history trading data from the Binance Exchange and write the data into 4 .csv files. Then we combine the .csv files according to their frequencies, which is daily and hourly.

We add the date, time and the symbols of the trading, which are "bitcoins" and "eth"

For all signals, we defined a variable `signalside`. We will long the asset when it is > 0 and short otherwise. There is also a variable `signalidx` which is the location where the signal takes changes. This variable helps us to calculate the holding period and the return. `signaldate` and `signaltime` are variables that shows the real world time of the transaction. Daily data doesn't have the variable `signaltime`

`pxenter` is the variable that calculates the real enter price. Because we get the trading signal based on the history, we have to make the deal in the following period. 

`pxexit` is the variable that calculates the real exit price. It is just the next enter price when we need to change our position, so we just need to use `next` on the `pxenter`

## EMA parameters

To determine the dealing process using EMA, we defined a series of moving average prices based on the close price. The moving average represents the price momentum. When short term momentum beats the relatively longer term momentum, we long the asset. Otherwise, we short asset.

So we use $EMA(short-term, long-term)$ to represent this signal, we buy the asset when $EMA >0$, sell otherwise.

We chose 4 periods and 3 variables for EMA signal $EMA(5, 12), EMA(12, 25), EMA(12, 50)$

## MACD parameters

MACD has 3 parameters which include 3 periods. A short-term period and a relatively longer one are used to calculate the $DIF$ series, and the other one is used to calculate the EMA of $DIF$. We long the asset when MACD > 0 and short the asset otherwise.

We chose 6 MACD signals:

MACD(12, 26, 9); MACD(15, 26, 9); MACD(15, 30, 9); MACD(15, 30, 12); MACD(12, 30, 12); MACD(12, 26, 12)

## P&L Evaluation

We do the performance analysis at different parameter (average return per trade, accumulated  return, win ratio, max win/loss percentage)

What is special for the accumulated return is that we use 2 kind of approaches. The sum of return for each position and the product of return for each position. The sum can be seen as investing with constant principals. The product can be seen as doing the re-investment on a rolling basis.

For each signal, we show the parameters selected by the symbol and position sides. Also, we show the parameters selected by symbol which means that no comparison between position sides.

## Signal Comparison Conclusion

To conclude, ETH is a more profitable asset to invest, the return is significantly higher. Although the max loss and volatility seems a little bit higher, it worth the trade, meaning that the ETH is a much more profitable asset in terms of Sharp Ratio.

For the strategy, we should use constant principal to invest. From the result shown below, the product of return has a much higher volatility, while the accumulated return is    often lower.

For the trading signals, we hope that the strategy has a good return. In reality, the win ratio is also important, a higher win ratio gives the investor more motivation to put money in the market.

### For Hourly Data

EMA(5,12) is the best signal for EMA because it produces stable profit.

MACD(12,26,12) and MACD(12,30,12) are better signals for the same reason.

MACD signal seems to beat the EMA because MACD has a higher accumulated return.

### For Daily Data

EMA(12,50) is the best signal for EMA because it has the biggest accumulated return and captures all the sudden jumps.

MACD(12,26,12) and MACD(15,30,12) are better signals for the same reason.

EMA is by far a better signal than MACD because it has the ability to capture the sudden jumps in the price. However, it should be noted that this works for cryptocurrencies because they are very profitable assets according to the history data. Since cryptocurrencies are also very volatile and their future is still a question mark, this kind of strategy should be used very carefully.

## Hourly Data P&L Analysis

EMA(5, 12)

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154747857.png" alt="image-20240405154747857" style="zoom:50%;" />

![image-20240405132554997](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405132554997.png)

EMA(12, 25)

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154720091.png" alt="image-20240405154720091" style="zoom:50%;" />

![image-20240405132126740](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405132126740.png)

EMA(12, 50)

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154644588.png" alt="image-20240405154644588" style="zoom:50%;" />

![image-20240405134020854](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405134020854.png)

MACD(12, 26, 9);

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154612043.png" alt="image-20240405154612043" style="zoom:50%;" />

![image-20240405134917627](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405134917627.png)

MACD(15, 26, 9); 

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154541310.png" alt="image-20240405154541310" style="zoom:50%;" />

![image-20240405140324313](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405140324313.png)

MACD(15, 30, 9);

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154508044.png" alt="image-20240405154508044" style="zoom:50%;" />

![image-20240405142109088](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405142109088.png)

MACD(15, 30, 12);

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154442005.png" alt="image-20240405154442005" style="zoom:50%;" />

![image-20240405144218244](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405144218244.png)

MACD(12, 30, 12);

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154417658.png" alt="image-20240405154417658" style="zoom:50%;" />

![image-20240405145053954](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405145053954.png)

MACD(12, 26, 12)

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154146656.png" alt="image-20240405154146656" style="zoom:50%;" />

![image-20240405151021780](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405151021780.png)

## Daily Data P&L Analysis

EMA(5, 12)

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405155544018.png" alt="image-20240405155544018" style="zoom:50%;" />

![image-20240405133300032](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405133300032.png)

EMA(12, 25)

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405155505624.png" alt="image-20240405155505624" style="zoom:50%;" />

![image-20240404232057719](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240404232057719.png)

EMA(12,50)

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405155433913.png" alt="image-20240405155433913" style="zoom:50%;" />

![image-20240405134301581](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405134301581.png)

MACD(12, 26, 9);

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405155152246.png" alt="image-20240405155152246" style="zoom:50%;" />

![image-20240405135123970](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405135123970.png)

MACD(15, 26, 9); 

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405155130670.png" alt="image-20240405155130670" style="zoom:50%;" />

![image-20240405140648649](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405140648649.png)

MACD(15, 30, 9);

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405155102848.png" alt="image-20240405155102848" style="zoom:50%;" />

![image-20240405142339777](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405142339777.png)

MACD(15, 30, 12);

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405155033463.png" alt="image-20240405155033463" style="zoom:50%;" />

![image-20240405144624555](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405144624555.png)

MACD(12, 30, 12);

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154823131.png" alt="image-20240405154823131" style="zoom:50%;" />

![image-20240405145844043](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405145844043.png)

MACD(12, 26, 12)

<img src="C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405154315079.png" alt="image-20240405154315079" style="zoom:50%;" />

![image-20240405151422869](C:\Users\HP\AppData\Roaming\Typora\typora-user-images\image-20240405151422869.png)
