<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Client extends ActiveRecord
{
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'clients';
    }
}