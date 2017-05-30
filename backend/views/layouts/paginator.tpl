<nav aria-label="...">
  <ul class="pagination">
  {foreach $paginator as $item}
    <li class="page-item {$item.state}" >
      <a class="page-link" href="{$item.href}">{$item.page}</a>
    </li>
  {/foreach}
  </ul>
</nav>

    {*
&laquo;

<li class="page-item">
      <a class="page-link" href="#">1</a>
    </li>
    <li class="page-item disabled">
      <a class="page-link" href="#">...</a>
    </li>
    <li class="page-item active">
      <a class="page-link" href="#">6 <span class="sr-only">(current)</span></a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">7 <span class="sr-only">(current)</span></a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">8 <span class="sr-only">(current)</span></a>
    </li>
    <li class="page-item"><a class="page-link" href="#">9</a></li>
    <li class="page-item disabled">
      <a class="page-link" href="#">...</a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">40</a>
    </li>
    <li class="page-item">
      <a class="page-link" href="#">&raquo;</a>
    </li>*}
