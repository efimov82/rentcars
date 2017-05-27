<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class User extends ActiveRecord
{
   const   ROLE_ADMIN       = 1;
   const   ROLE_MANAGER     = 2;
   const   ROLE_CARS_OWNER  = 3;
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'user';
    }
}