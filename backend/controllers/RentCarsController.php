<?php

/* 
 * Общий класс для всех котроллеров
 * 
 */

namespace backend\controllers;

use Yii;
use yii\web\Controller;
use yii\helpers\Url;
use backend\models\Car;

/**
 * Common controller
 */
class RentCarsController extends Controller
{
  public $common_vars = array();
  public $title = 'Admin';
  public  $layout = 'main.tpl';
  
  public function beforeAction($action)
  {
    $this->enableCsrfValidation = false;
    if (!parent::beforeAction($action))
      return false;
     
    $menu = array();
    $this->common_vars['main_menu'] = $menu;
    
    if (Yii::$app->user->can('admin')){
      $menu['new'] = ['name'=>'<b>NEW</b>','href'=>'', 'class'=>'fa fa-file-text',
                          'items'=>[1=>['name'=>'Contract', 'href'=>'/contracts/add'],
                                    2=>['name'=>'Payment',  'href'=>'/payments/add'],
                                    3=>['name'=>'Car',      'href'=>'/cars/add'],
                                    3=>['name'=>'Cusromer', 'href'=>'/customers/add'],
                                    4=>['name'=>'Users',    'href'=>'/users/add']]
                      ];
      $menu['view'] = ['name'=>'Show', 'href'=>'', 'class'=>'',
                          'items'=>[0=>['name'=>'Contracts',  'href'=>'/contracts'],
                                    1=>['name'=>'Payments',   'href'=>'/payments'],
                                    2=>['name'=>'Cars',       'href'=>'/cars'],
                                    2=>['name'=>'Customers',  'href'=>'/customers'],
                                    3=>['name'=>'Users',      'href'=>'/users']]
                      ];
      $menu['statistic'] = ['name'=>'Statistic', 'href'=>'/', 'class'=>'',
                            'items'=>[0=>['name'=>'Reports',    'href'=>'/reports'],
                                      1=>['name'=>'Cars usage', 'href'=>'/cars-usage'],
                                     ]
                           ];
      $menu['settings'] = ['name'=>'Settings', 
                           'href'=>'/settings',
                           'class'=>'fa fa-cog fa-fw',
                           'items'=>[]];
      
    } elseif (Yii::$app->user->can('manager')) {
      $menu['cars'] = ['name'=>'Cars', 'href'=>'/cars', 'class'=>'fa fa-user', 'items'=>[]];
      $menu['reports'] = ['name'=>'Reports', 'class'=>'fa fa-table', 'href'=>'reports', 'items'=>[]];
    } elseif (Yii::$app->user->can('cars_owner')) {
      $menu['cars'] = ['name'=>'My cars', 'href'=>'/cars', 'class'=>'fa fa-user', 'items'=>[]];
    }
    
    if (!Yii::$app->user->isGuest){
      $menu['logout'] = ['name'=>Yii::$app->user->identity->name, 
                         'class'=>'fa fa-sign-out', 
                         'href'=>'/site/logout', 
                         'items'=>[]];
    }
    
    $this->common_vars['main_menu'] = $menu;
    //$this->view->params['title'] = $this->title;
    //$this->main_menu = $menu;
    
    return true;
  }
  
  public function render($view, $params = [])
  {
    $data = array_merge($this->common_vars, $params);
    $data['statuses'] = Car::$statuses;
    
    return parent::render($view, $data);
  }
  
}

