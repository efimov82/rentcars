<?php

namespace console\controllers;

use yii\console\Controller;
use \common\models\User;
/**
 * Create users -  php yii users/create
 */
class UsersController extends Controller {
  
  public function actionCreate() {
    //die();
    
    $user = new User();
    $user->username = 'dan82';
    $user->setPassword('qwe123');
    $user->name = 'Creator';
    $user->email = 'efimov82@gmail.com';
    
    $user->generateAuthKey();
    if ($user->save()) {
        echo 'user create!';
    }
  }
  
  public function actionCreateManager() {
    $data = [4=>['name'=>'Tim', 'username'=>'tim', 'password'=>'tim', 'email'=>'tim@gmail.com'],
             5=>['name'=>'Bagrat', 'username'=>'bagrat', 'password'=>'bagrat', 'email'=>'bagrat@gmail.com'],
             6=>['name'=>'Dmitry', 'username'=>'dmitry', 'password'=>'dmitry', 'email'=>'dmitry@gmail.com'],
             7=>['name'=>'Polly', 'username'=>'polly', 'password'=>'polly', 'email'=>'polly@gmail.com']
            ];
    foreach($data as $id=>$arr){
      $user = new User();
      $user->id = $id;
      $user->name = $arr['name'];
      $user->username = $arr['username'];
      $user->email = $arr['email'];
      $user->setPassword($arr['password']);
      $user->generateAuthKey();
      $user->save();
    }
  }
  
}