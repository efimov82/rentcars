<form id="login-form" action="/site/login" method="post" role="form">
<input type="hidden" name="_csrf-backend" value='{$csrf}'>
                <div class="form-group field-loginform-username required">
<label class="control-label" for="loginform-username">Username</label>
<input type="text" id="loginform-username" class="form-control" name="LoginForm[username]" autofocus aria-required="true">

<p class="help-block help-block-error"></p>
</div>
                <div class="form-group field-loginform-password required">
<label class="control-label" for="loginform-password">Password</label>
<input type="password" id="loginform-password" class="form-control" name="LoginForm[password]" aria-required="true">

<p class="help-block help-block-error"></p>
</div>
                <div class="form-group field-loginform-rememberme">
<div class="checkbox">
<label for="loginform-rememberme">
<input type="hidden" name="LoginForm[rememberMe]" value="0"><input type="checkbox" id="loginform-rememberme" name="LoginForm[rememberMe]" value="1" checked>
Remember Me
</label>
<p class="help-block help-block-error"></p>

</div>
</div>
                <div class="form-group">
                    <button type="submit" class="btn" name="login-button">Login</button>                </div>

            </form> 