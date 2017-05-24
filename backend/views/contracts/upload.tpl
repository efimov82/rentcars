{include file="layouts/header.tpl"}
<!-- page content -->
<form action="" enctype="multipart/form-data" method="POST">

<div class="col-xs-6 col-md-6">
    <label>Add Files</label>
    <div class="input-group">
        {*<input type="file" name="images[]" multiple/>
        <input type="file" name="image2" />
        <input type="file" name="image3" />*}
        <label class="input-group-btn"><span class="btn btn-fill">Browse<input type="file" name="files[]" style="display: none;" multiple></span></label>
        <input type="text" name="image1" class="form-control" readonly>
    </div>
</div>
<input type="submit">SEND</input>

</form>
