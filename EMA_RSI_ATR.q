filepath:"C:\\Users\\adnan\\Downloads\\BANKNIFTY.txt"

trade:read0 `$filepath

column_name:(`Symbol,`Date,`Time,`Open,`High,`Low,`Close)

table_trade:flip column_name !("SDTFFFF"; ",") 0:trade

table_trade

table_trade:update ema1:((10#0n),10_10 mavg Close) from table_trade
 
table_trade:update ema2:((100#0n),100_100 mavg Close) from table_trade

table_trade:update delta:(Close-prev Close) from table_trade

table_trade:update gain:delta*(0<delta) from table_trade

table_trade:update loss:abs(delta*(0>delta)) from table_trade

table_trade:update avg_gain:((7#0n),7_7 mavg gain) from table_trade

table_trade:update avg_loss:((7#0n),7_7 mavg loss) from table_trade

table_trade:update RS:((7#0n),7_ (avg_gain % avg_loss)) from table_trade

table_trade:update RSI:((7#0n),7_ (100 - (100 % (1 + RS)))) from table_trade

select ((prev ema1 > prev ema2) and (ema1 < ema2) and (RSI<30)) from table_trade

table_trade:update HL:(High-Low) from table_trade

table_trade:update HPC:(High-(prev Close)) from table_trade

table_trade:update LPC:(Low-(prev Close)) from table_trade

max_val: {max each flip x}

maxValues: max_val table_trade[`HL`HPC`LPC]

table_trade: update TR: maxValues from table_trade

table_trade:update ATR:((7#0n),7_7 mavg TR) from table_trade

table_trade:update short:(RSI<30) and (prev ema1 > prev ema2) and (ema1 < ema2) and (ATR<50)from table_trade

table_trade:update long:(RSI>70) and (prev ema1 < prev ema2) and (ema1 > ema2) and (ATR<50) from table_trade

select from table_trade where (long=1)

select from table_trade where (short=1)

table_trade

