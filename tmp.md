## Range Types
Postgres comes with several built-in range types, we are interested in tstzrange, daterange and int4range- a range of integers.  You can define your own range types using the keyword RANGE but that is out of scope of thsi journey.

We try out a few examples to get our head in the game:
```SQL
SELECT '[3,7)'::int4range;
SELECT numrange(1.0, 14.0, '(]');

```

We will look at using GIST indexes on columns of range types.
```SQL
CREATE INDEX <new_idx> ON <my_table> USING GIST (<my_column);
```
We can no use the operators :
```
=
&&
<@
@>
<<
>>
-|-
&<
&>
```
to create constraints;

|Operator |Description |Example |Result|
|= |equal |int4range(1,5) = '[1,4]'::int4range |t|
|<> |not equal |numrange(1.1,2.2) <> numrange(1.1,2.3) |t|
|< |less than |int4range(1,10) < int4range(2,3) |t|
|> |greater than |int4range(1,10) > int4range(1,5) |t|
|<= |less than or equal |numrange(1.1,2.2) <= numrange(1.1,2.2) |t|
|>= |greater than or equal |numrange(1.1,2.2) >= numrange(1.1,2.0) |t|
|@> |contains range |int4range(2,4) @> int4range(2,3) |t|
|@> |contains element |'[2011-01-01,2011-03-01)'::tsrange @> '2011-01-10'::timestamp |t|
|<@ |range is contained by |int4range(2,4) <@ int4range(1,7) |t|
|<@ |element is contained by |42 <@ int4range(1,7) |f|
|&& |overlap (have points in common) |int8range(3,7) && int8range(4,12) |t|
|<< |strictly left of |int8range(1,10) << int8range(100,110) |t|
|>> |strictly right of |int8range(50,60) >> int8range(20,30) |t|
|&< |does not extend to the right of |int8range(1,20) &< int8range(18,20) |t|
|&> |does not extend to the left of |int8range(7,20) &> int8range(5,10) |t|
|-\|- |is adjacent to |numrange(1.1,2.2) -|- numrange(2.2,3.3) |t|
|+ |union |numrange(5,15) + numrange(10,20) |[5,20)|
|* |intersection |int8range(5,15) * int8range(10,20) |[10,15)|
|- |difference |int8range(5,15) - int8range(10,20) |[5,10)|





