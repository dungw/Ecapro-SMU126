<?php
/**
 * Created by PhpStorm.
 * User: JFog
 * Date: 6/20/15
 * Time: 1:02 AM
 */

namespace common\models;

use common\models\Station;

/**
 * Class Request
 */
class Request {

    /**
     * constructor function
     * @param $command
     */
    public function __construct($command)
    {
        $units = explode('&', $command);
        if (!empty($units)) {
            $this->setProperties($units);
        } else {
            $this->setError('Invalid data');
        }
    }

    /**
     * get properties
     * @return array
     */
    public function getProperties()
    {
        return [
            [
                'property'  => 'data',
                'order'     => '',
            ],
            [
                'property'  => 'id',
                'order'     => 0,
                'before'    => 'getStationID',
                'after'     => 'isValidID',
            ],
            [
                'property'  => 'name',
                'order'     => 1
            ],
            [
                'property'  => 'function',
                'order'     => 2,
            ],
            [
                'property'  => 'message',
                'order'     => 3,
            ],
            [
                'property'  => 'input_status',
                'order'     => 4,
            ],
            [
                'property'  => 'output_status',
                'order'     => 5,
            ],
            [
                'property'  => 'configure_status',
                'order'     => 6,
            ],
            [
                'property'  => 'temp',
                'order'     => 7,
            ],
            [
                'property'  => 'humi',
                'order'     => 8,
            ],
            [
                'property'  => 'power_voltage',
                'order'     => 9,
            ],
            [
                'property'  => 'power_capacity',
                'order'     => 10,
            ],
            [
                'property'  => 'power_consume',
                'order'     => 11,
            ],
            [
                'property'  => 'power_frequency',
                'order'     => 12,
            ],
            [
                'property'  => 'dc1_voltage',
                'order'     => 13,
            ],
            [
                'property'  => 'dc2_voltage',
                'order'     => 14,
            ],
            [
                'property'  => 'dc1_ampe',
                'order'     => 15,
            ],
            [
                'property'  => 'dc2_ampe',
                'order'     => 16,
            ],
        ];
    }

    /**
     * set properties
     * @param $units
     * @return $this
     */
    public function setProperties($units)
    {
        $properties = $this->getProperties();
        foreach ($properties as $item) {

            if ($item['order'] === '') {
                $value = implode('&', $units);
            } else if (isset($units[$item['order']])) {
                $value = $units[$item['order']];
            }

            //hook before function
            if (isset($item['before'])) {
                var_dump($value);
                $value = call_user_func($item['before'], $value);
                var_dump($value);
            }

            //set value
            $this->$item['property'] = $value;

            //hook after function
            if (isset($item['after'])) {
                call_user_func($item['after'], $value);
            }
        }

        return $this;
    }

    /**
     * convert myself to array
     * @return array
     */
    public function toArray()
    {
        return (array)$this;
    }

    /**
     * get station id by station code
     * @param $code
     * @return null
     */
    public function getStationID($code)
    {
        $station = Station::findOne(['code' => $code]);
        if ($station) return $station['id'];
        return null;
    }

    /**
     * check valid ID
     * @param $id
     * @return bool
     */
    public function isValidID($id)
    {
        $id = intval($id);
        if ($id <= 0) {
            $this->setError('Invalid ID');
            return false;
        }
        return true;
    }

    /**
     * set error message
     * @param $err
     * @return $this
     */
    public function setError($err)
    {
        $this->error = $err;
        return $this;
    }

    /**
     * get error message
     * @return mixed
     */
    public function getError()
    {
        return $this->error;
    }

}