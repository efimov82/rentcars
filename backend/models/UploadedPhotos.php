<?php

namespace backend\models;
use yii\base\Model;
 
class UploadedPhotos{
  protected $base_folder = '/web/files/';
  protected $folder = '';
  protected $arr_files = [];
  
  /**
   * 
   * @param string $folder_name - main folder with / on end
   * @param string $key - key files array in $_FILES array
   */
  public function __construct($folder_name, $key='files'){
    $this->folder = $folder_name;
    $files = $_FILES[$key];
    $count = count($files['name']);
    for($i=0; $i<$count; $i++){
      if (in_array($files['type'][$i], ['image/jpeg', 'image/png', 'image/jpg', 'image/bmp'])){
        $this->arr_files[] = ['name'=>$files['name'][$i],
                              'tmp_name'=>$files['tmp_name'][$i]
                             ];
      }
        
    }
    return count($this->arr_files);
  }
  
  /**
   * 
   * @param string $sub_folder
   * @return array names of saves files
   */
  public function save($sub_folder=''){
    $path = realpath(__DIR__ .'/../'. $this->base_folder . $this->folder).'/';
    if (!is_dir($path.$sub_folder)){
      mkdir($path.$sub_folder);
    }
    
    $num_file = 1; // TODO - find max num file in folder
    if (substr($sub_folder, -1) != '/')
      $sub_folder .= '/';
    
    $res = [];
    foreach($this->arr_files as $num=>$arr){
      $filename = $num_file . strtolower(substr($arr['name'], -4));
      copy($arr['tmp_name'], $path . $sub_folder . $filename);
      $res[] = $filename;
      $num_file++;
    }
    
    return $res;
  }
}
