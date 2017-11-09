<style type="text/css">
   .admin #side-menu, .admin #setup-menu {
      background: #e9ebef;
   }
   body.hide-sidebar #wrapper #side-menu li:hover {
      margin-left: 0px;
   }
   #side-menu li > a {
      border: 2px dashed #000;
      color: #000;
      text-transform: uppercase;
      padding: 12px 17px;
      font-size: 13px;
   }
   #side-menu.nav>li>a:focus, #side-menu.nav>li>a:hover {
      border-bottom: 2px dashed #000 !important;
   }
   #side-menu li .nav-second-level li a:hover{
      text-decoration: none;
      background-color: #e7eaec;
   }

   #side-menu li .nav-second-level li a {
      display: block;
      color: #000;
      margin-left: 16px;
      border: 2px dashed #449445;
   }
   #side-menu li .nav-second-level{
      list-style: none;
   }

   #side-menu li{
      margin: 15px 0px;
   }
   .drop-title{
      padding: 0px;
      font-size: 21px;
      border-radius: 50%;
      width: 200px;
      background: red;
      height: 200px;
      margin: auto;
      position: relative;
   }
   .drop-title a{
      text-decoration: none;
      color: #fff;
      top: 69px;
      left: 10px;
   }

</style>
<div class="content" style="position: relative;">
   <div style="display: inline-block;
      position: absolute;
      top: :0px;margin-right: -35px;
      margin-top: -48px;
      right: 117px;
      top: 27px;">
      <li class="quick-links" style="list-style: none;">
         <div class="dropdown dropdown-quick-links">
            <a href="#" class="dropdown-toggle btn btn-primary" id="dropdownQuickLinks" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            <i class="fa fa-table" aria-hidden="true"></i><span style="margin-left: 10px;">CÀI ĐẶT</span>
            </a>
            <ul class="dropdown-menu" aria-labelledby="dropdownQuickLinks">
               <li>
                  <a href="<?=base_url()?>system_settings"><i class="fa fa-cog"></i>Cài đặt hệ thống</a>
               </li>
               <li>
                  <a href="<?=base_url()?>system_settings/change_logo" data-toggle="modal" data-target="#myModal"><i class="fa fa-upload"></i><span class="text">Đổi Logo</span></a>
               </li>
               <li>
                  <a href="<?=base_url()?>system_settings/currencies"><i class="fa fa-money"></i>Tiền tệ</a>
               </li>
               <li>
                  <a href="<?=base_url()?>system_settings/email_templates"><i class="fa fa-envelope"></i>Mẫu mail</a>
               </li>
            </ul>
         </div>
      </li>
   </div>
   <h1 class="text-center">QUẢN LÝ SẢN XUẤT</h1>
   <hr>

   <div class="row">
      <div class="col-md-3">
         <div class="drop-title text-center" style=" background: #d83c3c;">
            <a>
               <div style="height: 100%">
                  <span style="position: relative; top: 35%;">QUẢN LÝ<br> DANH MỤC</span>
               </div>
            </a>
         </div>
         <aside class="sidebar">
            <ul class="nav metis-menu" id="side-menu">
               <li class="menu-item-customers">
                  <a href="<?=base_url()?>categories" aria-expanded="false"><i class="fa fa-cog menu-icon"></i>
                  Loại máy móc</a>
               </li>
               <li class="menu-item-tasks">
                  <a href="<?=base_url()?>machine" aria-expanded="false"><i class="fa fa-cogs menu-icon"></i>
                  Danh sách máy móc</a>
               </li>
               <li class="menu-item-quote_items">
                  <a href="<?=base_url()?>units" aria-expanded="false"><i class="fa fa-calculator menu-icon"></i>
                  Đơn vị tính</a>
               </li>
               <li class="menu-item-contracts">
                  <a href="<?=base_url()?>working_places" aria-expanded="false"><i class="fa fa-cubes menu-icon"></i>
                  Xưởng</a>
               </li>
               <li><a href="<?=base_url()?>warehouses"><i class="fa fa-calendar menu-icon"></i> Kho hàng</a></li>
            </ul>
         </aside>
      </div>
      <div class="col-md-3">
         <div class="drop-title text-center" style=" background: #566a75;">
            <a>
               <div style="height: 100%">
                  <span style="position: relative; top: 26%;">QUẢN LÝ<br> NGUYÊN VẬT LIỆU - THÀNH PHẨM</span>
               </div>
            </a>
         </div>
         <aside class="sidebar">
            <ul class="nav metis-menu" id="side-menu">
               <li class="menu-item-staff">
                  <a href="#" class="drop" aria-expanded="false"><i class="fa fa-chevron-down menu-icon"></i> Nguyên vật liệu</a>
                  <ul class="nav-second-level collapse" >
                     <li class="menu-item-products">
                        <a href="<?=base_url()?>items/add" aria-expanded="false"><i class="fa fa-plus-square menu-icon"></i> Thêm nguyên vật liệu</a>
                     </li>
                     <li class="menu-item-products">
                        <a href="<?=base_url()?>items/import_xls" aria-expanded="false"><i class="fa fa-upload menu-icon"></i> Import vật liệu</a>
                     </li>
                  </ul>
               </li>
               <li class="menu-item-products">
                  <a href="#" class="drop" aria-expanded="false"><i class="fa fa-chevron-down menu-icon"></i> Thành phẩm</a>
                  <ul class="nav-second-level collapse" >
                     <li class="menu-item-products">
                        <a href="<?=base_url()?>system_settings/categories" aria-expanded="false"><i class="fa fa-list-alt menu-icon"></i> Danh mục thành phẩm</a>
                     </li>
                     <li class="menu-item-products">
                        <a href="<?=base_url()?>items/products" aria-expanded="false"><i class="fa fa-list-alt menu-icon"></i> Danh sách bán thành phẩm</a>
                     </li>
                     <li class="menu-item-products">
                        <a href="<?=base_url()?>items/products/add" aria-expanded="false"><i class="fa fa-plus-square menu-icon"></i> Thêm bán thành phẩm</a>
                     </li>
                     <li class="menu-item-products">
                        <a href="<?=base_url()?>items/products/import_csv" aria-expanded="false"><i class="fa fa-upload menu-icon"></i> Import bán thành phẩm</a>
                     </li>
                  </ul>
               </li>

            </ul>
         </aside>
      </div>
      <div class="col-md-3">
         <div class="drop-title text-center" style=" background:#eaa133;">
            <a>
               <div style="height: 100%">
                  <span style="position: relative; top: 24%;">QUẢN LÝ<br>SẢN XUẤT -<br>NHẬP HÀNG</span>
               </div>
            </a>
         </div>
         <aside class="sidebar">
            <ul class="nav metis-menu" id="side-menu">

               <li class="menu-item-products">
                  <a href="#" class="drop" aria-expanded="false"><i class="fa fa-chevron-down menu-icon"></i> Lệnh sản xuất</a>
                  <ul class="nav-second-level collapse" >
                     <li>
                        <a href="<?=base_url()?>productions"><i class="fa fa-list-alt menu-icon"></i> Danh sách lệnh sản xuất</a>
                     </li>
                     <li>
                        <a href="<?=base_url()?>productions/add"><i class="fa fa-plus-square menu-icon"></i> Thêm lệnh sản xuất</a>
                     </li>

                  </ul>
               </li>

               <li class="menu-item-products">
                  <a href="#" class="drop" aria-expanded="false"><i class="fa fa-chevron-down menu-icon "></i> Yêu cầu mua hàng</a>
                  <ul class="nav-second-level collapse" >
                     <li>
                        <a href="<?=base_url()?>enquiry"><i class="fa fa-list-alt menu-icon"></i> Danh sách yêu cầu mua hàng</a>
                     </li>
                     <li>
                        <a href="<?=base_url()?>enquiry/add"><i class="fa fa-plus-square menu-icon"></i> Thêm yêu cầu mua hàng</a>
                     </li>

                  </ul>
               </li>

               <li class="menu-item-products ">
                  <a href="#" class="drop" aria-expanded="false"><i class="fa fa-chevron-down menu-icon"></i> Nhập hàng</a>
                  <ul class="nav-second-level collapse" >
                     <li>
                        <a href="<?=base_url()?>purchases"><i class="fa fa-list-alt menu-icon"></i> Danh sách nhập hàng</a>
                     </li>
                     <li>
                        <a href="<?=base_url()?>purchases/add"><i class="fa fa-plus-square menu-icon"></i> Thêm nhập hàng</a>
                     </li>
                  </ul>
               </li>


            </ul>
         </aside>
      </div>
      <div class="col-md-3">
         <div class="drop-title text-center" style=" background:#54a565;">
            <a>
               <div style="height: 100%">
                  <span style="position: relative; top: 26%;">QUẢN LÝ<br>CHẤM CÔNG -<br>LƯƠNG</span>
               </div>
            </a>
         </div>
         <aside class="sidebar">
            <ul class="nav metis-menu" id="side-menu">
               <li>
                  <a href="<?=base_url()?>timekeepers/view"><i class="fa fa-list-alt menu-icon"></i> Danh sách chấm công</a>
               </li>
               <li>
                  <a href="<?=base_url()?>timekeepers/import_xls"><i class="fa fa-upload menu-icon"></i> Import chấm công</a>
               </li>
               <li>
                  <a href="<?=base_url()?>salaries/view"><i class="fa fa-list-alt menu-icon"></i> Danh sách lương</a>
               </li>
            </ul>
         </aside>
      </div>
   </div>
</div>
<script type="text/javascript">
   var hiddenDashBoard = true;

   $('.drop').click(function() {
       $(this).parent().find('.nav-second-level').slideToggle(500);
       classList = $(this).parent().children('a').find('i')[0].classList;
       for (valClass in classList) {
         if (classList[valClass] == 'fa-chevron-down') {
            $(this).parent().children('a').find('i').removeClass('fa-chevron-down').addClass('fa-chevron-up');
            break;
         }
         if(classList[valClass] == 'fa-chevron-up'){
            $(this).parent().children('a').find('i').removeClass('fa-chevron-up').addClass('fa-chevron-down');
            break;
         }
       }
       return false;
   })

   $(document).ready(function() {
      $('#sidebar-left').remove();
      // $('#content').removeClass('sidebar-minified');
      $('#content')[0].style.setProperty( 'border-left', '0px', 'important' );
   });
</script>
