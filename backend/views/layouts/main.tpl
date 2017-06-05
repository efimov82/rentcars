<!doctype html>
<html lang="en">
<head>
	<title>Phuket car rental</title>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    <link href="/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/css/datepicker.css" rel="stylesheet" />
    <link href="/css/style.css?v=2" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'> 
</head>
<body>


{*popup*}
<div class="toggler">
  <div id="sys_message" class="ui-widget-content ui-corner-all">
    <h3 class="ui-widget-header ui-corner-all">Warning</h3>
    <p>
      You are OFFLINE. Check your internet connection.<br/> 
      Data will save in your local storage.
    </p>
  </div>
</div>


{$content}


        </div>
    </div>
</div>

{*popup*}
{literal}
<style>
  .toggler {
      position: absolute;  
      float:right;
       overflow: hidden;  
       z-index: 99999;  
       margin: 0;  
       padding: 0;
       height: 150px; }
  #sys_message {height: 150px; padding: 0.4em; position: relative; background-color: white; display:none;}
  #sys_message h3 { margin: 0; padding: 0.4em; text-align: center; background-color: yellow;}
</style>
{/literal}
{*popup*}

</body>
    <script src="/js/jquery-1.12.4.min.js"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
    <script src="/js/moment.min.js"></script>
    <script src="/js/spa/offline.js"></script>
    <script src="/js/inner_functions.js"></script>
    {*popup*}
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</html>