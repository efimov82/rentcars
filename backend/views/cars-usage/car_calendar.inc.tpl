
<div id="calendar"></div>

<script src="/js/spa/calendar.js"></script>

{*
{literal}
<style>
* {box-sizing:border-box;}
ul {list-style-type: none;}

.month {
    width: 100%;
    background: #1abc9c;
    padding: 5px 0;
}

.month ul {
    margin: 0;
    padding: 0;
}

.month ul li {
    color: white;
}


.weekdays {
    margin: 0;
    padding: 5px 0;
    background-color: #ddd;
}

.weekdays li {
    display: inline-block;
    width: 11.6%;
    color: #666;
    text-align: center;
}

.days {
    padding: 10px 0;
    background: #eee;
    margin: 0;
}

.days li {
    list-style-type: none;
    display: inline-block;
    width: 11.6%;
    text-align: center;
    margin-bottom: 5px;
    font-size:12px;
    color: #777;
}

.days li .active {
    padding: 5px;
    background: #1abc9c;
    color: white !important
}

/* Add media queries for smaller screens */
@media screen and (max-width:720px) {
    .weekdays li, .days li {width: 11.1%;}
}

@media screen and (max-width: 420px) {
    .weekdays li, .days li {width: 12.5%;}
    .days li .active {padding: 2px;}
}

@media screen and (max-width: 290px) {
    .weekdays li, .days li {width: 12.2%;}
}
</style>
{/literal}

{foreach $data as $num=>$arr}
  <div class="col-md-4">
    {include file="month.inc.tpl" name=$arr.name days=$arr.days}
  </div>
{/foreach}

*}