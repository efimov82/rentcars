<?php

namespace console\controllers;

use yii\console\Controller;
use \common\models\User;
/**
 * Create users -  php yii users/create
 */
class UsersController extends Controller {
  
  public function actionCreate() {
    $user = new User();
    $user->username = 'manager';
    $user->email = 'manager@mail';
    $user->setPassword('manager');
    $user->generateAuthKey();
    if ($user->save()) {
        echo 'user create!';
    }
  }
  
}