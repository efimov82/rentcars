<?php

namespace backend\models;

use yii\db\ActiveRecord;

class Payment extends ActiveRecord
{
  const STATUS_NEW        = 1;
  const STATUS_CONFIRMED  = 2;
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'payments';
    }
    
    /**
     * @return Car model find by car_id
     */
    public function getCar()
    {
      $car = Car::findOne(['id'=>$this->car_id]);
      if (!$car)
        $car = new Car();
      
      return $car;
    }
    
    public function getListStatuses()
    {
      return [self::STATUS_NEW=>'New', self::STATUS_CONFIRMED=>'Confirmed'];
    }
    
    public function getStatusName()
    {
      if ($this->status == self::STATUS_NEW)
      {
        return 'New';
      }
      else 
      {
        return 'Confirmed';
      }
    }
}