{****** 
Usage: {include file="shared/filters/managers.tpl" managers=$managers params=$params}
*******}
<!-- managers.tpl -->
<div class="col-xs-6 col-md-2">
    <label>Manager:</label>
    <select name="user_id" class="form-control">
        <option value="">-</option>
        {foreach $managers as $num=>$user}
        <option value="{$user.id}"{if $params.user_id == $user.id} selected="selected"{/if}>{$user.name}</option>
        {/foreach}
    </select>
</div> 
<!-- end managers.tpl-->