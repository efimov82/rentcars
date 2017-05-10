{include file="layouts/header.tpl"}
<!-- page content --!>
<form action="/payments/save" method="POST">
  <div class="col-md-6">
    <h3>Add/Edit contract</h3>

    <div class="row">
      <div class="col-xs-6 col-md-3">
        <label>Car Number</label>
        <div class="input-group">
          <input type="text" id="car_number" name="car_number" class="form-control">
          <span class="input-group-addon"><i class="fa fa-car"></i></span>
        </div>  
      </div>
      <div class="col-xs-6 col-md-3">
        <label>Model</label>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-addon"><i class="fa fa-car"></i></span>
        </div>  
      </div>
      <div class="col-xs-6 col-md-3">
        <label>Color</label>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-addon"><i class="fa fa-paint-brush"></i></span>
        </div>  
      </div>            
      <div class="col-xs-6 col-md-3">
        <label>Mileage</label>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-addon"><i class="fa fa-bug"></i></span>
        </div>  
      </div>
      <div class="col-xs-6 col-md-3">
        <label>Data of Start</label>
        <div class="input-group">
        <input class="datepicker form-control" type="text"/>
          <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
        </div>
      </div> 
      <div class="col-xs-6 col-md-3">
        <label>Data of Finish</label>
        <div class="input-group">
        <input class="datepicker form-control" type="text"/>
          <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
        </div>
      </div> 
      <div class="col-xs-6 col-md-3">
        <label>Time</label>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
        </div>  
      </div>
      <div class="col-xs-6 col-md-3">
        <label>Last Name</label>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-addon"><i class="fa fa-user"></i></span>
        </div>  
      </div> 
      <div class="col-xs-6 col-md-3">
        <label>Passport#</label>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-addon"><i class="fa fa-info-circle"></i></span>
        </div>  
      </div> 
      <div class="col-xs-6 col-md-3">
        <label>Nationality</label>
        <div class="input-group">
          <input type="text" value="RUS" class="form-control">
          <span class="input-group-addon"><i class="fa fa-flag"></i></span>
        </div>  
      </div> 
      <div class="col-xs-6 col-md-3">
        <label>Place of Birth</label>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-addon"><i class="fa fa-university"></i></span>
        </div>  
      </div>
    </div>

    <div class="row">
      <div class="col-xs-6 col-md-6">
        <label>Mobile Phome</label>
        <div class="input-group">
          <input type="text" value="+7" class="form-control">
          <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
        </div>  
      </div>
      <div class="col-xs-6 col-md-6">
        <label>Home Phone</label>
        <div class="input-group">
          <input type="text" value="+66" class="form-control">
          <span class="input-group-addon"><i class="fa fa-phone-square"></i></span>
        </div> 
      </div>
      <div class="col-xs-6 col-md-6">
        <label>E-mail</label>
        <div class="input-group">
          <input type="text" class="form-control">
          <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
        </div> 
      </div>
      <div class="col-xs-6 col-md-6">
        <label>Sex</label>
        <select class="form-control system-add-price" name="Sex">
          <option data="male" value="Male">Male</option>
          <option data="female" value="Woman">Female</option>
        </select>
      </div>
    </div>

    <div class="row">
      <div class="col-xs-6 col-md-6">
          <label>Add Files</label>
          <div class="input-group">
              <label class="input-group-btn">
                <span class="btn btn-fill">Browse<input type="file" style="display: none;" multiple></span>
              </label>
              <input type="text" class="form-control" readonly>
          </div>
      </div>
      <div class="col-xs-6 col-md-6">
        <label>Type Client</label>
        <select class="form-control system-add-price" name="Sex">
          <option data="male" value="Male">Pauper</option>
          <option data="male" value="Male">Middle</option>
          <option data="female" value="Woman">Rich</option>
        </select>
      </div>
    </div>


    {include file='layouts/panel.tpl' id=$contract->id}
  </div>
</form>

{literal}
  <script>
  $( function() {
    var availableTags = [
      "ActionScript",
      "AppleScript",
      "Asp",
      "BASIC",
      "C",
      "C++",
      "Clojure",
      "COBOL",
      "ColdFusion",
      "Erlang",
      "Fortran",
      "Groovy",
      "Haskell",
      "Java",
      "JavaScript",
      "Lisp",
      "Perl",
      "PHP",
      "Python",
      "Ruby",
      "Scala",
      "Scheme"
    ];
    $( "#car_number" ).autocomplete({
      source: availableTags
    });
  } );
  </script>
{/literal}