{****** 
Usage: {include file="shared/filters/payment_types.tpl" params=$params}
*******}
<!-- payment_types.tpl -->
<div class="col-xs-6 col-md-1">
    <label>Type:</label> 
    <select name="payment_type" class="form-control">
        <option value="0" class="form-control option">ALL</option>
        <option value="1" class="form-control option" {if $params.payment_type == 1}selected=selected{/if}>INCOME</option>
        <option value="2" class="form-control option" {if $params.payment_type == 2}selected=selected{/if}>OUTGOING</option>
    </select>
</div>
<!--end payment_types.tpl -->