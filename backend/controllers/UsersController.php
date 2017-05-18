<?php
namespace backend\controllers;

use yii\filters\AccessControl;
use backend\controllers\RentCarsController;
use backend\models\User;

/**
 * Site controller
 */
class UsersController extends RentCarsController{
  
  public  $title = 'Users';


  public function behaviors()
  {
      return [
          'access' => [
              'class' => AccessControl::className(),
              'rules' => [
                  [    // all the action are accessible to superadmin, admin and manager
                      'allow' => true,  
                      'roles' => ['admin'],
                  ],   
              ],
          ],        
      ];
  }
  

  

  /**
     * Displays homepage.
     *
     * @return string
     */
  public function actionIndex()
  {
    $users = User::find()->all();
    return $this->render('index.tpl', ['users'=>$users]);
  }
  
  public function actionEdit()
  {
    return $this->render('edit.tpl');
  }
}
