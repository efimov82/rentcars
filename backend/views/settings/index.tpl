<!-- header --!>
{include file="layouts/header.tpl"}
  <!-- page content --!>
    <div class="col-md-12">
    <!-- search form -->
      <h3>Settings</h3>

      <div>
        <form action="/settings/save" method="POST">
            <div class="row">
              Theme: {html_options name="theme" options=$themes selected=$current_theme}
            </div>
            <div class="row">
              <div class="col-md-2">
                <div class="tim-title">
                  <button name="action" value="Save" class="btn btn-block">Save</button>
                </div>
              </div>
            </div>
        </form>
