<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Thêm loại máy móc</h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("categories/add", $attrib); ?>
        <div class="modal-body">
        <!-- <div class="col-md-12"> -->
            <p><?= lang('enter_info'); ?></p>

            <div class="form-group">
                <?php echo lang('Tên loại máy móc', 'categories_name'); ?>
                <div class="controls">
                <?= form_input('categories_name', (isset($_POST['categories_name']) ? $_POST['categories_name'] : ''), 'class="form-control" id="categories_name" required="required"'); ?>
                </div>
            </div>

            <div class="form-group">
                <?php echo lang('Thông số chi tiết', 'categories_details'); ?>
                <div class="controls">
                <?= form_input('categories_details', (isset($_POST['categories_details']) ? $_POST['categories_details'] : ''), 'class="form-control" id="categories_details"'); ?>
                </div>
            </div>
            
            <div class="form-group">
                <?= lang("Ghi chú", "categories_note") ?>
                <?= form_textarea('categories_note', (isset($_POST['categories_note']) ? $_POST['categories_note'] : ''), 'class="form-control" id="categories_note"'); ?>
            </div>
            
        </div>

        <div class="modal-footer">
            <?php echo form_submit('add', 'Thêm loại máy móc', 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" src="<?= $assets ?>js/custom.js"></script>
<?= $modal_js ?>