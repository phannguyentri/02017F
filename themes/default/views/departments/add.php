<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Thêm phòng ban</h4>
        </div>
        <?php echo form_open("departments/add"); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="col-md-6">
                <div class="form-group">
                    <label for="percent">Tên phòng ban</label>
                    <div class="controls">
                        <?php echo form_input('name', '', 'class="form-control" id="percent" required="required"'); ?>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="form-group">
                    <label>Loại phòng ban</label>
                    <select name="type" class="form-control type" style="width: 100%;">
                          <option value="office" selected>Văn phòng</option>
                          <option value="production">Sản xuất</option>
                    </select>
                </div>
            </div>


        </div>
        <div class="modal-footer">
            <div class="col-md-6">
                <div class="form-group">
                    <?php echo form_submit('add_department', 'Thêm phòng ban', 'class="btn btn-primary pull-left"'); ?>
                </div>
            </div>

        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript">
    $(document).ready(function (e) {
        $('.type').select2();
    });
</script>
