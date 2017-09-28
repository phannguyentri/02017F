<?php  {
    foreach ($monthly_sales as $month_sale) {
        $months = date('Y-m-d', strtotime($month_sale->month));
        
            $trangthai = $month_sale->sale_status;
      
            
            $tongtien = $month_sale->total;

        // $loinhuangop = $monthly_sales[0]->loinhuan;

        // $loinhuangop = $monthly_sales['loinhuangop'];

        // $phieuthukhac = $monthly_sales['t']->price_t;
        // $phieuchikhac = $monthly_sales['c']->price_c;

        // $tongloinhuan = $monthly_sales['tongloinhuan'];

    }
    ?>
    <style type="text/css" media="screen">
        .tooltip-inner {
            max-width: 500px;
        }
    </style>
    <script src="<?= $assets; ?>js/hc/highcharts.js"></script>
    <script type="text/javascript">
        $(function () {
            Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
                return {
                    radialGradient: {cx: 0.5, cy: 0.3, r: 0.7},
                    stops: [[0, color], [1, Highcharts.Color(color).brighten(-0.3).get('rgb')]]
                };
            });
            $('#chart').highcharts({
                chart: {},
                credits: {enabled: false},
                title: {text: ''},
                xAxis: {categories: ['<?=$months;?>']},
                yAxis: {min: 0, title: ""},
                tooltip: {
                    shared: true,
                    followPointer: true,
                    formatter: function () {
                        if (this.key) {

                            return '<div class="tooltip-inner hc-tip" style="margin-bottom:0;">' + this.key + '<br><strong>' + currencyFormat(this.y) + '</strong> (' + formatNumber(this.percentage) + '%)';
                        } else {
                            var s = '<div class="well well-sm hc-tip" style="margin-bottom:0;"><h2 style="margin-top:0;">' + this.x + '</h2><table class="table table-striped"  style="margin-bottom:0;">';
                            $.each(this.points, function () {
                                s += '<tr><td style="color:{series.color};padding:0">' + this.series.name + ': </td><td style="color:{series.color};padding:0;text-align:right;"> <b>' +
                                currencyFormat(this.y) + '</b></td></tr>';
                            });
                            s += '</table></div>';
                            return s;
                        }
                    },
                    useHTML: true,
                    borderWidth: 0,
                    shadow: false,
                    valueDecimals: site.settings.decimals,
                    style: {
                        fontSize: '14px',
                        padding: '0',
                        color: '#000000'
                    }
                },
                series: [{
                    type: 'column',
                    name: 'Trạng thái',
                    data: [<?php
                            echo '';
                        ?>]
                },
                    {
                        type: 'column',
                        name: 'Tổng tiền',
                        data: [<?php
                        echo $tongtien;
                        ?>]
                    },
                    {
                        type: 'column',
                        name: 'Lợi nhuận gộp',
                        data: [<?php
                    echo $loinhuangop;
                    ?>]
                    }
                    , 
                    {
                    type: 'column',
                    name: 'Phiếu thu khác',
                    data: [<?php
                        echo $phieuthukhac;
                        ?>]
                },
                    {
                        type: 'spline',
                        name: 'Phiếu chi khác',
                        data: [<?php
                    echo  $phieuchikhac;
                    ?>],
                        marker: {
                            lineWidth: 2,
                            states: {
                                hover: {
                                    lineWidth: 4
                                }
                            },
                            lineColor: Highcharts.getOptions().colors[3],
                            fillColor: 'white'
                        }
                    }, 
                    {
                        type: 'spline',
                        name: 'Tổng lợi nhuận',
                        data: [<?php
                    echo  $tongloinhuan;
                    ?>],
                        marker: {
                            lineWidth: 2,
                            states: {
                                hover: {
                                    lineWidth: 4
                                }
                            },
                            lineColor: Highcharts.getOptions().colors[3],
                            fillColor: 'white'
                        }
                    }, 
                    {
                        type: 'pie',
                        name: '<?= lang("stock_value"); ?>',
                        data: [
                            ['', 0],
                            ['', 0],
                            ['<?= lang("stock_value_by_price"); ?>', <?php echo $stock->stock_by_price; ?>],
                            ['<?= lang("stock_value_by_cost"); ?>', <?php echo $stock->stock_by_cost; ?>],
                        ],
                        center: [80, 42],
                        size: 80,
                        showInLegend: false,
                        dataLabels: {
                            enabled: false
                        }
                    }]
            });
        });
    </script>
<?php } ?>
    

<?php  { ?>
    <div class="box" style="margin-top: 15px;">
        <div class="box-header">
            <h2 class="blue"><i class="fa-fw fa fa-bar-chart-o"></i><?= lang('overview_chart'); ?></h2>
        </div>
        <div class="box-content">
            <div class="row">
                <div class="col-lg-12">
                    <p class="introtext"><?php echo lang('overview_chart_heading'); ?></p>

                    <div id="chart" style="width:100%; height:450px;"></div>
                    <p class="text-center"><?= lang("chart_lable_toggle"); ?></p>
                </div>
            </div>
        </div>
    </div>
<?php } ?>