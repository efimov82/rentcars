<div id="navbar-full">
    <div id="navbar">
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>  
                    </button>
                    <a class="navbar-brand" href="/">Rent Car Phuket</a>
                </div>
                <div class="collapse navbar-collapse" id="navigation-example-2">
                    <ul class="nav navbar-nav navbar-right">
                      {foreach $main_menu as $num=>$item}
                        {if count($item.items) > 0}
                        <li class="dropdown">
                          <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="{$item.class}"> </i> {$item.name|upper}<b class="caret"></b></a>
                          <ul class="dropdown-menu dropdown-menu-right">
                            {foreach $item.items as $num2=>$subitem}
                            <li><a href="{$subitem.href}">{$subitem.name}</a></li>
                            {/foreach}</ul> 
                        </li>
                        {else}
                        <li><a href="{$item.href}"><i class="{$item.class}"> </i> {$item.name|upper}</a></li>  
                        {/if}
                      {/foreach}
                    </ul>
                </div>
            </div>
        </nav>        
    </div>
</div>
<div class="section">
    <div class="container-fluid content">
        <div class="row">