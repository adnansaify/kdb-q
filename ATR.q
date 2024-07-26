filepath:"C:\\Users\\adnan\\Downloads\\BANKNIFTY.txt"

trade:read0 `$filepath

column_name:(`Symbol,`Date,`Time,`Open,`Close,`High,`Low)

table_trade:flip column_name !("SDTFFFF"; ",") 0:trade

table_trade

table_trade:update HL:(High-Low) from table_trade

table_trade:update HPC:(High-(prev Close)) from table_trade

table_trade:update LPC:(Low-(prev Close)) from table_trade

max_val: {max each flip x}

maxValues: max_val table_trade[`HL`HPC`LPC]

table_trade: update TR: maxValues from table_trade

table_trade:update ATR:((7#0n),7_7 mavg TR) from table_trade

filePath: "table_trade.csv"

save `table_trade.csv

