<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Productions_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function getProductNames($term, $warehouse_id, $limit = 5)
    {
        $this->db->select('products.id, code, name, type, warehouses_products.quantity, price, tax_rate, tax_method')
            ->join('warehouses_products', 'warehouses_products.product_id=products.id', 'left')
            ->group_by('products.id');
        if ($this->Settings->overselling) {
            $this->db->where("(name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR  concat(name, ' (', code, ')') LIKE '%" . $term . "%')");
        } else {
            $this->db->where("(products.track_quantity = 0 OR warehouses_products.quantity > 0) AND warehouses_products.warehouse_id = '" . $warehouse_id . "' AND "
                . "(name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR  concat(name, ' (', code, ')') LIKE '%" . $term . "%')");
        }
        $this->db->limit($limit);
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

     public function getAllInvoiceItemsC($sale_id)
    {
        $this->db->select('sma_products.category_id,sma_categories.name')
            ->join('products', 'products.id=production_items.product_id', 'left')
            ->join('sma_categories', 'sma_categories.id=sma_products.category_id', 'left')
            ->group_by('sma_products.category_id');

        $q = $this->db->get_where('production_items', array('sale_id' => $sale_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getAllInvoiceItems1($sale_id,$cate_id)
    {
        $this->db->select('production_items.*, tax_rates.code as tax_code, tax_rates.name as tax_name, tax_rates.rate as tax_rate, products.unit, products.details as details,cf1,cf2,cf3,cf4,cf6,cf7, product_variants.name as variant,quantity_config')
            ->join('products', 'products.id=production_items.product_id', 'left')
            ->join('product_variants', 'product_variants.id=production_items.option_id', 'left')
            ->join('tax_rates', 'tax_rates.id=production_items.tax_rate_id', 'left')
            ->join('sma_categories', 'sma_categories.id=sma_products.category_id', 'left')
            ->group_by('production_items.id')
            ->order_by('id', 'asc');
        $q = $this->db->get_where('production_items', array('sale_id' => $sale_id,'sma_products.category_id'=>$cate_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getQProduction($production_id,$product_id){

        $q = $this->db->get_where('production_items', array('sale_id'=>$production_id,'product_id' => $product_id),1);
        if ($q->num_rows() > 0) {

            return $q->row();

        }
        return FALSE;
    }

    public function getProductNames1($term, $limit = 5)
    {

        $this->db->select('products.id, code, name, type, price, tax_rate, tax_method, quantity_config, cf2')
            ->join('warehouses_products', 'warehouses_products.product_id=products.id', 'left')
            ->group_by('products.id');
        if ($this->Settings->overselling) {
            $this->db->where("(name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR  concat(name, ' (', code, ')') LIKE '%" . $term . "%')");
        } else {
            $this->db->where("(name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR  concat(name, ' (', code, ')') LIKE '%" . $term . "%')");
        }
        $this->db->limit($limit);
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }


    public function getProductNames2($cate_id)
    {

        $this->db->select('products.id, code, name, type, price, tax_rate, tax_method, quantity_config, cf2')
            ->join('warehouses_products', 'warehouses_products.product_id=products.id', 'left')
            ->group_by('products.id');
        // if ($this->Settings->overselling) {
        //     $this->db->where("(name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR  concat(name, ' (', code, ')') LIKE '%" . $term . "%')");
        // } else {
        //     $this->db->where("(name LIKE '%" . $term . "%' OR code LIKE '%" . $term . "%' OR  concat(name, ' (', code, ')') LIKE '%" . $term . "%')");
        // }
        $this->db->where('category_id', $cate_id);
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getProductComboItems($pid, $warehouse_id = NULL)
    {
        $this->db->select('products.id as id, combo_items.item_code as code, combo_items.quantity as qty, products.name as name, warehouses_products.quantity as quantity')
            ->join('products', 'products.code=combo_items.item_code', 'left')
            ->join('warehouses_products', 'warehouses_products.product_id=products.id', 'left')
            ->group_by('combo_items.id');
        if($warehouse_id) {
            $this->db->where('warehouses_products.warehouse_id', $warehouse_id);
        }
        $q = $this->db->get_where('combo_items', array('combo_items.product_id' => $pid));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
        return FALSE;
    }

    public function getProductByCode($code)
    {
        $q = $this->db->get_where('products', array('code' => $code), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function syncQuantity($sale_id)
    {
        if ($sale_items = $this->getAllInvoiceItems($sale_id)) {
            foreach ($sale_items as $item) {
                $this->site->syncProductQty($item->product_id, $item->warehouse_id);
                if (isset($item->option_id) && !empty($item->option_id)) {
                    $this->site->syncVariantQty($item->option_id, $item->warehouse_id);
                }
            }
        }
    }

    public function getProductQuantity($product_id, $warehouse)
    {
        $q = $this->db->get_where('warehouses_products', array('product_id' => $product_id, 'warehouse_id' => $warehouse), 1);
        if ($q->num_rows() > 0) {
            return $q->row_array(); //$q->row();
        }
        return FALSE;
    }

    public function getProductOptions($product_id, $warehouse_id, $all = NULL)
    {
        $this->db->select('product_variants.id as id, product_variants.name as name, product_variants.price as price, product_variants.quantity as total_quantity, warehouses_products_variants.quantity as quantity')
            ->join('warehouses_products_variants', 'warehouses_products_variants.option_id=product_variants.id', 'left')
            //->join('warehouses', 'warehouses.id=product_variants.warehouse_id', 'left')
            ->where('product_variants.product_id', $product_id)
            ->where('warehouses_products_variants.warehouse_id', $warehouse_id)
            ->group_by('product_variants.id');
            if( ! $this->Settings->overselling && ! $all) {
                $this->db->where('warehouses_products_variants.quantity >', 0);
            }
        $q = $this->db->get('product_variants');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getProductVariants($product_id)
    {
        $q = $this->db->get_where('product_variants', array('product_id' => $product_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getItemNameByID($id)
    {

        $q = $this->db->get_where("items", array('id' => $id),1);
        if ($q->num_rows() > 0) {

            return $q->row();
        }

        return FALSE;
    }

    public function getItemByID($id)
    {

        $q = $this->db->get_where('sale_items', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }

        return FALSE;
    }

    public function getProductionItem($id,$product_id)
    {

        $q = $this->db->get_where('production_items', array('sale_id'=>$id,'product_id'=>$product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }

        return FALSE;
    }

    public function getAllInvoiceItems($sale_id)
    {
        $this->db->select('production_items.*, tax_rates.code as tax_code, tax_rates.name as tax_name, tax_rates.rate as tax_rate, products.unit, products.details as details, product_variants.name as variant,cf2, quantity_config')
            ->join('products', 'products.id=production_items.product_id', 'left')
            ->join('product_variants', 'product_variants.id=production_items.option_id', 'left')
            ->join('tax_rates', 'tax_rates.id=production_items.tax_rate_id', 'left')
            ->group_by('production_items.id')
            ->order_by('id', 'asc');
        $q = $this->db->get_where('production_items', array('sale_id' => $sale_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getAllInvoiceItemsUnCompleted($sale_id)
    {
        $this->db->select('production_items.*, tax_rates.code as tax_code, tax_rates.name as tax_name, tax_rates.rate as tax_rate, products.unit, products.details as details, product_variants.name as variant,cf2, quantity_config')
            ->join('products', 'products.id=production_items.product_id', 'left')
            ->join('product_variants', 'product_variants.id=production_items.option_id', 'left')
            ->join('tax_rates', 'tax_rates.id=production_items.tax_rate_id', 'left')
            ->group_by('production_items.id')
            ->order_by('id', 'asc')
            ->where('status !=', 'completed');
        $q = $this->db->get_where('production_items', array('sale_id' => $sale_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }


    public function getAllReturnItems($return_id)
    {
        $this->db->select('return_items.*, products.details as details, product_variants.name as variant')
            ->join('products', 'products.id=return_items.product_id', 'left')
            ->join('product_variants', 'product_variants.id=return_items.option_id', 'left')
            ->group_by('return_items.id')
            ->order_by('id', 'asc');
        $q = $this->db->get_where('return_items', array('return_id' => $return_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getAllInvoiceItemsWithDetails($sale_id)
    {
        $this->db->select('sale_items.id, sale_items.product_name, sale_items.product_code, sale_items.quantity, sale_items.serial_no, sale_items.tax, sale_items.net_unit_price, sale_items.item_tax, sale_items.item_discount, sale_items.subtotal, products.details');
        $this->db->join('products', 'products.id=sale_items.product_id', 'left');
        $this->db->order_by('id', 'asc');
        $q = $this->db->get_where('sale_items', array('sale_id' => $sale_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getInvoiceByID($id)
    {
        $q = $this->db->get_where('productions', array('id' => $id), 1);

        if ($q->num_rows() > 0) {
            $result=$q->row();
            if($result)
            {
                $result->deliveries=$this->getAllDeliveries($id);
            }
            return $result;
        }
        return FALSE;
    }

    public function getAllDeliveries($id)
    {
        $this->db->order_by('delivery_date_start asc');
        $q = $this->db->get_where('production_deliveries', array('production_id' => $id));

        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getProcess($product_id,$productions_id){

        $this->db->select('quantity');
        $this->db->where('product_id', $product_id)->where('production_id', $productions_id)->where('stage_status','completed') ;
        $this->db->order_by('date_end DESC');

        $q = $this->db->get('production_stages');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getReturnByID($id)
    {
        $q = $this->db->get_where('return_sales', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getReturnBySID($sale_id)
    {
        $q = $this->db->get_where('return_sales', array('sale_id' => $sale_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getProductOptionByID($id)
    {
        $q = $this->db->get_where('product_variants', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getPurchasedItems($product_id, $warehouse_id, $option_id = NULL)
    {
        $orderby = ($this->Settings->accounting_method == 1) ? 'asc' : 'desc';
        $this->db->select('id, quantity, quantity_balance, net_unit_cost, item_tax');
        $this->db->where('product_id', $product_id)->where('warehouse_id', $warehouse_id)->where('quantity_balance !=', 0);
        if ($option_id) {
            $this->db->where('option_id', $option_id);
        }
        $this->db->group_by('id');
        $this->db->order_by('date', $orderby);
        $this->db->order_by('purchase_id', $orderby);
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function updateOptionQuantity($option_id, $quantity)
    {
        if ($option = $this->getProductOptionByID($option_id)) {
            $nq = $option->quantity - $quantity;
            if ($this->db->update('product_variants', array('quantity' => $nq), array('id' => $option_id))) {
                return TRUE;
            }
        }
        return FALSE;
    }

    public function addOptionQuantity($option_id, $quantity)
    {
        if ($option = $this->getProductOptionByID($option_id)) {
            $nq = $option->quantity + $quantity;
            if ($this->db->update('product_variants', array('quantity' => $nq), array('id' => $option_id))) {
                return TRUE;
            }
        }
        return FALSE;
    }

    public function getProductWarehouseOptionQty($option_id, $warehouse_id)
    {
        $q = $this->db->get_where('warehouses_products_variants', array('option_id' => $option_id, 'warehouse_id' => $warehouse_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function updateProductOptionQuantity($option_id, $warehouse_id, $quantity, $product_id)
    {
        if ($option = $this->getProductWarehouseOptionQty($option_id, $warehouse_id)) {
            $nq = $option->quantity - $quantity;
            if ($this->db->update('warehouses_products_variants', array('quantity' => $nq), array('option_id' => $option_id, 'warehouse_id' => $warehouse_id))) {
                $this->site->syncVariantQty($option_id, $warehouse_id);
                return TRUE;
            }
        } else {
            $nq = 0 - $quantity;
            if ($this->db->insert('warehouses_products_variants', array('option_id' => $option_id, 'product_id' => $product_id, 'warehouse_id' => $warehouse_id, 'quantity' => $nq))) {
                $this->site->syncVariantQty($option_id, $warehouse_id);
                return TRUE;
            }
        }
        return FALSE;
    }


    public function setDelivery($production_id,$arrDeliveries)
    {
        // var_dump($arrDeliveries);die();
        if(isset($arrDeliveries['date']))
        {
            $count=0;
            $arrID=array();

            foreach ($arrDeliveries['date'] as $key => $value) {
                $arr=array(
                    'production_id'=>$production_id,
                    'delivery_date_start'=>($arrDeliveries['mode']==1)? $value['start'] : $this->sma->fsd($value['start']),
                    'delivery_date_end'=>($arrDeliveries['mode']==1)? $value['end'] : $this->sma->fsd($value['end']),
                    'delivery_percent'=>$value['percent']
                    );
                if(isset($value['id']))
                {
                    $arrID[]=$value['id'];
                    $this->db->update('production_deliveries',$arr,array('id'=>$value['id']));
                    $count++;
                }
                else
                {
                    $this->db->insert('production_deliveries',$arr);
                    $arrID[]=$this->db->insert_id();
                    $count++;
                }

            }
            $this->db->where('production_id', $production_id);
            $this->db->where_not_in('id',$arrID);
            $this->db->delete('production_deliveries');
            if($count)
                return true;
        }
        if(!isset($arrDeliveries['mode']))
        {
            //TH chuyen tu Giao 1 sang Giao nhieu
            $this->db->delete('production_deliveries',array('production_id'=>$production_id));
            $this->db->delete('production_stages',array('production_id'=>$production_id,'delivery_time'=>0));
        }
        return false;
    }


    public function setDeliveryEdit($production_id,$arrDeliveries)
    {
        // var_dump($arrDeliveries);die();
        if(isset($arrDeliveries['date']))
        {
            $count=0;
            $arrID=array();
            if ($arrDeliveries['mode']==1) {
                $this->db->where('production_id', $id);
                $this->db->update('production_deliveries',$arr);
                return true;
            }else{
                foreach ($arrDeliveries['date'] as $key => $value) {
                    $arr=array(
                        'production_id'=>$production_id,
                        'delivery_date_start'=>($arrDeliveries['mode']==1)? $value['start'] : $this->sma->fsd($value['start']),
                        'delivery_date_end'=>($arrDeliveries['mode']==1)? $value['end'] : $this->sma->fsd($value['end']),
                        'delivery_percent'=>$value['percent']
                        );
                    if(isset($value['id']))
                    {
                        $arrID[]=$value['id'];
                        $this->db->update('production_deliveries',$arr,array('id'=>$value['id']));
                        $count++;
                    }
                    else
                    {
                        $this->db->insert('production_deliveries',$arr);
                        $arrID[]=$this->db->insert_id();
                        $count++;
                    }

                }
                $this->db->where('production_id', $production_id);
                $this->db->where_not_in('id',$arrID);
                $this->db->delete('production_deliveries');
                if($count)
                    return true;
            }

        }
        if(!isset($arrDeliveries['mode']))
        {
            //TH chuyen tu Giao 1 sang Giao nhieu
            $this->db->delete('production_deliveries',array('production_id'=>$production_id));
            $this->db->delete('production_stages',array('production_id'=>$production_id,'delivery_time'=>0));
        }
        return false;
    }


    public function addProduction($data = array(), $items = array(), $payment = array(),$arrDeliveries)
    {

        // echo "<pre>";
        // print_r($data);
        // echo "</pre>";die();
        // if ($item['employees']) {
        //     print_r('aaaaa');
        // }else{
        //     print_r('bbbbb');
        // }

        $cost = $this->site->costing($items);
        if ($this->db->insert('productions', $data)) {

            $sale_id = $this->db->insert_id();
            $this->setDelivery($sale_id,$arrDeliveries);

            if ($this->site->getReference('prod') == $data['reference_no']) {
                $this->site->updateReference('prod');
            }
            foreach ($items as $item) {
                $item['sale_id'] = $sale_id;
                $this->db->insert('production_items', $item);
                $sale_item_id = $this->db->insert_id();
                if ($data['sale_status'] == 'completed' && $this->site->getProductByID($item['product_id'])) {

                    // $item_costs = $this->site->item_costing($item);
                    // foreach ($item_costs as $item_cost) {
                    //     $item_cost['sale_item_id'] = $sale_item_id;
                    //     $item_cost['sale_id'] = $sale_id;
                    //     if(! isset($item_cost['pi_overselling'])) {
                    //         $this->db->insert('costing', $item_cost);
                    //     }
                    // }

                }
            }

            if ($data['sale_status'] == 'completed') {
                $this->site->syncPurchaseItems($cost);
            }

            if ($data['payment_status'] == 'partial' || $data['payment_status'] == 'paid' && !empty($payment)) {
                // $payment['sale_id'] = $sale_id;
                // if ($payment['paid_by'] == 'gift_card') {
                //     $this->db->update('gift_cards', array('balance' => $payment['gc_balance']), array('card_no' => $payment['cc_no']));
                //     unset($payment['gc_balance']);
                //     $this->db->insert('payments', $payment);
                // } else {
                //     $this->db->insert('payments', $payment);
                // }
                // if ($this->site->getReference('pay') == $payment['reference_no']) {
                //     $this->site->updateReference('pay');
                // }
                // $this->site->syncSalePayments($sale_id);

            }

            $this->site->syncQuantity($sale_id);
            $this->sma->update_award_points($data['grand_total'], $data['customer_id'], $data['created_by']);
            return $sale_id;

        }

        return false;
    }




    public function updateProduction($id, $data, $items = array(),$arrDeliveries)
    {

        // $this->setDeliveryEdit($id,$arrDeliveries);
        // die();
        $this->resetSaleActions($id);

        if ($data['sale_status'] == 'completed') {
            $cost = $this->site->costing($items);
        }

        if ($this->db->update('productions', $data, array('id' => $id)) && $this->db->delete('production_items', array('sale_id' => $id))) {
            $this->setDeliveryEdit($id,$arrDeliveries);
            foreach ($items as $item) {

                $item['sale_id'] = $id;
                $this->db->insert('production_items', $item);
                $sale_item_id = $this->db->insert_id();
                if ($data['sale_status'] == 'completed' && $this->site->getProductByID($item['product_id'])) {
                    $item_costs = $this->site->item_costing($item);
                    foreach ($item_costs as $item_cost) {
                        $item_cost['sale_item_id'] = $sale_item_id;
                        $item_cost['sale_id'] = $id;
                        if(! isset($item_cost['pi_overselling'])) {
                            $this->db->insert('costing', $item_cost);
                        }
                    }
                }

            }

            if ($data['sale_status'] == 'completed') {
                $this->site->syncPurchaseItems($cost);
            }

            $this->site->syncQuantity($id);
            $this->sma->update_award_points($data['grand_total'], $data['customer_id'], $data['created_by']);
            return true;

        }
        return false;
    }




    public function add_material_norms($data){

        $item=$this->getMaterialNorm1s($data['id']);



        if($item){

            $item_r = array(
                'production_id'=>$data['id'],
                'product_id'=>$data['id_pro'],
                'item'=>$data['item'],
                'item_id'=>$data['id_item'],
                'quantity'=>$data['quantity'],
                'total_quantity'=>$data['total_quantity'],
                'ord_quantity'=>$data['ord_quantity'],
            );

            if($this->db->insert('material_norms',$item_r)){

                return true;
            }

        }




        return false;
    }

    public function getPurchasedItems1($product_id)
    {

        $this->db->select('purchase_id,item_id');
        $this->db->where('item_id', $product_id);
        $this->db->where('purchase_id', NULL);
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getAllPurchaseItems1($items_id){
        $q = $this->db->get_where('purchase_items', array('purchase_id' => null, 'item_id'=>$items_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function syncQuantity1($purchase_id,$items_id){

            $purchase_items = $this->getAllPurchaseItems1($items_id);

            foreach ($purchase_items as $item) {


                $this->site->syncProductQty($item->product_id, $item->warehouse_id,$item->item_id);


                if (isset($item->option_id) && !empty($item->option_id)) {
                    $this->site->syncVariantQty($item->option_id, $item->warehouse_id, $item->item_id);
                }
            }

    }

    public function material_norms($production_id=NULL, $product_id=NULL,$item_id=array(),$items=array(),$quantity=array(),$total_quantity=array(),$ord_quantity=array())
    {
        $list=array();
        $result = $this->db->get_where("material_norms", array('production_id' => $production_id,'product_id' => $product_id))->result();
        foreach ($result as $key => $value) {
            $list[$value->id]=$value->item_id;
        }

        $count=0;
        for ($i=0; $i < count($item_id) ; $i++)
        {
            $item_name=$this->getItemNameByID($item_id[$i])->item;
            $item=$this->getMaterialNorms($production_id,$product_id,$item_id[$i]);

            $item1 = $this->getItems1($item_id[$i]);
            $productions = $this->getProduction($production_id);
           $pur = $this->getPurchasedItems1($item_id[$i]);
            if($productions->sale_status == 'pending'){
                if($pur){
                    if($this->db->delete('purchase_items',array('purchase_id' => null,'item_id' => $item_id[$i] ))){
                          $this->db->insert('purchase_items', array('purchase_id' => null,'warehouse_id'=>$item1->warehouse_id,'item_id' => $item_id[$i],'product_name' => $item_name,'quantity' => -$total_quantity[$i],'quantity_balance' => -$total_quantity[$i]));

                    }
                }else{
                    $this->db->insert('purchase_items', array('purchase_id' => null,'warehouse_id'=>$item1->warehouse_id,'item_id' => $item_id[$i],'product_name' => $item_name,'quantity' => -$total_quantity[$i],'quantity_balance' => -$total_quantity[$i]));
                }


                $this->syncQuantity1(null,$item_id[$i]);
            }

            if ($item)
            {

                $this->db->update('material_norms',array('ord_quantity' => $ord_quantity[$i],'item' => $item_name,'quantity' => $quantity[$i],'total_quantity' => $total_quantity[$i]),array('id'=>$item->id));
                $index = array_search($item_id[$i],$list);
                unset($list[$index]);

                $count++;
            }
            elseif($this->db->insert('material_norms', array('production_id' => $production_id,'product_id' => $product_id,'item_id' => $item_id[$i],'item' => $item_name,'quantity' => $quantity[$i],'total_quantity' => $total_quantity[$i],'ord_quantity' => $ord_quantity[$i])))
            {
                $count++;
            }



        }

        foreach ($list as $key => $value) {
        $this->deleteMaterialNormItem($key);
                }

        if ($count)
        {
            return true;
        }
        return false;
    }

    public function deleteMaterialNormItem($id)
    {
        if ($this->db->delete("material_norms", array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function deleteMachineryNorms($id)
    {
        if ($this->db->delete("machinery_norms", array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function deleteProductionStages($id)
    {
        if ($this->db->delete("production_stages", array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function deleteComment($id)
    {
        if ($this->db->delete("production_stage_details", array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function deleteLaborNorms($id)
    {
        if ($this->db->delete("labor_norms", array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function getAllProductionStages($production_id,$product_id,$delivery_id=NULL)
    {
        $this->db->select("id as id, stage as text");
        $this->db->where('stage_status <>','completed');

        if(is_numeric($delivery_id))
        {
            $this->db->where('delivery_time',$delivery_id);
        }
        $this->db->where('stage_status <>','completed');
        $q = $this->db->get_where("production_stages", array('production_id' => $production_id,'product_id' => $product_id));
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getAllProductionStagesNotNullDate($production_id,$product_id,$delivery_id=NULL)
    {
        $this->db->select("id as id, stage as text");
        $this->db->where('stage_status <>','completed');
        $this->db->where('date_start <>', 'null');
        $this->db->where('date_end <>', 'null');

        // if(is_numeric($delivery_id))
        // {
        //     $this->db->where('delivery_time',$delivery_id);
        // }
        $this->db->where('stage_status <>','completed');
        $q = $this->db->get_where("production_stages", array('production_id' => $production_id,'product_id' => $product_id));
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }


    public function getAllStageCommments($production_id)
    {
        $this->db->order_by('date desc');
        $q = $this->db->get_where("production_stage_details", array('production_id' => $production_id));
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getStageCommments($stage_id=null)
    {

        $this->db->order_by('date desc');
        $q = $this->db->get_where("production_stage_details", array('stage_id' => $stage_id));
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function norm_detail($id, $data)
    {
        $product_id=$data['items'];
        // $this->production_stage($id,$product_id,$data['stage_id'],$data['attr_name'],$data['stages_percent'],$data['date_start'],$data['date_end'],$data['emp'],$data['delivery_times'],$data['stage_id'],$data['stages_percent']);die();
        // var_dump($data['delivery_times']);die();
        if ($data['machine']) {
            $this->machinery_norm($id,$product_id,$data['wps'],explode(',',$data['machine']));
        }
        if ($this->production_stage($id,$product_id,$data['stage_id'],$data['attr_name'],$data['stages_percent'],$data['date_start'],$data['date_end'],$data['emp'],$data['delivery_times'],$data['stage_id'],$data['stages_percent']) && $this->material_norms($id,$product_id,$data['id'],$data['item'],$data['quantity'],$data['total_quantity'],$data['ord_quantity']))
        {
            return true;
        }
        return false;
    }

    public function production_stage($production_id=NULL, $product_id=NULL,$stage_id=array(),$stage=array(),$stage_percent=array(),$date_start=array(),$date_end=array(),$employees=array(),$delivery_times=array(),$stages_id=array(),$stages_percent=array())
    {

        $list=array();
        $result = $this->db->get_where("production_stages", array('production_id' => $production_id,'product_id' => $product_id))->result();
        foreach ($result as $key => $value) {
            $list[$value->id]=$value->stage;
        }
        $count=0;

        for ($i=0; $i < count($stage); $i++)
        {
            $start=empty($date_start[$i] || $date_start[$i]=='00/00/0000')? NULL:$this->sma->fsd($date_start[$i]);
            $end=empty($date_end[$i] || $date_end[$i]=='00/00/0000')? NULL:$this->sma->fsd($date_end[$i]);
            $item=$this->getProductionStage($production_id,$product_id,$stage[$i],$delivery_times[$i]);

            $prot_id = $item->production_id;

            if ($item)
            {
                $this->db->update('production_stages',array('date_start' => $start,'date_end' => $end,'employee' => $employees[$i]),array('id'=>$item->id));
                $index = array_search($stage[$i],$list);
                unset($list[$index]);
                $count++;
            }
            else
            {
                // var_dump( array('production_id' => $production_id,'product_id' => $product_id,'stage_id' => $stage_id[$i],'stage' => $stage[$i],'stage_percent' => $stages_percent[$i],'date_start' => $start,'date_end' => $end,'employee' => $employees[$i],'delivery_time' => $delivery_times[$i]));die();
                // die($delivery_times[$i]);
                $this->db->insert('production_stages', array('production_id' => $production_id,'product_id' => $product_id,'stage_id' => $stage_id[$i],'stage' => $stage[$i],'stage_percent' => $stages_percent[$i],'date_start' => $start,'date_end' => $end,'employee' => $employees[$i],'delivery_time' => $delivery_times[$i]));
                $count++;
                // var_dump($this->db->affected_rows());die();
            }

        }
        if(count($this->getStage_ID($prot_id, $product_id)) > count($this->getStage_IDC($prot_id, $product_id))){
            $this->updateStatusProductionItem($prot_id, $product_id);
            $sale_status = $this->getProduction($prot_id)->sale_status;
            if (($sale_status != 'pending') && ($sale_status != 'not_start') && ($sale_status != 'cancel')) {
                $this->db->update('productions',array('sale_status'=>'pending'),array('id'=> $prot_id));
            }
        }

        foreach ($list as $key => $value) {
            $this->deleteProductionStages($key);
        }

        if ($count)
        {
            return true;
        }
        return false;
    }

    public function updateStatusProductionItem($productions_id, $product_id){
        $this->db->where('sale_id ', $productions_id);
        $this->db->where('product_id', $product_id);
        $this->db->update('production_items', array('status' => 'pending'));
    }


    public function getAllStagesByProductionID($production_id)
    {
        $this->db->group_by('production_stages.stage_id');
        $this->db->order_by('production_stages.stage_id ASC');
        $q = $this->db->get_where('production_stages', array('stage_id <>'=>0,'production_id' => $production_id));
        if ($q->num_rows() > 0) {
             foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }

        return FALSE;
    }


    public function getAllStagesByProductionAndProductId($production_id, $product_id)
    {
        $q = $this->db->get_where('production_stages', array('production_id' => $production_id, 'product_id' => $product_id));
        if ($q->num_rows() > 0) {
             foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }

        return FALSE;
    }


    public function getAllStagesT ($production_id,$product_id,$delivery_time)
    {

        $q = $this->db->get_where('production_stages', array('production_id' => $production_id,'product_id'=>$product_id,'delivery_time'=>$delivery_time));
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getAllStages1($production_id,$product_id,$stage_id)
    {
        $this->db->select('*');
        $this->db->select_sum('quantity');
        $this->db->group_by('stage_id');
        $this->db->order_by('stage_id ASC');
        $q = $this->db->get_where('production_stages', array('stage_id'=>$stage_id,'production_id' => $production_id,'product_id'=>$product_id));
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function GetdDliveryTimeByProductionID($id)
    {

        $q = $this->db->get_where('sma_production_deliveries', array('production_id'=>$id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }

        return FALSE;
    }


    public function getDeliveryTimeByProductionID($id)
    {
        $this->db->select('production_deliveries.id, production_deliveries.production_id, production_deliveries.product_id, products.name, production_deliveries.delivery_time, production_deliveries.delivery_quantity');
        $this->db->join('products', 'products.id = production_deliveries.product_id');
        $q = $this->db->get_where('production_deliveries', array('production_id'=>$id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }

        return FALSE;
    }



    public function labor_norm($production_id=NULL, $product_id=NULL,$lists=array())
    {
        $list=array();
        $result = $this->db->get_where("labor_norms", array('production_id' => $production_id,'product_id' => $product_id))->result();
        foreach ($result as $key => $value) {
            $list[$value->id]=$value->employee_id;
        }

        $count=0;
        foreach ($lists as $value)
        {
            $employee=$this->getCompanyByID($value)->name;

            $item=$this->getLaborNorm($production_id,$product_id,$value);

            if ($item)
            {
                $this->db->update('labor_norms',array('employee' => $employee),array('id'=>$item->id));
                $index = array_search($value,$list);
                unset($list[$index]);
                $count++;
            }
            elseif($this->db->insert('labor_norms', array('production_id' => $production_id,'product_id' => $product_id,'employee' => $employee,'employee_id' => $value)))
            {
                $count++;
            }

        }

        foreach ($list as $key => $value) {
        $this->deleteLaborNorms($key);
                }

        if ($count)
        {
            return true;
        }
        return false;
    }


    public function machinery_norm($production_id=NULL, $product_id=NULL,$wps=NULL,$lists=array())
    {

        $list=array();
        $result = $this->db->get_where("machinery_norms", array('production_id' => $production_id,'product_id' => $product_id))->result();
        foreach ($result as $key => $value) {
            $list[$value->id]=$value->machine_id;
        }
        $count=0;
        foreach ($lists as $value)
        {
            if($value==0)
            {
                continue;
            }
            $machine=$this->getMachineByID($value)->machine_name;
            $working_place=$this->getWorkingPlaceByID($wps)->working_place;
            $item=$this->getMachineryNorm($production_id,$product_id,$wps,$value);

            if ($item)
            {
                $this->db->update('machinery_norms',array('machine' => $machine,'working_place' => $working_place),array('id'=>$item->id));
                $index = array_search($value,$list);
                unset($list[$index]);
                $count++;
            }
            elseif($this->db->insert('machinery_norms', array('production_id' => $production_id,'product_id' => $product_id,'machine_id' => $value,'working_place_id' => $wps,'machine' => $machine,'working_place' => $working_place)))
            {
                $count++;
            }

        }

        foreach ($list as $key => $value) {
        $this->deleteMachineryNorms($key);
        }

        if ($count)
        {
            return true;
        }
        return false;
    }

    public function getMaterialNorms($production_id,$product_id,$item_id)
    {
        $q = $this->db->get_where("material_norms", array('production_id' => $production_id,'product_id' => $product_id,'item_id' => $item_id),1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getMaterialNorm1s($production_id)
    {
        $q = $this->db->get_where("material_norms", array('production_id' => $production_id),1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getItems1($item_id)
    {
        $q = $this->db->get_where("items", array('id' => $item_id),1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getProductionStage($production_id,$product_id,$stage,$delivery_time)
    {

        $q = $this->db->get_where("production_stages", array('production_id' => $production_id,'product_id' => $product_id,'stage' => $stage,'delivery_time'=>$delivery_time),1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getProduction($production_id)
    {

        $q = $this->db->get_where("productions", array('id' => $production_id),1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getLaborNorm($production_id,$product_id,$employee_id)
    {

        $q = $this->db->get_where("labor_norms", array('production_id' => $production_id,'product_id' => $product_id,'employee_id' => $employee_id),1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getAllEmployees($production_id,$product_id)
    {
        $q = $this->db->get_where('labor_norms', array('production_id' => $production_id,'product_id'=>$product_id));
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getAllStages($production_id,$product_id)
    {
        $q = $this->db->get_where('production_stages', array('production_id' => $production_id,'product_id'=>$product_id));
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getAlllStages($production_id)
    {
        $q = $this->db->get_where('production_stages', array('production_id' => $production_id));
         if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }



    public function getAlllStagesS($production_id,$status)
    {
        $q = $this->db->get_where('production_stages', array('production_id' => $production_id,'stage_status'=>$status));
         if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getChartData($product_id,$productions_id){

        $this->db->select('production_stages.quantity,production_items.product_name');
        $this->db->where('product_id', $product_id)->where('production_id', $productions_id)->where('stage_status','completed') ;
        $this->db->join('production_items', 'production_items.product_id=production_stages.product_id', 'left');

        $this->db->order_by('date_end DESC');

        $q = $this->db->get('production_stages');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getStage_IDC($production_id,$product_id)
    {
        $q = $this->db->get_where('production_stages', array('stage_status'=>'completed','production_id' => $production_id,'product_id'=>$product_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getStage_ID($production_id,$product_id)
    {
        $q = $this->db->get_where('production_stages', array('production_id' => $production_id,'product_id'=>$product_id, 'date_start !=' => null, 'date_end !=' => null));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getStage($production_id)
    {

        $q = $this->db->get_where('production_stages', array('id' => $production_id),1);
        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getCompanyByID($id)
    {
        $q = $this->db->get_where('companies', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getMachineryNorm($production_id,$product_id,$working_place_id,$machine_id)
    {
        $q = $this->db->get_where("machinery_norms", array('production_id' => $production_id,'product_id' => $product_id,'machine_id' => $machine_id,'working_place_id' => $working_place_id),1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getMachineByID($id)
    {
        $q = $this->db->get_where("machine", array('id' => $id),1);
        if ($q->num_rows() > 0) {

            return $q->row();
        }

        return FALSE;
    }

    public function getWorkingPlaceByID($id)
    {
        $q = $this->db->get_where("working_places", array('id' => $id),1);
        if ($q->num_rows() > 0) {

            return $q->row();
        }

        return FALSE;
    }

    public function getNormDeltail($id,$product_id)
    {
        $q = $this->db->get_where('machinery_norms', array('production_id' => $id,'product_id' => $product_id));

        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getPMachines($id,$product_id,$working_place_id)
    {
        $q = $this->db->get_where('machinery_norms', array('production_id' => $id,'product_id' => $product_id,'working_place_id'=>$working_place_id));

        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getPEmployees($id,$product_id)
    {
        $q = $this->db->get_where('labor_norms', array('production_id' => $id,'product_id' => $product_id));

        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    // public function get_production_stages($id,$product_id)
    // {

    //     $q = $this->db->get_where('production_stages', array('production_id' => $id,'product_id' => $product_id));

    //     if ($q->num_rows() > 0) {
    //         return $q->result();
    //     }
    //     return FALSE;
    // }

    public function get_production_stages($id,$product_id)
    {

        $times=$this->getAllDeliveries($id);
        // echo "<pre>";
        // print_r($times);
        // echo "</pre>";die();
        foreach ($times as $key => $value) {
            $value->delivery_times=$this->db->get_where('production_stages', array('production_id' => $id,'product_id' => $product_id,'delivery_time' => $value->id))->result();
        }
        if ($times) {
            return $times;
        }
        return FALSE;
    }

    public function get_material_norms($id,$product_id)
    {
        $q = $this->db->get_where('material_norms', array('production_id' => $id,'product_id' => $product_id));

        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function get_material_norms_item($id,$product_id,$item_id)
    {
        $q = $this->db->get_where('material_norms', array('production_id' => $id,'product_id' => $product_id,'item_id' => $item_id));

        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function get_group_material_norms($id)
    {
        $this->db->select('production_id, product_id, item_id,item,SUM(quantity) as quantity1, SUM(total_quantity) as total_quantity1')
            ->where('production_id',$id)
            ->group_by('item_id');

        $q = $this->db->get('material_norms');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function get_group_material_norms_join_warehouse($id)
    {
        $this->db->select('material_norms.production_id, items.item_code, material_norms.product_id, material_norms.item_id, material_norms.item, warehouses_products.quantity, SUM(total_quantity) as total_quantity1')
            ->where('material_norms.production_id',$id)
            ->group_by('material_norms.item_id');

        $this->db->join('items', 'items.id = material_norms.item_id');
        $this->db->join('warehouses_products', 'warehouses_products.item_id = material_norms.item_id');
        $this->db->where('warehouses_products.warehouse_id', 1);

        $q = $this->db->get('material_norms');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }


    public function get_group_material_norms_item($id,$item_id)
    {
        $this->db->select('production_id, product_id, item_id,item,SUM(quantity) as quantity1, SUM(total_quantity) as total_quantity1')
            ->where('production_id',$id)
            ->where('item_id',$item_id)
            ->group_by('item_id');

        $q = $this->db->get('material_norms');
        if ($q->num_rows() > 0) {
            return $q->result();
        }
    }

    public function get_items($id)
    {
        $q = $this->db->get_where('items', array('id' => $id));

        if ($q->num_rows() > 0) {
            return $q->result();
        }
        return FALSE;
    }

    public function getItemsInWarehousesAvailable($id)
    {
        $q = $this->db->get_where('warehouses_products', array('item_id' => $id, 'warehouse_id' => 1));

        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getProductByID($id)
    {
        $q = $this->db->get_where('products', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function deleteProduction($id)
    {
        // $sale_items = $this->resetSaleActions($id);
        if ($this->db->delete('productions', array('id' => $id))
            && $this->db->delete('production_items', array('sale_id' => $id))
            && $this->db->delete('production_deliveries', array('production_id' => $id))
            && $this->db->delete('machinery_norms',array('production_id' => $id))
            && $this->db->delete('production_stages',array('production_id' => $id)) ) {
            // if ($return = $this->getReturnBySID($id)) {
            //     $this->deleteReturn($return->id);
            // }
            // $this->site->syncQuantity(NULL, NULL, $sale_items);
            return true;
        }
        return FALSE;
    }

    public function updateStatusProductionC($id){
        $productions = $this->getProduction($id);
        if($productions->sale_status == 'not_start' ){
            if($this->db->update('productions', array('sale_status' => 'cancel'), array('id' => $id))){
                return true;
            }
            return true;
        }
        return false;
    }

    public function updateStatusProduction($id){

        if($this->db->update('productions', array('sale_status' => 'pending'), array('id' => $id))){
            $items = $this->get_group_material_norms($id);
            $productions = $this->getProduction($id);




            // if($productions->sale_status == 'pending' || $productions->sale_status =='completed'){

            //     foreach ($items as $key => $value) {
            //         $item1 = $this->getItems1($value->item_id);
            //         $pur = $this->getPurchasedItems1($value->item_id);


            //         if($pur){
            //             if($this->db->delete('purchase_items',array('purchase_id' => null,'item_id' => $value->item_id ))){
            //                   $this->db->insert('purchase_items', array('purchase_id' => null,'warehouse_id'=>$item1->warehouse_id,'item_id' => $value->item_id,'product_name' => $value->item,'quantity' => -$value->total_quantity,'quantity_balance' => -$value->total_quantity));

            //             }
            //         }else{
            //             $this->db->insert('purchase_items', array('purchase_id' => null,'warehouse_id'=>$item1->warehouse_id,'item_id' => $value->item_id,'product_name' => $value->item,'quantity' => -$value->total_quantity,'quantity_balance' => -$value->total_quantity));
            //         }


            //         $this->syncQuantity1(null,$item_id[$i]);
            //     }

            // }
            return true;
        }
        return false;
    }

    public function resetSaleActions($id)
    {
        $sale = $this->getInvoiceByID($id);
        $items = $this->getAllInvoiceItems($id);
        foreach ($items as $item) {

            if ($sale->sale_status == 'completed') {
                if ($costings = $this->getCostingLines($item->id, $item->product_id)) {
                    $quantity = $item->quantity;
                    foreach ($costings as $cost) {
                        if ($cost->quantity >= $quantity) {
                            $qty = $cost->quantity - $quantity;
                            $bln = $cost->quantity_balance ? $cost->quantity_balance + $quantity : $quantity;
                            $this->db->update('costing', array('quantity' => $qty, 'quantity_balance' => $bln), array('id' => $cost->id));
                            $quantity = 0;
                        } elseif ($cost->quantity < $quantity) {
                            $qty = $quantity - $cost->quantity;
                            $this->db->delete('costing', array('id' => $cost->id));
                            $quantity -= $qty;
                        }
                        if ($quantity == 0) {
                            break;
                        }
                    }
                    $this->updatePurchaseItem($cost->purchase_item_id, $item->quantity, $cost->sale_item_id);
                }
            }

        }
        $this->sma->update_award_points($sale->grand_total, $sale->customer_id, $sale->created_by, TRUE);
        return $items;
    }

    public function deleteReturn($id)
    {
        if ($this->db->delete('return_items', array('return_id' => $id)) && $this->db->delete('return_sales', array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function updatePurchaseItem($id, $qty, $sale_item_id)
    {
        if ($id) {
            if($pi = $this->getPurchaseItemByID($id)) {
                $bln = $pi->quantity_balance + $qty;
                $this->db->update('purchase_items', array('quantity_balance' => $bln), array('id' => $id));
            }
        } else {
            if ($sale_item = $this->getSaleItemByID($sale_item_id)) {
                $option_id = isset($sale_item->option_id) && !empty($sale_item->option_id) ? $sale_item->option_id : NULL;
                $clause = array('purchase_id' => NULL, 'transfer_id' => NULL, 'product_id' => $sale_item->product_id, 'warehouse_id' => $sale_item->warehouse_id, 'option_id' => $option_id);
                if ($pi = $this->site->getPurchasedItem($clause)) {
                    $quantity_balance = $pi->quantity_balance+$qty;
                    $this->db->update('purchase_items', array('quantity_balance' => $quantity_balance), $clause);
                } else {
                    $clause['quantity'] = 0;
                    $clause['quantity_balance'] = $qty;
                    $this->db->insert('purchase_items', $clause);
                }
            }
        }
    }

    public function getPurchaseItemByID($id)
    {
        $q = $this->db->get_where('purchase_items', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function returnSale($data = array(), $items = array(), $payment = array())
    {

        foreach ($items as $item) {
            if ($costings = $this->getCostingLines($item['sale_item_id'], $item['product_id'])) {
                $quantity = $item['quantity'];
                foreach ($costings as $cost) {
                    if ($cost->quantity >= $quantity) {
                        $qty = $cost->quantity - $quantity;
                        $bln = $cost->quantity_balance && $cost->quantity_balance >= $quantity ? $cost->quantity_balance - $quantity : 0;
                        $this->db->update('costing', array('quantity' => $qty, 'quantity_balance' => $bln), array('id' => $cost->id));
                        $quantity = 0;
                    } elseif ($cost->quantity < $quantity) {
                        $qty = $quantity - $cost->quantity;
                        $this->db->delete('costing', array('id' => $cost->id));
                        $quantity = $qty;
                    }
                }
                $this->updatePurchaseItem($cost->purchase_item_id, $item['quantity'], $cost->sale_item_id);
            }

        }
        //$this->sma->print_arrays($items);
        $sale_items = $this->site->getAllSaleItems($data['sale_id']);

        if ($this->db->insert('return_sales', $data)) {
            $return_id = $this->db->insert_id();
            if ($this->site->getReference('re') == $data['reference_no']) {
                $this->site->updateReference('re');
            }
            foreach ($items as $item) {
                $item['return_id'] = $return_id;
                $this->db->insert('return_items', $item);

                if ($sale_item = $this->getSaleItemByID($item['sale_item_id'])) {
                    if ($sale_item->quantity == $item['quantity']) {
                        $this->db->delete('sale_items', array('id' => $item['sale_item_id']));
                    } else {
                        $nqty = $sale_item->quantity - $item['quantity'];
                        $tax = $sale_item->unit_price - $sale_item->net_unit_price;
                        $discount = $sale_item->item_discount / $sale_item->quantity;
                        $item_tax = $tax * $nqty;
                        $item_discount = $discount * $nqty;
                        $subtotal = $sale_item->unit_price * $nqty;
                        $this->db->update('sale_items', array('quantity' => $nqty, 'item_tax' => $item_tax, 'item_discount' => $item_discount, 'subtotal' => $subtotal), array('id' => $item['sale_item_id']));
                    }

                }
            }
            $this->calculateSaleTotals($data['sale_id'], $return_id, $data['surcharge']);
            if (!empty($payment)) {
                $payment['sale_id'] = $data['sale_id'];
                $payment['return_id'] = $return_id;
                $this->db->insert('payments', $payment);
                if ($this->site->getReference('pay') == $data['reference_no']) {
                    $this->site->updateReference('pay');
                }
                $this->site->syncSalePayments($data['sale_id']);
            }
            $this->site->syncQuantity(NULL, NULL, $sale_items);
            return true;
        }
        return false;
    }

    public function getCostingLines($sale_item_id, $product_id)
    {
        $this->db->order_by('id', 'asc');
        $q = $this->db->get_where('costing', array('sale_item_id' => $sale_item_id, 'product_id' => $product_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getSaleItemByID($id)
    {
        $q = $this->db->get_where('sale_items', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function calculateSaleTotals($id, $return_id, $surcharge)
    {
        $sale = $this->getInvoiceByID($id);
        $items = $this->getAllInvoiceItems($id);
        if (!empty($items)) {
            $this->sma->update_award_points($sale->grand_total, $sale->customer_id, $sale->created_by, TRUE);
            $total = 0;
            $product_tax = 0;
            $order_tax = 0;
            $product_discount = 0;
            $order_discount = 0;
            $total_items = 0;
            foreach ($items as $item) {
                $total_items += $item->quantity;
                $product_tax += $item->item_tax;
                $product_discount += $item->item_discount;
                $total += $item->net_unit_price * $item->quantity;
            }
            if ($sale->order_discount_id) {
                $percentage = '%';
                $order_discount_id = $sale->order_discount_id;
                $opos = strpos($order_discount_id, $percentage);
                if ($opos !== false) {
                    $ods = explode("%", $order_discount_id);
                    $order_discount = (($total + $product_tax) * (Float)($ods[0])) / 100;
                } else {
                    $order_discount = $order_discount_id;
                }
            }
            if ($sale->order_tax_id) {
                $order_tax_id = $sale->order_tax_id;
                if ($order_tax_details = $this->site->getTaxRateByID($order_tax_id)) {
                    if ($order_tax_details->type == 2) {
                        $order_tax = $order_tax_details->rate;
                    }
                    if ($order_tax_details->type == 1) {
                        $order_tax = (($total + $product_tax - $order_discount) * $order_tax_details->rate) / 100;
                    }
                }
            }
            $total_discount = $order_discount + $product_discount;
            $total_tax = $product_tax + $order_tax;
            $grand_total = $total + $total_tax + $sale->shipping - $order_discount + $surcharge;
            $data = array(
                'total' => $total,
                'product_discount' => $product_discount,
                'order_discount' => $order_discount,
                'total_discount' => $total_discount,
                'product_tax' => $product_tax,
                'order_tax' => $order_tax,
                'total_tax' => $total_tax,
                'grand_total' => $grand_total,
                'total_items' => $total_items,
                'return_id' => $return_id,
                'surcharge' => $surcharge
            );

            if ($this->db->update('sales', $data, array('id' => $id))) {
                $this->sma->update_award_points($data['grand_total'], $sale->customer_id, $sale->created_by);
                return true;
            }
        } else {
            $this->db->delete('sales', array('id' => $id));
            //$this->db->delete('payments', array('sale_id' => $id, 'return_id !=' => $return_id));
        }
        return FALSE;
    }

    public function getProductByName($name)
    {
        $q = $this->db->get_where('products', array('name' => $name), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function addDelivery($data = array())
    {
        if ($this->db->insert('deliveries', $data)) {
            if ($this->site->getReference('do') == $data['do_reference_no']) {
                $this->site->updateReference('do');
            }
            return true;
        }
        return false;
    }

    public function updateDelivery($id, $data = array())
    {
        if ($this->db->update('deliveries', $data, array('id' => $id))) {
            return true;
        }
        return false;
    }

    public function getDeliveryByID($id)
    {
        $q = $this->db->get_where('deliveries', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }


    public function getInvoicePayments($sale_id)
    {
        $this->db->order_by('id', 'asc');
        $q = $this->db->get_where('payments', array('sale_id' => $sale_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getPaymentByID($id)
    {
        $q = $this->db->get_where('payments', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getPaymentsForSale($sale_id)
    {
        $this->db->select('payments.date, payments.paid_by, payments.amount, payments.cc_no, payments.cheque_no, payments.reference_no, users.first_name, users.last_name, type')
            ->join('users', 'users.id=payments.created_by', 'left');
        $q = $this->db->get_where('payments', array('sale_id' => $sale_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

     public function getWProductById($product_id)
    {
        $this->db->select('quantity');
        $q = $this->db->get_where('warehouses_products', array('product_id' => $product_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function addPayment($data = array())
    {
        if ($this->db->insert('payments', $data)) {
            if ($this->site->getReference('pay') == $data['reference_no']) {
                $this->site->updateReference('pay');
            }
            $this->site->syncSalePayments($data['sale_id']);
            if ($data['paid_by'] == 'gift_card') {
                $gc = $this->site->getGiftCardByNO($data['cc_no']);
                $this->db->update('gift_cards', array('balance' => ($gc->balance - $data['amount'])), array('card_no' => $data['cc_no']));
            }
            return true;
        }
        return false;
    }




    public function updateStage($id, $data = array())
    {

        $sta_status = $this->db->get_where('production_stages', array('id' => $data['stage_id']))->row();
        if (!$data['stage_status']) {
            $status = $sta_status->stage_status;
        }

        if(isset($data['stage_id']))
        {
            if($data['stage_status']===0)
            {
                $status='not_start';
                $data['quantity']=0;
                $data['error_quantity']=0;
            }

            if($data['stage_status']==1)
            {
                $status='pending';
                $data['error_quantity']=0;
                $this->updateQuantityProduct($data['product_id'],$data['warehouse_id'],$data['quantity']);
            }
            $complete_quantity=$this->getTotalQuantityReport($id,$data['stage_id'])+$data['quantity'];


            $item=$this->getProductionItem($id,$data['product_id']);
            if($data['stage_status']==2)
            {

                $error=$item->quantity-$complete_quantity;
                $status='completed';
                $data['error_quantity']=0;

                // $data['error_quantity']=($error>=0)? $error : 0 ;
            }

            $arr=array('stage_status'=>$status,'quantity'=>$complete_quantity,'error_quantity'=>$data['error_quantity']);

            if($this->db->update('production_stages',$arr,array('id'=>$data['stage_id']))){

                $all = $this->getAlllStages($id);

                $completed = $this->getAlllStagesS($id,'completed');

                if(count($this->getStage_ID($id,$data['product_id']))==count($this->getStage_IDC($id,$data['product_id']))){

                    if($this->db->update('production_items',array('status'=>'completed'),array('sale_id'=>$id, 'product_id'=>$data['product_id']))) {

                        //BEGIN code insert table completed_products when all stage completed
                        $arr_completed_stages = $this->getStage_IDC($id, $data['product_id']);
                        $arr_quantity = array();

                        foreach ($arr_completed_stages as $z) {
                            if ($z->date_start && $z->date_end) {
                                $arr_quantity[] = ($z->quantity) ? $z->quantity : 0;
                            }
                        }

                        $real_completed = (min($arr_quantity)) ? (min($arr_quantity)) : 0;
                        $this->db->insert('completed_products',
                            array(
                                'production_id' => $id,
                                'product_id'    => $data['product_id'],
                                'completed_quantity' => $real_completed
                            )
                        );
                        //END

                        $this->updateQuantityProductById($data['product_id'], $real_completed);

                        if(count($this->getProduction_item($id))==count($this->getProduction_item_completed($id))){
                            $this->db->update('productions',array('sale_status'=>'completed'),array('id'=>$id));
                        }
                    }
                }


            }
        }
        unset($data['error_quantity']);
        unset($data['delivery_id']);
        unset($data['stage_status']);
        unset($data['warehouse_id']);
        $data['complete_quantity']=$data['quantity'];
        unset($data['quantity']);
        $data['production_id']=$id;
        $data['date']=$this->sma->fld($data['date']);
        if ($this->db->insert('production_stage_details', $data, array('id' => $id))) {

            return true;
        }
        return false;
    }

    public function getTotalQuantityReport($production_id,$product_id=NULL)
    {
        if(is_numeric($product_id))
        {
            $this->db->where('stage_id',$product_id);
        }
        $this->db->select_sum('complete_quantity');
        $q = $this->db->get_where('production_stage_details', array('production_id' => $production_id));
        if ($q->num_rows() > 0) {
            return $q->row()->complete_quantity;
        }
        return FALSE;
    }

    public function updateQuantityProduct($product_id,$warehouse_id,$quantity)
    {
        if($warehouse_id)
        {
            if($this->db->update('warehouses_products',array('quantity'=>$quantity),array('product_id'=>$product_id,'warehouse_id'=>$warehouse_id))){
                $w = $this->getWProductById($product_id);

                $totalq = 0;
                foreach ($w as $key => $value) {
                    $totalq += $value->quantity;

                }
                $this->db->update('products',array('quantity'=>$totalq),array('id'=>$product_id));
            }
            if($this->db->affected_rows()>0)
                return true;
        }
        return false;
    }
    public function getProduction_item($production_id)
    {
        $q = $this->db->get_where('production_items', array('sale_id' => $production_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getProduction_item_completed($production_id)
    {
        $q = $this->db->get_where('production_items', array('sale_id' => $production_id, 'status'=>'completed'));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getProductionItemPID($production_id)
    {
        $this->db->select('production_items.id, production_items.quantity, production_items.product_id, products.quantity_config,');
        $this->db->join('products', 'products.id = production_items.product_id');
        $q = $this->db->get_where('production_items', array('sale_id' => $production_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getProductionItemByProductionId($production_id)
    {
        $q = $this->db->get_where('production_items', array('sale_id' => $production_id, 'status' => 'completed'));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getCompletedProductsByProductionId($production_id){
      $this->db->join('products', 'products.id = completed_products.product_id');
      $q = $this->db->get_where('completed_products', array('production_id' => $production_id, 'completed_quantity <>' => 0));
      if ($q->num_rows() > 0) {
          foreach (($q->result()) as $row) {
              $data[] = $row;
          }
          return $data;
      }
      return FALSE;
    }

    public function updatePayment($id, $data = array())
    {
        if ($this->db->update('payments', $data, array('id' => $id))) {
            $this->site->syncSalePayments($data['sale_id']);
            return true;
        }
        return false;
    }

    // public function deletePayment($id)
    // {
    //     $opay = $this->getPaymentByID($id);
    //     if ($this->db->delete('payments', array('id' => $id))) {
    //         $this->site->syncSalePayments($opay->sale_id);
    //         return true;
    //     }
    //     return FALSE;
    // }

    public function getWarehouseProductQuantity($warehouse_id, $product_id)
    {
        $q = $this->db->get_where('warehouses_products', array('warehouse_id' => $warehouse_id, 'product_id' => $product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }



    /* ----------------- Gift Cards --------------------- */

    public function addGiftCard($data = array(), $ca_data = array(), $sa_data = array())
    {
        if ($this->db->insert('gift_cards', $data)) {
            if (!empty($ca_data)) {
                $this->db->update('companies', array('award_points' => $ca_data['points']), array('id' => $ca_data['customer']));
            } elseif (!empty($sa_data)) {
                $this->db->update('users', array('award_points' => $sa_data['points']), array('id' => $sa_data['user']));
            }
            return true;
        }
        return false;
    }

    public function updateGiftCard($id, $data = array())
    {
        $this->db->where('id', $id);
        if ($this->db->update('gift_cards', $data)) {
            return true;
        }
        return false;
    }

    public function deleteGiftCard($id)
    {
        if ($this->db->delete('gift_cards', array('id' => $id))) {
            return true;
        }
        return FALSE;
    }

    public function getPaypalSettings()
    {
        $q = $this->db->get_where('paypal', array('id' => 1));
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getSkrillSettings()
    {
        $q = $this->db->get_where('skrill', array('id' => 1));
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getQuoteByID($id)
    {
        $q = $this->db->get_where('quotes', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getAllQuoteItems($quote_id)
    {
        $q = $this->db->get_where('quote_items', array('quote_id' => $quote_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getStaff()
    {
        if (!$this->Owner) {
            $this->db->where('group_id !=', 1);
        }
        $this->db->where('group_id !=', 3)->where('group_id !=', 4);
        $q = $this->db->get('users');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getProductVariantByName($name, $product_id)
    {
        $q = $this->db->get_where('product_variants', array('name' => $name, 'product_id' => $product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getTaxRateByName($name)
    {
        $q = $this->db->get_where('tax_rates', array('name' => $name), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getItemByProductionID($production_id)
    {
        $this->db->where('sale_id', $production_id);
        $q = $this->db->get('production_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }




    public function addPaymentNew($paym){

        if ($this->db->insert('payments_new', $paym)) {
            $grand_total = $this->getProduction($paym['production_id'])->grand_total;
            $paid = $this->getPaid($paym['production_id']);

            if ($this->getProduction($paym['production_id'])->grand_total <= $paid) {

                $this->updatePaymentStatus($paym['production_id'], 1);
            }

            return true;
        }
        return false;
    }

    public function updatePaymentStatus($production_id, $status){
        $this->db->update('productions', array('payment_status' => $status), array('id' => $production_id));
    }

    // Hàm lấy tổng số tiền đã trả theo production id
    public function getPaid($production_id){
        $this->db->where('production_id',$production_id);
        $this->db->group_by('production_id');
        $this->db->select_sum('amount');
        $q = $this->db->get('payments_new');
        if ($q->num_rows() > 0) {
            return $q->row()->amount;
        }
        return FALSE;
    }

    public function getPaymentByProductionID($production_id)
    {
        $this->db->where('production_id', $production_id);
        $q = $this->db->get('payments_new');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function deletePayment($id, $production_id){
        if ($this->db->delete("payments_new", array('id' => $id))) {
            $grand_total = $this->getProduction($production_id)->grand_total;
            $paid = $this->getPaid($production_id);

                if ($this->getProduction($production_id)->grand_total > $paid) {

                    $this->updatePaymentStatus($production_id, 0);
                }

            return true;
        }
        return false;
    }

    public function updateDeliveryStatus($delivery_id, $current_status){
        if ($current_status == 0) {
            $status = 1;
        }elseif($current_status == 1){
            $status = 0;
        }
        if($this->db->update('production_deliveries', array('delivery_status' => $status), array('id' => $delivery_id))){
            return true;
        }
        return false;
    }

    //
    public function getMaterialNormsByProductionId($production_id){

        $this->db->select('material_norms.id, item_id, material_norms.item, items.cost, items.quantity as items_quantity');
        $this->db->join('items','items.id=material_norms.item_id','left');
        $this->db->group_by('material_norms.item_id');
        // $this->db->select_sum('material_norms.ord_quantity');
        // $this->db->select_sum('material_norms.quantity');
        $this->db->select_sum('material_norms.total_quantity');
        $q = $this->db->get_where('material_norms',array('material_norms.production_id'=>$production_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getPurchasesByProductionId($production_id){
        $this->db->where('production_id', $production_id);
        $q = $this->db->get('purchases');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row->id;
            }
            return $data;
        }
        return FALSE;
    }

    public function getPurchasesByParentId($parent_id){
        $this->db->where('parent_id', $parent_id);


        $q = $this->db->get('purchases');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    // $ids is array parent_id
    public function getTotalBought($ids){
        $this->db->select('product_name, item_id');
        $this->db->select_sum('quantity');
        $this->db->where_in('parent_id', $ids);
        $this->db->join('purchase_items','purchase_items.purchase_id = purchases.id', 'left');
        $this->db->group_by('item_id');
        $q = $this->db->get('purchases');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
              }
            return $data;
        }
        return FALSE;
    }

    public function getDatePurchaseItems($arr_purchases_id, $item_id){
        // $this->db->select('purchase_items.id, reference_no, purchase_items.item_id, product_name');
        $this->db->where_in('purchases.id', $arr_purchases_id);
        $this->db->where('purchase_items.item_id', $item_id);
        $this->db->group_by('purchase_items.date');
        $this->db->join('purchase_items','purchase_items.purchase_id=purchases.id','left');
        $q = $this->db->get('purchases');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getInfoPurcharesDate($arr_purchases_id, $item_id){
        $this->db->select('purchase_items.id, purchase_items.purchase_id, reference_no, purchase_items.item_id, product_name, purchase_items.date');
        $this->db->where_in('purchases.id', $arr_purchases_id);
        $this->db->where('purchase_items.item_id', $item_id);
        $this->db->join('purchase_items','purchase_items.purchase_id=purchases.id','left');
        $q = $this->db->get('purchases');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getInfoProductionChart(){
        $this->db->select('productions.id, productions.reference_no, grand_total');
        $this->db->select_sum('payments_new.amount');
        $this->db->group_by('productions.id');
        $this->db->where('productions.sale_status', 'pending');
        $this->db->join('payments_new', 'payments_new.production_id=productions.id', 'left');

        $q = $this->db->get('productions');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function addProductionDeliveries($data){
        $return = true;
        foreach ($data as $value) {
            if ($this->db->insert('production_deliveries', $value)) {
                $product_id = $value['product_id'];
                $quantity = $value['delivery_quantity'];
                $this->updateQuantityProductById($product_id, $quantity, 1);
                $this->updateCompletedProductsQuantity($value['production_id'], $product_id, $quantity, 1);
            }else{
                $return = false;
            }
        }
        return $return;
    }

    /**
     * [updateQuantityProductById description]
     * @param  integer  $product_id [description]
     * @param  integer  $quantity   [description]
     * @param  0|1      $option     [description]
     */
    public function updateQuantityProductById($product_id, $quantity, $option = 0){
        $this->db->where('id', $product_id);
        if ($option == 0) {
            $this->db->set('product_quantity', 'product_quantity+'.$quantity, FALSE);
        }else{
            $this->db->set('product_quantity', 'product_quantity-'.$quantity, FALSE);
        }

        $this->db->update('products');
    }

    /**
     * [updateQuantityProductById description]
     * @param  integer  $production_id  [description]
     * @param  integer  $product_id     [description]
     * @param  integer  $quantity       [description]
     * @param  0|1      $option         [description]
     */
    public function updateCompletedProductsQuantity($production_id, $product_id, $quantity, $option = 0){
        $this->db->where('production_id', $production_id);
        $this->db->where('product_id', $product_id);
        if ($option == 0) {
            $this->db->set('completed_quantity', 'completed_quantity+'.$quantity, FALSE);
        }else{
            $this->db->set('completed_quantity', 'completed_quantity-'.$quantity, FALSE);
        }

        $this->db->update('completed_products');
    }

    public function getProductionDeliveryByID($id)
    {
        $q = $this->db->get_where('production_deliveries', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getProductionDeliveryByIDJoinProducts($id)
    {
        $this->db->select('production_deliveries.id, production_deliveries.delivery_quantity, production_deliveries.production_id, production_deliveries.product_id, production_deliveries.delivery_time,
            products.name');
        $this->db->join('products', 'products.id = production_deliveries.product_id');
        $q = $this->db->get_where('production_deliveries', array('production_deliveries.id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    /**
     * [deleteDelivery description]
     * @param  object $delivery [description]
     * @return boolean          [description]
     */
    public function deleteDelivery($delivery)
    {
        if ($this->db->delete('production_deliveries', array('id' => $delivery->id))) {
            $this->updateQuantityProductById($delivery->product_id, $delivery->delivery_quantity);
            $this->updateCompletedProductsQuantity($delivery->production_id, $delivery->product_id, $delivery->delivery_quantity);
            return true;
        }
        return FALSE;
    }

    public function getCompletedByProductionProductId($production_id, $product_id){
        $q = $this->db->get_where('completed_products', array('production_id' => $production_id, 'product_id' => $product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function updateProductionDeliveries($id, $data, $old_qtt, $production_id, $product_id){
        if ($this->db->update('production_deliveries', $data, array('id' => $id))) {
            if ($old_qtt > $data['delivery_quantity']) {
                $change_qtt = $old_qtt - $data['delivery_quantity'];
                $this->updateCompletedProductsQuantity($production_id, $product_id, $change_qtt);
                $this->updateQuantityProductById($product_id, $change_qtt);
            }elseif ($old_qtt < $data['delivery_quantity']) {
                $change_qtt = $data['delivery_quantity'] - $old_qtt;
                $this->updateCompletedProductsQuantity($production_id, $product_id, $change_qtt, 1);
                $this->updateQuantityProductById($product_id, $change_qtt, 1);
            }

            return TRUE;
        }
        return FALSE;
    }


    public function checkExistStages($production_id, $product_id){
        $q = $this->db->get_where('production_stages', array('production_id' => $production_id, 'product_id' => $product_id), 1);
        if ($q->num_rows() > 0) {
            return true;
        }
        return false;
    }

    public function getProductionByYearMonth($year, $month){
        $this->db->select('productions.id, production_items.product_id, productions.created_at, productions.reference_no, production_items.product_name, production_items.product_name, production_stages.employee, production_stages.stage, production_stages.quantity as soluonghoanthanh, products.wage, products.quantity_config');

        $this->db->where('MONTH(created_at) = '.$month);
        $this->db->where('YEAR(created_at) = '.$year);
        // $this->db->where('production_items.status', 'completed');
        $this->db->where('production_stages.product_id = production_items.product_id');
        $this->db->where('production_stages.date_start <>','NULL');
        // $this->db->where('products.id','production_items.product_id');


        $this->db->join('production_items', 'production_items.sale_id = productions.id');
        $this->db->join('products','products.id = production_items.product_id');
        $this->db->join('production_stages', 'production_stages.production_id = productions.id');

        $q = $this->db->get('productions');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }
}
