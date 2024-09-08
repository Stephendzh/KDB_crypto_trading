btch : ("SFFFFFDT"; enlist ",") 0: `$ "D:/5530/proj1/bitcoin_h.csv";
btcd : ("DSFFFFF"; enlist ",") 0: `$ "D:/5530/proj1/bitcoin_d.csv";
btch
btcd-
// here we define a set of functions that are going to use

EMA:{[x;n] ema[2%(n+1);x]};
MACD:{[x;nFast;nSlow;nSig] diff:EMA[x;nFast]-EMA[x;nSlow]; sig:EMA[diff;nSig]; diff - sig};
// we choose 4 periods from really short to rather long 5, 12, 25, 50, the scale is different according to the data is hourly or daily
d: update ema5: EMA[close; 5], ema12: EMA[close; 12], ema25: EMA[close; 25], ema50: EMA[close; 50] by sym from btcd;
d: update macd1: MACD[close; 12; 26; 9], macd2: MACD[close; 15; 26; 9], macd3: MACD[close; 15; 30; 9],
   macd4: MACD[close; 15; 30; 12], macd5: MACD[close; 12; 30; 12], macd6: MACD[close; 12; 26; 12] by sym from d;
d: update pxenter: next open by sym from d;
d

h: update ema5: EMA[close; 5], ema12: EMA[close; 12], ema25: EMA[close; 25], ema50: EMA[close; 50] by sym from btch;
h: update macd1: MACD[close; 12; 26; 9], macd2: MACD[close; 15; 26; 9], macd3: MACD[close; 15; 30; 9],
          macd4: MACD[close; 15; 30; 12], macd5: MACD[close; 12; 30; 12], macd6: MACD[close; 12; 26; 12] by sym from h;
h: update pxenter: next open by sym from h;
// here we define the variables that help us to calculate where to buy or sell and holding period
// the signal and date (hour or minutes if required) and enter-price
cross_signal:{[m] m: update signalside: ?[signal > 0; 1i; -1i], j: sums 1 ^ i - prev i by sym from m;
 m: update signalidx: fills ?[0 = deltas signalside; 0N; j] by sym from m;
 m: update n: sums abs signalside, signaldate: first date, signaltime: first time by sym, signalidx from m};

cross_signal_daily:{[m] m: update signalside: ?[signal > 0; 1i; -1i], j: sums 1 ^ i - prev i by sym from m;
m: update signalidx: fills ?[0 = deltas signalside; 0N; j] by sym from m;
m: update n: sums abs signalside, signaldate: first date by sym, signalidx from m};

cross_signal_bench:{[m]
 r: select from cross_signal[m] where n=1, 1=abs signalside;
 r: r upsert 0! select by sym from m;
 r: update pxexit: next pxenter by sym from r;
 r: update bps: 10000 * signalside * -1 + pxexit % pxenter, nholds: (next j) - j by sym from r;
 delete from r where null signalside
 };

cross_signal_bench_daily:{[m]
 r: select from cross_signal_daily[m] where n=1, 1=abs signalside;
 r: r upsert 0! select by sym from m;
 r: update pxexit: next pxenter by sym from r;
 r: update bps: 10000 * signalside * -1 + pxexit % pxenter, nholds: (next j) - j by sym from r;
 delete from r where null signalside
 };

//PnL analysis
result: cross_signal_bench[select sym, date, time, signal: ema5 - ema12, pxenter from h];
result
result_daily : cross_signal_bench_daily[select sym, date, signal: ema5-ema12, pxenter from d]
result_daily
/by sym and side
select n:count i, avg bps, stdev: dev bps, rtn_sum:sum bps%10000, rtn_prd:-1+prd 1+bps%10000, winpct:(count i where bps>0)%count i,winmax:max bps%10000, maxloss:min bps%10000  by signalside,sym from result where date>2015.01.01

//by sym
select n:count i, avg bps, stdev: dev bps, rtn_sum:sum bps%10000, rtn_prd:-1+prd 1+bps%10000, winpct:(count i where bps>0)%count i,winmax:max bps%10000, maxloss:min bps%10000  by sym from result where date>2015.01.01

// buy & hold
select i, sum_rtn: sums bps % 10000, prd_rtn: -1 + prds 1 + bps %10000 from result


/by sym and side
select n:count i, avg bps, stdev: dev bps, rtn_sum:sum bps%10000, rtn_prd:-1+prd 1+bps%10000, winpct:(count i where bps>0)%count i,winmax:max bps%10000, maxloss:min bps%10000  by signalside,sym from result_daily where date>2015.01.01

//by sym
select n:count i, avg bps, stdev: dev bps, rtn_sum:sum bps%10000, rtn_prd:-1+prd 1+bps%10000, winpct:(count i where bps>0)%count i,winmax:max bps%10000, maxloss:min bps%10000  by sym from result_daily where date>2015.01.01


select i, sum_rtn: sums bps % 10000, prd_rtn: -1 + prds 1 + bps %10000 from result_daily where sym=`eth