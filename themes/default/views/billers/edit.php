<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?php echo lang('edit_biller'); ?></h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open_multipart("billers/edit/" . $biller->id, $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="row">
                <div class="col-md-6" style="display: none;">
                    <div class="form-group">
                        <?= lang("logo", "biller_logo"); ?>
                        <?php
                        $biller_logos[''] = '';
                        foreach ($logos as $key => $value) {
                            $biller_logos[$value] = $value;
                        }
                        echo form_dropdown('logo', $biller_logos, $biller->logo, 'class="form-control select" id="biller_logo" required="required" '); ?>
                    </div>
                </div>

                <div class="col-md-6"  style="display: none;">
                    <div id="logo-con" class="text-center"><img
                            src="<?= base_url('assets/uploads/logos/' . $biller->logo) ?>" alt=""></div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">

                    <div class="form-group person">
                        <label>Họ và tên *</label>
                        <?php echo form_input('name', $biller->name, 'class="form-control tip" id="name" required="required"'); ?>
                    </div>

                    <div class="form-group person">
                        <label>Lương hệ số *</label>
                        <?php echo form_input('basic_salary', $this->sma->formatNumber($biller->basic_salary), 'class="form-control tip" id="basic_salary" required="required"'); ?>
                    </div>

                    <div class="form-group">
                        <label>Phòng ban</label>
                        <select name="department" class="form-control select" id="department" style="width: 100%;">
                            <?php
                                foreach ($departments as $department) {
                                    if ($biller->department_id == $department->id) {
                                        echo '<option value="'.$department->id.'" selected>'.$department->name.'</option>';
                                    }else{
                                        echo '<option value="'.$department->id.'">'.$department->name.'</option>';
                                    }
                                }
                             ?>
                        </select>
                    </div>
                    <div class="form-group company">
                        <?= lang("company", "company"); ?>
                        <?php echo form_input('company', $biller->company, 'class="form-control tip" id="company" required="required"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang("vat_no", "vat_no"); ?>
                        <?php echo form_input('vat_no', $biller->vat_no, 'class="form-control" id="vat_no"'); ?>
                    </div>
                    <div class="form-group">
                        <?= lang("email_address", "email_address"); ?>
                        <input type="email" name="email" class="form-control" required="required" id="email_address"
                               value="<?= $biller->email ?>"/>
                    </div>


                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <?= lang("phone", "phone"); ?>
                        <input type="tel" name="phone" class="form-control" required="required" id="phone"
                               value="<?= $biller->phone ?>"/>
                    </div>
                    <div class="form-group">
                        <?= lang("address", "address"); ?>
                        <?php echo form_input('address', $biller->address, 'class="form-control" id="address" required="required"'); ?>
                    </div>
                    <div class="form-group">
                        <?= lang("state", "state"); ?>
                        <?php echo form_input('state', $biller->state, 'class="form-control" id="state"'); ?>
                    </div>
                    <div class="form-group">
                        <?= lang("city", "city"); ?>
                        <?php echo form_input('city', $biller->city, 'class="form-control" id="city"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang("country", "country"); ?>
                        <?php echo form_input('country', $biller->country, 'class="form-control" id="country"'); ?>
                    </div>
                </div>
                <div class="col-md-12" style="display: none;">
                    <div class="form-group">
                        <?= lang("invoice_footer", "invoice_footer"); ?>
                        <?php echo form_textarea('invoice_footer', $biller->invoice_footer, 'class="form-control skip" id="invoice_footer" style="height:100px;"'); ?>
                    </div>
                </div>
            </div>


        </div>
        <div class="modal-footer">
            <?php echo form_submit('edit_biller', lang('edit_biller'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" charset="utf-8">
    $(document).ready(function () {
        $('#biller_logo').change(function (event) {
            var biller_logo = $(this).val();
            $('#logo-con').html('<img src="<?=base_url('assets/uploads/logos')?>/' + biller_logo + '" alt="">');
        });
    });
</script>
<?= $modal_js ?>

