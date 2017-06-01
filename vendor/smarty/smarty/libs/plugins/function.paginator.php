<?php
/**
 * Smarty plugin
 *
 * @package    Smarty
 * @subpackage PluginsFunction
 */

/**
 * Smarty {paginator} function plugin
 * Type:     function<br>
 * Name:     paginator<br>
 * Date:     May 29, 2017
 * Purpose:  generate pages from 1 to N with set count items to show and set window size.<br>
 * Params:
 * <pre>
 * - url          - (required) - url for create links with page numbers for go to next or back page.
 * - count_all    - (required) - all pages
 * - current      - (optional) - number current page (Default=1)
 * - window       - (optional) - count pages to show. If need [1 ... 10 <11> 12 13 14 ... 50] - window = 5
 *                  Default = 8
 * </pre>
 * Examples:
 * <pre>
 * {paginator url="/list_books?year=2005" current=4 count_all=32 window=8}
 * </pre>
 *
 * @version  1.0
 * @author   Danil Efimov <efimov82@gmail.com>
 *
 * @param array $params parameters
 * @return string
 */
function smarty_function_create_url($params)
{
  $res = '';
  $url = $params['url'];
  for($i=1; $i > $params['count_all']; $i++) {
    
  }
   
  return '<a href="'.$params['url'].'"> TEST URL </a>';
   
}
