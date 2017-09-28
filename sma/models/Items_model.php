<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Items_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function addItem($data,$warehouse_qty)
    {
        unset($data['add']);
        if ($this->db->insert("items", $data)) {
            $item_id=$this->db->insert_id();

            if ($warehouse_qty && !empty($warehouse_qty)) {

                foreach ($warehouse_qty as $wh_qty) {
                    if (isset($wh_qty['quantity']) && ! empty($wh_qty['quantity'])) {

                        $this->db->insert('warehouses_products', array('item_id' => $item_id, 'warehouse_id' => $wh_qty['warehouse_id'], 'quantity' => $wh_qty['quantity'], 'rack' => $wh_qty['rack']));

                        if (!$product_attributes) {                            
                            $tax_rate_id = $tax_rate ? $tax_rate->id : NULL;
                            $tax = $tax_rate ? (($tax_rate->type == 1) ? $tax_rate->rate . "%" : $tax_rate->rate) : NULL;
                            $unit_cost = $data['cost'];
                            if ($tax_rate) {
                                if ($tax_rate->type == 1 && $tax_rate->rate != 0) {
                                    if ($data['tax_method'] == '0') {
                                        $pr_tax_val = ($data['cost'] * $tax_rate->rate) / (100 + $tax_rate->rate);
                                        $net_item_cost = $data['cost'] - $pr_tax_val;
                                        $item_tax = $pr_tax_val * $wh_qty['quantity'];
                                    } else {
                                        $net_item_cost = $data['cost'];
                                        $pr_tax_val = ($data['cost'] * $tax_rate->rate) / 100;
                                        $unit_cost = $data['cost'] + $pr_tax_val;
                                        $item_tax = $pr_tax_val * $wh_qty['quantity'];
                                    }
                                } else {
                                    $net_item_cost = $data['cost'];
                                    $item_tax = $tax_rate->rate;
                                }
                            } else {
                                $net_item_cost = $data['cost'];
                                $item_tax = 0;
                            }

                            $subtotal = (($net_item_cost * $wh_qty['quantity']) + $item_tax);

                            $item = array(
                                'item_id' => $item_id,
                                'product_code' => $data['code'],
                                'product_name' => $data['item'],
                                'net_unit_cost' => $net_item_cost,
                                'unit_cost' => $unit_cost,
                                'quantity' => $wh_qty['quantity'],
                                'quantity_balance' => $wh_qty['quantity'],
                                'item_tax' => $item_tax,
                                'tax_rate_id' => $tax_rate_id,
                                'tax' => $tax,
                                'subtotal' => $subtotal,
                                'warehouse_id' => $wh_qty['warehouse_id'],
                                'date' => date('Y-m-d'),
                                'status' => 'received',
                            );
                         
                            $this->db->insert('purchase_items', $item);
                           
                            $this->site->syncProductQty(NULL, $wh_qty['warehouse_id'],$item_id);
                        }
                    }
                }
            }
            return true;
        }
        return false;
    }

    public function updateItem($id, $data = array(),$warehouse_qty)
    {
       
        unset($data['edit']);
        $this->db->where('id', $id);
        if ($this->db->update("items", $data)) {
            if ($warehouse_qty && !empty($warehouse_qty)) {

                foreach ($warehouse_qty as $wh_qty) {
                    if($this->db->update('warehouses_products', array('rack' => $wh_qty['rack'],'quantity'=>$wh_qty['quantity']), array('item_id' => $id, 'warehouse_id' => $wh_qty['warehouse_id'])))
                    {

                        // $items=$this->site->getPurchasedItems(null,$wh_qty['warehouse_id'],null,$id);                     


                    }
                }
            }
            return true;
        }
        return false;
    }

    public function deleteItem($id)
    {
        if ($this->db->delete("items", array('id' => $id)) && $this->db->delete('warehouses_products', array('item_id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function getAllWarehousesWithIQ($item_id)
    {
        $this->db->select('' . $this->db->dbprefix('warehouses') . '.*, ' . $this->db->dbprefix('warehouses_products') . '.quantity, ' . $this->db->dbprefix('warehouses_products') . '.rack')
            ->join('warehouses_products', 'warehouses_products.warehouse_id=warehouses.id', 'left')
            ->where('warehouses_products.item_id', $item_id)
            ->group_by('warehouses.id');
        $q = $this->db->get('warehouses');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getItemByID($id)
    {
        $q = $this->db->get_where("items", array('id' => $id),1);
        if ($q->num_rows() > 0) {

            return $q->row();
        }

        return FALSE;
    }
    public function getAllItems()
    {
        $q = $this->db->get("items");
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
}
