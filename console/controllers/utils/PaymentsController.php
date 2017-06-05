<?php

namespace console\controllers\utils;

use Yii;
use yii\console\Controller;
use backend\models\Payment;
use backend\models\PaymentMethod;
use backend\models\Car;

/**
 * Import payments -  php yii utils/payments/import
 */
class PaymentsController extends Controller {
  
  
  /**
   * format: 14.04.2017,1750,180,заправка,миша
   */
  public function actionImport(){
    
    $file = __DIR__.'/data/spending.csv';
    $f = fopen($file, 'r');
    while(!feof($f)){
      $str = fgets($f);
      $arr = $this->parseData($str);
      if ($arr){
        $this->save($arr);
      } else {
        echo("wrong: $str\n");
      }
    }
    fclose($f);
  }
  
  /**
   * 
   * @param string "14.04.2017,1750,180,заправка,миша"
   * @return array
 */
  protected function parseData($str) {
    $arr = explode(',', $str);
    if (count($arr) < 5)
      return false;
    
    if ($arr[0] && $arr[2] && $arr[3] ) {
      return ['date'      =>trim($arr[0]), 
              'car_number'=>trim($arr[1]),
              'sum'       =>trim($arr[2]),
              'comment'   =>trim($arr[3].",".$arr[4]),
            ];
    } else {
      return false;
    }
  }
  
  /**
   * @param array $data [date, car_number, sum, comment]
   */
  protected function save($data){
    $payment = new Payment();
    
    $payment->user_id     = 4; // Tim
    $payment->category_id = 6; // other
    $payment->method_id   = 1; // cash
    $payment->type_id     = 2; // -
    $payment->status      = Payment::STATUS_CONFIRMED; // -
    $payment->date        = date('Y-m-d', strtotime($data['date']));
    $payment->date_create = date('Y-m-d H:i:s', time());
    $payment->car_id      = $this->getCarId($data['car_number']);
    $payment->thb         = (int)$data['sum'];
    $payment->description = $data['comment'];
    
    //print_r($payment);
    $payment->save();
  }
    
  /**
   * 
   * @param
   * @return 
 */
  protected function getCarId($number) {
    $car = Car::findOne(['number'=>$number]);
    if ($car)
      return $car->id;
    else
      return 0;
    
  }
}