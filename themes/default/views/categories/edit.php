<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-2x">&times;</i>
            </button>
            <h4 class="modal-title" id="myModalLabel">Sửa loại máy móc <?php echo $categories->categories_name ?></h4>
        </div>
        <?php $attrib = array('data-toggle' => 'validator', 'role' => 'form');
        echo form_open("categories/edit/" . $id, $attrib); ?>
        <div class="modal-body">
            <p><?= lang('update_info'); ?></p>

            <div class="form-group">
                <?php echo lang('Tên loại máy móc', 'categories_name'); ?>
                <div class="controls">
                <?= form_input('categories_name', (isset($_POST['categories_name']) ? $_POST['categories_name'] : (isset($categories) ? $categories->categories_name : '')), 'class="form-control" id="categories_name" required="required"'); ?>
                </div>
            </div>

            
            <div class="form-group">
                <?php echo lang('Thông số chi tiết', 'categories_details'); ?>
                <div class="controls">
                <?= form_input('categories_details', (isset($_POST['categories_details']) ? $_POST['categories_details'] : (isset($categories
                ) ? $categories->categories_details : '')), 'class="form-control" id="categories_details"'); ?>
                </div>
            </div>

            <div class="form-group">
                <?php echo lang('Ghi chú', 'categories_note'); ?>
                <div class="controls">
                <?= form_textarea('categories_note', (isset($_POST['categories_note']) ? $_POST['categories_note'] : (isset($categories
                ) ? $categories->categories_note : '')), 'class="form-control" id="categories_note"'); ?>
                </div>
            </div>
            <?php echo form_hidden('id', $id); ?>
        </div>
        <div class="modal-footer">
            <?php echo form_submit('edit', lang('Sửa loại máy móc'), 'class="btn btn-primary"'); ?>
        </div>
    </div>
    <?php echo form_close(); ?>
</div>
<script type="text/javascript" src="<?= $assets ?>js/custom.js"></script>
<?= $modal_js ?>