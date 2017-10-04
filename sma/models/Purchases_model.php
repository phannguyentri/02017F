<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Purchases_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    public function getProductNames($term, $limit = 5)
    {
        $this->db->where("item LIKE '%" . $term . "%'");
        $this->db->limit($limit);
        $q = $this->db->get('items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getAllProducts()
    {
        $q = $this->db->get('products');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
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

    public function getProductsByCode($code)
    {
        $this->db->select('*')->from('products')->like('code', $code, 'both');
        $q = $this->db->get();
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
    }

    public function getProductByNameS($name,$specification)
    {

        $q = $this->db->get_where('items', array('item' => $name,'specification'=>$specification), 1);

        if ($q->num_rows() > 0) {
            return $q->row();
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

    public function getProductByName($name)
    {
        $q = $this->db->get_where('products', array('name' => $name), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function updateProductQuantity($product_id, $quantity, $warehouse_id, $product_cost)
    {
        if ($this->addQuantity($product_id, $warehouse_id, $quantity)) {
            $this->site->syncProductQty($product_id, $warehouse_id);
            return true;
        }
        return false;
    }

    public function calculateAndUpdateQuantity($item_id, $product_id, $quantity, $warehouse_id, $product_cost)
    {
        if ($this->updatePrice($product_id, $product_cost) && $this->calculateAndAddQuantity($item_id, $product_id, $warehouse_id, $quantity)) {
            return true;
        }
        return false;
    }

    public function calculateAndAddQuantity($item_id, $product_id, $warehouse_id, $quantity)
    {

        if ($this->getProductQuantity($product_id, $warehouse_id)) {
            $quantity_details = $this->getProductQuantity($product_id, $warehouse_id);
            $product_quantity = $quantity_details['quantity'];
            $item_details = $this->getItemByID($item_id);
            $item_quantity = $item_details->quantity;
            $after_quantity = $product_quantity - $item_quantity;
            $new_quantity = $after_quantity + $quantity;
            if ($this->updateQuantity($product_id, $warehouse_id, $new_quantity)) {
                return TRUE;
            }
        } else {

            if ($this->insertQuantity($product_id, $warehouse_id, $quantity)) {
                return TRUE;
            }
        }
        return FALSE;
    }

    public function addQuantity($product_id, $warehouse_id, $quantity)
    {

        if ($this->getProductQuantity($product_id, $warehouse_id)) {
            $warehouse_quantity = $this->getProductQuantity($product_id, $warehouse_id);
            $old_quantity = $warehouse_quantity['quantity'];
            $new_quantity = $old_quantity + $quantity;

            if ($this->updateQuantity($product_id, $warehouse_id, $new_quantity)) {
                return TRUE;
            }
        } else {

            if ($this->insertQuantity($product_id, $warehouse_id, $quantity)) {
                return TRUE;
            }
        }
        return FALSE;
    }

    public function insertQuantity($product_id, $warehouse_id, $quantity)
    {
        $productData = array(
            'product_id' => $product_id,
            'warehouse_id' => $warehouse_id,
            'quantity' => $quantity
        );
        if ($this->db->insert('warehouses_products', $productData)) {
            $this->site->syncProductQty($product_id, $warehouse_id);
            return true;
        }
        return false;
    }

    public function updateQuantity($product_id, $warehouse_id, $quantity)
    {
        if ($this->db->update('warehouses_products', array('quantity' => $quantity), array('product_id' => $product_id, 'warehouse_id' => $warehouse_id))) {
            $this->site->syncProductQty($product_id, $warehouse_id);
            return true;
        }
        return false;
    }

    public function getProductQuantity($product_id, $warehouse)
    {
        $q = $this->db->get_where('warehouses_products', array('product_id' => $product_id, 'warehouse_id' => $warehouse), 1);

        if ($q->num_rows() > 0) {
            return $q->row_array(); //$q->row();
        }

        return FALSE;
    }

    public function updatePrice($id, $unit_cost)
    {

        if ($this->db->update('products', array('cost' => $unit_cost), array('id' => $id))) {
            return true;
        }

        return false;
    }

    public function getAllPurchases()
    {
        $q = $this->db->get('purchases');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }

            return $data;
        }
    }

    public function getAllPurchaseItems($purchase_id)
    {
        $this->db->select('purchase_items.*,items.specification,items.cost, tax_rates.code as tax_code, tax_rates.name as tax_name, tax_rates.rate as tax_rate, products.unit, products.details as details, product_variants.name as variant')
            ->join('products', 'products.id=purchase_items.product_id', 'left')
            ->join('items', 'items.id=purchase_items.item_id', 'left')
            ->join('product_variants', 'product_variants.id=purchase_items.option_id', 'left')
            ->join('tax_rates', 'tax_rates.id=purchase_items.tax_rate_id', 'left')
            ->group_by('purchase_items.id')
            ->order_by('id', 'asc');
        $q = $this->db->get_where('purchase_items', array('purchase_id' => $purchase_id));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getPurchaseItemsBalanceNotZero($purchase_id)
    {
        $this->db->select('purchase_items.*,items.specification,items.cost, tax_rates.code as tax_code, tax_rates.name as tax_name, tax_rates.rate as tax_rate, products.unit, products.details as details, product_variants.name as variant')
            ->join('products', 'products.id=purchase_items.product_id', 'left')
            ->join('items', 'items.id=purchase_items.item_id', 'left')
            ->join('product_variants', 'product_variants.id=purchase_items.option_id', 'left')
            ->join('tax_rates', 'tax_rates.id=purchase_items.tax_rate_id', 'left')
            ->group_by('purchase_items.id')
            ->order_by('id', 'asc');

        $q = $this->db->get_where('purchase_items', array('purchase_id' => $purchase_id, 'quantity_balance <>' => 0));
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
        $q = $this->db->get_where('purchase_items', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getItemByIDP($id)
    {
        $q = $this->db->get_where('purchase_items', array('purchase_id' => $id));
         if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function getSumItemByIDP($id)
    {
        $this->db->select_sum('quantity_balance');
        $this->db->where('purchase_id',$id);
        $this->db->group_by('purchase_id');
        $q = $this->db->get('purchase_items');
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

    public function getPurchaseByID($id)
    {
        $q = $this->db->get_where('purchases', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getPurchaseItemByPID($purchase_id)
    {
        $this->db->where('purchase_id', $purchase_id);
        $q = $this->db->get('purchase_items');
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
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

    public function getProductWarehouseOptionQty($option_id, $warehouse_id)
    {
        $q = $this->db->get_where('warehouses_products_variants', array('option_id' => $option_id, 'warehouse_id' => $warehouse_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function addProductOptionQuantity($option_id, $warehouse_id, $quantity, $product_id)
    {
        if ($option = $this->getProductWarehouseOptionQty($option_id, $warehouse_id)) {
            $nq = $option->quantity + $quantity;
            if ($this->db->update('warehouses_products_variants', array('quantity' => $nq), array('option_id' => $option_id, 'warehouse_id' => $warehouse_id))) {
                return TRUE;
            }
        } else {
            if ($this->db->insert('warehouses_products_variants', array('option_id' => $option_id, 'product_id' => $product_id, 'warehouse_id' => $warehouse_id, 'quantity' => $quantity))) {
                return TRUE;
            }
        }
        return FALSE;
    }

    public function resetProductOptionQuantity($option_id, $warehouse_id, $quantity, $product_id)
    {
        if ($option = $this->getProductWarehouseOptionQty($option_id, $warehouse_id)) {
            $nq = $option->quantity - $quantity;
            if ($this->db->update('warehouses_products_variants', array('quantity' => $nq), array('option_id' => $option_id, 'warehouse_id' => $warehouse_id))) {
                return TRUE;
            }
        } else {
            $nq = 0 - $quantity;
            if ($this->db->insert('warehouses_products_variants', array('option_id' => $option_id, 'product_id' => $product_id, 'warehouse_id' => $warehouse_id, 'quantity' => $nq))) {
                return TRUE;
            }
        }
        return FALSE;
    }

    public function getOverSoldCosting($product_id)
    {
        $q = $this->db->get_where('costing', array('overselling' => 1));
        if ($q->num_rows() > 0) {
            foreach (($q->result()) as $row) {
                $data[] = $row;
            }
            return $data;
        }
        return FALSE;
    }

    public function addPurchase($data, $items)
    {
        if($data['enquiery']){

            $id = $data['enquiery'];
            $unit_total = $this->getSumItemByIDP($id);


            unset($data['enquiery']);
            if ($this->db->insert('purchases', $data)) {
                $purchase_id = $this->db->insert_id();
                $item['purchase_id'] = $purchase_id;

                if ($this->site->getReference('po') == $data['reference_no']) {
                    // $this->site->updateReference('po');
                }
                $i = 0;
                $total=0;
                $oldpus = $this->getItemByIDP($id);
                $flag = 0;
                foreach ($items as $item) {
                    $this->updateQuantityItems($item['item_id'], $item['quantity']);
                    $item['purchase_id'] = $id;

                    foreach ($oldpus as $oldpu) {
                        if($oldpu->item_id == $item['item_id']){

                            $total = $oldpu->quantity_balance - $item['quantity_balance'];

                            if ($total <= 0) {
                                $this->db->update('purchase_items', array('quantity_balance' => $total, 'status' => 'done'), array('purchase_id' => $id,'item_id' => $item['item_id']));
                            }else{
                                $flag = 1;
                                $this->db->update('purchase_items', array('quantity_balance' => $total, 'status' => 'approval'), array('purchase_id' => $id,'item_id' => $item['item_id']));
                            }
                            $item['purchase_id'] = $purchase_id;
                            $this->db->insert('purchase_items', $item);
                        }
                        $i++;

                    }

                }

                $unit_total1 = $this->getSumItemByIDP($id);

                if($flag == 0){
                    $this->db->update('purchases', array('status'=>'done') ,array('id' => $id));
                }else{
                    $this->db->update('purchases', array('status'=>'approval') ,array('id' => $id));
                }

                if ($data['status'] == 'received') {
                        // $this->site->syncQuantity(NULL, $purchase_id);
                }
                return true;
            }



            return false;




        }else{
            unset($data['enquiery']);
            if ($this->db->insert('purchases', $data)) {
                $purchase_id = $this->db->insert_id();
                if ($this->site->getReference('po') == $data['reference_no']) {
                    $this->site->updateReference('po');
                }
                foreach ($items as $item) {
                    $item['purchase_id'] = $purchase_id;
                    $this->db->insert('purchase_items', $item);

                    if($item['item_id'] == NULL){
                    $this->db->update('products', array('cost' => $item['real_unit_cost']), array('id' => $item['product_id']));
                    }else{
                        $this->db->update('items', array('cost' => $item['real_unit_cost']), array('id' => $item['item_id']));
                    }
                    if($item['option_id']) {
                        $this->db->update('product_variants', array('cost' => $item['real_unit_cost']), array('id' => $item['option_id'], 'product_id' => $item['product_id']));
                    }
                }
                if ($data['status'] == 'received') {

                    // $this->site->syncQuantity(NULL, $purchase_id);
                }
                return true;
            }
        }
        return false;
    }

    public function getPurchaseItemById($id){
        $q = $this->db->get_where('purchase_items', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function deletePurchaseItem($id, $quantity, $item_id, $enquiries, $parent_id){
        // die('2');
        if($this->db->delete('purchase_items', array('id' => $id))){
            $this->updateQuantityItems($item_id, $quantity, 1);
            $this->updateEnquiryWhenDeleteItem($item_id, $quantity, $enquiries, $parent_id);
        }

    }


    public function updateEnquiryWhenDeleteItem($item_id, $quantity, $enquiries, $parent_id){
        foreach ($enquiries as $enquiery) {
            if ($enquiery->item_id == $item_id) {
                $this->db->set('quantity_balance', 'quantity_balance+'.$quantity, FALSE);
                $this->db->where('id', $enquiery->id);
                $this->db->update('purchase_items');

                if ($this->getPurchaseItemById($enquiery->id)->quantity_balance > 0) {
                    if($this->db->update('purchase_items', array('status' => 'approval'), array('id' => $enquiery->id))){
                        $this->db->update('purchases', array('status' => 'approval'), array('id' => $parent_id));
                    }
                }
            }
        }
    }

    public function updatePurchase($id, $data, $items = array(), $list_del, $parent_id)
    {

        $enquiery_id = $opurchase->parent_id;
        $enquiries = $this->getItemByIDP($enquiery_id);
        $enquiries_del = $this->getItemByIDP($parent_id);

        // echo "<pre>";
        // print_r($enquiries_del);
        // echo "</pre>";die();

        if ($list_del) {
            // die('1');
            foreach ($list_del as $key => $value) {
                // echo $key;
                // die();
                $this->deletePurchaseItem($key, $value['quantity'], $value['item_id'], $enquiries_del, $parent_id);
            }
        }

        $opurchase = $this->getPurchaseByID($id);


        $oitems = $this->getAllPurchaseItems($id);
        $flag = 0;
        if ($this->db->update('purchases', $data, array('id' => $id))) {

            foreach ($items as $item) {
                $old_qty = $item['old_quantity'];
                $current_qty = $item['quantity'];
                unset($item['old_quantity']);
                if ($this->updatePurchaseItem($item, $old_qty, $current_qty, $enquiries)) {
                    $this->updateQuantityItemsWhenEdit($item['item_id'], $old_qty, $current_qty);
                }
            }

            $new_enquiries = $this->getItemByIDP($enquiery_id);
            foreach ($new_enquiries as $enquiery) {
                if ($enquiery->quantity_balance > 0) {
                    $flag = 1;
                    break;
                }
            }

            if ($flag == 0) {
                $this->db->update('purchases', array('status'=>'done') ,array('id' => $enquiery_id));
            }else{
                $this->db->update('purchases', array('status'=>'approval') ,array('id' => $enquiery_id));
            }

            $this->site->syncPurchasePayments($id);
            return true;
        }

        return false;
    }

    public function updateQuantityBalanceWhenEdit($enquiery_id, $quantity_balance){
        $this->db->where('id', $enquiery_id);
        if ($quantity_balance <= 0) {
            $this->db->set('status', 'done');
        }else{
            $this->db->set('status', 'approval');
        }
        $this->db->update('purchase_items', array('quantity_balance' => $quantity_balance));
    }

    public function updatePurchaseItem($item, $old_qty, $current_qty, $enquiries){
        foreach ($enquiries as $enquiery) {
            if ($enquiery->item_id == $item['item_id']) {
                if ($old_qty > $current_qty) {
                    $change_quantity_balance = $old_qty - $current_qty;
                    $quantity_balance = $enquiery->quantity_balance + $change_quantity_balance;
                    $this->updateQuantityBalanceWhenEdit($enquiery->id,$quantity_balance);
                }elseif ($old_qty < $current_qty) {
                    $change_quantity_balance = $current_qty - $old_qty;
                    $quantity_balance = $enquiery->quantity_balance - $change_quantity_balance;
                    $this->updateQuantityBalanceWhenEdit($enquiery->id,$quantity_balance, 1);
                }
            }
        }


        $item_id = $item['id'];
        unset($item['id']);
        $this->db->where('id', $item_id);
        if ($this->db->update('purchase_items', $item)) {
            return true;
        }
        return false;
    }

    // update quantity item when edit purchases items
    public function updateQuantityItemsWhenEdit($item_id, $old_qty, $current_qty){
        $this->db->set('quantity', 'quantity-'.$old_qty, FALSE);
        $this->db->where('id', $item_id);
        if ($this->db->update('items')) {
            $this->db->set('quantity', 'quantity+'.$current_qty, FALSE);
            $this->db->where('id', $item_id);
            if ($this->db->update('items')) {
                return true;
            }
        }
        return false;

    }

    // $option 0: when add purchases, $option 1: when delete purchases
    public function updateQuantityItems($item_id, $item_quantity, $option=0){
        if ($option == 0) {
            $this->db->set('quantity', 'quantity+'.$item_quantity, FALSE);
        }else{
            $this->db->set('quantity', 'quantity-'.$item_quantity, FALSE);
        }

        $this->db->where('id', $item_id);
        $this->db->update('items');
    }

    public function updateQuantityItemsWhenDelete($purchase_items){
        foreach ($purchase_items as $value) {
            $this->updateQuantityItems($value->item_id, $value->quantity, 1);
        }
    }

    public function updateQuantityBalanceWhenDelete($purchase_item_id, $purchase_quantity){
        $this->db->set('quantity_balance', 'quantity_balance+'.$purchase_quantity, FALSE);
        $this->db->where('id', $purchase_item_id);
        $this->db->update('purchase_items', array('status'=>'approval'));
    }

    public function deletePurchase($id)
    {
        $purchase_items = $this->site->getAllPurchaseItems($id);
        $enquiery_id = $this->getPurchaseByID($id)->parent_id;
        $enquiery_items = $this->getPurchaseItemByPID($enquiery_id);

        foreach ($enquiery_items as $enquiery_item) {
            foreach ($purchase_items as $purchase_item) {
                if ($purchase_item->item_id == $enquiery_item->item_id) {
                    $this->updateQuantityBalanceWhenDelete($enquiery_item->id, $purchase_item->quantity_balance);
                }
            }
        }

        if ($this->db->delete('purchase_items', array('purchase_id' => $id)) && $this->db->delete('purchases', array('id' => $id))) {
            $this->db->update('purchases', array('status' => 'approval'), array('id' => $enquiery_id));

            $this->db->delete('payments', array('purchase_id' => $id));
            $this->updateQuantityItemsWhenDelete($purchase_items); // update quantity when delete purchase

            // $this->site->syncQuantity(NULL, NULL, $purchase_items);

            return true;
        }
        return FALSE;
    }

    public function getWarehouseProductQuantity($warehouse_id, $product_id)
    {
        $q = $this->db->get_where('warehouses_products', array('warehouse_id' => $warehouse_id, 'product_id' => $product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getPurchasePayments($purchase_id)
    {
        $this->db->order_by('id', 'asc');
        $q = $this->db->get_where('payments', array('purchase_id' => $purchase_id));
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

    public function getPaymentsForPurchase($purchase_id)
    {
        $this->db->select('payments.date, payments.paid_by, payments.amount, payments.reference_no, users.first_name, users.last_name, type')
            ->join('users', 'users.id=payments.created_by', 'left');
        $q = $this->db->get_where('payments', array('purchase_id' => $purchase_id));
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
            $this->site->syncPurchasePayments($data['purchase_id']);
            return true;
        }
        return false;
    }

    public function updatePayment($id, $data = array())
    {
        if ($this->db->update('payments', $data, array('id' => $id))) {
            $this->site->syncPurchasePayments($data['purchase_id']);
            return true;
        }
        return false;
    }

    public function deletePayment($id)
    {
        $opay = $this->getPaymentByID($id);
        if ($this->db->delete('payments', array('id' => $id))) {
            $this->site->syncPurchasePayments($opay->purchase_id);
            return true;
        }
        return FALSE;
    }

    public function getProductOptions($product_id)
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

    public function getProductVariantByName($name, $product_id)
    {
        $q = $this->db->get_where('product_variants', array('name' => $name, 'product_id' => $product_id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function getExpenseByID($id)
    {
        $q = $this->db->get_where('expenses', array('id' => $id), 1);
        if ($q->num_rows() > 0) {
            return $q->row();
        }
        return FALSE;
    }

    public function addExpense($data = array())
    {
        if ($this->db->insert('expenses', $data)) {
            if ($this->site->getReference('ex') == $data['reference']) {
                $this->site->updateReference('ex');
            }
            return true;
        }
        return false;
    }

    public function updateExpense($id, $data = array())
    {
        if ($this->db->update('expenses', $data, array('id' => $id))) {
            return true;
        }
        return false;
    }

    public function deleteExpense($id)
    {
        if ($this->db->delete('expenses', array('id' => $id))) {
            return true;
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

}
