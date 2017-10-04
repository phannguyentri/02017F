<style type="text/css">
    .highcharts-container {
        overflow: auto !important;
    }
</style>
<?php
function row_status($x)
{
    if ($x == null) {
        return '';
    }elseif($x == 'cancel') {
        return '<div class="text-center"><span class="label label-danger">'.'Hủy bỏ'.'</span></div>';
    }elseif($x == 'approve') {
        return '<div class="text-center"><span class="label label-warning">'.'Đang duyệt'.'</span></div>';
    }elseif($x == 'approval') {
        return '<div class="text-center"><span class="label label-warning">'.'Đã duyệt'.'</span></div>';
    }elseif($x == 'done') {
        return '<div class="text-center"><span class="label label-warning">'.'Đã đặt hàng'.'</span></div>';
    }elseif($x == 'not_start') {
         return '<div class="text-center"><span class="label label-warning">'.'Chưa bắt đầu'.'</span></div>';
    }elseif ($x == 'pending') {
        return '<div class="text-center"><span class="label label-warning">' . lang($x) . '</span></div>';
    } elseif ($x == 'completed' || $x == 'paid' || $x == 'sent' || $x == 'received') {
        return '<div class="text-center"><span class="label label-success">' . lang($x) . '</span></div>';
    } elseif ($x == 'partial' || $x == 'transferring') {
        return '<div class="text-center"><span class="label label-info">' . lang($x) . '</span></div>';
    } elseif ($x == 'due') {
        return '<div class="text-center"><span class="label label-danger">' . lang($x) . '</span></div>';
    } else {
        return '<div class="text-center"><span class="label label-default">' . lang($x) . '</span></div>';
    }
}

?>
<?php if ($Owner && $chatData) {
    foreach ($chatData as $month_sale) {
        $months[] = date('M-Y', strtotime($month_sale->month));
        $msales[] = $month_sale->sales;
        $mtax1[] = $month_sale->tax1;
        $mtax2[] = $month_sale->tax2;
        $mpurchases[] = $month_sale->purchases;
        $mtax3[] = $month_sale->ptax;
    }
    ?>
    <div class="box" style="margin-bottom: 15px;">
        <div class="box-header">
            <h2 class="blue"><i class="fa-fw fa fa-bar-chart-o"></i><?= lang('overview_chart'); ?></h2>
        </div>
        <div class="box-content">
            <div class="row">

                <div class="col-lg-12">
                    <ul id="myTab" class="nav nav-tabs">
                       <li class="active"><a data-toggle="tab" href="#proccess-con" class="tab-grey">Tiến độ sản xuất</a></li>
                       <li><a data-toggle="tab" href="#amount-con" class="tab-grey">Tiến độ thanh toán</a></li>
                    </ul>

                    <div class="tab-content">
                        <div id="proccess-con" class="tab-pane active">
                            <div class="row">
                                <div id="amount-chart" style="width:inherit;"></div>
                            </div>
                        </div>

                        <div id="amount-con" class="tab-pane">
                            <div class="row">
                                <div id="ov-chart" style="width:inherit;"></div>
                            </div>
                        </div>
                    </div>
                </div>








                <div class="col-md-12">
                    <p class="introtext"><?php echo lang('overview_chart_heading'); ?></p>


                    <p class="text-center"><?= lang("chart_lable_toggle"); ?></p>
                </div>
            </div>
        </div>
    </div>
<?php } ?>
<div class="row" style="margin-bottom: 15px;">
    <div class="col-lg-12">
        <div class="box">
            <div class="box-header">
                <h2 class="blue"><i class="fa fa-th"></i><span class="break"></span><?= lang('quick_links') ?></h2>
            </div>
            <div class="box-content">
                <div class="col-lg-1 col-md-2 col-xs-6">
                    <a class="bblue white quick-button small" href="<?= site_url('products') ?>">
                        <i class="fa fa-barcode"></i>

                        <p><?= lang('products') ?></p>
                    </a>
                </div>
                <div class="col-lg-1 col-md-2 col-xs-6">
                    <a class="bdarkGreen white quick-button small" href="<?= site_url('sales') ?>">
                        <i class="fa fa-heart"></i>

                        <p><?= lang('sales') ?></p>
                    </a>
                </div>

                <div class="col-lg-1 col-md-2 col-xs-6">
                    <a class="blightOrange white quick-button small" href="<?= site_url('quotes') ?>">
                        <i class="fa fa-heart-o"></i>

                        <p><?= lang('quotes') ?></p>
                    </a>
                </div>

                <div class="col-lg-1 col-md-2 col-xs-6">
                    <a class="bred white quick-button small" href="<?= site_url('purchases') ?>">
                        <i class="fa fa-star"></i>

                        <p><?= lang('purchases') ?></p>
                    </a>
                </div>

                <div class="col-lg-1 col-md-2 col-xs-6">
                    <a class="bpink white quick-button small" href="<?= site_url('transfers') ?>">
                        <i class="fa fa-star-o"></i>

                        <p><?= lang('transfers') ?></p>
                    </a>
                </div>

                <div class="col-lg-1 col-md-2 col-xs-6">
                    <a class="bgrey white quick-button small" href="<?= site_url('customers') ?>">
                        <i class="fa fa-users"></i>

                        <p><?= lang('customers') ?></p>
                    </a>
                </div>

                <div class="col-lg-1 col-md-2 col-xs-6">
                    <a class="bgrey white quick-button small" href="<?= site_url('suppliers') ?>">
                        <i class="fa fa-users"></i>

                        <p><?= lang('suppliers') ?></p>
                    </a>
                </div>
                <?php if ($Owner || $Admin) { ?>
                    <div class="col-lg-1 col-md-2 col-xs-6">
                        <a class="blightBlue white quick-button small" href="<?= site_url('notifications') ?>">
                            <i class="fa fa-comments"></i>

                            <p><?= lang('notifications') ?></p>
                            <!--<span class="notification green">4</span>-->
                        </a>
                    </div>
                <?php }
                if ($Owner) { ?>
                    <div class="col-lg-1 col-md-2 col-xs-6">
                        <a class="bblue white quick-button small" href="<?= site_url('auth/users') ?>">
                            <i class="fa fa-group"></i>

                            <p><?= lang('users') ?></p>
                            <!--<span class="notification blue">7</span>-->
                        </a>
                    </div>
                    <div class="col-lg-1 col-md-2 col-xs-6">
                        <a class="bblue white quick-button small" href="<?= site_url('system_settings') ?>">
                            <i class="fa fa-cogs"></i>

                            <p><?= lang('settings') ?></p>
                        </a>
                    </div>
                <?php } ?>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

</div>

<?php if ($this->Customer) { ?>
    <div class="row" style="margin-bottom: 15px;">
        <div class="col-md-4">
            <!-- small box -->
            <div class="small-box bblue white">
                <div class="inner">
                    <div class="col-md-4">
                        <h3><?= '0.00' ?></h3>

                        <p>Invoice <br>Amount</p>
                    </div>
                    <div class="col-md-4">
                        <h3><?= '0.00' ?></h3>

                        <p>Total <br>Paid</p>
                    </div>
                    <div class="col-md-4">
                        <h3><?= '0.00' ?></h3>

                        <p>Rest <br>Amount</p>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-md-8">
            <div class="row">
                <div class="col-md-2">
                    <div class="small-box blightOrange">
                        <div class="inner clearfix">
                            <a href="<?= site_url('orders/drafts') ?>">
                                <h3><?= '0.00' ?></h3>

                                <p>Drafts<br>Orders</p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="small-box blightBlue">
                        <div class="inner clearfix">
                            <a href="<?= site_url('orders/opened_orders') ?>">
                                <h3><?= '0.00' ?></h3>

                                <p>Opened<br>Orders</p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="small-box bred">
                        <div class="inner clearfix">
                            <a href="<?= site_url('orders/cancelled_orders') ?>">
                                <h3><?= '0.00' ?></h3>

                                <p>Cancelled<br>Orders</p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="small-box bdarkGreen">
                        <div class="inner clearfix">
                            <a href="<?= site_url('orders/completed_orders') ?>">
                                <h3><?= '0.00' ?></h3>

                                <p>Completed<br>Orders</p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="small-box bgrey">
                        <div class="inner clearfix">
                            <a href="<?= site_url('orders/back_orders') ?>">
                                <h3><?= '0.00' ?></h3>

                                <p>Back <br>Orders</p>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="small-box borange">
                        <div class="inner clearfix">
                            <a href="<?= site_url('quotes') ?>">
                                <h3><?= '0.00' ?></h3>

                                <p>Quotations<br>&nbsp;</p>
                            </a>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
<?php } ?>

<div class="row" style="margin-bottom: 15px;">
    <div class="col-md-12">
        <div class="box">
            <div class="box-header">
                <h2 class="blue"><i class="fa-fw fa fa-tasks"></i> <?= lang('latest_five') ?></h2>
            </div>
            <div class="box-content">
                <div class="row">
                    <div class="col-md-12">

                        <ul id="dbTab" class="nav nav-tabs">
                            <?php if ($Owner || $Admin || $GP['sales-index']) { ?>
                            <li class=""><a href="#sales"><?= lang('sales') ?></a></li>
                            <?php } if ($Owner || $Admin || $GP['quotes-index']) { ?>

                            <?php } if ($Owner || $Admin || $GP['purchases-index']) { ?>
                            <li class=""><a href="#purchases"><?= lang('purchases') ?></a></li>
                            <li class=""><a href="#enquiry"><?= lang('enquiry') ?></a></li>
                            <?php } if ($Owner || $Admin || $GP['transfers-index']) { ?>
                            <li class=""><a href="#transfers"><?= lang('transfers') ?></a></li>
                            <?php } if ($Owner || $Admin || $GP['customers-index']) { ?>
                            <li class=""><a href="#customers"><?= lang('customers') ?></a></li>
                            <?php } if ($Owner || $Admin || $GP['suppliers-index']) { ?>
                            <li class=""><a href="#suppliers"><?= lang('suppliers') ?></a></li>
                            <?php } ?>
                        </ul>

                        <div class="tab-content">
                        <?php if ($Owner || $Admin || $GP['sales-index']) { ?>

                            <div id="sales" class="tab-pane fade in">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="table-responsive">
                                            <table id="sales-tbl" cellpadding="0" cellspacing="0" border="0"
                                                   class="table table-bordered table-hover table-striped"
                                                   style="margin-bottom: 0;">
                                                <thead>
                                                <tr>
                                                    <th style="width:30px !important;">#</th>
                                                    <th><?= $this->lang->line("date"); ?></th>
                                                    <th><?= $this->lang->line("reference_no"); ?></th>
                                                    <th><?= $this->lang->line("customer"); ?></th>
                                                    <th><?= $this->lang->line("status"); ?></th>
                                                    <th><?= $this->lang->line("total"); ?></th>
                                                    <th><?= $this->lang->line("payment_status"); ?></th>
                                                    <th><?= $this->lang->line("paid"); ?></th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php if (!empty($sales)) {
                                                    $r = 1;
                                                    foreach ($sales as $order) {
                                                        echo '<tr id="' . $order->id . '" class="' . ($order->pos ? "receipt_link" : "invoice_link") . '"><td>' . $r . '</td>
                                                            <td>' . $this->sma->hrld($order->date) . '</td>
                                                            <td>' . $order->reference_no . '</td>
                                                            <td>' . $order->customer . '</td>
                                                            <td>' . row_status($order->sale_status) . '</td>
                                                            <td class="text-right">' . $this->sma->formatMoney($order->grand_total) . '</td>
                                                            <td>' . row_status($order->payment_status) . '</td>
                                                            <td class="text-right">' . $this->sma->formatMoney($order->paid) . '</td>
                                                        </tr>';
                                                        $r++;
                                                    }
                                                } else { ?>
                                                    <tr>
                                                        <td colspan="7"
                                                            class="dataTables_empty"><?= lang('no_data_available') ?></td>
                                                    </tr>
                                                <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <?php } if ($Owner || $Admin || $GP['quotes-index']) { ?>

                            <div id="quotes" class="tab-pane fade">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="table-responsive">
                                            <table id="quotes-tbl" cellpadding="0" cellspacing="0" border="0"
                                                   class="table table-bordered table-hover table-striped"
                                                   style="margin-bottom: 0;">
                                                <thead>
                                                <tr>
                                                    <th style="width:30px !important;">#</th>
                                                    <th><?= $this->lang->line("date"); ?></th>
                                                    <th><?= $this->lang->line("reference_no"); ?></th>
                                                    <th><?= $this->lang->line("customer"); ?></th>
                                                    <th><?= $this->lang->line("status"); ?></th>
                                                    <th><?= $this->lang->line("amount"); ?></th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php if (!empty($quotes)) {
                                                    $r = 1;
                                                    foreach ($quotes as $quote) {
                                                        echo '<tr id="' . $quote->id . '" class="quote_link"><td>' . $r . '</td>
                                                        <td>' . $this->sma->hrld($quote->date) . '</td>
                                                        <td>' . $quote->reference_no . '</td>
                                                        <td>' . $quote->customer . '</td>
                                                        <td>' . row_status($quote->status) . '</td>
                                                        <td class="text-right">' . $this->sma->formatMoney($quote->grand_total) . '</td>
                                                    </tr>';
                                                        $r++;
                                                    }
                                                } else { ?>
                                                    <tr>
                                                        <td colspan="6"
                                                            class="dataTables_empty"><?= lang('no_data_available') ?></td>
                                                    </tr>
                                                <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <?php } if ($Owner || $Admin || $GP['purchases-index']) { ?>

                            <div id="purchases" class="tab-pane fade in">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="table-responsive">
                                            <table id="purchases-tbl" cellpadding="0" cellspacing="0" border="0"
                                                   class="table table-bordered table-hover table-striped"
                                                   style="margin-bottom: 0;">
                                                <thead>
                                                <tr>
                                                    <th style="width:30px !important;">#</th>
                                                    <th><?= $this->lang->line("date"); ?></th>
                                                    <th><?= $this->lang->line("reference_no"); ?></th>
                                                    <th><?= $this->lang->line("supplier"); ?></th>
                                                    <th><?= $this->lang->line("status"); ?></th>
                                                    <th><?= $this->lang->line("amount"); ?></th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php if (!empty($purchases)) {
                                                    $r = 1;
                                                    foreach ($purchases as $purchase) {
                                                        echo '<tr id="' . $purchase->id . '" class="purchase_link"><td>' . $r . '</td>
                                                    <td>' . $this->sma->hrld($purchase->date) . '</td>
                                                    <td>' . $purchase->reference_no . '</td>
                                                    <td>' . $purchase->supplier . '</td>
                                                    <td>' . row_status($purchase->status) . '</td>
                                                    <td class="text-right">' . $this->sma->formatMoney($purchase->grand_total) . '</td>
                                                </tr>';
                                                        $r++;
                                                    }
                                                } else { ?>
                                                    <tr>
                                                        <td colspan="6"
                                                            class="dataTables_empty"><?= lang('no_data_available') ?></td>
                                                    </tr>
                                                <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div id="enquiry" class="tab-pane fade in">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="table-responsive">
                                            <table id="purchases-tbl" cellpadding="0" cellspacing="0" border="0"
                                                   class="table table-bordered table-hover table-striped"
                                                   style="margin-bottom: 0;">
                                                <thead>
                                                <tr>
                                                    <th style="width:30px !important;">#</th>
                                                    <th><?= $this->lang->line("date"); ?></th>
                                                    <th><?= $this->lang->line("reference_no"); ?></th>
                                                    <th><?= $this->lang->line("supplier"); ?></th>
                                                    <th><?= $this->lang->line("status"); ?></th>
                                                    <th><?= $this->lang->line("amount"); ?></th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php if (!empty($enquiries)) {
                                                    $r = 1;
                                                    foreach ($enquiries as $purchase) {
                                                        echo '<tr id="' . $purchase->id . '" class="purchase_link"><td>' . $r . '</td>
                                                    <td>' . $this->sma->hrld($purchase->date) . '</td>
                                                    <td>' . $purchase->reference_no . '</td>
                                                    <td>' . $purchase->supplier . '</td>
                                                    <td>' . row_status($purchase->status) . '</td>
                                                    <td class="text-right">' . $this->sma->formatMoney($purchase->grand_total) . '</td>
                                                </tr>';
                                                        $r++;
                                                    }
                                                } else { ?>
                                                    <tr>
                                                        <td colspan="6"
                                                            class="dataTables_empty"><?= lang('no_data_available') ?></td>
                                                    </tr>
                                                <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <?php } if ($Owner || $Admin || $GP['transfers-index']) { ?>

                            <div id="transfers" class="tab-pane fade">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="table-responsive">
                                            <table id="transfers-tbl" cellpadding="0" cellspacing="0" border="0"
                                                   class="table table-bordered table-hover table-striped"
                                                   style="margin-bottom: 0;">
                                                <thead>
                                                <tr>
                                                    <th style="width:30px !important;">#</th>
                                                    <th><?= $this->lang->line("date"); ?></th>
                                                    <th><?= $this->lang->line("reference_no"); ?></th>
                                                    <th><?= $this->lang->line("from"); ?></th>
                                                    <th><?= $this->lang->line("to"); ?></th>
                                                    <th><?= $this->lang->line("status"); ?></th>
                                                    <th><?= $this->lang->line("amount"); ?></th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php if (!empty($transfers)) {
                                                    $r = 1;
                                                    foreach ($transfers as $transfer) {
                                                        echo '<tr id="' . $transfer->id . '" class="transfer_link"><td>' . $r . '</td>
                                                <td>' . $this->sma->hrld($transfer->date) . '</td>
                                                <td>' . $transfer->transfer_no . '</td>
                                                <td>' . $transfer->from_warehouse_name . '</td>
                                                <td>' . $transfer->to_warehouse_name . '</td>
                                                <td>' . row_status($transfer->status) . '</td>
                                                <td class="text-right">' . $this->sma->formatMoney($transfer->grand_total) . '</td>
                                            </tr>';
                                                        $r++;
                                                    }
                                                } else { ?>
                                                    <tr>
                                                        <td colspan="7"
                                                            class="dataTables_empty"><?= lang('no_data_available') ?></td>
                                                    </tr>
                                                <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <?php } if ($Owner || $Admin || $GP['customers-index']) { ?>

                            <div id="customers" class="tab-pane fade in">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="table-responsive">
                                            <table id="customers-tbl" cellpadding="0" cellspacing="0" border="0"
                                                   class="table table-bordered table-hover table-striped"
                                                   style="margin-bottom: 0;">
                                                <thead>
                                                <tr>
                                                    <th style="width:30px !important;">#</th>
                                                    <th><?= $this->lang->line("company"); ?></th>
                                                    <th><?= $this->lang->line("name"); ?></th>
                                                    <th><?= $this->lang->line("email"); ?></th>
                                                    <th><?= $this->lang->line("phone"); ?></th>
                                                    <th><?= $this->lang->line("address"); ?></th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php if (!empty($customers)) {
                                                    $r = 1;
                                                    foreach ($customers as $customer) {
                                                        echo '<tr id="' . $customer->id . '" class="customer_link pointer"><td>' . $r . '</td>
                                            <td>' . $customer->company . '</td>
                                            <td>' . $customer->name . '</td>
                                            <td>' . $customer->email . '</td>
                                            <td>' . $customer->phone . '</td>
                                            <td>' . $customer->address . '</td>
                                        </tr>';
                                                        $r++;
                                                    }
                                                } else { ?>
                                                    <tr>
                                                        <td colspan="6"
                                                            class="dataTables_empty"><?= lang('no_data_available') ?></td>
                                                    </tr>
                                                <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <?php } if ($Owner || $Admin || $GP['suppliers-index']) { ?>

                            <div id="suppliers" class="tab-pane fade">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="table-responsive">
                                            <table id="suppliers-tbl" cellpadding="0" cellspacing="0" border="0"
                                                   class="table table-bordered table-hover table-striped"
                                                   style="margin-bottom: 0;">
                                                <thead>
                                                <tr>
                                                    <th style="width:30px !important;">#</th>
                                                    <th><?= $this->lang->line("company"); ?></th>
                                                    <th><?= $this->lang->line("name"); ?></th>
                                                    <th><?= $this->lang->line("email"); ?></th>
                                                    <th><?= $this->lang->line("phone"); ?></th>
                                                    <th><?= $this->lang->line("address"); ?></th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <?php if (!empty($suppliers)) {
                                                    $r = 1;
                                                    foreach ($suppliers as $supplier) {
                                                        echo '<tr id="' . $supplier->id . '" class="supplier_link pointer"><td>' . $r . '</td>
                                        <td>' . $supplier->company . '</td>
                                        <td>' . $supplier->name . '</td>
                                        <td>' . $supplier->email . '</td>
                                        <td>' . $supplier->phone . '</td>
                                        <td>' . $supplier->address . '</td>
                                    </tr>';
                                                        $r++;
                                                    }
                                                } else { ?>
                                                    <tr>
                                                        <td colspan="6"
                                                            class="dataTables_empty"><?= lang('no_data_available') ?></td>
                                                    </tr>
                                                <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <?php } ?>

                        </div>


                    </div>

                </div>

            </div>
        </div>
    </div>
<?php
    $arr_total_final_process = array();
    $arr_uncomplete = array();

    foreach ($productions_chart as $val) {

        $total_final_process = 0;
        $production_items = $this->productions_model->getProductionItemPID($val->id);

        foreach ($production_items as $value) {

            $production_stages = $this->productions_model->getAllStagesByProductionAndProductId($val->id, $value->product_id);
            $count_stages = 0;
            $progress = 0;
            foreach ($production_stages as $production_stage) {
                if ($production_stage->date_start != NULL && $production_stage->date_end != NULL) {
                    $count_stages++;
                }
            }
            foreach ($production_stages as $production_stage) {

                if ($production_stage->date_start != NULL && $production_stage->date_end != NULL) {
                    $total_detail = $value->quantity_config*$value->quantity;
                    $progress += ($production_stage->quantity > $total_detail) ? 100 : ($production_stage->quantity/$total_detail)*100;
                }

            }
            $final_progress = ($progress/($count_stages*100))*100;
            $total_final_process += $final_progress;

        }

        // echo "<h1>Total Final Process: ".$total_final_process.",".count($production_items)."</h1>";
        // echo "<h1>Total Final Percent: ".($total_final_process/(count($production_items)*100)*100)."</h1>";
        $arr_total_final_process[]  = $this->sma->formatNumber($total_final_process/(count($production_items)*100)*100);
        $arr_uncomplete[]           = $this->sma->formatNumber(100 - ($total_final_process/(count($production_items)*100)*100));

    }

    // echo "<pre>";
    // print_r($arr_total_final_process);
    // echo "</pre>";




    $arr_reference_no   = array();
    $arr_amount         = array();
    $arr_grand_total    = array();
    $arr_unpaid         = array();

    foreach ($productions_chart as $val) {
        $arr_reference_no[] = $val->reference_no;
        $arr_amount[]       = ($val->amount) ? $val->amount : 0;
        $arr_grand_total[]  = $val->grand_total;
        $arr_unpaid[]       = (($val->grand_total - $val->amount) > 0) ? $val->grand_total - $val->amount : 0;
    }



 ?>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('.order').click(function () {
            window.location.href = '<?=site_url()?>orders/view/' + $(this).attr('id') + '#comments';
        });
        $('.invoice').click(function () {
            window.location.href = '<?=site_url()?>orders/view/' + $(this).attr('id');
        });
        $('.quote').click(function () {
            window.location.href = '<?=site_url()?>quotes/view/' + $(this).attr('id');
        });
    });
</script>

<?php if ($Owner && $chatData) { ?>
    <style type="text/css" media="screen">
        .tooltip-inner {
            max-width: 500px;
        }
    </style>
    <script src="<?= $assets; ?>js/hc/highcharts.js"></script>
    <script type="text/javascript">
        $(function () {
            arr_reference_no = <?= json_encode($arr_reference_no) ?>;
            console.log(arr_reference_no.toString());
            Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
                return {
                    radialGradient: {cx: 0.5, cy: 0.3, r: 0.7},
                    stops: [[0, color], [1, Highcharts.Color(color).brighten(-0.3).get('rgb')]]
                };
            });

            $('#amount-chart').highcharts({
                chart: {
                    type: 'column'
                },

                title: {
                    text: ''
                },

                xAxis: {
                    categories: <?= json_encode($arr_reference_no); ?>
                },

                yAxis: {
                    allowDecimals: false,
                    min: 0,
                    title: {
                        text: 'Số phần trăm'
                    }
                },

                tooltip: {
                    formatter: function () {
                        return '<b>' + this.x + '</b><br/>' +
                            this.series.name + ': ' + this.y + '%<br/>' +
                            'Trong: ' + this.point.stackTotal + '%';
                    }
                },

                plotOptions: {
                    column: {
                        stacking: 'normal'
                    }
                },

                series: [{
                    name: 'Đã hoàn thành',
                    data: [<?= implode($arr_total_final_process, ',') ?>],
                    stack: 'process',
                    color: '#90ed7d'
                }, {
                    name: 'Chưa hoàn thành',
                    data: [<?= implode($arr_uncomplete, ',') ?>],
                    stack: 'process',
                    color: '#434348'
                }]
            });

            $('#ov-chart').highcharts({
                chart: {
                    type: 'column'
                },

                title: {
                    text: ''
                },

                xAxis: {
                    categories: <?= json_encode($arr_reference_no); ?>
                },

                yAxis: {
                    allowDecimals: false,
                    min: 0,
                    title: {
                        text: 'Số tiền'
                    }
                },

                tooltip: {
                    formatter: function () {
                        return '<b>' + this.x + '</b><br/>' +
                            this.series.name + ': ' + this.y + '<br/>' +
                            'Tổng: ' + this.point.stackTotal;
                    }
                },

                plotOptions: {
                    column: {
                        stacking: 'normal'
                    }
                },

                series: [{
                    name: 'Đã thanh toán',
                    data: [<?= implode($arr_amount, ',') ?>],
                    stack: 'payment',
                    color: '#90ed7d'
                }, {
                    name: 'Chưa thanh toán',
                    data: [<?= implode($arr_unpaid, ',') ?>],
                    stack: 'payment',
                    color: '#f7a35c'
                }]

            });
        });
    </script>

    <script type="text/javascript">

    </script>
   <!--  <div class="row" style="margin-bottom: 15px;">
        <div class="col-sm-6">
            <div class="box">
                <div class="box-header">
                    <h2 class="blue"><i
                            class="fa-fw fa fa-bar-chart-o"></i><?= lang('best_seller'), ' (' . date('M-Y', time()) . ')'; ?>
                    </h2>
                </div>
                <div class="box-content">
                    <div class="row">
                        <div class="col-md-12">
                            <div id="bschart" style="width:100%; height:450px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="box">
                <div class="box-header">
                    <h2 class="blue"><i
                            class="fa-fw fa fa-bar-chart-o"></i><?= lang('best_seller') . ' (' . date('M-Y', strtotime('-1 month')) . ')'; ?>
                    </h2>
                </div>
                <div class="box-content">
                    <div class="row">
                        <div class="col-md-12">
                            <div id="lmbschart" style="width:100%; height:450px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> -->
<?php } ?>

