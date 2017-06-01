<?php
namespace backend\controllers;

use Yii;
use yii\filters\AccessControl;
use backend\controllers\RentCarsController;
use backend\models\User;

/**
 * Site controller
 */
class SettingsController extends RentCarsController{
  
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
     *
     * @return string
     */
  public function actionIndex()
  {
    $list_themes = [''   => 'default', 
                    'amelia'    => 'amelia', 
                    'cerulean'  => 'cerulean', 
                    'cosmo'     => 'cosmo', 
                    'flatly'    => 'flatly', 
                    'journal'   => 'journal', 
                    'readable'  => 'readable',
                    'simplex'   => 'simplex',
                    'slate'     => 'slate',
                    ];
    $message = Yii::$app->getSession()->getFlash('message');
    $current_theme = Yii::$app->user->identity->current_theme;
    return $this->render('index.tpl', ['themes'=>$list_themes, 'message'=>$message, 'current_theme'=>$current_theme]);
  }
  
  public function actionSave()
  {
    $theme = Yii::$app->getRequest()->post('theme');
    
    $user = Yii::$app->user->identity;
    $user->current_theme = $theme;
    $user->save();
    Yii::$app->getSession()->setFlash('message', 'Settings saved successfully.');
    return $this->redirect('/settings');
  }
}
