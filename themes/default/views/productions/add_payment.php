<script type="text/javascript">
    if (localStorage.getItem('sldate')) {
        localStorage.removeItem('sldate');
    }
    if (!localStorage.getItem('sldate')) {
        $("#sldate").datetimepicker({
            format: site.dateFormats.js_sdate,
            fontAwesome: true,
            language: 'sma',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0
        }).datetimepicker('update', new Date());
    }

</script>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Thanh toán</h4>
        </div>

        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("productions/add_payment/".$id, $attrib); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <?= lang("date", "sldate"); ?>
                        <?php echo form_input('date','','class="form-control input-tip date" id="sldate" required="required"'); ?>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Số tiền thanh toán</label>
                        <?php echo form_input('amount', 0, 'class="form-control input-tip amount" required="required"'); ?>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group all">
                        <label>Thanh toán bằng</label>
                        <select name="paid_by" class="form-control select">
                            <option value="cash">Tiền mặt</option>
                            <option value="CC">Chuyển khoản</option>
                            <option value="visa">Thẻ tín dụng</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                <div class="form-group">
                    <label>Ghi chú</label>
                    <?php echo form_textarea('note', (isset($_POST['note']) ? $_POST['note'] : ""), 'class="form-control" id="note" style="margin-top: 10px; height: 100px;" required="required"'); ?>
                </div></div>
            </div>
        </div>


        <div id="comment"></div>
        <div class="modal-footer">
            <?php echo form_submit('update_production', lang('Lưu'), 'class="btn btn-primary"'); ?>
        </div>

        <?php echo form_close(); ?>
    </div>

</div>
<script type="text/javascript">
    $(document).on('keyup', '.amount', function () {
        console.log($(this).val());
    });

</script>
