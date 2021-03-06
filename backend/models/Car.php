<?php
namespace backend\models;

use yii\db\ActiveRecord;
use \backend\models\Payment;

class Car extends ActiveRecord{
  const   STATUS_AVAILABLE  = 1;
  const   STATUS_LEASED     = 2;
  const   STATUS_BOOKED     = 3;
  const   STATUS_REPAIR     = 4;
  const   STATUS_UNAVAILABLE = 5;
  const   STATUS_DELETED     = 10;
  
  public static  $statuses = [1=>'available', 2=>'leased', 3=>'booked', 4=>'under repair', 5=>'unavailable'];
  
  /**
    * @inheritdoc
    */
   public static function tableName(){
       return 'cars';
   }

   public function getStatusName(){
     if (isset(self::$statuses[$this->status]))
       return self::$statuses[$this->status];
     else
       return 'unknown';
   }

   /**
    * Find last payment type 'Pay car owner' (id=1)
    * @return Payment
    */
   public function getLastRentPayment(){
     $payment = Payment::findOne(['id'=>$this->last_payment_id]);
     return $payment;
   }
}