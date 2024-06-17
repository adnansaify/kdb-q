filepath:"C:\\Users\\adnan\\Downloads\\BANKNIFTY.txt"

trade:read0 `$filepath

column_name:(`Symbol,`Date,`Time,`Open,`Close,`High,`Low)

table_trade:flip column_name !("SDTFFFF"; ",") 0:trade

table_trade

\\trade:([]time:`time$();sym:`symbol$())

table_trade:update m1:((8#0n),8_8 mavg Close) from table_trade
 
table_trade:update m2:((100#0n),100_100 mavg Close) from table_trade

\\table_trade:update diff:((1#0), 1_deltas Close) from table_trade

\\use by

table_trade

\\table_trade: update signal: 1b where (21#0b), (1_deltas m1 < 0) and (1_deltas m2 > 0) from table_trade

select from table_trade  where (prev m2>prev m1 and m2<m1)

update dt:Date+Time from `table_trade

\\update (prev m2> prev m1 and m2<m1) from table_trade
\\table_trade: update signal: (0b, 21#0b), 1b where (22#0b), 1_deltas m1 < 0 and 1_deltas m2 > 0 from table_trade

update signal:(m2>m1) and (prev[m1]>prev[m2]) from table_trade

update s3:s1 and s2 from update s1:(m2>m1),s2:(prev[m2]>prev[m1]) from table_trade

update signal:(m2<m1) and (prev[m2]>prev[m1]) from table_trade

update s1:(m2>m1) , s2:(prev[m2] > prev[m1]) from table_trade

(m2<m1)and(prev m2> prev m1)

parse "(prev m2)>prev m1"

parse "(prev m2> prev m1)"

parse "(m2>m1) and (prev[m1]>prev[m2])"