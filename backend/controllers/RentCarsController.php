<?php

/* 
 * Общий класс для всех котроллеров
 * 
 */

namespace backend\controllers;

use Yii;
use yii\web\Controller;
use yii\helpers\Url;

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
     
    $menu = array();
    $this->common_vars['main_menu'] = $menu;
    
    //if (is_object(Yii::$app->user) || Yii::$app->user->isGuest )
    //  return Yii::$app->getResponse()->redirect(array(Url::to(['site/login'],302)));  

    
    if (Yii::$app->user->can('admin'))
    {
      $menu['new'] = ['name'=>'<b>NEW</b>','href'=>'', 'class'=>'fa fa-file-text',
                          'items'=>[1=>['name'=>'Contract', 'href'=>'/contracts/add'],
                                    2=>['name'=>'Payment',  'href'=>'/payments/add'],
                                    3=>['name'=>'Car',      'href'=>'/cars/add'],
                                    4=>['name'=>'Manager',  'href'=>'/managers/add']
                                   ]];
                                  //0=>['name'=>'Client', 'href'=>'/clients/add'],
      $menu['view'] = ['name'=>'Show', 'href'=>'', 'class'=>'',
                          'items'=>[0=>['name'=>'Contracts',  'href'=>'/contracts'],
                                    1=>['name'=>'Payments',   'href'=>'/payments'],
                                    2=>['name'=>'Cars',       'href'=>'/cars'],
                      ]];
                                
      //$menu['cars'] = array('name'=>'Cars', 'href'=>'/cars', 'class'=>'fa fa-car,', 'items'=>[]);
      //$menu['reports'] = array('name'=>'Reports', 'href'=>'/reports', 'class'=>'fa fa-table', 'items'=>[]);
      //$menu['contracts'] = ['name'=>'Contracts', 'href'=>'/contracts', 'class'=>'fa fa-file-text', 'items'=>[]];
    }
    elseif (Yii::$app->user->can('manager'))
    {
      $menu['cars'] = ['name'=>'Cars', 'href'=>'/cars', 'class'=>'fa fa-user', 'items'=>[]];
      $menu['reports'] = ['name'=>'Reports', 'class'=>'fa fa-table', 'href'=>'reports', 'items'=>[]];
      
    } 
    $menu['logout'] = array('name'=>'Logout ('.Yii::$app->user->identity->username.')', 'class'=>'fa-sign-out', 'href'=>'/site/logout', 'items'=>[]);
    
    $this->common_vars['main_menu'] = $menu;
    //$this->view->params['title'] = $this->title;
    //$this->main_menu = $menu;
    
    return true;
  }
  
  public function render($view, $params = [])
  {
    $params = array_merge($this->common_vars, $params);
    
    return parent::render($view, $params);
  }
  
}

