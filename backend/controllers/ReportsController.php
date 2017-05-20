<?php
namespace backend\controllers;

use yii\filters\AccessControl;
use common\models\LoginForm;
use backend\controllers\RentCarsController;


class ReportsController extends RentCarsController{
  public function behaviors(){
    return [
        'access' => [
            'class' => AccessControl::className(),
            'rules' => [
                [    // all the action are accessible to superadmin, admin and manager
                    'allow' => true,  
                    'roles' => ['admin', 'manager'],
                ],   
              ],
          ],        
  
      ];
  }
    /**
     * @inheritdoc
     */
    /*public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
        ];
    }*/

    /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
      $params = $this->getSearchParams();
      return $this->render('index.tpl', $params);
    }
    
    protected function getSearchParams(){
      return ['search'=>[]];
    }

    
}
