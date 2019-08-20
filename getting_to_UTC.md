# Getting to UTC

```
POLITICAL CORRECTNESS WARNING: May contain anti-colonial humour
```

So what is time? This turns out to be an easy question to ask but impossible to answer.  Physicists (at least since Albert Einstein first described the theory of special relativity) see time as the fourth dimension in our space-time existence, which is not only relative but can be compressed or expanded depending on the relative velocity of the observers.

![Time](https://wikimedia.org/api/rest_v1/media/math/render/svg/dedcd9d07bd1344bf31dbdd61886479bb980716a)

Time is also however subjective in its passing ( watching a kettle boil) and simultaneously very measurable for points at rest (refer to www.speedtest.net if you need an example).  Of course, we live on a rotating ball, which is rotating around a star, which is rotating (in its spiral arm) around the centre of our galaxy, which is, as best we know, expanding (possibly with a gentle rotation of its own...?).  Our perception of the passage of time then is determined by the astronomical cycles of day, night, seasons & years; simultaneously though our experience of the passage time appears to be more subjective & harder to pin down.
```text
This talk flies by because it is so interesting to listen to, 
but the speed of rotation of all the astronomical bodies
including the earth has apparently not changed. 
For that bored person in the 3rd row however, 
the world seems to have painfully slowed right down!
```
One basic problem with time is that we are forced to express it in terms of spatial & temporal coordinates for it to be universal in application. We have:
- **time zones**; which exist because of planetary rotation wrt an external solar reference, and taken together with geo-location or latitude on our familiar ball, we then apply convention for convenience and throw in politics & habit so we can add inconvenient consequences such as daylight savings & international date lines etc.
- and we have **astronomical units** such as rotations around an axis or rotations around the sun etc, a convention that gives rise to the fact that Venus has a day that is about half a year long. i.e. it rotates around the Sun in 224.65 Earth-days and around its own axis in  116.75 Earth days.  Put another way, it rotates around it's own axis in 1 Venus-day and around the Sun (a Venus year) in 1.92 Venus-days.

For us here on earth we use a scientific & a political definition of time, rather than a purely astronomical time.  We call this UTC but more on that in 0.694444 thousandth of an earth rotation. We measure time in SI (Système International d'Unités) metric units and then conveniently group these units into a time scale that is more pragmatic, called a calender.

Since 1848 maps & times used Greenwich meridian and since 1879 the world was divided into 24 x 15deg time-zones, which have morphed into all the time-zones that we have today : 
![time-zones](https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/World_Time_Zones_Map.png/1200px-World_Time_Zones_Map.png)

GMT or Greenwich Mean Time was generally a Civil Time (starting at midnight) and is still how we all commonly organise our days.  We stay out after midnight and into the early hours of the new day in the thrall of young love, but in the rational light of the scientific day we define Universal Time, being an astronomical day as starting at noon.  Just in case we forgot AM/PM is about noon and not midnight (being ante/poste meridiem).

UTC is Coordinated Universal Time and is the modern version of GMT.  As in all things that involve the French it is however more complicated than it need be, as it is a compromise between the English (Coordinated Universal Time) which would have been CUT and the French phrase (Temps Universel Coordonné) which would have been TUC. Then as any good colonial is supposed to reason they concluded we could the use the same official abbreviation in all languages, not just French & English - and so they do.
 
UT is set by an atomic clock and adjusted by leap seconds etc to remain within 0.9 sec UT1 (one of the astronomical universal times set by very distant stars & quasars) from time to time.  UT1 would be the same everywhere on earth & is proportional to the angle of the earth to these distant quasars. Higher versions of UT e.g. UT2 include smoothing for tiny wobbles & seasonal & lunar tidal influences etc..  The Earth's rotation is gradually slowing down relative to International Atomic Time (TAI) - another backwards abreviation. In order to rationalize UTC with respect to TAI, a leap second is inserted at intervals of about 18 months, as determined by the International Earth Rotation Service (IERS).  And just because you think you now follow what is going on, you probably also need to know that from 1972 GMT was not no longer a time standard but became the time zone name used by a few countries, including the UK (but only during their winter) but Iceland for example use it all year round.

[WikiPedia: Universal Time](https://en.wikipedia.org/wiki/Universal_Time)

Most systems treat time as starting from some epoch (significant time marker). Lisp used 0-time to be 1900-01-01 00:00:00 UTC and Unix uses 1970-01-01 00:00:00 UTC, and simply keep a continuous count of seconds (as does postgreSQL).

Programming languages such as Go, Python and .NET utilise Rata Die (R.D.) <from latin for "fixed-date"> , which is a system for assigning numbers to calendar days (optionally with time of day), independent of any calendar, for the purposes of calendrical calculations.

The civil calender used by most countries is the Gregorian solar calendar, named after Pope Gregory XIII, who introduced it in October 1582, which has 365.2425 days in a year and caters for leap years.  This is a very close approximation for the actual 365.2422 days in a tropical year that is currently determined by the Earth's actual revolution around the Sun.

The rule for leap years is as follows:
> Every year that is exactly divisible by four is a leap year, 
> except for years that are exactly divisible by 100 which are not, 
> except for when these centennial years are exactly divisible by 400 then they are. 

For example, the years 1700, 1800, and 1900 were not leap years, but the year 2000 was and the 2100 wont be.

RD is similar to UTC but is different in different time-zones whereas UTC is the same planet wide.  RD 1 == Jan 1, AD 1 midnight (00:00) local time.  The Julian day by contrast is a continuous count of days from noon UT (Julian Epoch) starting at day 0 being noon, Jan 1st, Monday, 4713 BC (being a date where the lunar, solar & 15 year "indiction" cycles all coincided).  The 15 year indiction or agricultural tax cycle hails from Roman controlled Egypt as if doing calculations modular 15 on precious papyrus was a good idea!

Julius Caesar introduced the Julian calendar in 46 BC (two years before his death) intended initially only for the counting of years, but just to add to fun, the Julian "Date System" (JD) was invented by the French scholar Joseph Justus Scaliger (1540-1609) and JD 0 corresponds to 1 January 4713 BC in the Julian calendar, or 24 November 4714 BC in the Gregorian calendar.  And lastly to make the chaos complete, PostgreSQL does not observe the nicety of having dates run from noon to noon. PostgreSQL treats a Julian Date as running from midnight to midnight.

So, may you never need to do any of this in your code:
```java
RD = JD − 1 721 424.5
//convert Gregorian date (Y/M/D) to JD Number:
JDN = (1461 × (Y + 4800 + (M − 14)/12))/4 +\
(367 × (M − 2 − 12 × ((M − 14)/12)))/12 − \
(3 × ((Y + 4900 + (M - 14)/12)/100))/4 + D − 32075

//US Day of week (sun:0- sat:6) :
w1 = mod(jdn + 1 ,7)

//ISO Day of Week (mon:1 - sun:7) :
w0 = mod(jdn, 7) + 1
```

PostgreSQL uses Julian Dates for all date/time calculations.This has the useful property of correctly calculating dates from 4713 BC to far into the future like 294276 AD using "timestamp" or even further like 178 million years if you use the "interval" type, all using the assumption that the length of the year is 365.2425 days.


[Wikipedia: Gregorian calendar](https://en.wikipedia.org/wiki/Gregorian_calendar)

However, people tend to prefer words to numbers, and go out of their way to name things - such as months & days of week & times of day etc. This also creates convention chaos e.g. **mm/dd/yy** vs **dd/mm/CCyy** or worse just **mm/dd** which 
```bash
ls -l
```
uses by default, so you probably want to do something like:
```bash
ls -l --time-style=+%C%y/%m/%d
```
Between Date & Time, Time is more blessed.  If you get past all the modulus 60 stuff -> it always appears in the same order: hours, minutes, seconds & decimal fractions of seconds and that is it ...except there is AM & PM ,as well as 12hr, 24 hr clocks to deal with.  The 12 hrs a days not 10 being another artefact of Roman's 2000 year reach into history.

Language Neutral Notation such as ISO 8601 solves the problems of convention chaos with painful verbosity:

```sql
'2019-03-11T11:10:30,5+02:00'
# which is [unambiguous date]T[time with fractional seconds][+-UTC timezone]
```
And then of course there is the International Date Line (IDL) at 180 deg (-24 hrs west to east), and for our pleasure the time-zone zigzags to take into account countries and geopolitical regions - so it is possible to cross the IDL from Baker Island to Tokelau (just 1061km) and have to add 25 hrs forward = 1 day + 1 hr because of time zigzags across time-zones.  
![International Date Line](https://c.tadst.com/gfx/750x500/international-date-line.jpg)

It is also interesting to note that on our planet everyday between 10:00 and 11:59 UTC there are three different dates on the calender in use.
- 10:30 UTC it is 2nd May
- 23:30 UTC-11 (American Samoa) it is May 1st
- 06:30 UTC-4 (New York) it is May 2nd, and
- 00:30 UTC+14 it is May 3rd (Kiritimati always the first country to celebrate New Year)

UTC is a time standard and GMT is now relegated to being a time-zone.

Oh, and Britain are not actually in the GMT time zone but BST (British Summer Time) which uses GMT+1 in their summer and GMT in winter.  
Our time-zone would be South African Standard Time SAST which is UTC+02:00, except for the Department of Home Affairs where the time-zone is more like tea-time, strike-time or closed-due-to-training-time, which most city & urban dwellers now call rather-go-to-your-bank-for-passport-time.

Lastly, the military & aviation have what is called the Zulu convention 14:00 ZULU is simply 14:00 UTC.

Therefore, here in Zululand (KZN), Zulu time is off by two hours being SAST-02:00, but if you're in the town of Zulu, which is in Alabama, all bets are off - I include a satellite view of this so called town, but of course whatever time zone you use, every day there's a time when you're only a second away from tomorrow.
https://goo.gl/maps/i3c4GxV16eo

And just as a side-track before we move on, we take note that the Network Time Protocol (NTP) is used to keep our various systems in sync with UTC & each other.
```
timedatectl list-timezones

sudo timedatectl set-timezone Africa/Johannesburg

timedatectl

                      Local time: Mon 2019-01-07 18:42:55 SAST
                  Universal time: Mon 2019-01-07 16:42:55 UTC
                        RTC time: Mon 2019-01-07 16:42:55
                       Time zone: Africa/Johannesburg (SAST, +0200)
       System clock synchronized: yes
systemd-timesyncd.service active: yes
                 RTC in local TZ: no
```
and checking the standard timesyncd
```
systemctl status systemd-timesyncd
● systemd-timesyncd.service - Network Time Synchronization
   Loaded: loaded (/lib/systemd/system/systemd-timesyncd.service; enabled; vendor preset: enabled)
   Active: active (running) since Mon 2019-01-07 08:35:49 SAST; 10h ago
     Docs: man:systemd-timesyncd.service(8)
 Main PID: 891 (systemd-timesyn)
   Status: "Synchronized to time server 91.189.89.198:123 (ntp.ubuntu.com)."
    Tasks: 2 (limit: 4915)
   CGroup: /system.slice/systemd-timesyncd.service
           └─891 /lib/systemd/systemd-timesyncd

Jan 07 08:35:48 serenity systemd[1]: Starting Network Time Synchronization...
Jan 07 08:35:49 serenity systemd[1]: Started Network Time Synchronization.
Jan 07 08:41:49 serenity systemd-timesyncd[891]: Synchronized to time server 91.189.89.198:123 (ntp.ubuntu.com).
```

The NTP synchronization protocol determines the time offset of the server clock relative to the client clock.  On request, the server sends a message including its current clock value or timestamp and the client records its own timestamp upon arrival of the message. The accuracy over the Internet is proportional to the propagation delay.

It seems that we simply cannot get away from time or is it that time keeps getting away from us?

---
References:
```
http://naggum.no/lugm-time.html - long painful history of time
https://tapoueh.org/blog/2018/04/postgresql-data-types-date-timestamp-and-time-zones/
http://clarkdave.net/2015/02/historical-records-with-postgresql-and-temporal-tables-and-sql-2011/

```
