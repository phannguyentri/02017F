<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Productions extends MY_Controller
{

    function __construct()
    {
        parent::__construct();

        if (!$this->loggedIn) {
            $this->session->set_userdata('requested_page', $this->uri->uri_string());
            redirect('login');
        }


        $this->lang->load('productions', $this->Settings->language);
        $this->load->library('form_validation');
        $this->load->model('items_model');
        $this->load->model('units_model');
        $this->load->model('productions_model');
        $this->load->model('companies_model');
        $this->load->model('working_places_model');
        $this->load->model('enquiry_model');
    }

    function index()
    {
        $this->data['error'] = validation_errors() ? validation_errors() : $this->session->flashdata('error');
        $bc                  = array(
            array(
                'link' => base_url(),
                'page' => lang('home')
            ),
            array(
                'link' => '#',
                'page' => lang('Lệnh sản xuất')
            )
        );
        $meta                = array(
            'page_title' => lang('Lệnh sản xuất'),
            'bc' => $bc
        );
        $this->page_construct('productions/index', $meta, $this->data);
    }

    function getProductions()
    {
        $this->sma->checkPermissions('index');

        if (!$this->Owner && !$warehouse_id) {
            $user         = $this->site->getUser();
            $warehouse_id = $user->warehouse_id;
        }
        $process_link      = anchor('productions/view_process/$1', '<i class="fa fa-file-text-o"></i> ' . lang('Tiến độ sản xuất'));
        $detail_link       = anchor('productions/view_update/$1', '<i class="fa fa-plus-circle"></i> ' . lang('Cập nhật tiến độ'), 'data-toggle="modal" data-target="#myModal"');
        $payments_link     = anchor('productions/payments/$1', '<i class="fa fa-money"></i> Lịch sử thanh toán', 'data-toggle="modal" data-target="#myModal"');
        $add_payment_link  = anchor('productions/add_payment/$1', '<i class="fa fa-money"></i> ' . lang('add_payment'), 'data-toggle="modal" data-target="#myModal"');
        $deliveries_link   = anchor('productions/deliveries/$1', '<i class="fa fa-file-text-o"></i> Lịch sử giao nhận', 'data-toggle="modal" data-target="#myModal"');
        $add_delivery_link = anchor('productions/add_delivery/$1', '<i class="fa fa-truck"></i> ' . lang('add_delivery'), 'data-toggle="modal" data-target="#myModal"');
        $email_link        = anchor('productions/email/$1', '<i class="fa fa-envelope"></i> ' . lang('email_sale'), 'data-toggle="modal" data-target="#myModal"');
        $edit_link         = anchor('productions/edit/$1', '<i class="fa fa-edit"></i> ' . lang('Sửa lệnh sản xuất'), 'class="sledit"');
        $pdf_link          = anchor('productions/pdf/$1', '<i class="fa fa-file-pdf-o"></i> ' . lang('download_pdf'));
        $return_link       = anchor('productions/return_sale/$1', '<i class="fa fa-angle-double-left"></i> ' . lang('return_sale'));
        $delete_link       = "<a href='#' class='po' title='<b>" . lang("Hủy bỏ lệnh sản xuất") . "</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-cancel' href='" . site_url('productions/cancel/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-trash-o\"></i> " . lang('Hủy bỏ lệnh sản xuất') . "</a>";
        // $update_status_production_link       = "<a href='#' class='po' title='<b>" . lang("Đưa vào sản xuất") . "</b>' data-content=\"<p>" . lang('r_u_sure') . "</p><a class='btn btn-danger po-update-status-production' href='" . site_url('productions/updateStatusProduction/$1') . "'>" . lang('i_m_sure') . "</a> <button class='btn po-close'>" . lang('no') . "</button>\"  rel='popover'><i class=\"fa fa-exchange\"></i> " . lang('Đưa vào sản xuất') . "</a>";
        $update_status_production_link   = anchor('productions/updateStatusProduction/$1', '<i class="fa fa-exchange"></i> Đưa vào sản xuất', 'data-toggle="modal" data-target="#myModal"');
        $action            = '<div class="text-center"><div class="btn-group text-left">' . '<button type="button" class="btn btn-default btn-xs btn-primary dropdown-toggle" data-toggle="dropdown">' . lang('actions') . ' <span class="caret"></span></button>
        <ul class="dropdown-menu pull-right" role="menu">
            <li>' . $detail_link . '</li>
            <li>' . $process_link . '</li>
            <li>' . $update_status_production_link . '</li>
            <li>' . $add_payment_link . '</li>
            <li>' . $payments_link . '</li>
            <li>' . $add_delivery_link . '</li>
            <li>' . $deliveries_link . '</li>
            <li>' . $edit_link . '</li>
            <li>' . $delete_link . '</li>
        </ul>
    </div></div>';
        //$action = '<div class="text-center">' . $detail_link . ' ' . $edit_link . ' ' . $email_link . ' ' . $delete_link . '</div>';

        $this->load->library('datatables');
        // $this->datatables->select("productions.id, created_at, reference_no, customer, GROUP_CONCAT(CONCAT(" . $this->db->dbprefix('production_deliveries') . ".delivery_date_start, ' - ', " . $this->db->dbprefix('production_deliveries') . ".delivery_date_end, '') SEPARATOR '<br>') as iname, sale_status, grand_total, SUM(".$this->db->dbprefix('payments_new').".amount), (grand_total - SUM(".$this->db->dbprefix('payments_new').".amount)) as conlai, payment_status")

        // ->from('productions');
        $this->datatables->select("productions.id, 1, created_at, reference_no, customer, sale_status, grand_total, SUM(".$this->db->dbprefix('payments_new').".amount), (grand_total - SUM(".$this->db->dbprefix('payments_new').".amount)) as conlai, payment_status")

        ->from('productions');

        $this->datatables->where('pos !=', 1);
        $this->datatables->join('production_deliveries', 'productions.id=production_deliveries.production_id');
        $this->datatables->join('payments_new', 'payments_new.production_id=productions.id','left');
        $this->datatables->group_by('productions.id');
        // $this->datatables->group_by('production_deliveries.delivery_date_start');


        if (!$this->Customer && !$this->Supplier && !$this->Owner && !$this->Admin) {
            $this->datatables->where('created_by', $this->session->userdata('user_id'));
        } elseif ($this->Customer) {
            $this->datatables->where('customer_id', $this->session->userdata('user_id'));
        }
        $this->datatables->add_column("Actions", $action, "productions.id");
        // $this->datatables->unset_column('productions.id');

        $result = json_decode($this->datatables->generate());

        foreach($result->aaData as $key=>$item) {
            $result->aaData[$key][1] = $key+1;
        }
        echo (json_encode($result));
    }

    function add_delivery($id){
        $this->sma->checkPermissions();

        $this->form_validation->set_rules('delivery_time', 'Ngày giao', 'required');

        if ($this->form_validation->run() == true) {

            $products = array();

            $i = isset($_POST['product_id']) ? sizeof($_POST['product_id']) : 0;
            for ($r = 0; $r < $i; $r++) {
                $products[] = array(
                    'production_id' => $_POST['production_id'],
                    'product_id'    => $_POST['product_id'][$r],
                    'delivery_quantity' => $_POST['quantity'][$r],
                    'delivery_time'     => $this->sma->fsd(trim($_POST['delivery_time'])),
                );
            }
            if (empty($products)) {
                $this->form_validation->set_rules('product', lang("order_items"), 'required');
            }

            if ($this->productions_model->addProductionDeliveries($products)) {
                $this->session->set_flashdata('message', 'Thêm giao nhận thành công!');
                redirect("productions");
            }else{
                $this->session->set_flashdata('error', 'Thêm giao nhận thất bại');
                redirect("productions");
            }

        }

        $this->data['production'] = $this->productions_model->getProduction($id);
        $this->data['products'] = $this->productions_model->getCompletedProductsByProductionId($id);
        $this->data['id'] = $id;
        $this->load->view($this->theme . 'productions/add_delivery', $this->data);
    }

    function edit_delivery($id){
        $this->sma->checkPermissions();

        $this->form_validation->set_rules('delivery_time', 'Ngày giao', 'required');

        if ($this->form_validation->run() == true) {
            $old_qtt = $_POST['old_qtt'];
            $delivery = array(
                'delivery_quantity' => $_POST['quantity'],
                'delivery_time'     => $this->sma->fsd(trim($_POST['delivery_time'])),

            );
            if (empty($delivery)) {
                $this->form_validation->set_rules('product', lang("order_items"), 'required');
            }

            if ($this->productions_model->updateProductionDeliveries($id, $delivery, $old_qtt, $_POST['production_id'], $_POST['product_id'])) {
                $this->session->set_flashdata('message', 'Sửa giao nhận thành công!');
                redirect("productions");
            }else{
                $this->session->set_flashdata('error', 'Sửa giao nhận thất bại');
                redirect("productions");
            }

        }


        $this->data['delivery'] = $this->productions_model->getProductionDeliveryByIDJoinProducts($id);
        $completed_quantity = $this->productions_model->getCompletedByProductionProductId($this->data['delivery']->production_id, $this->data['delivery']->product_id)->completed_quantity;

        $this->data['max_completed'] = $completed_quantity + $this->data['delivery']->delivery_quantity;
        $this->data['id'] = $id;
        $this->load->view($this->theme . 'productions/edit_delivery', $this->data);
    }

    function delete_delivery($id){
        $delivery = $this->productions_model->getProductionDeliveryByID($id);

        if ($this->productions_model->deleteDelivery($delivery)) {
            echo json_encode(array('status'=>'success','msg'=>'Hủy bỏ đợt giao nhận thành công'));
        }else{
            echo json_encode(array('status'=>'error','msg'=>'Hủy bỏ đợt giao nhận thất bại'));
        }

    }

    function deliveries($id){
        $this->sma->checkPermissions();

        $this->data['production'] = $this->productions_model->getProduction($id);
        $this->data['deliveries'] = $this->productions_model->getDeliveryTimeByProductionID($id);
        $this->load->view($this->theme . 'productions/deliveries', $this->data);
    }



    function updateDelivery(){
        $this->sma->checkPermissions();

        $delivery_id = $this->input->get('delivery_id');
        $current_status = $this->input->get('current_status');

        if($this->productions_model->updateDeliveryStatus($delivery_id, $current_status)){
            echo json_encode(array('status_error' => 0));
        }else{
            echo json_encode(array('status_error' => 1));
        }
    }

    function add_payment($id){
        $this->sma->checkPermissions();
        $this->form_validation->set_rules('amount', 'Số tiền thanh toán', 'required');
        $this->form_validation->set_rules('date', 'Ngày thanh toán', 'required');

        if ($this->form_validation->run() == true) {
            $paym = array(
                "production_id" => $id,
                "amount"        => $this->input->post('amount'),
                "date"          => $this->sma->fsd(trim($this->input->post('date'))),
                "paid_by"       => $this->input->post('paid_by'),
                "note"          => $this->input->post('note')
            );

            if ($this->form_validation->run() == true && $this->productions_model->addPaymentNew($paym)) {
                $this->session->set_flashdata('message', 'Thêm thanh toán thành công!');
                redirect("productions");
            }else{
                $this->data['error']    = validation_errors() ? validation_errors() : $this->session->flashdata('error');
                // $this->load->view($this->theme . 'productions/add_payment', $this->data);
            }

        }else{
            $this->data['id'] = $id;
            $this->load->view($this->theme . 'productions/add_payment', $this->data);
        }
    }



    function payments($id){
        $this->sma->checkPermissions();
        $this->data['production'] = $this->productions_model->getProduction($id);
        $this->data['payments'] = $this->productions_model->getPaymentByProductionID($id);
        $this->load->view($this->theme . 'productions/payments', $this->data);
    }

    function deletePayment(){
        $payment_id = $this->input->get('payment_id');
        $production_id = $this->input->get('production_id');
        if ($this->productions_model->deletePayment($payment_id, $production_id)) {
            echo json_encode(array('status_error' => 0));
        }else{
            echo json_encode(array('status_error' => 1));
        }
    }

    function add($quote_id = NULL)
    {
        // echo "<pre>";
        // print_r($this->input->post('grand_total'));
        // echo("</pre>");die();

        $this->sma->checkPermissions();

        $this->form_validation->set_message('is_natural_no_zero', lang("no_zero_required"));
        $this->form_validation->set_rules('reference_no', lang("reference_no"), 'required');
        $this->form_validation->set_rules('customer', lang("customer"), 'required');

        if ($this->form_validation->run() == true) {
            $quantity  = "quantity";
            $product   = "product";
            $unit_cost = "unit_cost";
            $tax_rate  = "tax_rate";
            $reference = $this->input->post('reference_no') ? $this->input->post('reference_no') : $this->site->getReference('so');
            if ($this->Owner || $this->Admin) {
                $date     = $this->sma->fsd(trim($this->input->post('date')));
                $due_date = $this->sma->fsd(trim($this->input->post('due_date')));
            } else {
                $date     = date('Y-m-d');
                $due_date = date('Y-m-d');
            }

            $warehouse_id     = $this->input->post('warehouse');
            $customer_id      = $this->input->post('customer');
            $biller_id        = $this->input->post('biller');
            $total_items      = $this->input->post('total_items');
            $sale_status      = $this->input->post('sale_status');
            $payment_status   = $this->input->post('payment_status');
            $payment_term     = $this->input->post('payment_term');
            // $due_date = $payment_term ? date('Y-m-d', strtotime('+' . $payment_term . ' days')) : NULL;
            $shipping         = $this->input->post('shipping') ? $this->input->post('shipping') : 0;
            $customer_details = $this->site->getCompanyByID($customer_id);
            $customer         = $customer_details->company ? $customer_details->company : $customer_details->name;
            $biller_details   = $this->site->getCompanyByID($biller_id);
            $biller           = $biller_details->company != '-' ? $biller_details->company : $biller_details->name;
            $note             = $this->sma->clear_tags($this->input->post('note'));
            $staff_note       = $this->sma->clear_tags($this->input->post('staff_note'));
            $quote_id         = $this->input->post('quote_id') ? $this->input->post('quote_id') : NULL;

            $total            = 0;
            $product_tax      = 0;
            $order_tax        = 0;
            $product_discount = 0;
            $order_discount   = 0;
            $percentage       = '%';

            $i = isset($_POST['product_code']) ? sizeof($_POST['product_code']) : 0;

            $grand_total = 0;

            for ($r = 0; $r < $i; $r++) {
                // echo "<pre>";
                // print_r($_POST['total_money'][$r]);
                // echo "</pre>";
                $grand_total = $grand_total + $_POST['total_money'][$r];

                $item_id         = $_POST['product_id'][$r];
                $item_type       = $_POST['product_type'][$r];
                $item_code       = $_POST['product_code'][$r];
                $item_name       = $_POST['product_name'][$r];
                $item_option     = isset($_POST['product_option'][$r]) && $_POST['product_option'][$r] != 'false' ? $_POST['product_option'][$r] : NULL;
                //$option_details = $this->productions_model->getProductOptionByID($item_option);
                $real_unit_price = $this->sma->formatDecimal($_POST['real_unit_price'][$r]);
                $unit_price      = $this->sma->formatDecimal($_POST['unit_price'][$r]);
                $item_quantity   = $_POST['quantity'][$r];
                $item_serial     = isset($_POST['serial'][$r]) ? $_POST['serial'][$r] : '';
                $item_tax_rate   = isset($_POST['product_tax'][$r]) ? $_POST['product_tax'][$r] : NULL;
                $item_discount   = isset($_POST['product_discount'][$r]) ? $_POST['product_discount'][$r] : NULL;

                if (isset($item_code) /* && isset($real_unit_price)*/ /* && isset($unit_price)*/ && isset($item_quantity)) {

                    $product_details = $item_type != 'manual' ? $this->productions_model->getProductByCode($item_code) : NULL;
                    $unit_price      = $real_unit_price;
                    $pr_discount     = 0;

                    if (isset($item_discount)) {
                        $discount = $item_discount;
                        $dpos     = strpos($discount, $percentage);
                        if ($dpos !== false) {
                            $pds         = explode("%", $discount);
                            $pr_discount = (($this->sma->formatDecimal($unit_price)) * (Float) ($pds[0])) / 100;
                        } else {
                            $pr_discount = $this->sma->formatDecimal($discount);
                        }
                    }

                    $unit_price       = $this->sma->formatDecimal($unit_price - $pr_discount);
                    $item_net_price   = $unit_price;
                    $pr_item_discount = $this->sma->formatDecimal($pr_discount * $item_quantity);
                    $product_discount += $pr_item_discount;
                    $pr_tax      = 0;
                    $pr_item_tax = 0;
                    $item_tax    = 0;
                    $tax         = "";
                    if (isset($item_tax_rate) && $item_tax_rate != 0) {
                        $pr_tax = $item_tax_rate;


                        $tax_details = $this->site->getTaxRateByID($pr_tax);
                        if ($tax_details->type == 1 && $tax_details->rate != 0) {

                            if ($product_details && $product_details->tax_method == 1) {
                                $item_tax = $this->sma->formatDecimal((($unit_price) * $tax_details->rate) / 100);
                                $tax      = $tax_details->rate . "%";
                            } else {
                                $item_tax       = $this->sma->formatDecimal((($unit_price) * $tax_details->rate) / (100 + $tax_details->rate));
                                $tax            = $tax_details->rate . "%";
                                $item_net_price = $unit_price - $item_tax;
                            }

                        } elseif ($tax_details->type == 2) {

                            if ($product_details && $product_details->tax_method == 1) {
                                $item_tax = $this->sma->formatDecimal((($unit_price) * $tax_details->rate) / 100);
                                $tax      = $tax_details->rate . "%";
                            } else {
                                $item_tax       = $this->sma->formatDecimal((($unit_price) * $tax_details->rate) / (100 + $tax_details->rate));
                                $tax            = $tax_details->rate . "%";
                                $item_net_price = $unit_price - $item_tax;
                            }

                            $item_tax = $this->sma->formatDecimal($tax_details->rate);
                            $tax      = $tax_details->rate;

                        }
                        $pr_item_tax = $this->sma->formatDecimal($item_tax * $item_quantity);

                    }
                    $product_tax += $pr_item_tax;
                    $subtotal = (($item_net_price * $item_quantity) + $pr_item_tax);
                    $employees = implode(",",$_POST['employees_'.$item_id]);
                    // var_dump($item_id);
                    $products[] = array(
                        'product_id' => $item_id,
                        'product_code' => $item_code,
                        'product_name' => $item_name,
                        'product_type' => $item_type,
                        'option_id' => $item_option,
                        'net_unit_price' => $item_net_price,
                        'unit_price' => $this->sma->formatDecimal($item_net_price + $item_tax),
                        'quantity' => $item_quantity,
                        'warehouse_id' => $warehouse_id,
                        'item_tax' => $pr_item_tax,
                        'tax_rate_id' => $pr_tax,
                        'tax' => $tax,
                        'discount' => $item_discount,
                        'item_discount' => $pr_item_discount,
                        'subtotal' => $this->sma->formatDecimal($subtotal),
                        'serial_no' => $item_serial,
                        'real_unit_price' => $real_unit_price,
                        'employees' => (!empty($employees)) ? $employees : NULL,
                    );

                    // var_dump($_POST['employees_'.$item_id]);die();
                    $total += $item_net_price * $item_quantity;
                }
                // echo "<pre>";
                // print_r($products);
                // echo("</pre>");
            }
            // var_dump($products);die();
            if (empty($products)) {
                $this->form_validation->set_rules('product', lang("order_items"), 'required');
            } else {
                krsort($products);
            }

            if ($this->input->post('order_discount')) {
                $order_discount_id = $this->input->post('order_discount');
                $opos              = strpos($order_discount_id, $percentage);
                if ($opos !== false) {
                    $ods            = explode("%", $order_discount_id);
                    $order_discount = $this->sma->formatDecimal((($total + $product_tax) * (Float) ($ods[0])) / 100);
                } else {
                    $order_discount = $this->sma->formatDecimal($order_discount_id);
                }
            } else {
                $order_discount_id = NULL;
            }
            $total_discount = $this->sma->formatDecimal($order_discount + $product_discount);

            if ($this->Settings->tax2) {
                $order_tax_id = $this->input->post('order_tax');
                if ($order_tax_details = $this->site->getTaxRateByID($order_tax_id)) {
                    if ($order_tax_details->type == 2) {
                        $order_tax = $this->sma->formatDecimal($order_tax_details->rate);
                    }
                    if ($order_tax_details->type == 1) {
                        $order_tax = $this->sma->formatDecimal((($total + $product_tax - $order_discount) * $order_tax_details->rate) / 100);
                    }
                }
            } else {
                $order_tax_id = NULL;
            }

            $total_tax   = $this->sma->formatDecimal($product_tax + $order_tax);
            // $grand_total = $this->sma->formatDecimal($this->sma->formatDecimal($total) + $total_tax + $this->sma->formatDecimal($shipping) - $order_discount);
            $create_at = date('Y-m-d');
            $data        = array(
                'date' => $date,
                'due_date' => $due_date,
                'reference_no' => $reference,
                'customer_id' => $customer_id,
                'customer' => $customer,
                'biller_id' => $biller_id,
                'biller' => $biller,
                'warehouse_id' => $warehouse_id,
                'note' => $note,
                'staff_note' => $staff_note,
                'total' => $this->sma->formatDecimal($total),
                'product_discount' => $this->sma->formatDecimal($product_discount),
                'order_discount_id' => $order_discount_id,
                'order_discount' => $order_discount,
                'total_discount' => $total_discount,
                'product_tax' => $this->sma->formatDecimal($product_tax),
                'order_tax_id' => $order_tax_id,
                'order_tax' => $order_tax,
                'total_tax' => $total_tax,
                'shipping' => $this->sma->formatDecimal($shipping),
                'grand_total' => $grand_total,
                'total_items' => $total_items,
                'sale_status' => 'not_start',
                'payment_term' => $payment_term,
                'working' => $this->input->post('implementation_unit'),
                'due_date' => $due_date,
                'paid' => 0,
                'created_by' => $this->session->userdata('user_id'),
                'created_at' => $create_at
                // 'employees' => json_encode($this->input->post('employees'));
            );
            $delivery_mode=$this->input->post('delivery_mode');
            if($delivery_mode==1)
            {
                $data['delivery_mode']=1;
                $arrDeliveries=array('mode'=>$delivery_mode,'date'=>array(array('start'=>$date,'end'=>$due_date,'percent'=>100)));
            }
            else
            {
                $data['delivery_mode']=0;
                $deliveries=$this->input->post('delivery_date');
                $arrDeliveries=array('mode'=>$delivery_mode,'date'=>$deliveries);
            }

            if ($payment_status == 'partial' || $payment_status == 'paid') {
                if ($this->input->post('paid_by') == 'gift_card') {
                    $gc            = $this->site->getGiftCardByNO($this->input->post('gift_card_no'));
                    $amount_paying = $grand_total >= $gc->balance ? $gc->balance : $grand_total;
                    $gc_balance    = $gc->balance - $amount_paying;
                    $payment       = array(
                        'date' => $date,
                        'reference_no' => $this->input->post('payment_reference_no'),
                        'amount' => $this->sma->formatDecimal($amount_paying),
                        'paid_by' => $this->input->post('paid_by'),
                        'cheque_no' => $this->input->post('cheque_no'),
                        'cc_no' => $this->input->post('gift_card_no'),
                        'cc_holder' => $this->input->post('pcc_holder'),
                        'cc_month' => $this->input->post('pcc_month'),
                        'cc_year' => $this->input->post('pcc_year'),
                        'cc_type' => $this->input->post('pcc_type'),
                        'created_by' => $this->session->userdata('user_id'),
                        'note' => $this->input->post('payment_note'),
                        'type' => 'received',
                        'gc_balance' => $gc_balance
                    );
                } else {
                    $payment = array(
                        'date' => $date,
                        'reference_no' => $this->input->post('payment_reference_no'),
                        'amount' => $this->sma->formatDecimal($this->input->post('amount-paid')),
                        'paid_by' => $this->input->post('paid_by'),
                        'cheque_no' => $this->input->post('cheque_no'),
                        'cc_no' => $this->input->post('pcc_no'),
                        'cc_holder' => $this->input->post('pcc_holder'),
                        'cc_month' => $this->input->post('pcc_month'),
                        'cc_year' => $this->input->post('pcc_year'),
                        'cc_type' => $this->input->post('pcc_type'),
                        'created_by' => $this->session->userdata('user_id'),
                        'note' => $this->input->post('payment_note'),
                        'type' => 'received'
                    );
                }
            } else {
                $payment = array();
            }

            if ($_FILES['document']['size'] > 0) {
                $this->load->library('upload');
                $config['upload_path']   = $this->digital_upload_path;
                $config['allowed_types'] = $this->digital_file_types;
                $config['max_size']      = $this->allowed_file_size;
                $config['overwrite']     = FALSE;
                $config['encrypt_name']  = TRUE;
                $this->upload->initialize($config);
                if (!$this->upload->do_upload('document')) {
                    $error = $this->upload->display_errors();
                    $this->session->set_flashdata('error', $error);
                    redirect($_SERVER["HTTP_REFERER"]);
                }
                $photo              = $this->upload->file_name;
                $data['attachment'] = $photo;
            }

            // $this->sma->print_arrays($data, $products, $payment);
        }

        $production_id = '';

        if ($this->form_validation->run() == true && $production_id = $this->productions_model->addProduction($data, $products, $payment,$arrDeliveries)) {

            /* BEGIN Send Mail */
            $this->load->model('products_model');
            $this->load->model('companies_model');

            $cssBorder = 'style="border: 1px solid black;padding: 4px;"';
            $message  = '<p>Đơn hàng sản xuất <b>'.$reference.'</b> đã được tạo vào <b>'.$create_at.'</b></p>';
            $message .= '<p>Đơn vị thức hiện: <b>'.$data['working'].'</b></p>';
            $message .= '<p>Khách hàng: <b>'.$data['customer'].'</b></p>';
            $message .= '<p>Ngày bắt đầu: <b>'.$date.'</b> | Ngày giao hàng: <b>'.$due_date.'</b></p>';
            $message .= 'Ghi chú: '.str_replace(array("\r", "\n"), "", $this->sma->decode_html($note));
            $message .= '<hr></br>';
            $message .= '<div style="text-align:center;margin-top: 20px;" >';
            $message .= '<table style="border-collapse: collapse;border: 1px solid black;margin-left:15px;">';
            $message .=   '<tr '.$cssBorder.'>';
            $message .=     '<th '.$cssBorder.'>Tên bán thành phẩm(Mã)</td>';
            $message .=     '<th '.$cssBorder.'>Số lượng cấu thành</td>';
            $message .=     '<th '.$cssBorder.'>Giá</td>';
            $message .=     '<th '.$cssBorder.'>Trọng lượng</td>';
            $message .=     '<th '.$cssBorder.'>Số lượng sản xuất</td>';
            $message .=     '<th '.$cssBorder.'>Tổng số chi tiết</td>';
            $message .=     '<th '.$cssBorder.'>Tổng tiền</td>';
            $message .=     '<th '.$cssBorder.'>Tổng khối lượng</td>';
            $message .=     '<th '.$cssBorder.'>Nhân viên</th>';
            $message .=   '</tr>';

            $products = array_reverse($products);

            $arrEmpSendMail  = array();
            $arrEmail        = array();

            foreach ($products as $product) {
                $infoProduct = $this->products_model->getProductByID($product['product_id']);
                $totalDetail = $product['quantity']*$infoProduct->quantity_config;
                $totalMoney  = $product['quantity']*$infoProduct->price;
                $totalWeight = $product['quantity']*$infoProduct->cf2;

                $arrEmployeeId      = explode(',', $product['employees']);
                $arrEmployeeName    = array();
                foreach ($arrEmployeeId as $employeeId) {
                    if (!in_array($employeeId, $arrEmpSendMail)) {
                        $arrEmpSendMail[]   = $employeeId;
                        $arrEmail[]          = $this->companies_model->getCompanyEmailByID($employeeId)->email;
                    }

                    $arrEmployeeName[]  = $this->companies_model->getCompanyNameByID($employeeId)->name;
                }

                $message .= '<tr '.$cssBorder.'>';
                $message .=   '<td '.$cssBorder.'>'.$product['product_name'].'('.$product['product_code'].')</td>';
                $message .=   '<td '.$cssBorder.'>'.$infoProduct->quantity_config.'</td>';
                $message .=   '<td '.$cssBorder.'>'.$this->sma->formatMoney($infoProduct->price).'</td>';
                $message .=   '<td '.$cssBorder.'>'.$infoProduct->cf2.'</td>';
                $message .=   '<td '.$cssBorder.'>'.$product['quantity'].'</td>';
                $message .=   '<td '.$cssBorder.'>'.$totalDetail.'</td>';
                $message .=   '<td '.$cssBorder.'>'.$this->sma->formatMoney($totalMoney).'</td>';
                $message .=   '<td '.$cssBorder.'>'.$totalWeight.'</td>';
                $message .=   '<td '.$cssBorder.'>'.implode(', ', $arrEmployeeName).'</td>';
                $message .= '</tr>';
            }

            $message .= '</table>';

            $arrUser  = $this->companies_model->getUsersEmailByGroupId(1);

            if($arrUser){
                foreach ($arrUser as $user) {
                    $arrEmail[] = $user->email;
                }
            }

            foreach ($arrEmail as $email) {
                $this->sma->send_email($email, 'Lệnh sản xuất được tạo', $message);
            }

            /* END Send Mail */

            if ($quote_id) {
                $this->db->update('quotes', array(
                    'status' => 'completed'
                ), array(
                    'id' => $quote_id
                ));
            }
            $this->session->set_flashdata('message', lang("Thêm lệnh sản xuất thành công"));
            redirect("productions/edit/" . $production_id);
        } else {

            if ($quote_id) {
                $this->data['items']      = $this->site->getAllProductionItems($quote_id);
                $this->data['production'] = $this->productions_model->getInvoiceByID($quote_id);
            }

            $this->data['error']       = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
            $this->data['quote_id']    = $quote_id;
            $this->data['billers']     = $this->site->getAllCompanies('biller');
            $this->data['warehouses']  = $this->site->getAllWarehouses();
            $this->data['tax_rates']   = $this->site->getAllTaxRates();
            $this->data['categories'] = $this->site->getAllCategories();
            //$this->data['currencies'] = $this->productions_model->getAllCurrencies();
            $this->data['slnumber']    = ''; //$this->site->getReference('so');
            $this->data['payment_ref'] = $this->site->getReference('pay');
            $bc                        = array(
                array(
                    'link' => base_url(),
                    'page' => lang('home')
                ),
                array(
                    'link' => site_url('productions'),
                    'page' => lang('Lệnh sản xuất')
                ),
                array(
                    'link' => '#',
                    'page' => lang('Thêm lệnh sản xuất')
                )
            );
            $meta                      = array(
                'page_title' => lang('Thêm lệnh sản xuất'),
                'bc' => $bc
            );
            // var_dump($this->data['slnumber']);die();
            $this->page_construct('productions/add', $meta, $this->data);
        }
    }

    function getAllStages($production_id = NULL, $product_id = NULL,$delivery_id=NULL)
    {
        if ($rows = $this->productions_model->getAllProductionStages($production_id, $product_id,$delivery_id)) {
            $data = json_encode($rows);
        } else {
            $data = false;
        }
        echo $data;
    }

    function getAllStagesNotNullDate($production_id = NULL, $product_id = NULL)
    {
        // echo $production_id;
        // echo $product_id;
        // die();
        if ($rows = $this->productions_model->getAllProductionStagesNotNullDate($production_id, $product_id)) {
            $data = json_encode($rows);
        } else {
            $data = false;
        }
        echo $data;
    }


    function getStatus()
    {
        $product_id=$this->input->get('id_product');
        $production_id=$this->input->get('id_pr');
        $delivery_id=$this->input->get('id_delivery');

        $price_ba = $this->productions_model->getProcess($product_id, $this->input->get('id_pr'));
        $rows = $this->productions_model->getStage($this->input->get('id_stage'));
        $completed=$this->productions_model->getTotalQuantityReport($production_id,$product_id);
        $rows['min'] = $price_ba[0]->quantity;
        $rows['completed']=$completed;

        echo json_encode($rows);
    }

    function modal_view($id = NULL)
    {
        $this->sma->checkPermissions('index', TRUE);

        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }

        $this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
        $inv                 = $this->productions_model->getInvoiceByID($id);

        $this->sma->view_rights($inv->created_by, TRUE);
        $this->data['customer']   = $this->site->getCompanyByID($inv->customer_id);
        $this->data['biller']     = $this->site->getCompanyByID($inv->biller_id);
        $this->data['billers']    = $this->site->getAllCompanies('biller');
        $this->data['created_by'] = $this->site->getUser($inv->created_by);
        $this->data['updated_by'] = $inv->updated_by ? $this->site->getUser($inv->updated_by) : NULL;
        $this->data['warehouse']  = $this->site->getWarehouseByID($inv->warehouse_id);
        $this->data['inv']        = $inv;


        $return = $this->productions_model->getReturnBySID($id);

        $this->data['return_sale'] = $return;
        $this->data['rows']        = $this->productions_model->getAllInvoiceItems($id);

        $this->load->view($this->theme . 'productions/modal_view', $this->data);
    }

    public function remove_comment($id)
    {
        echo json_encode(array(
            'success' => $this->productions_model->deleteComment($id)
        ));
    }

    function getItemByID($id = NULL)
    {
        if ($rows = $this->hotel_model->getItemByID($id)) {
            $data = json_encode($rows);
        } else {
            $data = false;
        }
        echo $data;
    }

    function getProductionItem($product_id = NULL, $id = NULL)
    {
        if ($rows = $this->productions_model->getProductionItem($id, $product_id)) {
            $data = json_encode($rows);
        } else {
            $data = false;
        }
        echo $data;
    }

    function norm_detail($id = NULL)
    {

        if ($this->input->post()) {
            $data = $this->input->post();
            // echo "<pre>";
            // print_r($data);
            // echo "</pre>";die();
            if ($this->productions_model->norm_detail($id, $data)) {

                $this->session->set_flashdata('message', lang("Cập nhật kế hoạch sản xuất thành công"));
                redirect($_SERVER['HTTP_REFERER']);
            } else {
                $this->session->set_flashdata('message', lang("Cập nhật kế hoạch sản xuất thất bại"));
                redirect($_SERVER['HTTP_REFERER']);
            }
        }
    }

    function edit($id = NULL)
    {
        $this->sma->checkPermissions();
        // echo "<pre>";
        // print_r($this->input->post());die();
        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }

        $a = $this->productions_model->getProduction($id);

        $this->data['a'] = $a;


        $this->form_validation->set_message('is_natural_no_zero', lang("no_zero_required"));
        $this->form_validation->set_rules('reference_no', lang("reference_no"), 'required');
        $this->form_validation->set_rules('customer', lang("customer"), 'required');
        // $this->form_validation->set_rules('biller', lang("biller"), 'required');

        // $this->form_validation->set_rules('payment_status', lang("payment_status"), 'required');
        //$this->form_validation->set_rules('note', lang("note"), 'xss_clean');

        if ($this->form_validation->run() == true) {
            // die($this->input->post('delivery_mode'));
            $quantity  = "quantity";
            $product   = "product";
            $unit_cost = "unit_cost";
            $tax_rate  = "tax_rate";
            $reference = $this->input->post('reference_no');
            if ($this->Owner || $this->Admin) {
                $date = $this->sma->fsd(trim($this->input->post('date')));
            } else {
                $date = date('Y-m-d');
            }
            $warehouse_id     = $this->input->post('warehouse');
            $customer_id      = $this->input->post('customer');
            $biller_id        = $this->input->post('biller');
            $total_items      = $this->input->post('total_items');
            $sale_status      = $this->input->post('sale_status');
            $payment_status   = $this->input->post('payment_status');
            $payment_term     = $this->input->post('payment_term');
            $due_date         = $this->input->post('due_date') ? $this->sma->fsd($this->input->post('due_date')) : NULL;

            $shipping         = $this->input->post('shipping') ? $this->input->post('shipping') : 0;
            $customer_details = $this->site->getCompanyByID($customer_id);
            $customer         = $customer_details->company ? $customer_details->company : $customer_details->name;
            $biller_details   = $this->site->getCompanyByID($biller_id);
            $biller           = $biller_details->company != '-' ? $biller_details->company : $biller_details->name;
            $note             = $this->sma->clear_tags($this->input->post('note'));
            $staff_note       = $this->sma->clear_tags($this->input->post('staff_note'));

            $total            = 0;
            $product_tax      = 0;
            $order_tax        = 0;
            $product_discount = 0;
            $order_discount   = 0;
            $percentage       = '%';
            $i                = isset($_POST['product_code']) ? sizeof($_POST['product_code']) : 0;

            $grand_total = 0;
            for ($r = 0; $r < $i; $r++) {
                $grand_total = $grand_total + $_POST['total_money'][$r];

                $item_id         = $_POST['product_id'][$r];
                $item_type       = $_POST['product_type'][$r];
                $item_code       = $_POST['product_code'][$r];
                $item_name       = $_POST['product_name'][$r];
                $item_option     = isset($_POST['product_option'][$r]) && $_POST['product_option'][$r] != 'false' ? $_POST['product_option'][$r] : NULL;
                //$option_details = $this->productions_model->getProductOptionByID($item_option);
                $real_unit_price = $this->sma->formatDecimal($_POST['real_unit_price'][$r]);
                $unit_price      = $this->sma->formatDecimal($_POST['unit_price'][$r]);
                $item_quantity   = $_POST['quantity'][$r];
                $item_serial     = isset($_POST['serial'][$r]) ? $_POST['serial'][$r] : '';
                $item_tax_rate   = isset($_POST['product_tax'][$r]) ? $_POST['product_tax'][$r] : NULL;
                $item_discount   = isset($_POST['product_discount'][$r]) ? $_POST['product_discount'][$r] : NULL;

                if (isset($item_code) && isset($real_unit_price) && isset($unit_price) && isset($item_quantity)) {
                    $product_details = $item_type != 'manual' ? $this->productions_model->getProductByCode($item_code) : NULL;
                    $unit_price      = $real_unit_price;
                    $pr_discount     = 0;

                    if (isset($item_discount)) {
                        $discount = $item_discount;
                        $dpos     = strpos($discount, $percentage);
                        if ($dpos !== false) {
                            $pds         = explode("%", $discount);
                            $pr_discount = (($this->sma->formatDecimal($unit_price)) * (Float) ($pds[0])) / 100;
                        } else {
                            $pr_discount = $this->sma->formatDecimal($discount);
                        }
                    }

                    $unit_price       = $this->sma->formatDecimal($unit_price - $pr_discount);
                    $item_net_price   = $unit_price;
                    $pr_item_discount = $this->sma->formatDecimal($pr_discount * $item_quantity);
                    $product_discount += $pr_item_discount;
                    $pr_tax      = 0;
                    $pr_item_tax = 0;
                    $item_tax    = 0;
                    $tax         = "";

                    if (isset($item_tax_rate) && $item_tax_rate != 0) {
                        $pr_tax      = $item_tax_rate;
                        $tax_details = $this->site->getTaxRateByID($pr_tax);
                        if ($tax_details->type == 1 && $tax_details->rate != 0) {

                            if ($product_details && $product_details->tax_method == 1) {
                                $item_tax = $this->sma->formatDecimal((($unit_price) * $tax_details->rate) / 100);
                                $tax      = $tax_details->rate . "%";
                            } else {
                                $item_tax       = $this->sma->formatDecimal((($unit_price) * $tax_details->rate) / (100 + $tax_details->rate));
                                $tax            = $tax_details->rate . "%";
                                $item_net_price = $unit_price - $item_tax;
                            }

                        } elseif ($tax_details->type == 2) {

                            if ($product_details && $product_details->tax_method == 1) {
                                $item_tax = $this->sma->formatDecimal((($unit_price) * $tax_details->rate) / 100);
                                $tax      = $tax_details->rate . "%";
                            } else {
                                $item_tax       = $this->sma->formatDecimal((($unit_price) * $tax_details->rate) / (100 + $tax_details->rate));
                                $tax            = $tax_details->rate . "%";
                                $item_net_price = $unit_price - $item_tax;
                            }

                            $item_tax = $this->sma->formatDecimal($tax_details->rate);
                            $tax      = $tax_details->rate;

                        }
                        $pr_item_tax = $this->sma->formatDecimal($item_tax * $item_quantity);

                    }

                    $product_tax += $pr_item_tax;
                    $subtotal = (($item_net_price * $item_quantity) + $pr_item_tax);
                    $employees = implode(",",$_POST['employees_'.$item_id]);

                    $products[] = array(
                        'product_id' => $item_id,
                        'product_code' => $item_code,
                        'product_name' => $item_name,
                        'product_type' => $item_type,
                        'option_id' => $item_option,
                        'net_unit_price' => $item_net_price,
                        'unit_price' => $this->sma->formatDecimal($item_net_price + $item_tax),
                        'quantity' => $item_quantity,
                        'warehouse_id' => $warehouse_id,
                        'item_tax' => $pr_item_tax,
                        'tax_rate_id' => $pr_tax,
                        'tax' => $tax,
                        'discount' => $item_discount,
                        'item_discount' => $pr_item_discount,
                        'subtotal' => $this->sma->formatDecimal($subtotal),
                        'serial_no' => $item_serial,
                        'real_unit_price' => $real_unit_price,
                        'employees' => (!empty($employees)) ? $employees : NULL,
                    );

                    $total += $item_net_price * $item_quantity;
                }
            }

            if (empty($products)) {
                $this->form_validation->set_rules('product', lang("order_items"), 'required');
            } else {
                krsort($products);
            }
            if ($this->input->post('order_discount')) {
                $order_discount_id = $this->input->post('order_discount');
                $opos              = strpos($order_discount_id, $percentage);
                if ($opos !== false) {
                    $ods            = explode("%", $order_discount_id);
                    $order_discount = $this->sma->formatDecimal((($total + $product_tax) * (Float) ($ods[0])) / 100);
                } else {
                    $order_discount = $this->sma->formatDecimal($order_discount_id);
                }
            } else {
                $order_discount_id = NULL;
            }
            $total_discount = $this->sma->formatDecimal($order_discount + $product_discount);

            if ($this->Settings->tax2) {
                $order_tax_id = $this->input->post('order_tax');
                if ($order_tax_details = $this->site->getTaxRateByID($order_tax_id)) {
                    if ($order_tax_details->type == 2) {
                        $order_tax = $this->sma->formatDecimal($order_tax_details->rate);
                    }
                    if ($order_tax_details->type == 1) {
                        $order_tax = $this->sma->formatDecimal((($total + $product_tax - $order_discount) * $order_tax_details->rate) / 100);
                    }
                }
            } else {
                $order_tax_id = NULL;
            }

            $total_tax   = $this->sma->formatDecimal($product_tax + $order_tax);
            // $grand_total = $this->sma->formatDecimal($this->sma->formatDecimal($total) + $total_tax + $this->sma->formatDecimal($shipping) - $order_discount);
            $data        = array(
                'date' => $date,
                'reference_no' => $reference,
                'customer_id' => $customer_id,
                'customer' => $customer,
                'biller_id' => $biller_id,
                'biller' => $biller,
                'warehouse_id' => $warehouse_id,
                'note' => $note,
                'staff_note' => $staff_note,
                'total' => $this->sma->formatDecimal($total),
                'product_discount' => $this->sma->formatDecimal($product_discount),
                'order_discount_id' => $order_discount_id,
                'order_discount' => $order_discount,
                'total_discount' => $total_discount,
                'product_tax' => $this->sma->formatDecimal($product_tax),
                'order_tax_id' => $order_tax_id,
                'order_tax' => $order_tax,
                'total_tax' => $total_tax,
                'shipping' => $this->sma->formatDecimal($shipping),
                'grand_total' => $grand_total,
                'total_items' => $total_items,

                'payment_status' => $payment_status,
                'payment_term' => $payment_term,
                'working' => $this->input->post('implementation_unit'),
                'due_date' => $due_date,
                'updated_by' => $this->session->userdata('user_id'),
                'updated_at' => date('Y-m-d H:i:s')
            );

            $delivery_mode=$this->input->post('delivery_mode');
            if($delivery_mode==1)
            {
                $data['delivery_mode']=1;
                $arrDeliveries=array('mode'=>$delivery_mode,'date'=>array('start'=>$date,'end'=>$due_date));
            }
            else
            {
                $data['delivery_mode']=0;
                $deliveries=$this->input->post('delivery_date');
                $arrDeliveries=array('mode'=>$delivery_mode,'date'=>$deliveries,'percent'=>100);
            }


            // var_dump($arrDeliveries);die();
            if ($_FILES['document']['size'] > 0) {
                $this->load->library('upload');
                $config['upload_path']   = $this->digital_upload_path;
                $config['allowed_types'] = $this->digital_file_types;
                $config['max_size']      = $this->allowed_file_size;
                $config['overwrite']     = FALSE;
                $config['encrypt_name']  = TRUE;
                $this->upload->initialize($config);
                if (!$this->upload->do_upload('document')) {
                    $error = $this->upload->display_errors();
                    $this->session->set_flashdata('error', $error);
                    redirect($_SERVER["HTTP_REFERER"]);
                }
                $photo              = $this->upload->file_name;
                $data['attachment'] = $photo;
            }


        }

        if ($this->form_validation->run() == true && $this->productions_model->updateProduction($id, $data, $products,$arrDeliveries)) {
            $this->session->set_userdata('remove_slls', 1);
            $this->session->set_flashdata('message', lang("Cập nhật lệnh sản xuất thành công"));
            redirect("productions");
        } else {

            if ($id) {
                $this->data['items'] = $this->site->getAllProductionItems($id);

            }


            $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));


            $this->data['inv'] = $this->productions_model->getInvoiceByID($id);
            $this->data['deliveries'] = array('mode'=>$this->data['inv']->delivery_mode,'deliveries'=>$this->data['inv']->deliveries);
            // var_dump($this->data['deliveries']);die();
            if ($this->data['inv']->date <= date('Y-m-d', strtotime('-3 months'))) {
                $this->session->set_flashdata('error', lang("sale_x_edited_older_than_3_months"));
                redirect($_SERVER["HTTP_REFERER"]);
            }
            $inv_items = $this->productions_model->getAllInvoiceItems($id);

            $c = rand(100000, 9999999);
            foreach ($inv_items as $item) {
                $row = $this->site->getProductByID($item->product_id);
                // var_dump($)
                if (!$row) {
                    $row             = json_decode('{}');
                    $row->tax_method = 0;
                    $row->quantity   = 0;
                } else {
                    unset($row->details, $row->product_details, $row->cost, $row->supplier1price, $row->supplier2price, $row->supplier3price, $row->supplier4price, $row->supplier5price);
                }
                $pis = $this->productions_model->getPurchasedItems($item->product_id, $item->warehouse_id, $item->option_id);
                if ($pis) {
                    foreach ($pis as $pi) {
                        $row->quantity += $pi->quantity_balance;
                    }
                }

                $row->id   = $item->product_id;
                $row->code = $item->product_code;
                $row->name = $item->product_name;
                $row->type = $item->product_type;
                $row->qty  = $item->quantity;
                $row->quantity += $item->quantity;
                $row->discount        = $item->discount ? $item->discount : '0';
                // $row->price           = $item->price;
                $row->unit_price      = $row->tax_method ? $item->unit_price + $this->sma->formatDecimal($item->item_discount / $item->quantity) + $this->sma->formatDecimal($item->item_tax / $item->quantity) : $item->unit_price + ($item->item_discount / $item->quantity);

                $row->real_unit_price = $item->real_unit_price;

                $row->tax_rate        = $item->tax_rate_id;
                $row->serial          = $item->serial_no;
                $row->option          = $item->option_id;
                $options              = $this->productions_model->getProductOptions($row->id, $item->warehouse_id);

                if ($options) {
                    $option_quantity = 0;
                    foreach ($options as $option) {
                        $pis = $this->productions_model->getPurchasedItems($row->id, $item->warehouse_id, $item->option_id);
                        if ($pis) {
                            foreach ($pis as $pi) {
                                $option_quantity += $pi->quantity_balance;
                            }
                        }
                        $option_quantity += $item->quantity;
                        if ($option->quantity > $option_quantity) {
                            $option->quantity = $option_quantity;
                        }
                    }
                }

                $ri = $this->Settings->item_addition ? $row->id : $c;

                if ($row->tax_rate) {
                    $tax_rate = $this->site->getTaxRateByID($row->tax_rate);
                    $pr[$ri]  = array(
                        'id' => $c,
                        'item_id' => $row->id,
                        'label' => $row->name . " (" . $row->code . ")",
                        'row' => $row,
                        'tax_rate' => $tax_rate,
                        'options' => $options
                    );
                } else {
                    $pr[$ri] = array(
                        'id' => $c,
                        'item_id' => $row->id,
                        'label' => $row->name . " (" . $row->code . ")",
                        'row' => $row,
                        'tax_rate' => false,
                        'options' => $options
                    );
                }

                $c++;
            }

            $this->data['inv_items']    = json_encode($pr);
            $this->data['id']           = $id;
            $this->data['billers']      = $this->site->getAllCompanies('biller');

            $this->data['wps']          = $this->working_places_model->getAllWPS();

            $this->data['tax_rates']            = $this->site->getAllTaxRates();
            $this->data['warehouses']           = $this->site->getAllWarehouses();
            $this->data['itemss']               = $this->items_model->getAllItems();
            $this->data['production_items']     = $this->productions_model->getItemByProductionID($id);

            $bc                       = array(
                array(
                    'link' => base_url(),
                    'page' => lang('home')
                ),
                array(
                    'link' => site_url('productions'),
                    'page' => lang('Lệnh sản xuất')
                ),
                array(
                    'link' => '#',
                    'page' => lang('Sửa lệnh sản xuất')
                )
            );
            $meta                     = array(
                'page_title' => lang('Sửa lệnh sản xuất'),
                'bc' => $bc
            );

            $this->page_construct('productions/edit', $meta, $this->data);
        }
    }

    function getItemQuantity(){
        $a = $this->productions_model->get_items($this->input->get('id_item'));

        $data['group'] = $this->productions_model->get_group_material_norms_item($this->input->get('id'),$this->input->get('id_item'));

        $data['item'] = $this->productions_model->get_material_norms_item($this->input->get('id'),$this->input->get('id_pro'),$this->input->get('id_item'));

        $total = $a[0]->quantity-($data['group'][0]->total_quantity1 - $data['item'][0]->total_quantity + $this->input->get('quantity'));

        $data['total_new'] = $total;

        echo json_encode($data);

    }

     function suggestions()
    {

        $term = $this->input->get('term', TRUE);
        $supplier_id = $this->input->get('supplier_id', TRUE);
        $radio_opt = (int)$this->input->get('radio_opt', TRUE);
        $cate_id = $this->input->get('cate_id', TRUE);



        $spos = strpos($term, ' ');
        if ($spos !== false) {
            $st = explode(" ", $term);
            $sr = trim($st[0]);
            $option = trim($st[1]);
        } else {
            $sr = $term;
            $option = '';
        }

        if ($cate_id == 0) {
            if($radio_opt == 1){
                $rows = $this->productions_model->getProductNames1($term);
            }else {
                $this->load->model('site');
                $rows = $this->site->getAllCategories();

            }
        }else{
            $rows = $this->productions_model->getProductNames2($cate_id);
        }

        if ($rows) {
            $c = str_replace(".", "", microtime(true)); $r = 0;
            foreach ($rows as $row) {
                $option = FALSE;
                $row->item_tax_method = $row->tax_method;
                $options = $this->enquiry_model->getProductOptions($row->id);
                if ($options) {
                    $opt = current($options);
                    if (!$option) {
                        $option = $opt->id;
                    }
                } else {
                    $opt = json_decode('{}');
                    $opt->price = 0;
                }
                $row->option = $option;
                if ($opt->price != 0) {
                    $row->price = $opt->price;
                } else {

                    $row->price = $row->price;
                    if ($supplier_id == $row->supplier1 && (! empty($row->supplier1price)) && $row->supplier1price != 0) {
                        $row->cost = $row->supplier1price;
                    } elseif ($supplier_id == $row->supplier2 && (! empty($row->supplier2price)) && $row->supplier2price != 0) {
                        $row->cost = $row->supplier2price;
                    } elseif ($supplier_id == $row->supplier3 && (! empty($row->supplier3price)) && $row->supplier3price != 0) {
                        $row->cost = $row->supplier3price;
                    } elseif ($supplier_id == $row->supplier4 && (! empty($row->supplier4price)) && $row->supplier4price != 0) {
                        $row->cost = $row->supplier4price;
                    } elseif ($supplier_id == $row->supplier5 && (! empty($row->supplier5price)) && $row->supplier5price != 0) {
                        $row->cost = $row->supplier5price;
                    }
                }

                $row->real_unit_price = $row->price;
                $row->expiry = '';
                $row->qty = 1;
                $row->quantity_balance = '';
                $row->discount = '0';
                unset($row->details, $row->product_details, $row->file, $row->supplier1price, $row->supplier2price, $row->supplier3price, $row->supplier4price, $row->supplier5price);
                if ($row->tax_rate) {
                    $tax_rate = $this->site->getTaxRateByID($row->tax_rate);
                    $pr[] = array('id' => ($c+$r), 'item_id' => $row->id, 'label' => $row->name . " (" . $row->code . ")", 'row' => $row, 'tax_rate' => $tax_rate, 'options' => $options);
                } else {
                    $pr[] = array('id' => ($c+$r), 'item_id' => $row->id, 'label' => $row->name . " (" . $row->code . ")", 'row' => $row, 'tax_rate' => false, 'options' => $options);
                }
                $r++;

            }

            echo json_encode($pr);

        } else {
            echo json_encode(array(array('id' => 0, 'label' => lang('no_match_found'), 'value' => $term, 'error' => 'error')));
        }
    }

    function addQuick(){
        if($this->productions_model->add_material_norms($this->input->get())){
            return true;

        }

        return false;


    }

    function addQuickEnquiry(){

        $subtotal = 0;
        foreach ($this->input->get('arr') as $key => $value) {
            $item = $this->productions_model->getItemNameByID($value['id']);
            $subtotal += $item->cost * $value['value'];

            $products[] = array(
                'item_id' => $item->id,
                'product_name' => $item->item,
                'net_unit_cost' => $this->sma->formatDecimal($item->cost),
                'unit_cost' => $this->sma->formatDecimal($item->cost),
                'quantity' => $value['value'],
                'quantity_balance' => $value['value'],
                'warehouse_id' => $item->warehouse_id,
                'item_tax' => 0,
                'tax_rate_id' => 0,
                'tax' => 0,
                'discount' => 0,
                'item_discount' => 0,
                'subtotal' => $this->sma->formatDecimal($item->cost * $value['value']),
                'expiry' => $item_expiry,
                'real_unit_cost' => $this->sma->formatDecimal($item->cost),
                'date' => date('Y-m-d'),
                'status' => 'approve',
            );


        }

        $data = array(
                'reference_no' =>$this->site->getReference('re'),
                'date' => date('Y-m-d H:i:s'),
                'warehouse_id' => $this->input->get('warehouse_id'),
                'note' => 'Yêu cầu nhập hàng / '. date('Y-m-d'),
                'total' => $this->sma->formatDecimal($subtotal),
                'product_discount' => 0,
                'order_discount_id' =>NULL,
                'order_discount' => 0,
                'total_discount' => 0,
                'product_tax' => 0,
                'order_tax_id' => 0,
                'order_tax' => 0,
                'total_tax' => 0,
                'shipping' => 0,
                'grand_total' => $subtotal,
                'status' => 'approve',
                'created_by' => $this->session->userdata('user_id')
        );



        if ($this->enquiry_model->addEnquiry($data, $products)) {
            echo json_encode('msg');
            return true;

        }

        return false;

    }

    function getProductByID($production_id = NULL, $product_id = NULL)
    {
        $result                  = $this->productions_model->getNormDeltail($production_id, $product_id);
        $data['productions']     = $this->productions_model->getProduction($production_id);
        $data['machinery_norms'] = $result;
        $data['selectedMachine'] = $this->productions_model->getPMachines($production_id, $product_id, $result[0]->working_place_id);
        $data['selectedEmp']     = $this->productions_model->getPEmployees($production_id, $product_id);
        $data['machine_list']    = $this->working_places_model->getAllMechines($result[0]->working_place_id);
        $data['stage_norms']     = $this->productions_model->get_production_stages($production_id, $product_id);
        // $data['deliveries']     = $this->productions_model->get_production_stages($production_id, $product_id);
        $data['material_norms']  = $this->productions_model->get_material_norms($production_id, $product_id);
        $data['qproduction']     = $this->productions_model->getQProduction($production_id,$product_id)->quantity;
        $this->load->model('settings_model');
        $data['variants']        = $this->site->getAllVariants();
        $b = $this->productions_model->get_group_material_norms($production_id, $product_id);

        $i=0;
        foreach ($b as $key => $value) {
            $a  = $this->productions_model->getItemsInWarehousesAvailable($value->item_id);
            $value->rquatity        = $a->quantity;
            $value->ex_warehouse    = $this->productions_model->getExWarehouseQuantityByProductionItemId($production_id, $value->item_id);
        }
        $data['group_material_norms'] = $b;

        if ($rows = $this->productions_model->getProductByID($product_id)) {
            $rows->cf4       = json_decode($rows->cf4);
            $rows->cf5       = json_decode($rows->cf5);

            $data['product'] = $rows;
        } else {
            $data = false;
        }
        echo json_encode($data);
    }

    function updateStatusProduction($id = NULL){

        $this->sma->checkPermissions();

        $production = $this->productions_model->getProduction($id);
        $this->data['production'] = $this->productions_model->getProduction($id);
        $this->data['deliveries'] = $this->productions_model->getDeliveryTimeByProductionID($id);
        $this->data['group_material_norms'] = $this->productions_model->get_group_material_norms_join_warehouse($id);
        $this->data['id']         = $id;
        $this->data['status']     = TRUE;

        if ($production->sale_status != 'not_start') {
            $this->data['status']     = FALSE;
        }

        $dataExWarehouse        = array();
        $dataUpdateWarehouse    = array();

        foreach ($this->data['group_material_norms'] as $material) {
            if ($material->available >= $material->total_quantity1) {
                $quantityWarehouseUpdate        = $material->available-$material->total_quantity1;
                $material->quantity_need_ex     = $material->total_quantity1;
            }else{
                $quantityWarehouseUpdate        = 0;
                $material->quantity_need_ex     = $material->available;
            }

            if ($material->quantity_need_ex != 0) {
                $dataExWarehouse[] = array(
                    'production_id' => $id,
                    'item_id'       => $material->item_id,
                    'ex_quantity'   => $material->quantity_need_ex,
                    'created_at'    => date('Y-m-d')
                );
            }
        }

        $this->data['dataExWarehouse'] = $dataExWarehouse;

        if ($this->input->post('confirm')) {
            if($production->sale_status == 'not_start'){
                if ($this->productions_model->updateStatusProduction($id)) {
                    $this->session->set_flashdata('message', 'Cập nhật trạng thái thành công');

                    $this->load->model('exwarehouses_model');
                    $this->exwarehouses_model->insertBatch($dataExWarehouse);

                }else{
                    $this->session->set_flashdata('error', 'Cập nhật trạng thái thất bại');
                }
            } else {
                $this->session->set_flashdata('error', 'Cập nhật trạng thái thất bại');
            }
            redirect("productions");
        }else{
            $this->load->view($this->theme . 'productions/view_info_items', $this->data);
        }


    }

    function cancel($id = NULL){
        $a = $this->productions_model->getProduction($id);
        if($a->sale_status=='not_start'){
            if ($this->productions_model->updateStatusProductionC($id)) {
                echo json_encode(array('status'=>'success','msg'=>'Hủy bỏ lệnh sản xuất thành công'));

            }
        } else {
            echo json_encode(array('status'=>'fail','msg'=>'Hủy bỏ lệnh sản xuất thất bại'));

        }
    }

    function delete($id = NULL){
        $data = $this->productions_model->getProduction($id);

        if($data->sale_status=='not_start'){
            if ($this->productions_model->deleteProduction($id)) {
                echo json_encode(array('status'=>'success','msg'=>'Xóa lệnh sản xuất thành công'))  ;

            }
        } else {
            echo json_encode(array('status'=>'fail','msg'=>'Xóa lệnh sản xuất thất bại'))  ;

        }
    }

    function view_process($id = NULL,$pdf = NULL, $xls = NULL)
    {
        $this->sma->checkPermissions('index');

        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }

        if ($this->input->get('xls')) {
            $xls = $this->input->get('xls');
        }



        $this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
        $inv                 = $this->productions_model->getInvoiceByID($id);

        $this->sma->view_rights($inv->created_by);
        $this->data['barcode']     = "<img src='" . site_url('products/gen_barcode/' . $inv->reference_no) . "' alt='" . $inv->reference_no . "' class='pull-left' />";

        $this->data['customer']    = $this->site->getCompanyByID($inv->customer_id);
        $this->data['payments']    = $this->productions_model->getPaymentsForSale($id);
        $this->data['biller']      = $this->site->getCompanyByID($inv->biller_id);
        $this->data['created_by']  = $this->site->getUser($inv->created_by);
        $this->data['updated_by']  = $inv->updated_by ? $this->site->getUser($inv->updated_by) : NULL;
        $this->data['warehouse']   = $this->site->getWarehouseByID($inv->warehouse_id);
        $this->data['inv']         = $inv;
        $return                    = $this->productions_model->getReturnBySID($id);
        $this->data['return_sale'] = $return;
        $this->data['material_norms'] = $this->productions_model->getMaterialNormsByProductionId($id);
        $this->data['enquiery']    = $this->productions_model->getPurchasesByProductionId($id);

        $rows                      = $this->productions_model->getAllInvoiceItems($id);



        $rows1 = $this->productions_model->getAllInvoiceItemsC($id);
        $sum_weight_comp = 0;
        $sum_weightt_comp = 0;
        foreach ($rows1 as $key => $row1v) {
            $row1v->row = $this->productions_model->getAllInvoiceItems1($id,$row1v->category_id);
            $totalw = 0;
            $totalwt = 0;
            $totaltwt = 0;
            foreach ($row1v->row as $key => $value) {
               $ab = $this->productions_model->getProcess($value->product_id, $inv->id);

            $total_pre = 0;
            foreach ($ab as $key => $value1) {


                $total_pre += ($value1->quantity/$value->quantity)*100;

            }




            $cf5 = json_decode($value->cf5);

            foreach ($cf5 as $key2 => $value2) {
               $value2->item = $this->productions_model->getItemNameByID($value2->id);

            }
            $value->cf5 = json_encode($cf5);
            $totalw += $value->cf2;
            $totaltwt += ($value->cf2*$value->quantity);
            $value->employees = $this->productions_model->getAllEmployees($id, $value->product_id);
            $value->delivery_time = $this->productions_model->GetdDliveryTimeByProductionID($id);
            foreach ($value->delivery_time as $key3 => $value3) {

                $value3->stages3    = $this->productions_model->getAllStagesT($id, $value->product_id,$value3->id);

                foreach ($value3->stages3 as $val) {

                    $emps          = '';
                    $comments      = $this->productions_model->getStageCommments($val->id);
                    $val->comments = $comments;



                    foreach (explode(',', $val->employee) as $v) {

                        $emp = $this->productions_model->getCompanyByID($v);
                        $emps .= ' <span class="label label-info">' . $emp->name . '</span>';
                        // var_dump('<span class="label label-info">'.$emp->name.'</span>');die();

                    }

                    }
            }


            $value->stages    = $this->productions_model->getAllStages($id, $value->product_id);
            $value->stages2   = $this->productions_model->getAllStagesByProductionID($id);

            foreach ($value->stages2  as $key4 => $value4) {

                $value4->stages1    = $this->productions_model->getAllStages1($id, $value->product_id, $value4->stage_id);
                if(!$value4->stages1->quantity){
                    $value4->stages1->quantity = 0;
                }

                $totalwt += ($value4->stages1->quantity)*( ($value->cf2*$value->quantity) /  ($value->quantity_config * $value->quantity));


            }



           if($value->stages){
            $value->pre = ($total_pre/count($value->stages));
           }
            }


            $row1v->totalW = $totalw;
            $row1v->totalWT = $totalwt;
            $row1v->totalTWT = $totaltwt;

            $sum_weight_comp += $row1v->totalW;
            $sum_weightt_comp += $row1v->totalWT;
            $sum_weightwt_comp += $row1v->totalTWT;

        }

        //--------------------------

        foreach ($rows as $value) {
            $ab = $this->productions_model->getProcess($value->product_id, $inv->id);

            $total_pre = 0;
            foreach ($ab as $key => $value1) {


                $total_pre += ($value1->quantity/$value->quantity)*100;

            }




            $cf5 = json_decode($value->cf5);

            foreach ($cf5 as $key2 => $value2) {
               $value2->item = $this->productions_model->getItemNameByID($value2->id);

            }
            $value->cf5 = json_encode($cf5);

            $value->employees = $this->productions_model->getAllEmployees($id, $value->product_id);
            $value->delivery_time = $this->productions_model->GetdDliveryTimeByProductionID($id);
            foreach ($value->delivery_time as $key3 => $value3) {

                $value3->stages3    = $this->productions_model->getAllStagesT($id, $value->product_id,$value3->id);

                foreach ($value3->stages3 as $val) {

                    $emps          = '';
                    $comments      = $this->productions_model->getStageCommments($val->id);
                    $val->comments = $comments;



                    foreach (explode(',', $val->employee) as $v) {

                        $emp = $this->productions_model->getCompanyByID($v);
                        $emps .= ' <span class="label label-info">' . $emp->name . '</span>';
                        // var_dump('<span class="label label-info">'.$emp->name.'</span>');die();

                    }

                    }
            }


            $value->stages    = $this->productions_model->getAllStages($id, $value->product_id);
            $value->stages2   = $this->productions_model->getAllStagesByProductionID($id);
            $value->stages_final   = $this->productions_model->getAllStagesByProductionAndProductId($id, $value->product_id);

            foreach ($value->stages_final as $val) {

                $emps          = '';
                $comments      = $this->productions_model->getStageCommments($val->id);
                $val->comments = $comments;



                foreach (explode(',', $val->employee) as $v) {

                    $emp = $this->productions_model->getCompanyByID($v);
                    $emps .= ' <span class="label label-info">' . $emp->name . '</span>';
                    // var_dump('<span class="label label-info">'.$emp->name.'</span>');die();

                }

            }

            foreach ($value->stages2  as $key4 => $value4) {

                $value4->stages1    = $this->productions_model->getAllStages1($id, $value->product_id, $value4->stage_id);

            }


           if($value->stages){
            $value->pre = ($total_pre/count($value->stages));
           }

        }

        // echo "<pre>";
        // print_r($rows);
        // echo "</pre>";die();

        $this->data['sum_WT'] = array('sum_weight_comp'=>$sum_weight_comp,'sum_weightt_comp'=>$sum_weightt_comp);

        $this->data['sum_row'] = (count($value->stages2)*2)+14;
        $this->data['sum_row_'] = (count($value->stages2)*2);
        $this->data['rows'] = $rows;
        $this->data['rows1'] = $rows1;

        $this->data['variants'] = $this->productions_model->getAllStagesByProductionID($id);

        $this->data['paypal'] = $this->productions_model->getPaypalSettings();
        $this->data['skrill'] = $this->productions_model->getSkrillSettings();
        if($xls){
            if (!empty($rows) && !empty($rows1)) {
                if($value->stages2){
                    $sum_row_stage = count($value->stages2);
                }else{
                    $sum_row_stage = 0;
                }

                $this->load->library('excel');
                $this->excel->setActiveSheetIndex(0);
                $this->excel->getActiveSheet()->setTitle(lang('productions'));


                $this->excel->getActiveSheet()->SetCellValue('A1', lang('BẢNG THEO DÕI TIẾN ĐỘ SẢN XUẤT'));

                $this->excel->getActiveSheet()->SetCellValue('A2', lang('HỢP ĐỒNG: ').$inv->reference_no );


                $this->excel->getActiveSheet()->mergeCells('A1:K1');
                $this->excel->getActiveSheet()->mergeCells('A2:K2');

                $this->excel->getActiveSheet()->SetCellValue('A4', lang('TT'));
                $this->excel->getActiveSheet()->SetCellValue('B4', lang('Tên chi tiết'));
                $this->excel->getActiveSheet()->SetCellValue('C4', lang('Đơn vị tính'));

                $style = array(
                    'alignment' => array(
                        'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                        'vertical' => PHPExcel_Style_Alignment::VERTICAL_CENTER,
                    ),
                );


                $styleColorRed = array(
                    'font'  => array(
                        'color' => array('rgb' => 'EF0808'),
                ));

                $styleColorBlue = array(
                    'font'  => array(
                        'color' => array('rgb' => '0000FF'),
                ));


                $this->excel->getActiveSheet()->mergeCells('A4:A6');
                $this->excel->getActiveSheet()->mergeCells('B4:B6');
                $this->excel->getActiveSheet()->mergeCells('C4:C6');


                $this->excel->getActiveSheet()->SetCellValue('D4', lang('Chi tiết cho 1 bộ'));
                $this->excel->getActiveSheet()->mergeCells('D4:H5');
                $this->excel->getActiveSheet()->mergeCells('D4:H4');


                $this->excel->getActiveSheet()->SetCellValue('D6', lang('Qui cách'));
                $this->excel->getActiveSheet()->SetCellValue('E6', lang('Kích thước'));
                $this->excel->getActiveSheet()->mergeCells('E6:F6');
                $this->excel->getActiveSheet()->SetCellValue('G6', lang('Số lượng'));
                $this->excel->getActiveSheet()->SetCellValue('H6', lang('Trọng lượng'));


                $this->excel->getActiveSheet()->SetCellValue('I4', lang('Số lượng bộ'));
                $this->excel->getActiveSheet()->SetCellValue('J4', lang('Tổng số chi tiết'));
                $this->excel->getActiveSheet()->SetCellValue('K4', lang('Tổng khối lượng'));


                $this->excel->getActiveSheet()->mergeCells('I4:I6');
                $this->excel->getActiveSheet()->mergeCells('J4:J6');
                $this->excel->getActiveSheet()->mergeCells('K4:K6');


                $this->excel->getActiveSheet()->SetCellValue('L4', lang('Số lượng cộng dồn'));


                $countA = 0 ;
                $countA1 = 0;
                    foreach ($rows[0]->stages2 as $key => $value) {

                        if($value->stages1){
                            if(76+($countA*1) < 91){
                                $this->excel->getActiveSheet()->SetCellValue(chr(76+($countA*1)).'5', $value->stages1->stage);
                                //-----------
                                $this->excel->getActiveSheet()->SetCellValue(chr(76+($countA*1)).'6', $value->stages1->stage_percent);
                                //-----------
                                $this->excel->getActiveSheet()->getColumnDimension(chr(76+($countA*1)))->setWidth(15);
                                $countA++;
                            }else{
                                $this->excel->getActiveSheet()->SetCellValue('A'.chr(64+($countA1*1)).'5', $value->stages1->stage);
                                //-----------
                                $this->excel->getActiveSheet()->SetCellValue('A'.chr(64+($countA1*1)).'6', $value->stages1->stage_percent);
                                //---------
                                $this->excel->getActiveSheet()->getColumnDimension('A'.chr(64+($countA1*1)))->setWidth(15);
                                $countA1++;
                            }
                        }

                    }


                if($sum_row_stage > 0){
                    if(75+($countA*1) < 91){
                        $this->excel->getActiveSheet()->mergeCells('L4:'.(chr(75+($sum_row_stage*1))).'4');
                    }else{
                        $this->excel->getActiveSheet()->mergeCells('L4:'.('A'.chr(63+($sum_row_stage*1))).'4');
                    }
                }


                $rowB = 76+$countA ;
                $rowB1 = 65+$countA1 ;
                $countB = 0 ;
                $countB1 = 0 ;
                $this->excel->getActiveSheet()->SetCellValue(chr($rowB).'4', lang('Tổng khối lượng'));

                    foreach ($rows[0]->stages2 as $key => $value) {
                        if($value->stages1){
                            if($rowB+$countB < 91){


                                $this->excel->getActiveSheet()->SetCellValue(chr($rowB+$countB).'5', $value->stages1->stage);
                                //-----------
                                $this->excel->getActiveSheet()->SetCellValue(chr($rowB+$countB).'6', $value->stages1->stage_percent);
                                //-----------
                                $this->excel->getActiveSheet()->getColumnDimension(chr($rowB+$countB))->setWidth(15);
                                $countB++;

                            }else{
                                $this->excel->getActiveSheet()->SetCellValue('A'.chr($rowB1+$countB1).'5', $value->stages1->stage);
                                //-----------
                                $this->excel->getActiveSheet()->SetCellValue('A'.chr($rowB1+$countB1).'6', $value->stages1->stage_percent);
                                //-----------
                                $this->excel->getActiveSheet()->getColumnDimension('A'.chr($rowB1+$countB1))->setWidth(15);
                                $countB1++;

                            }



                        }

                }


                if($sum_row_stage > 0){
                     if($rowB+($sum_row_stage*1)-1 < 91){
                        $this->excel->getActiveSheet()->mergeCells(chr($rowB).'4:'.(chr($rowB+($sum_row_stage*1)-1)).'4');
                    }else{
                        $this->excel->getActiveSheet()->mergeCells(chr($rowB1).'4:'.(chr($rowB1+($sum_row_stage*1)-1)).'4');
                    }

                }


                $rowC = $rowB+$countB ;
                $rowC1 = $rowB1+$countB1 ;

                if($rowC < 91){
                    $this->excel->getActiveSheet()->SetCellValue(chr($rowC).'4', lang('Mức độ hoàn thành quy đổi'));
                    //-----------
                    $this->excel->getActiveSheet()->mergeCells(chr($rowC).'4:'. chr($rowC) .'5');
                    //-----------
                    $this->excel->getActiveSheet()->getColumnDimension(chr($rowC))->setWidth(32);
                }else{
                    $this->excel->getActiveSheet()->SetCellValue('A'.chr($rowC1).'4', lang('Mức độ hoàn thành quy đổi'));
                    //-----------
                    $this->excel->getActiveSheet()->mergeCells('A'.chr($rowC1).'4:A'. chr($rowC1) .'5');
                    //-----------
                    $this->excel->getActiveSheet()->getColumnDimension('A'.chr($rowC1))->setWidth(35);
                }

                if($rowC < 91){
                    $this->excel->getActiveSheet()->SetCellValue(chr($rowC).'6', (($sum_weightt_comp/$sum_weightwt_comp)*100).'%' );
                    $this->excel->getActiveSheet()->getStyle(chr($rowC).'6')->applyFromArray($styleColorRed);

                }else{
                    $this->excel->getActiveSheet()->SetCellValue('A'.chr($rowC1).'6', (($sum_weightt_comp/$sum_weightwt_comp)*100).'%'  );
                    $this->excel->getActiveSheet()->getStyle('A'.chr($rowC1).'6')->applyFromArray($styleColorRed);
                }




                $this->excel->getActiveSheet()->SetCellValue('A7', lang('TỔNG'));
                $this->excel->getActiveSheet()->mergeCells('A7:G7');

                $this->excel->getActiveSheet()->SetCellValue('H7', $sum_weight_comp);
                 $this->excel->getActiveSheet()->SetCellValue('K7', $sum_weightwt_comp);
                if(75+($sum_row_stage*2) < 91){
                    $this->excel->getActiveSheet()->mergeCells('L7:'.chr(75+($sum_row_stage*2)).'7');
                }else{
                    $this->excel->getActiveSheet()->mergeCells('L7:A'.chr(64+($sum_row_stage*2)).'7');
                }



                if(76+($sum_row_stage*2) < 91){
                    $this->excel->getActiveSheet()->SetCellValue(chr(76+($sum_row_stage*2)).'7', $this->sma->formatNumber($sum_weightt_comp) );
                }else{
                    $this->excel->getActiveSheet()->SetCellValue('A'.chr(65+($sum_row_stage*2)).'7',$this->sma->formatNumber($sum_weightt_comp) );
                }




                if($rowC < 91 ){
                    $totalRow = chr($rowC);
                }else{
                    $totalRow = 'A'.chr($rowC1);
                }


                $this->excel->getActiveSheet()->getStyle(
                    'A4:'.$totalRow.'4'
                )->getBorders()->getAllBorders()->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);

                $this->excel->getActiveSheet()->getStyle(
                    'A5:'.$totalRow.'5'
                )->getBorders()->getAllBorders()->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);

                $this->excel->getActiveSheet()->getStyle(
                    'A6:'.$totalRow.'6'
                )->getBorders()->getAllBorders()->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);

                 $this->excel->getActiveSheet()->getStyle(
                    'A7:'.$totalRow.'7'
                )->getBorders()->getAllBorders()->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);




                $this->excel->getActiveSheet()->getStyle("A1:". $totalRow ."1")->applyFromArray($style);
                $this->excel->getActiveSheet()->getStyle("A2:". $totalRow ."2")->applyFromArray($style);
                $this->excel->getActiveSheet()->getStyle("A4:". $totalRow ."4")->applyFromArray($style);
                $this->excel->getActiveSheet()->getStyle("A5:". $totalRow ."5")->applyFromArray($style);
                $this->excel->getActiveSheet()->getStyle("A6:". $totalRow ."6")->applyFromArray($style);


                $this->excel->getActiveSheet()->getStyle("A7:". $totalRow ."7")->applyFromArray($styleColorRed);


                $rowCate = 8;
                $i= 1;
                foreach ($rows1 as $data_row) {
                     $this->excel->getActiveSheet()->getStyle("A".$rowCate.":". $totalRow .$rowCate)->applyFromArray($styleColorBlue);
                    $this->excel->getActiveSheet()->SetCellValue('A' . $rowCate, $i);

                    $this->excel->getActiveSheet()->SetCellValue('B' . $rowCate, $data_row->name);
                    $this->excel->getActiveSheet()->mergeCells('B'.$rowCate.':G'.$rowCate);

                    $this->excel->getActiveSheet()->SetCellValue('H' . $rowCate, $data_row->totalW);
                    $this->excel->getActiveSheet()->SetCellValue('I' . $rowCate, $data_row->row[0]->quantity);

                    $this->excel->getActiveSheet()->SetCellValue('K' . $rowCate, $data_row->totalW * $data_row->row[0]->quantity);


                    if(76+($sum_row_stage*2) < 91){
                        $this->excel->getActiveSheet()->SetCellValue(chr(76+($sum_row_stage*2)) . $rowCate, $data_row->totalWT);
                    }else{
                        $this->excel->getActiveSheet()->SetCellValue('A'.chr(65+($sum_row_stage*2)).$rowCate,$data_row->totalWT );
                    }


                    foreach ($data_row->row as $row) {
                        $rowCate++;

                        $this->excel->getActiveSheet()->SetCellValue('B' . $rowCate, $row->product_name);
                        $this->excel->getActiveSheet()->SetCellValue('C' . $rowCate, $row->unit);
                        $this->excel->getActiveSheet()->SetCellValue('D' . $rowCate, $row->cf1);
                        $this->excel->getActiveSheet()->SetCellValue('E' . $rowCate, $row->cf7);
                        $this->excel->getActiveSheet()->SetCellValue('F' . $rowCate, $row->cf8);
                        $this->excel->getActiveSheet()->SetCellValue('G' . $rowCate, $row->quantity_config);
                        $this->excel->getActiveSheet()->SetCellValue('H' . $rowCate, $row->cf2);
                        $this->excel->getActiveSheet()->SetCellValue('I' . $rowCate, $data_row->row[0]->quantity);
                        $this->excel->getActiveSheet()->SetCellValue('J' . $rowCate, $row->quantity_config * $data_row->row[0]->quantity);
                        $this->excel->getActiveSheet()->SetCellValue('K' . $rowCate, $row->cf2 * $data_row->row[0]->quantity);

                        $countA = 0 ;
                        $countA1= 0;
                        foreach ($row->stages2 as $key2 => $value2) {

                            if(76+($countA*1) < 91){
                                $this->excel->getActiveSheet()->SetCellValue(chr(76+($countA*1)).$rowCate, $value2->stages1->quantity);
                                $countA++;

                            }else{
                                $this->excel->getActiveSheet()->SetCellValue('A'.chr(64+($countA*1)).$rowCate, $value2->stages1->quantity);
                                $countA1++;
                            }

                        }


                        $rowB = 76+$countA ;
                        $rowB1 = 65+$countA1 ;
                        $countB = 0 ;
                        $countB1 = 0 ;
                        $totalWR = 0;
                        foreach ($row->stages2 as $key2 => $value2) {
                            if($rowB+$countB < 91){
                                $this->excel->getActiveSheet()->SetCellValue(chr($rowB+$countB).$rowCate, $value2->stages1->quantity*( ($row->cf2 * $data_row->row[0]->quantity) /($row->quantity_config * $data_row->row[0]->quantity) ));
                                //-----------
                                $countB++;

                            }else{
                                $this->excel->getActiveSheet()->SetCellValue('A'.chr($rowB1+$countB).$rowCate, $value2->stages1->quantity*( ($row->cf2 * $data_row->row[0]->quantity) /($row->quantity_config * $data_row->row[0]->quantity) ));
                                $countB1++;


                            }
                            $totalWR += $value2->stages1->quantity*( ($row->cf2 * $data_row->row[0]->quantity) /($row->quantity_config * $data_row->row[0]->quantity) );


                        }


                        $rowC = $rowB+$countB ;
                        $rowC1 = $rowB1+$countB1 ;

                        if($rowC < 91){
                            $this->excel->getActiveSheet()->SetCellValue(chr($rowC).$rowCate, $totalWR);
                        }else{
                            $this->excel->getActiveSheet()->SetCellValue('A'.chr($rowC1).$rowCate, $totalWR);
                        }

                    }


                    $rowCate++;
                    $i++;


                }

                for ($m=8; $m < $rowCate ; $m++) {
                    $this->excel->getActiveSheet()->getStyle(
                    'A'.$m.':'.$totalRow.$m
                    )->getBorders()->getAllBorders()->setBorderStyle(PHPExcel_Style_Border::BORDER_THIN);
                }

                $this->excel->getActiveSheet()->getRowDimension('1')->setRowHeight(20);
                $this->excel->getActiveSheet()->getRowDimension('2')->setRowHeight(20);



                $this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(10);
                $this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(25);
                $this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
                $this->excel->getActiveSheet()->getColumnDimension('D')->setWidth(20);
                $this->excel->getActiveSheet()->getColumnDimension('E')->setWidth(10);
                $this->excel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
                $this->excel->getActiveSheet()->getColumnDimension('G')->setWidth(20);
                $this->excel->getActiveSheet()->getColumnDimension('H')->setWidth(20);
                $this->excel->getActiveSheet()->getColumnDimension('I')->setWidth(15);
                $this->excel->getActiveSheet()->getColumnDimension('J')->setWidth(20);
                $this->excel->getActiveSheet()->getColumnDimension('K')->setWidth(20);

                $filename = 'productions_view_'.$id;
                $this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
                // if ($pdf) {
                //     $styleArray = array(
                //         'borders' => array(
                //             'allborders' => array(
                //                 'style' => PHPExcel_Style_Border::BORDER_THIN
                //             )
                //         )
                //     );
                //     $this->excel->getDefaultStyle()->applyFromArray($styleArray);
                //     $this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
                //     require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
                //     $rendererName = PHPExcel_Settings::PDF_RENDERER_MPDF;
                //     $rendererLibrary = 'MPDF';
                //     $rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
                //     if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
                //         die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' .
                //             PHP_EOL . ' as appropriate for your directory structure');
                //     }

                //     header('Content-Type: application/pdf');
                //     header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
                //     header('Cache-Control: max-age=0');

                //     $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
                //     $objWriter->save('php://output');
                //     exit();
                // }
                // if ($xls) {

                    header('Content-Type: application/vnd.ms-excel');
                    header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
                    header('Cache-Control: max-age=0');
                    ob_clean();
                    $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
                    $objWriter->save('php://output');
                    exit();
                // }

            }
            $this->session->set_flashdata('error', lang('nothing_found'));
            redirect($_SERVER["HTTP_REFERER"]);
        }
        $bc   = array(
            array(
                'link' => base_url(),
                'page' => lang('home')
            ),
            array(
                'link' => site_url('productions'),
                'page' => lang('Lệnh sản xuất')
            ),
            array(
                'link' => '#',
                'page' => lang('Tiến độ sản xuất')
            )
        );
        $meta = array(
            'page_title' => lang('Tiến độ sản xuất'),
            'bc' => $bc
        );
        $this->page_construct('productions/view', $meta, $this->data);
    }

    //  function import_csv()
    // {

    //     // $this->load->library('excel');

    //     require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . 'PHPExcel' . DIRECTORY_SEPARATOR . 'PHPExcel.php');
    //     $this->load->helper('security');
    //     $this->form_validation->set_rules('userfile', lang("upload_file"), 'xss_clean');

    //     if ($this->form_validation->run() == true) {

    //         if (isset($_FILES["userfile"])) {

    //             $this->load->library('upload');

    //             $config['upload_path']   = $this->digital_upload_path;
    //             $config['allowed_types'] = 'xlsx';
    //             $config['max_size']      = $this->allowed_file_size;
    //             $config['overwrite']     = TRUE;

    //             $this->upload->initialize($config);

    //             if (!$this->upload->do_upload()) {

    //                 $error = $this->upload->display_errors();
    //                 $this->session->set_flashdata('error', $error);
    //                 redirect("products/import_csv");
    //             }

    //             $filename      = $this->upload->file_name;
    //             $fullfile      = $this->digital_upload_path . $filename;
    //             $inputFileType = PHPExcel_IOFactory::identify($fullfile);

    //             $objReader = PHPExcel_IOFactory::createReader($inputFileType);

    //             $objReader->setReadDataOnly(true);


    //             /**  Load $inputFileName to a PHPExcel Object  **/
    //             $objPHPExcel = $objReader->load("$fullfile");

    //             $total_sheets = $objPHPExcel->getSheetCount();

    //             $allSheetName       = $objPHPExcel->getSheetNames();
    //             $objWorksheet       = $objPHPExcel->setActiveSheetIndex(0);
    //             $highestRow         = $objWorksheet->getHighestRow();
    //             $highestColumn      = $objWorksheet->getHighestColumn();
    //             $highestColumnIndex = PHPExcel_Cell::columnIndexFromString($highestColumn);
    //             $arraydata          = array();


    //             for ($row = 2; $row <= $highestRow; ++$row) {
    //                 for ($col = 0; $col < $highestColumnIndex; ++$col) {
    //                     $value                     = $objWorksheet->getCellByColumnAndRow($col, $row)->getValue();
    //                     $arraydata[$row - 2][$col] = $value;
    //                 }
    //             }

    //             $keys = array(
    //                 'code',
    //                 'supplier',
    //                 'name',
    //                 'category_code',

    //                 'unit',
    //                 'cost',
    //                 'price',
    //                 'alert_quantity'
    //             );

    //             $final = array();

    //             foreach ($arraydata as $key => $value) {
    //                 $final[] = array_combine($keys, $value);
    //             }

    //            echo '<pre>';var_dump($final);die();

    //             $rw = 2;
    //             foreach ($final as $csv_pr) {
    //                 if ($this->products_model->getProductByCode5(trim($csv_pr['code']),trim($csv_pr['supplier']))) {
    //                     $this->session->set_flashdata('error', lang("check_product_code") . " ( " . $csv_pr['code'] . ") và nhà cung cấp  (". $csv_pr['supplier'] .").". lang("Mã vật tư và nhà cung cấp đã tồn tại") . " " . lang("line_no") . " " . $rw);
    //                     redirect("products/import_csv");

    //                 }

    //                 $array = explode("-", trim($csv_pr['code']));

    //                 if ($catd = $this->products_model->getCategoryByCode(trim($csv_pr['category_code']))) {
    //                     $pr_code[]  = trim($csv_pr['code']);
    //                     $pr_supplier[] = trim($csv_pr['supplier']);
    //                     $pr_name[]  = trim($csv_pr['name']);
    //                     $pr_cat[]   = $catd->id;
    //                     $cf1[]      = $array[1];
    //                     $cf2[]      = $array[0];
    //                     $cf3[]      = $array[2];
    //                     $cf4[]      = $array[3];
    //                     $cf5[]      = $array[4];
    //                     $cf6[]      = $array[5];
    //                     $pr_unit[]  = trim($csv_pr['unit']);
    //                     $pr_cost[]  = trim($csv_pr['cost']);
    //                     $pr_price[] = trim($csv_pr['price']);
    //                     $pr_aq[]    = trim($csv_pr['alert_quantity']);


    //                 }



    //                  else {
    //                     $this->session->set_flashdata('error', lang("check_category_code") . " (" . $csv_pr['category_code'] . "). " . lang("category_code_x_exist") . " " . lang("line_no") . " " . $rw);

    //                     redirect("products/import_csv");
    //                 }

    //                 $rw++;

    //             }




    //             $ikeys = array(
    //                 'code',
    //                 'supplier1',
    //                 'name',
    //                 'category_id',
    //                 'cf1',
    //                 'cf2',
    //                 'cf3',
    //                 'cf4',
    //                 'cf5',
    //                 'cf6',
    //                 'unit',
    //                 'cost',
    //                 'price',
    //                 'alert_quantity'
    //             );


    //             $items = array();
    //             foreach (array_map(null, $pr_code,$pr_supplier, $pr_name, $pr_cat, $cf1, $cf2, $cf3, $cf4, $cf5, $cf6, $pr_unit, $pr_cost, $pr_price, $pr_aq) as $ikey => $value) {
    //                 $items[] = array_combine($ikeys, $value);
    //             }


    //         }

    //     }




    //     if ($this->form_validation->run() == true && $this->products_model->add_products($items)) {

    //         $this->session->set_flashdata('message', lang("products_added"));
    //         redirect('products');
    //     } else {

    //         $this->data['error'] = (validation_errors() ? validation_errors() : $this->session->flashdata('error'));
    //         $bc                  = array(
    //             array(
    //                 'link' => base_url(),
    //                 'page' => lang('home')
    //             ),
    //             array(
    //                 'link' => site_url('products'),
    //                 'page' => lang('products')
    //             ),
    //             array(
    //                 'link' => '#',
    //                 'page' => lang('import_products_by_exe')
    //             )
    //         );
    //         $meta                = array(
    //             'page_title' => lang('import_products_by_exe'),
    //             'bc' => $bc
    //         );
    //         $this->page_construct('products/import_csv', $meta, $this->data);
    //     }
    // }

    function view_update($id)
    {
        $this->load->helper('security');
        $this->form_validation->set_rules('product_id', lang("product_id"), 'trim|required');
        $this->form_validation->set_rules('stage_id', lang("Giai đoạn"), 'required');
        if ($this->input->post('quantity')) {
            $this->form_validation->set_rules('quantity', lang("quantity"), 'required|numeric');
        }
        $production = $this->productions_model->getProduction($id);
        if($production->sale_status != 'pending'){
           $this->sma->PermissionsModelView(false,true,'Không thể cập này tiến độ khi chưa cho vào xử lý');
        }

        if ($this->form_validation->run() == true) {
            $data              = $this->input->post();
            $data['user_id']   = $this->session->userdata('user_id');
            $data['warehouse_id'] = $production->warehouse_id;
            $data['user_name'] = $this->site->getUser($data['user_id'])->first_name . ' ' . $this->site->getUser($data['user_id'])->last_name;
            if (isset($data['note'])) {
                $data['note'] = $this->sma->clear_tags($data['note']);
            }
            unset($data['update_production']);

        } elseif ($this->input->post('update_production')) {
            $this->session->set_flashdata('error', validation_errors());
            redirect("productions");
        }


        if ($this->form_validation->run() == true && $this->productions_model->updateStage($id, $data)) {

            /* BEGIN Send Mail */

            $this->load->model('products_model');
            $this->load->model('companies_model');

            $arrEmail = array();
            $arrUser  = $this->companies_model->getUsersEmailByGroupId(1);

            if($arrUser){
                foreach ($arrUser as $user) {
                    $arrEmail[] = $user->email;
                }
            }

            $currentEmailUser = $this->companies_model->getUserEmailById($data['user_id'])->email;
            if ($currentEmailUser) {
                if (!in_array($currentEmailUser, $arrEmail)) {
                    $arrEmail[] = $currentEmailUser;
                }
            }

            $allInfoStages = $this->productions_model->getAllStagesEmployeeByProductionAndProductId($id, $data['product_id']);

            $arrEmpSendMail = array();

            foreach ($allInfoStages as $stage) {
                $arrEmpId = explode(",", $stage->employee);
                foreach ($arrEmpId as $empId) {
                    if (!in_array($empId, $arrEmpSendMail)) {
                        $arrEmpSendMail[] = $empId;
                        $arrEmail[]       = $this->companies_model->getCompanyEmailByID($empId)->email;
                    }
                }
            }

            $reference      = $this->productions_model->getProductionName($id)->reference_no;
            $infoStage      = $this->productions_model->getStageName($data['stage_id']);
            $infoProduct    = $this->products_model->getProductByID($data['product_id']);

            if ($data['stage_status'] == 0) {
                $txtStatus = 'Chưa bắt đầu';
            }elseif ($data['stage_status'] == 1) {
                $txtStatus = 'Đang xử lý';
            }else{
                $txtStatus = 'Hoàn thành';
            }

            $message  = '<p><b>Đơn hàng sản xuất '.$reference.'</b></p>';
            $message .= '<hr></br>';
            $message .= '<p>Tên nhân viên báo cáo: <b>'.$data['user_name'].'</b></p>';
            $message .= '<p>Tên bán sản phẩm: <b>'.$infoProduct->name.'</b></p>';
            $message .= '<p>Giai đoạn: <b>'.$infoStage->stage.'</b></p>';
            $message .= '<p>Trạng thái: <b>'.$txtStatus.'</b></p>';
            if ($data['stage_status'] != 2) {
                $message .= '<p>Số lượng hoàn thành: <b>'.$data['quantity'].'</b></p>';
            }
            $message .= 'Ghi chú: '.str_replace(array("\r", "\n"), "", $this->sma->decode_html($data['note']));

            foreach ($arrEmail as $email) {
                $this->sma->send_email($email, 'Cập nhật tiến độ sản xuất đơn hàng sản xuất '.$reference, $message);
            }

            /* END Send Mail */

            $this->session->set_flashdata('message', lang("Cập nhật giai đoạn thành công"));
            redirect("productions/view_process/".$id);
        } else {
            $this->data['error']    = validation_errors() ? validation_errors() : $this->session->flashdata('error');
            $this->data['comments'] = $this->productions_model->getAllStageCommments($id);

            $this->data['inv']      = $this->productions_model->getInvoiceByID($id);
            $this->data['deliveries']=$this->data['inv']->deliveries;
            $this->data['rows']     = $this->productions_model->getAllInvoiceItemsUnCompleted($id);
            $this->data['rowss']    = json_encode($this->data['rows']);

            $this->data['id']       = $id;

            $this->data['modal_js'] = $this->site->modal_js();

            $this->load->view($this->theme . 'productions/view_update', $this->data);
        }
    }

    function pdf($id = NULL, $view = NULL, $save_bufffer = NULL)
    {
        $this->sma->checkPermissions();

        if ($this->input->get('id')) {
            $id = $this->input->get('id');
        }
        $this->data['error'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('error');
        $inv                 = $this->productions_model->getInvoiceByID($id);
        $this->sma->view_rights($inv->created_by);
        $this->data['barcode']      = "<img src='" . site_url('products/gen_barcode/' . $inv->reference_no) . "' alt='" . $inv->reference_no . "' class='pull-left' />";
        $this->data['customer']     = $this->site->getCompanyByID($inv->customer_id);
        $this->data['payments']     = $this->productions_model->getPaymentsForSale($id);
        $this->data['biller']       = $this->site->getCompanyByID($inv->biller_id);
        $this->data['user']         = $this->site->getUser($inv->created_by);
        $this->data['warehouse']    = $this->site->getWarehouseByID($inv->warehouse_id);
        $this->data['inv']          = $inv;
        $return                     = $this->productions_model->getReturnBySID($id);
        $this->data['return_sale']  = $return;
        $this->data['rows']         = $this->productions_model->getAllInvoiceItems($id);
        $this->data['return_items'] = $return ? $this->productions_model->getAllReturnItems($return->id) : NULL;
        //$this->data['paypal'] = $this->sales_model->getPaypalSettings();
        //$this->data['skrill'] = $this->sales_model->getSkrillSettings();

        $name = lang("productions") . "_" . str_replace('/', '_', $inv->reference_no) . ".pdf";
        $html = $this->load->view($this->theme . 'productions/pdf', $this->data, TRUE);

        if ($view) {
            $this->load->view($this->theme . 'productions/pdf', $this->data);
        } elseif ($save_bufffer) {
            return $this->sma->generate_pdf($html, $name, $save_bufffer, $this->data['biller']->invoice_footer);
        } else {
            $this->sma->generate_pdf($html, $name, FALSE, $this->data['biller']->invoice_footer);
        }
    }

    function production_actions()
    {
        if (!$this->Owner) {
            $this->session->set_flashdata('warning', lang('access_denied'));
            redirect($_SERVER["HTTP_REFERER"]);
        }

        $this->form_validation->set_rules('form_action', lang("form_action"), 'required');

        if ($this->form_validation->run() == true) {

            if (!empty($_POST['val'])) {
                if ($this->input->post('form_action') == 'delete') {
                    foreach ($_POST['val'] as $id) {
                        $data = $this->productions_model->getProduction($id);
                        if($data->sale_status == 'not_start'){
                            $this->productions_model->deleteProduction($id);
                        }

                    }
                    $this->session->set_flashdata('message', lang("productions_deleted"));
                    redirect($_SERVER["HTTP_REFERER"]);
                }

                if ($this->input->post('form_action') == 'export_excel' || $this->input->post('form_action') == 'export_pdf') {

                    $this->load->library('excel');
                    $this->excel->setActiveSheetIndex(0);
                    $this->excel->getActiveSheet()->setTitle(lang('productions'));
                    $this->excel->getActiveSheet()->SetCellValue('A1', lang('date'));
                    $this->excel->getActiveSheet()->SetCellValue('B1', lang('reference_no'));
                    $this->excel->getActiveSheet()->SetCellValue('C1', lang('customer'));
                    $this->excel->getActiveSheet()->SetCellValue('D1', lang('Ngày giao hàng'));


                    $row = 2;
                    foreach ($_POST['val'] as $id) {
                        $sale = $this->productions_model->getInvoiceByID($id);
                        $this->excel->getActiveSheet()->SetCellValue('A' . $row, $this->sma->hrld($sale->date));
                        $this->excel->getActiveSheet()->SetCellValue('B' . $row, $sale->reference_no);
                        $this->excel->getActiveSheet()->SetCellValue('C' . $row, $sale->customer);
                        $this->excel->getActiveSheet()->SetCellValue('D' . $row, $sale->due_date);

                        $row++;
                    }

                    $this->excel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
                    $this->excel->getActiveSheet()->getColumnDimension('B')->setWidth(20);
                    $this->excel->getActiveSheet()->getColumnDimension('C')->setWidth(20);
                    $this->excel->getActiveSheet()->getColumnDimension('D')->setWidth(20);

                    $this->excel->getDefaultStyle()->getAlignment()->setVertical(PHPExcel_Style_Alignment::VERTICAL_CENTER);
                    $filename = 'productions_' . date('Y_m_d_H_i_s');
                    if ($this->input->post('form_action') == 'export_pdf') {
                        $styleArray = array(
                            'borders' => array(
                                'allborders' => array(
                                    'style' => PHPExcel_Style_Border::BORDER_THIN
                                )
                            )
                        );
                        $this->excel->getDefaultStyle()->applyFromArray($styleArray);
                        $this->excel->getActiveSheet()->getPageSetup()->setOrientation(PHPExcel_Worksheet_PageSetup::ORIENTATION_LANDSCAPE);
                        require_once(APPPATH . "third_party" . DIRECTORY_SEPARATOR . "MPDF" . DIRECTORY_SEPARATOR . "mpdf.php");
                        $rendererName        = PHPExcel_Settings::PDF_RENDERER_MPDF;
                        $rendererLibrary     = 'MPDF';
                        $rendererLibraryPath = APPPATH . 'third_party' . DIRECTORY_SEPARATOR . $rendererLibrary;
                        if (!PHPExcel_Settings::setPdfRenderer($rendererName, $rendererLibraryPath)) {
                            die('Please set the $rendererName: ' . $rendererName . ' and $rendererLibraryPath: ' . $rendererLibraryPath . ' values' . PHP_EOL . ' as appropriate for your directory structure');
                        }

                        header('Content-Type: application/pdf');
                        header('Content-Disposition: attachment;filename="' . $filename . '.pdf"');
                        header('Cache-Control: max-age=0');

                        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'PDF');
                        return $objWriter->save('php://output');
                    }
                    if ($this->input->post('form_action') == 'export_excel') {
                        header('Content-Type: application/vnd.ms-excel');
                        header('Content-Disposition: attachment;filename="' . $filename . '.xls"');
                        header('Cache-Control: max-age=0');

                        $objWriter = PHPExcel_IOFactory::createWriter($this->excel, 'Excel5');
                        return $objWriter->save('php://output');
                    }

                    redirect($_SERVER["HTTP_REFERER"]);
                }
            } else {
                $this->session->set_flashdata('error', lang("Không có danh sách nào được lựa chọn"));
                redirect($_SERVER["HTTP_REFERER"]);
            }
        } else {
            $this->session->set_flashdata('error', validation_errors());
            redirect($_SERVER["HTTP_REFERER"]);
        }
    }

    public function exportWarehouse(){
        $itemId         = $this->input->post('item_id');
        $quanExport     = $this->input->post('quan_export');
        $productionId   = $this->input->post('production_id');
        // redirect(base_url()."productions/");
        if ($this->productions_model->exportWarehouse($productionId, $itemId, $quanExport)) {
            $this->session->set_flashdata('message', 'Xuất kho thành công!');
            echo json_encode(array('status' => true));
        }else{
            echo json_encode(array('status' => false));
        }


    }
}
