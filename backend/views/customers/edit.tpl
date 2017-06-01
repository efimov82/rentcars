<!-- header --!>
{include file="layouts/header.tpl"}

<!-- page content --!>
<form action="/customers/save" method="POST">
  <input type="hidden" name="id" value="{$customer->id}">
    <div class="col-md-6">
      <h3>Add / Edit customer</h3>
      <div class="row">
        <div class="col-xs-6 col-md-6">
          <label>First name</label>
          <div class="input-group">
            <input type="text" name="f_name" value="{$customer->f_name}" class="form-control">
          </div> 
        </div>
        <div class="col-xs-6 col-md-6">
          <label>Second name</label>
          <div class="input-group">
            <input type="text" name="s_name" value="{$customer->s_name}" class="form-control">
          </div> 
        </div>
      </div>
      <div class="row">
        <div class="col-xs-6 col-md-6">
          <label>Last name</label>
          <div class="input-group">
            <input type="text" name="l_name" value="{$customer->l_name}" class="form-control">
          </div> 
        </div>
        <div class="col-xs-6 col-md-6">
          <label>Email</label>
          <div class="input-group">
            <input type="text" name="email" value="{$customer->email}" class="form-control">
          </div> 
        </div>
      </div>
      <div class="row">
        <div class="col-xs-6 col-md-6">
          <label>Thai phone#</label>
          <div class="input-group">
            <input type="text" name="phone_m" value="{$customer->phone_m}" class="form-control">
          </div> 
        </div>
        <div class="col-xs-6 col-md-6">
          <label>Russian phone#</label>
          <div class="input-group">
            <input type="text" name="phone_h" value="{$customer->phone_h}" class="form-control">
          </div> 
        </div>
      </div>
      <div class="row">
        
      </div>
      <div class="row">
        <div class="col-xs-6 col-md-6">
          <label>Passport#</label>
          <div class="input-group">
            <input type="text" name="passport" value="{$customer->passport}" class="form-control">
          </div> 
        </div>
        <div class="col-xs-6 col-md-6">
          <label>Facebook page</label>
          <div class="input-group">
            <input type="text" name="facebook" value="{$customer->facebook}" class="form-control">
          </div> 
        </div>
      </div>
      <div class="row">
        <div class="col-xs-6 col-md-6">
          <label>Description</label>
          <div class="input-group">
            <textarea name="description" class="form-control">{$customer->description}</textarea>
          </div> 
        </div>
      </div>
        <div class="col-xs-6 col-md-6">
                <label>Add Files</label>
                <div class="input-group">
                    <label class="input-group-btn"><span class="btn btn-fill">Browse<input type="file" name="files[]" style="display: none;" multiple></span></label>
                    <input type="text" name="image1" class="form-control" readonly>
                </div>

      {include file='layouts/panel.tpl' id=$customer->id}
    </div>
  
</form>