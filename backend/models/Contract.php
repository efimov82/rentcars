<?php

namespace backend\models;

use Yii;
use yii\db\ActiveRecord;

class Contract extends ActiveRecord
{
  /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'contracts';
    }
}