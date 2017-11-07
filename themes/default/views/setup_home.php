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
   padding: 12px 20px 12px 16px;
   font-size: 13px;
   }
   #side-menu.nav>li>a:focus, #side-menu.nav>li>a:hover {
   border-bottom: 2px dashed #000 !important;
   }
   #side-menu li .nav-second-level li a:hover{
   padding: 8px 10px 8px 45px;
   }
   #side-menu li .nav-second-level li a {
   padding: 7px 10px 7px 45px;
   color: #0181BB;
   text-transform: none;
   font-size: 14px;
   border: 0px;
   }
   #side-menu li{
   margin: 15px 0px;
   }
   .drop-title{
   padding: 0px;
   font-size: 25px;
   /* padding: 60px 0px 70px 0px; */
   /* margin-bottom: 25px; */
   border-radius: 50%;
   width: 200px;
   background: red;
   height: 200px;
   margin: auto;
   position: relative;
   }
   .drop-title a{
   /* background: red; */
   /* border-radius: 50%; */
   /* height: 50px; */
   color: #fff;
   /* width: 50px; */
   /* padding-top: 53px; */
   top: 69px;
   left: 10px;
   }
</style>
<div class="content" style="position: relative;">

   <h1 class="text-center tc padding">QUẢN LÝ DOANH NGHIỆP</h1>
   <hr>
   <div style="display: inline-block;
      position: absolute;
      top: :0px;margin-right: -35px;
      margin-top: -48px;
      right: 58px;
      top: 27px;">
      <li class="quick-links" style="list-style: none;">
         <div class="dropdown dropdown-quick-links">
            <a href="#" class="dropdown-toggle btn btn-primary" id="dropdownQuickLinks" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            <i class="fa fa-table" aria-hidden="true"></i><span style="margin-left: 10px;">DANH MỤC</span>
            </a>
            <ul class="dropdown-menu" aria-labelledby="dropdownQuickLinks">
               <li>
                  <a href="http://192.168.50.19/02617F/admin/positions">Chức vụ</a>
               </li>
               <li>
                  <a href="http://192.168.50.19/02617F/admin/workplaces">Nơi làm việc</a>
               </li>
               <li>
                  <a href="http://192.168.50.19/02617F/admin/workforms">Hình thức làm việc</a>
               </li>
               <li>
                  <a href="http://192.168.50.19/02617F/admin/units">Đơn vị tính</a>
               </li>
               <li>
                  <a href="http://192.168.50.19/02617F/admin/racks">Kệ hàng</a>
               </li>
               <li>
                  <a href="http://192.168.50.19/02617F/admin/warehouses">Kho</a>
               </li>
               <li>
                  <a href="http://192.168.50.19/02617F/admin/#">Công trình</a>
               </li>
            </ul>
         </div>
      </li>
   </div>
   <div class="row">
      <div class="col-md-3">
         <div class="drop-title text-center" style=" background: #f43737;">
            <a href="http://192.168.50.19/02617F/admin/clients">
               <div style="height: 100%">
                  <span style="position: relative; top: 29%;">QUẢN LÝ<br> KINH DOANH</span>
               </div>
            </a>
         </div>
         <aside class="sidebar">
            <ul class="nav metis-menu" id="side-menu">
               <li class="menu-item-customers">
                  <a href="http://192.168.50.19/02617F/admin/clients" aria-expanded="false"><i class="fa fa-users menu-icon"></i>
                  Khách Hàng                                          </a>
               </li>
               <li class="menu-item-tasks">
                  <a href="http://192.168.50.19/02617F/admin/tasks/list_tasks" aria-expanded="false"><i class="fa fa-tasks menu-icon"></i>
                  Giao dịch                                          </a>
               </li>
               <li class="menu-item-quote_items">
                  <a href="http://192.168.50.19/02617F/admin/quotes" aria-expanded="false"><i class="fa fa-clone menu-icon"></i>
                  Báo giá                                          </a>
               </li>
               <li class="menu-item-contracts">
                  <a href="http://192.168.50.19/02617F/admin/contracts" aria-expanded="false"><i class="fa fa-clone menu-icon"></i>
                  Hợp đồng bán                                          </a>
               </li>
               <li class="menu-item-_email_marketing drop">
                  <a href="javascript:void(0)" aria-expanded="false"><i class="glyphicon glyphicon-envelope menu-icon"></i>
                  Email marketing<span class="fa arrow"></span></a>
                  <ul class="nav nav-second-level collapse" aria-expanded="false">
                     <li class="sub-menu-item-email_marketing"><a href="http://192.168.50.19/02617F/admin/email_marketing">
                        Gửi email</a>
                     </li>
                     <li class="sub-menu-item-been_send_email"><a href="http://192.168.50.19/02617F/admin/email_marketing/been_send_email">Email đã gửi</a></li>
                     <li class="sub-menu-item-template_mail">
                        <a href="http://192.168.50.19/02617F/admin/email_marketing/template_emails">Mẩu email</a>
                     </li>
                  </ul>
               </li>
               <li><a href="#"><i class="fa fa-calendar menu-icon"></i>QUẢN LÝ SMS</a></li>
            </ul>
         </aside>
      </div>
      <div class="col-md-3">
         <div class="drop-title text-center" style=" background: #f43737;">
            <a href="http://192.168.50.19/02617F/admin/staff">
               <div style="height: 100%">
                  <span style="position: relative; top: 29%;">QUẢN LÝ<br> KẾ TOÁN</span>
               </div>
            </a>
         </div>
         <aside class="sidebar">
            <ul class="nav metis-menu" id="side-menu">
               <li class="menu-item-staff">
                  <a href="http://192.168.50.19/02617F/admin/staff" aria-expanded="false"><i class="fa fa-user-circle-o menu-icon"></i>Nhân Viên</a>
               </li>
               <li class="menu-item-products">
                  <a href="http://192.168.50.19/02617F/admin/invoice_items" aria-expanded="false"><i class="fa fa-product-hunt menu-icon"></i>Sản Phẩm</a>
               </li>
               <li class="menu-item-import_goods drop">
                  <a href="javascript:void(0)" aria-expanded="false"><i class="fa fa-building-o menu-icon"></i>Nhập hàng<span class="fa arrow"></span></a><
                  <ul class="nav nav-second-level collapse" aria-expanded="false">
                     <li class="sub-menu-item-imp_adjustments"><a href="http://192.168.50.19/02617F/admin/imports/imp_adjustment">Nhập kho</a>
                     </li>
                  </ul>
               </li>
               <li class="menu-item-export_warehouses drop">
                  <a href="javascript:void(0)" aria-expanded="false"><i class="fa fa-building-o menu-icon"></i>
                  Xuất Hàng                                          <span class="fa arrow"></span>
                  </a>
                  <ul class="nav nav-second-level collapse" aria-expanded="false">
                     <li class="sub-menu-item-sale_export_warehouses"><a href="http://192.168.50.19/02617F/admin/exports">
                        Xuất kho bán hàng</a>
                     </li>
                  </ul>
               </li>
               <li class="menu-item-reports drop">
                  <a href="javascript:void(0)" aria-expanded="false"><i class="fa fa-area-chart menu-icon"></i>
                  Báo Cáo<span class="fa arrow"></span></a>
                  <ul class="nav nav-second-level collapse" aria-expanded="false">
                     <li class="sub-menu-item-child-sales"><a href="http://192.168.50.19/02617F/admin/reports/sales">Bán Hàng</a>
                     </li>
                     <li class="sub-menu-item-child-expenses"><a href="http://192.168.50.19/02617F/admin/reports/expenses">Chi phí</a>
                     </li>
                     <li class="sub-menu-item-child-expenses-vs-income"><a href="http://192.168.50.19/02617F/admin/reports/expenses_vs_income">Chi phí vs Thu nhập</a>
                     </li>
                  </ul>
               </li>
            </ul>
         </aside>
      </div>
      <div class="col-md-3">
         <div class="drop-title text-center" style=" background:#f58632;">
            <a href="http://192.168.50.19/02617F/admin/clients">
               <div style="height: 100%">
                  <span style="position: relative; top: 24%;">QUẢN LÝ<br>KỸ THUẬT<br>VÀ LẮP ĐẶT</span>
               </div>
            </a>
         </div>
         <aside class="sidebar">
            <ul class="nav metis-menu" id="side-menu">
               <li>
                  <a href="#"><i class="fa fa-plus-square menu-icon"></i>THÊM YÊU CẦU LẮP ĐẶT</a>
               </li>
               <li>
                  <a href="#"><i class="fa fa-list-alt menu-icon"></i>DANH SÁCH LẮP ĐẶT</a>
               </li>
            </ul>
         </aside>
      </div>
      <div class="col-md-3">
         <div class="drop-title text-center" style=" background:#175f96;">
            <a href="http://192.168.50.19/02617F/admin/clients">
               <div style="height: 100%">
                  <span style="position: relative; top: 29%;">QUẢN LÝ<br>BẢO HÀNH</span>
               </div>
            </a>
         </div>
         <aside class="sidebar">
            <ul class="nav metis-menu" id="side-menu">
               <li>
                  <a href="#"><i class="fa fa-plus-square menu-icon"></i>THÊM YÊU CẦU BẢO HÀNH</a>
               </li>
               <li>
                  <a href="#"><i class="fa fa-list-alt menu-icon"></i>DANH SÁCH BẢO HÀNH</a>
               </li>
            </ul>
         </aside>
      </div>
   </div>
</div>
