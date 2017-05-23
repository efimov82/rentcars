<?php

namespace console\controllers\utils;

use Yii;
use yii\console\Controller;
use backend\models\Car;

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