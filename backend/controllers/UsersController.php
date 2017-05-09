<?php
namespace backend\controllers;

use Yii;

use yii\filters\VerbFilter;
use yii\filters\AccessControl;
use common\models\LoginForm;

use backend\controllers\RentCarsController;

/**
 * Site controller
 */
class UsersController extends RentCarsController
{
  
  public  $title = 'Users';


  public function behaviors()
  {
      return [
          'access' => [
              'class' => AccessControl::className(),
              'rules' => [
                  /*[
                      'actions' => ['index','view'], // these action are accessible 
                                                     //only the yourRole1 and yourRole2
                      'allow' => true,
                      'roles' => ['yourRole1', 'yourRole2'],
                  ],*/
                  [    // all the action are accessible to superadmin, admin and manager
                      'allow' => true,  
                      'roles' => ['admin'],
                  ],   
//                   [
//                       'deny',
//                       'users'=>array('?'),
//                  ],
              ],
          ],        
          /*'verbs' => [
              'class' => VerbFilter::className(),
              'actions' => [
                  'delete' => ['post'],
              ],
          ],*/
      ];
  }
  

  

  /**
     * Displays homepage.
     *
     * @return string
     */
  public function actionIndex()
  {
    return $this->render('index.tpl', array( "title"=>"test222"));//'main_menu'=>$this->common_vars['main_menu'],
  }
  
  public function actionEdit()
  {
    //echo('id='.);
    return $this->render('edit.tpl');
  }
}
