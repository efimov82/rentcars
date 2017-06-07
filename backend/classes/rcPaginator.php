<?php
namespace backend\classes;

use yii\helpers\Url;

class rcPaginator implements \Iterator {
  private $position = 0;
  private $data = [];  
  
  /**
   * 
   * @param array $params:  
   *                  pages   - (required) - count pages 
    *                 current - (required) - number current page
   *                  visible - (optional) - size of window visible pages if  count pages > visible. Default = 2
   */
  public function __construct($params) {
    $this->position = 0;
    
    if (!isset($params['visible']))
      $params['visible'] = 2;
    if ($params['current'] < 1)
      $params['current'] = 1;
    
    if ($params['pages'] < 1)
      return; 
    
    if ($params['pages'] > ($params['visible']+3))
      $this->_wideInit($params);
    else
      $this->_simpleInit($params);
    
    $this->position = 0;
  }
  
  /**
   * Init like [<< 1, 2, 3, (4), 5, 6 >>]
   * 
   * @param array [pages, current, visible]
 */
  protected function _simpleInit($params) {
    // arrows <<
    //$url = ;
    //if ($params['pages'] > 1) {
      if ($params['current'] >1) $state = '';
      else $state = 'disabled';
      
      $this->data[] = ['state'=>$state, 'page'=>'&laquo;', 'href'=>Url::current(['page' => $params['current']-1 ])];
    //}
    
    // pages
    for($i=1; $i <= $params['pages']; $i++) {
      if ($i == $params['current']) {
        $state = 'active';
      } else {
        $state = '';
      }
      $this->data[] = ['state'=>$state, 'page'=>$i, 'href'=>Url::current(['page' => $i])];
    }
    
    // arrows >>
    //if ($params['pages'] > 1) {
      if ($params['current'] < $params['pages']) $state = '';
      else $state = 'disabled';
      
      $this->data[] = ['state'=>$state, 'page'=>'&raquo;', 'href'=>Url::current(['page' => $params['current']+1])];
    //}
  }
  
  /**
   * Init with arrows, '...', and window pages size $params['visible']+1 
   *  like [<< 1, ... 23, 24, (25), 26, 27, ... 50 >>]
   * 
   * @param array $params [pages, current, visible]
   */
  protected function _wideInit($params) {
    $window = floor($params['visible']/2);
    $current = ($params['current'] < 1) ? 1 : $params['current'];
    // arrows <<
    $this->data[] = ['state'=>$current > 1 ? '' : 'disabled', 
                     'page'=>'&laquo;', 
                     'href'=>Url::current(['page' => $current-1])];
    // first page
    if ($current == 1) {
      $this->data[] = ['state'=>'active', 'page'=>1, 'href'=>'#'];
    } else {
      $this->data[] = ['state'=>'', 'page'=>1, 'href'=>Url::current(['page' => null])];
    }
    // dots
    $start = (($current - $window) > 2) ? ($current - $window) : 2;
    if ($start > 2)
      $this->data[] = ['state'=>'disabled', 'page'=>'...', 'href'=>''];
    
    $stop = (($current + $window) > ($params['pages']-1)) ? ($params['pages']-1) : ($current + $window);
    // pages
    for($i=$start; $i <= $stop; $i++) {
      $state = ($i == $params['current']) ? 'active' : '';
      $this->data[] = ['state'=>$state, 'page'=>$i, 'href'=>Url::current(['page' => $i])];
    }
    
    // dots
    if ($stop < ($params['pages']-1)) {
      $this->data[] = ['state'=>'disabled', 'page'=>'...', 'href'=>''];
    }
    
    // last page
    if ($current == $params['pages']) {
      $this->data[] = ['state'=> 'active', 'page'=>$params['pages'], 'href'=>'#'];
    } else {
      $this->data[] = ['state'=>'', 'page'=>$params['pages'], 'href'=>Url::current(['page' => $params['pages']])];
    }
    
    // arrows >>
      $this->data[] = ['state'=> $current < $params['pages'] ? '' : 'disabled', 
                       'page'=>'&raquo;', 
                       'href'=>Url::current(['page' => $current+1])];
  }


  public function rewind() {
    $this->position = 0;
  }

  public function current() {
    return $this->data[$this->position];
  }

  public function key() {
    return $this->position;
  }

  public function next() {
    ++$this->position;
  }

  public function valid() {
    return isset($this->data[$this->position]);
  }
}
