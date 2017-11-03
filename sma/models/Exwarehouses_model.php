<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Exwarehouses_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function insertBatch($data){
      if ($data) {
        foreach ($data as $exWare) {
          if ($this->db->insert("ex_warehouses", $exWare)) {
            $this->updateWareAvailable($exWare['item_id'], $exWare['ex_quantity']);
          }
        }
        return TRUE;
      }
      return FALSE;
    }

    public function updateWareAvailable($item_id, $ex_quantity){
      $this->db->where('item_id', $item_id);
      $this->db->where('warehouse_id', 1);
      $this->db->set('quantity', 'quantity-'.$ex_quantity, FALSE);
      $this->db->update('warehouses_products');
    }

}
