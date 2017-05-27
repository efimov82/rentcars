<?php
namespace backend\controllers;

use Yii;
use yii\web\Controller;


use backend\models\Car;
use backend\models\Payment;

/**
 * Chart controller
 */
class ChartController extends RentCarsController {
  
  public function actionIndex(){
    
    return $this->render('index.tpl');
  }
  
  public function actionDates() {
    $d1 = new \DateTime('2017-05-01');
    $d2 = new \DateTime('2017-06-01');
    
    $c1 = new \DateTime('2017-04-25');
    $c2 = new \DateTime('2017-05-14');
    
    $diff = (int)$d1->diff($c1)->format('%R%a');
    echo("diff=".$diff);
  }
}