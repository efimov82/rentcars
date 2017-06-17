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
     
    /*if (Yii::$app->session->has('lang')) {
        Yii::$app->language = Yii::$app->session->get('lang');
    } else {
        if (Yii::$app->request->post('new_lang') == 'ru') {
          Yii::$app->language = 'ru'; 
          Yii::$app->session->set('lang', 'ru');
        } else { 
          Yii::$app->language = 'en'; 
        }
    }*/
    
    $menu = array();
    //$this->common_vars['main_menu'] = $menu;
    
    if (Yii::$app->user->can('admin')){

      $menu['new'] = ['name'=>'New','href'=>'', 'class'=>'glyphicon glyphicon-plus',

                          'items'=>[1=>['name'=>'Contract', 'href'=>'/contracts/add'],
                                    2=>['name'=>'Payment',  'href'=>'/payments/add'],
                                    3=>['name'=>'Car',      'href'=>'/cars/add'],
                                    4=>['name'=>'Cusromer', 'href'=>'/customers/add'],
                                   ]
                      ];
      $menu['view'] = ['name'=>'Data', 'href'=>'', 'class'=>'glyphicon glyphicon-inbox',
                          'items'=>[0=>['name'=>'Contracts',  'href'=>'/contracts'],
                                    1=>['name'=>'Payments',   'href'=>'/payments'],
                                    2=>['name'=>'Cars',       'href'=>'/cars'],
                                    3=>['name'=>'Customers',  'href'=>'/customers'],
                                    4=>['name'=>'Managers',      'href'=>'/users']]
                      ];
      $menu['statistic'] = ['name'=>'Statistic', 'href'=>'/', 'class'=>'glyphicon glyphicon-signal',
                            'items'=>[0=>['name'=>'Reports',    'href'=>'/reports'],
                                      1=>['name'=>'Cars usage', 'href'=>'/cars-usage'],
                                     ]
                           ];
      $menu['settings'] = ['name'=>'Settings', 
                           'href'=>'/settings',
                           'class'=>'glyphicon glyphicon-cog',
                           'items'=>[]];
      
    } elseif (Yii::$app->user->can('manager')) {
      $menu['cars'] = ['name'=>'Cars', 'href'=>'/cars', 'class'=>'', 'items'=>[]];
      $menu['reports'] = ['name'=>'Reports', 'class'=>'fa fa-table', 'href'=>'reports', 'items'=>[]];
    } elseif (Yii::$app->user->can('cars_owner')) {
      $menu['cars'] = ['name'=>'My cars', 'href'=>'/cars', 'class'=>'', 'items'=>[]];
    }
    
    if (!Yii::$app->user->isGuest){
      $menu['logout'] = ['name'=>Yii::$app->user->identity->name, 
                         'class'=>'glyphicon glyphicon-new-window', 
                         'href'=>'/site/logout', 
                         'items'=>[]];
    }
    
    $this->common_vars['main_menu'] = $menu;
    
    return true;
  }
  
  public function render($view, $params = [])
  {
    $data = array_merge($this->common_vars, $params);
    $data['statuses'] = Car::$statuses;
    
    return parent::render($view, $data);
  }
  
}

