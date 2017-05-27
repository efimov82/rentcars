<?php

namespace console\controllers\utils;

use Yii;
use yii\console\Controller;
use backend\models\Car;
use backend\models\User;
use backend\models\Payment;
use backend\models\PaymentType;

/**
 * Import cars -  php yii cars/import
 */
class CarsController extends Controller {
  
  protected $models = ['Toyota'=>['Vios', 'Altis', 'Fortuner', 'Innova', 'Yaris'],
                      'Suzuki'=>['Swift', 'Dreza'],
                      'Isusu'=>['MU5', 'MU7', 'MUX'],
                      'Honda'=>['City', 'Civic', 'Accord', 'HRV', 'Jazz'],
                      'Mitsubishi'=>['Pajero Sport'],
                      'Chevrolet'=>['Captiva'],
                      'Ford'=>['Fiesta'],
                      'BMW'=>['320I'],
                      'Nissan'=>['Almera']
      
                      ];
  
  protected $colors = ['Black', 'White', 'Grey', 'Red', 'Brown', 'Gold', 'Dark'];
  
  public function actionImport() {
    die(); // make already
    
    $file = __DIR__.'/cars_list.txt';
    $f = fopen($file, 'r');
    while(!feof($f)){
      $str = fgets($f);
      $arr = $this->parseData($str);
      if ($arr){
        $car = new Car();
        $car->setAttributes($arr, false);
        $car->save();
      } else {
        echo("wrong: $str");
      }
      
    }
    
    fclose($f);
  }
  
  /**
   * Import payments to Owners + new Owners and link Car - Owner
   */
  public function actionImportBills() {
    $file = __DIR__.'/data/cars_bills.csv';
    $f = fopen($file, 'r');
    while(!feof($f)){
      $str = fgets($f);
      $arr = $this->parseBillData($str);
      if ($arr){
        $car = $this->_findCar($arr['car']);
        if (!$car) {
          echo("car not found: ".$str."\n");
          continue;
        }
        
        if (!$this->_updateCar($car, $arr['owner'])) {
          echo("wrong update car id=".$car->id." str=$str \n");
          
        }
        
        if (!$this->_createPayment($car, $arr)) {
          echo("wrong save payment: str=$str \n");
        }
        
      } else {
        echo("wrong: $str");
      }
    }
    
    fclose($f);
  }
  
  /**
   * 
   * @param string "Toyota Vios New Red #1399"
   * @return Car | null
 */
  protected function _findCar($number) {
    $res = preg_match('/(\d{3,4})/', $number, $matches);
    if (isset($matches[1])) {
      $car = Car::findOne(['number'=>$matches[1]]);
      return $car;
    }
  }
  
  /**
   * 
   * @param Car $car
   * @param string $owner_name
   * @return bool
 */
  protected function _updateCar($car, $owner_name) {
    if (!$owner_name)
      return true;
    
    if ((int)$owner_name > 0)
      $owner_name = 'CarsToRent_CO';
    
    $owner = User::findOne(['name'=>$owner_name]);
    if (!$owner) {
      $owner = new User();
      $owner->name = $owner_name;
      $owner->username = $owner_name;
      $owner->email = $owner_name."@mail.ru";
      $owner->type_id = User::ROLE_CARS_OWNER;
      $owner->save();
    }
    
    $car->owner_id = $owner->id;
    $car->save();
      
    return true;
  }
  
  /**
   * 
   * @param Car $car
   * @param array $data [date_start, date_stop, thb]
   * @return bool
 */
  protected function _createPayment($car, $data) {
    // save payment
      $user_id = 4;
      if (!$data['date_start'] && !$data{'date_stop'})
        return;
      
      if ($data['date_stop'])
        $stop = strtotime($data['date_stop']);
      else
        $stop = strtotime('1970-01-01');
      
      
      $payment = new Payment(['car_id'      => $car->id, 
                              'user_id'     => $user_id,
                              'creator_id'  => $user_id,
                              'category_id' => 1, // Pay rent car owner
                              'type_id'     => PaymentType::OUTGOING,
                              'date'        => date('Y-m-d', strtotime($data['date_start'])),
                              'date_stop'   => date('Y-m-d', $stop),
                              'date_create' => date('Y-m-d H:i:s', time()),
                              'thb'       => (int)$data['price'],
                              'status'      => Payment::STATUS_CONFIRMED]
                            );
      $payment->save();
      
      // update Car record
      $car->last_payment_id = $payment->id;
      $car->save();
      return true;
  }
  
  /**
   * 
   * @param str [Ma;Honda City #3555;09.12.2016;05.12.2016;12200]
   * @return array[owner, car, date_start, date_stop, thb]
 */
  protected function parseBillData($str) {
    if ($str == ';;;;')
      return null;
    
    $arr =  explode(';', $str);
    $res['owner'] = trim($arr[0]);
    $res['car'] = trim($arr[1]);
    $res['date_start'] = trim($arr[2]);
    $res['date_stop'] = trim($arr[3]);
    $res['price'] = (int)trim($arr[4]);
    return $res;
  }
  
  /**
   * 
   * @param string $str [112,0,,Almera White,6127,,]
   */
  protected function parseData($str){
    $arr = explode(',', $str);
    if (!isset($arr[3]))
      return false;
    
    $name = trim($arr[3]);
    // find Model and try detect Mark
    $car_data = [];
    foreach($this->models as $mark=>$models){
      foreach ($models as $model){
        if (strpos(strtolower($name), strtolower($model)) !== false){
          $car_data['mark'] = $mark;
          $car_data['model'] = ucfirst(strtolower($model));
          break;
        }
      }
    }
    if (!$car_data)
      return null;
    
    // find color
    foreach($this->colors as $color){
      if (strpos(strtolower($name), strtolower($color)) !== false){
        $car_data['color'] = $color;
        break;
      }
    }
    $car_data['number'] = (int)$arr[4];
    
    return $car_data;
  }
    
  
}