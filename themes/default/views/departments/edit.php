<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Sửa phòng ban</h4>
        </div>
        <?php echo form_open("departments/edit/" . $department->id); ?>
        <div class="modal-body">
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <label for="percent">Tên phòng ban</label>
                <div class="controls"> <?php echo form_input('name', $department->name, 'class="form-control" id="percent" required="required"'); ?>
            </div>

        </div>
        <div class="modal-footer">
            <?php echo form_submit('edit_department', 'Sửa phòng ban', 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<?= $modal_js ?>
