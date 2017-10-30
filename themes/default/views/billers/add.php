<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel"><?php echo lang('add_biller'); ?></h4>
        </div>

        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open_multipart("billers/add", $attrib); ?>
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
                        echo form_dropdown('logo', $biller_logos, 'logo-foso-06.gif', 'class="form-control select" id="biller_logo"'); ?>
                    </div>
                </div>

                <div class="col-md-6">
                    <div id="logo-con" class="text-center"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">

                    <div class="form-group person">
                        <label>Họ và tên *</label>
                        <?php echo form_input('name', '', 'class="form-control tip" id="name" data-bv-notempty="true"'); ?>
                    </div>

                    <div class="form-group">
                        <label>Phòng ban</label>
                        <select name="department" class="form-control select" id="department" style="width: 100%;">
                            <?php
                                foreach ($departments as $department) {
                                    echo '<option value="'.$department->id.'">'.$department->name.'</option>';
                                }
                             ?>
                        </select>
                    </div>

                    <div class="form-group person">
                        <label>Lương hệ số *</label>
                        <?php echo form_input('basic_salary', '', 'class="form-control tip" id="basic_salary" data-bv-notempty="true"'); ?>
                    </div>

                    <div class="form-group person">
                        <label>Lương đóng BHXH</label>
                        <?php echo form_input('social_insurance', '', 'class="form-control tip" id="basic_salary"'); ?>
                    </div>

                    <div class="form-group person">
                        <label>Hệ số HTCV</label>
                        <?php echo form_input('coefficient_htcv', '', 'class="form-control tip" "'); ?>
                    </div>

                    <div class="form-group person">
                        <label>Hệ số lương</label>
                        <?php echo form_input('coefficient_salary', '', 'class="form-control tip" "'); ?>
                    </div>

                    <div class="form-group person">
                        <label>Hệ số quản lý</label>
                        <?php echo form_input('coefficient_manage', '', 'class="form-control tip"'); ?>
                    </div>

                    <div class="form-group person">
                        <label>HS kỹ năng chuyên môn</label>
                        <?php echo form_input('coefficient_specialize', '', 'class="form-control tip"'); ?>
                    </div>

                    <div class="form-group person">
                        <label>Hệ số thâm niên</label>
                        <?php echo form_input('coefficient_seniority', '', 'class="form-control tip"'); ?>
                    </div>

                    <div class="form-group person">
                        <label>Phần trăm thâm niên</label>
                        <?php echo form_input('percent_seniority', '', 'class="form-control tip"'); ?>
                    </div>



                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <?= lang("phone", "phone"); ?>
                        <input type="tel" name="phone" class="form-control" required="required" id="phone"/>
                    </div>
                    <div class="form-group">
                        <?= lang("address", "address"); ?>
                        <?php echo form_input('address', '', 'class="form-control" id="address" required="required"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang("state", "state"); ?>
                        <?php echo form_input('state', '', 'class="form-control" id="state"'); ?>
                    </div>
                    <div class="form-group">
                        <?= lang("city", "city"); ?>
                        <?php echo form_input('city', '', 'class="form-control" id="city"'); ?>
                    </div>
                    <div class="form-group">
                        <?= lang("country", "country"); ?>
                        <?php echo form_input('country', 'Việt Nam', 'class="form-control" id="country"'); ?>
                    </div>

                    <div class="form-group company">
                        <?= lang("company", "company"); ?>
                        <?php echo form_input('company', '', 'class="form-control tip" id="company" data-bv-notempty="true"'); ?>
                    </div>

                    <div class="form-group">
                        <?= lang("vat_no", "vat_no"); ?>
                        <?php echo form_input('vat_no', '', 'class="form-control" id="vat_no"'); ?>
                    </div>
                    <div class="form-group">
                        <?= lang("email_address", "email_address"); ?>
                        <input type="email" name="email" class="form-control" required="required" id="email_address"/>
                    </div>

                    <div class="form-group person">
                        <label>Hệ số hiệu suất</label>
                        <?php echo form_input('efficiency', '', 'class="form-control tip"'); ?>
                    </div>

                    <div class="form-group person">
                        <label>Phần trăm hiệu suất</label>
                        <?php echo form_input('percent_efficiency', '', 'class="form-control tip"'); ?>
                    </div>

                </div>

                <div class="col-md-12" style="display: none;">
                    <div class="form-group">
                        <?= lang("invoice_footer", "invoice_footer"); ?>
                        <?php echo form_textarea('invoice_footer', '', 'class="form-control skip" id="invoice_footer" style="height:100px;"'); ?>
                    </div>
                </div>
            </div>


        </div>
        <div class="modal-footer">
            <?php echo form_submit('add_biller', lang('add_biller'), 'class="btn btn-primary"'); ?>
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
