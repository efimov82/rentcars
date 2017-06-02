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
    <link href="/css/style.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'> 
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet" type='text/css'>

    <script src="/js/jquery-1.12.4.min.js"></script>
    <script src="/js/jquery-ui-1.12.1.js"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
    {*<script src="/js/bootstrap-select.js"></script>*}
    <script src="/js/bootstrap-datepicker.js"></script>
    <script src="/js/moment.min.js"></script>


    {$theme = Yii::$app->user->identity->current_theme}
      {if $theme}
        <link href="/css/themes/{$theme}.min.css" rel="stylesheet">
        {*<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">*}
    {/if}

</head>
<body>
                    {$content}
        </div>
    </div>
</div>
</body>
    
</html>