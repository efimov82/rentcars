{include file="layouts/header.tpl"}
            <!-- page content -->

<div>
  <p>isMobile: {$detecter->isMobile()}</p>

<p>version iPad={$detecter->version('iPad')}</p>
<p>version iPhone={$detecter->version('iPhone')}</p>
<p>version Android={$detecter->version('Android')}</p>
</div>

</div>