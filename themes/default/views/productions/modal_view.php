<div class="modal-dialog modal-lg no-modal-header">
    <div class="modal-content">
        <div class="modal-body">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <?php if ($logo) { ?>
                <div class="text-center" style="margin-bottom:20px;">
                    <img src="<?= base_url() . 'assets/uploads/logos/' . $biller->logo; ?>"
                         alt="<?= $biller->company != '-' ? $biller->company : $biller->name; ?>">
                </div>
            <?php } ?>
            <div class="well well-sm">
                <div class="row bold">
                    <div class="col-xs-5">
                    <p class="bold">
                        Lệnh sản xuất: <?= $inv->reference_no; ?><br>
                        <?= lang("date"); ?>: <?= $this->sma->hrld($inv->date); ?><br>
                        <?= lang("Trạng thái"); ?>: <?= lang($inv->sale_status); ?><br>

                    </p>
                    </div>
                    <div class="col-xs-7 text-right">
                        <?php $br = $this->sma->save_barcode($inv->reference_no, 'code39', 70, false); ?>
                        <img src="<?= base_url() ?>assets/uploads/barcode<?= $this->session->userdata('user_id') ?>.png"
                             alt="<?= $inv->reference_no ?>"/>
                        <?php $this->sma->qrcode('link', urlencode(site_url('sales/view/' . $inv->id)), 2); ?>
                        <img src="<?= base_url() ?>assets/uploads/qrcode<?= $this->session->userdata('user_id') ?>.png"
                             alt="<?= $inv->reference_no ?>"/>
                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>

            <div class="row" style="margin-bottom:15px;">
<!--                 <div class="col-xs-6">

                    <?php echo $this->lang->line("from"); ?>:

                    <h2><?=  $warehouse->name ?></h2>

                    <?php



                    echo lang("address"). ": " . $warehouse->address . "<br>" .  lang("tel") . ": " . $warehouse->phone . "<br>" . lang("email") . ": " . $warehouse->email;
                    ?>
                </div> -->
                <div class="col-xs-6">
                    <?php echo $this->lang->line("to"); ?>:
                    <h2 style="margin-top:15px;"><?= $customer->company ? $customer->company : $customer->name; ?></h2>
                    <?= $customer->company ? "" : "Attn: " . $customer->name ?>

                    <?php
                    echo $customer->address . "<br>" . $customer->city . " " . $customer->postal_code . " " . $customer->state . "<br>" . $customer->country;

                    echo "<p>";

                    if ($customer->cf1 != "-" && $customer->cf1 != "") {
                        echo "<br>" . lang("ccf1") . ": " . $customer->cf1;
                    }
                    if ($customer->cf2 != "-" && $customer->cf2 != "") {
                        echo "<br>" . lang("ccf2") . ": " . $customer->cf2;
                    }
                    if ($customer->cf3 != "-" && $customer->cf3 != "") {
                        echo "<br>" . lang("ccf3") . ": " . $customer->cf3;
                    }
                    if ($customer->cf4 != "-" && $customer->cf4 != "") {
                        echo "<br>" . lang("ccf4") . ": " . $customer->cf4;
                    }
                    if ($customer->cf5 != "-" && $customer->cf5 != "") {
                        echo "<br>" . lang("ccf5") . ": " . $customer->cf5;
                    }
                    if ($customer->cf6 != "-" && $customer->cf6 != "") {
                        echo "<br>" . lang("ccf6") . ": " . $customer->cf6;
                    }

                    echo "</p>";
                    echo lang("tel") . ": <strong>" . $customer->phone . "</strong><br>" . lang("email") . ": <strong>" . $customer->email."</strong>";
                    ?>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped print-table order-table">

                    <thead>

                    <tr>
                        <th><?= lang("STT"); ?></th>
                        <th><?= lang("description"); ?></th>
                        <th>Số lượng cấu thành</th>
                        <th>Trọng lượng</th>
                        <th>Số lượng sản xuất</th>
                        <th>Tổng số chi tiết</th>
                        <th>Tổng khối lượng</th>
                        <th>Nhân viên</th>
                    </tr>

                    </thead>

                    <tbody>

                    <?php $r = 1;
                    $tax_summary = array();
                    // echo "<pre>";
                    // print_r($rows);
                    // echo "</pre>";
                    foreach ($rows as $row):
                    ?>

                        <tr>
                            <td style="text-align:center; width:40px; vertical-align:middle;"><?= $r; ?></td>
                            <td style="vertical-align:middle;">
                                <?= $row->product_name . " (" . $row->product_code . ")" . ($row->variant ? ' (' . $row->variant . ')' : ''); ?>
                                <?= $row->details ? '<br>' . $row->details : ''; ?>
                                <?= $row->serial_no ? '<br>' . $row->serial_no : ''; ?>
                            </td>
                            <td style="width: 80px; text-align:center; vertical-align:middle;"><?= $this->sma->formatNumber($row->quantity_config); ?></td>
                            <td style="text-align:right; width:100px;"><?= $this->sma->formatMoney($row->cf2); ?></td>
                            <td><?= $this->sma->formatMoney($row->quantity); ?></td>
                            <?php $total_detail = $row->quantity*$row->quantity_config; ?>
                            <td><?= $this->sma->formatMoney($total_detail); ?></td>
                            <td><?= $this->sma->formatMoney($total_detail*$row->cf2); ?></td>
                            <td style="width:120px;">
                                <?php
                                    $arr_emp = explode(',', $row->employees);
                                    foreach ($arr_emp as $emp) {
                                        foreach ($billers as $biller) {
                                            if ($emp == $biller->id) {
                                                echo $biller->name."</br>";
                                            }
                                        }
                                    }

                                 ?>

                            </td>
                        </tr>
                        <?php
                        $r++;
                    endforeach;
                    ?>
                    </tbody>
<!--                     <tfoot>
                    <?php
                    $col = 4;
                    if ($Settings->product_discount && $inv->product_discount != 0) {
                        $col++;
                    }
                    if ($Settings->tax1) {
                        $col++;
                    }
                    if ($Settings->product_discount && $inv->product_discount != 0 && $Settings->tax1) {
                        $tcol = $col - 2;
                    } elseif ($Settings->product_discount && $inv->product_discount != 0) {
                        $tcol = $col - 1;
                    } elseif ($Settings->tax1) {
                        $tcol = $col - 1;
                    } else {
                        $tcol = $col;
                    }
                    ?>
                    <?php if ($inv->grand_total != $inv->total) { ?>
                        <tr>
                            <td colspan="<?= $tcol; ?>"
                                style="text-align:right; padding-right:10px;"><?= lang("total"); ?>
                                (<?= $default_currency->code; ?>)
                            </td>
                            <?php
                            if ($Settings->tax1) {
                                echo '<td style="text-align:right;">' . $this->sma->formatMoney($inv->product_tax) . '</td>';
                            }
                            if ($Settings->product_discount && $inv->product_discount != 0) {
                                echo '<td style="text-align:right;">' . $this->sma->formatMoney($inv->product_discount) . '</td>';
                            }
                            ?>
                            <td style="text-align:right; padding-right:10px;"><?= $this->sma->formatMoney($inv->total + $inv->product_tax); ?></td>
                        </tr>
                    <?php } ?>
                    <?php if ($return_sale && $return_sale->surcharge != 0) {
                        echo '<tr><td colspan="' . $col . '" style="text-align:right; padding-right:10px;;">' . lang("return_surcharge") . ' (' . $default_currency->code . ')</td><td style="text-align:right; padding-right:10px;">' . $this->sma->formatMoney($return_sale->surcharge) . '</td></tr>';
                    }
                    ?>
                    <?php if ($inv->order_discount != 0) {
                        echo '<tr><td colspan="' . $col . '" style="text-align:right; padding-right:10px;;">' . lang("order_discount") . ' (' . $default_currency->code . ')</td><td style="text-align:right; padding-right:10px;">' . $this->sma->formatMoney($inv->order_discount) . '</td></tr>';
                    }
                    ?>
                    <?php if ($Settings->tax2 && $inv->order_tax != 0) {
                        echo '<tr><td colspan="' . $col . '" style="text-align:right; padding-right:10px;">' . lang("order_tax") . ' (' . $default_currency->code . ')</td><td style="text-align:right; padding-right:10px;">' . $this->sma->formatMoney($inv->order_tax) . '</td></tr>';
                    }
                    ?>
                    <?php if ($inv->shipping != 0) {
                        echo '<tr><td colspan="' . $col . '" style="text-align:right; padding-right:10px;;">' . lang("shipping") . ' (' . $default_currency->code . ')</td><td style="text-align:right; padding-right:10px;">' . $this->sma->formatMoney($inv->shipping) . '</td></tr>';
                    }
                    ?>
                    <tr>
                        <td colspan="<?= $col; ?>"
                            style="text-align:right; font-weight:bold;"><?= lang("total_amount"); ?>
                            (<?= $default_currency->code; ?>)
                        </td>
                        <td style="text-align:right; padding-right:10px; font-weight:bold;"><?= $this->sma->formatMoney($inv->grand_total); ?></td>
                    </tr>
                    <tr>
                        <td colspan="<?= $col; ?>"
                            style="text-align:right; font-weight:bold;"><?= lang("paid"); ?>
                            (<?= $default_currency->code; ?>)
                        </td>
                        <td style="text-align:right; font-weight:bold;"><?= $this->sma->formatMoney($inv->paid); ?></td>
                    </tr>
                    <tr>
                        <td colspan="<?= $col; ?>"
                            style="text-align:right; font-weight:bold;"><?= lang("balance"); ?>
                            (<?= $default_currency->code; ?>)
                        </td>
                        <td style="text-align:right; font-weight:bold;"><?= $this->sma->formatMoney($inv->grand_total - $inv->paid); ?></td>
                    </tr>

                    </tfoot> -->
                </table>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <?php
                        if ($inv->note || $inv->note != "") { ?>
                            <div class="well well-sm">
                                <p class="bold"><?= lang("note"); ?>:</p>
                                <div><?= $this->sma->decode_html($inv->note); ?></div>
                            </div>
                        <?php
                        }
                        if ($inv->staff_note || $inv->staff_note != "") { ?>
                            <div class="well well-sm staff_note">
                                <p class="bold"><?= lang("staff_note"); ?>:</p>
                                <div><?= $this->sma->decode_html($inv->staff_note); ?></div>
                            </div>
                        <?php } ?>
                </div>

                <div class="col-xs-5 pull-right">
                    <div class="well well-sm">
                        <p>
                            <?= lang("created_by"); ?>: <?= $created_by->first_name . ' ' . $created_by->last_name; ?> <br>
                            <?= lang("date"); ?>: <?= $this->sma->hrld($inv->date); ?>
                        </p>
                        <?php if ($inv->updated_by) { ?>
                        <p>
                            <?= lang("updated_by"); ?>: <?= $updated_by->first_name . ' ' . $updated_by->last_name;; ?><br>
                            <?= lang("update_at"); ?>: <?= $this->sma->hrld($inv->updated_at); ?>
                        </p>
                        <?php } ?>
                    </div>
                </div>
            </div>
            <?php if (!$Supplier || !$Customer) { ?>
                <div class="buttons">
                    <div class="btn-group btn-group-justified">

                        <?php if ($inv->attachment) { ?>
                            <div class="btn-group">
                                <a href="<?= site_url('welcome/download/' . $inv->attachment) ?>" class="tip btn btn-primary" title="<?= lang('attachment') ?>">
                                    <i class="fa fa-chain"></i>
                                    <span class="hidden-sm hidden-xs"><?= lang('attachment') ?></span>
                                </a>
                            </div>
                        <?php } ?>

                        <div class="btn-group">
                            <a href="<?= site_url('productions/pdf/' . $inv->id) ?>" class="tip btn btn-primary" title="<?= lang('download_pdf') ?>">
                                <i class="fa fa-download"></i>
                                <span class="hidden-sm hidden-xs"><?= lang('pdf') ?></span>
                            </a>
                        </div>
                        <div class="btn-group">
                            <a href="<?= site_url('productions/edit/' . $inv->id) ?>" class="tip btn btn-warning sledit" title="<?= lang('edit') ?>">
                                <i class="fa fa-edit"></i>
                                <span class="hidden-sm hidden-xs"><?= lang('edit') ?></span>
                            </a>
                        </div>
                        <div class="btn-group">
                            <a href="#" class="tip btn btn-danger bpo" title="<b><?= $this->lang->line("delete_sale") ?></b>"
                                data-content="<div style='width:150px;'><p><?= lang('r_u_sure') ?></p><a class='btn btn-danger' href='<?= site_url('productions/delete/' . $inv->id) ?>'><?= lang('i_m_sure') ?></a> <button class='btn bpo-close'><?= lang('no') ?></button></div>"
                                data-html="true" data-placement="top">
                                <i class="fa fa-trash-o"></i>
                                <span class="hidden-sm hidden-xs"><?= lang('delete') ?></span>
                            </a>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready( function() {
        $('.tip').tooltip();
    });
</script>
