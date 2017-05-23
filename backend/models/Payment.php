<?php
namespace backend\models;

use yii\db\ActiveRecord;

class Payment extends ActiveRecord{
  const STATUS_NEW        = 1;
  const STATUS_CONFIRMED  = 2;
  const STATUS_DELETED    = 3;
  const STATUS_UNPAID     = 4;
  /**
     * @inheritdoc
     */
    public static function tableName(){
        return 'payments';
    }
    
    /**
     * @return Car model find by car_id
     */
    public function getCar(){
      $car = Car::findOne(['id'=>$this->car_id]);
      if (!$car)
        $car = new Car();
      
      return $car;
    }
    
    public static function getListStatuses($with_all = false){
      if ($with_all)
        return [0=>'ALL', self::STATUS_NEW=>'New', self::STATUS_CONFIRMED=>'Confirmed', self::STATUS_DELETED=>'Deleted', self::STATUS_UNPAID=>'Unpaid'];
      else
        return [self::STATUS_NEW=>'New', self::STATUS_CONFIRMED=>'Confirmed', self::STATUS_DELETED=>'Deleted', self::STATUS_UNPAID=>'Unpaid'];
    }
    
    public function getStatusName(){
      switch ($this->status){
        case self::STATUS_NEW:
          return 'New';
        case self::STATUS_CONFIRMED:
          return 'Confirmed';
        case self::STATUS_UNPAID:
          return 'Unpaid';
        default:
          return 'Unknown';
      }
    }
    
    public function beforeSave($insert){
      if ($this->type_id == PaymentType::OUTGOING) $s = -1;
      else $s = 1;
        
      $this->usd    = $s * abs($this->usd);
      $this->euro   = $s * abs($this->euro);
      $this->thb    = $s * abs($this->thb);
      $this->ruble  = $s * abs($this->ruble);
      
      return parent::beforeSave($insert);
    }
}