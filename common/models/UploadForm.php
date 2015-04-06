<?php
namespace common\models;

use yii\base\Model;
use yii\web\UploadedFile;

class UploadForm extends Model {

    public $file;
    public $_type;
    public $_multiple;

    public function __construct($type = 'image', $multiple = false) {
        $this->_type = $type;
        $this->_multiple = $multiple;
    }

    public function rules() {
        $rules = array();
        $rules[] = ['file'];
        $rules[] = 'file';
        $rules['maxSize'] = 1024 * 1024 * 50;
        $rules['checkExtensionByMimeType'] = false;

        if ($this->_type == 'image') $rules['extensions'] = 'jpg, png, jpeg';
        if ($this->_multiple) $rules['maxFiles'] = 10;

        return [
            $rules,
        ];
    }

}