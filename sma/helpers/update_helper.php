<?php defined('BASEPATH') OR exit('No direct script access allowed');

if(! function_exists('get_remote_contents')) {
    function get_remote_contents($url, $post_fields = NULL) {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        if($post_fields) {
            curl_setopt($curl, CURLOPT_POST, 1);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $post_fields);
        }
        $resp = curl_exec($curl);
        if($resp) { $result = $resp; }
        else { $result = json_encode(array('status' => 'Failed', 'message' => 'Curl Error: "' .curl_error($curl).'"')); }
        curl_close($curl);
        return $result;
    }
}

if(! function_exists('save_remote_file')) {
    function save_remote_file($file) {
        $protocol = is_https() ? 'https://' : 'http://';
        file_put_contents('./files/updates/'.$file, fopen($protocol.'tecdiary.com/api/v1/download/file/'.$file, 'r'));
        return true;
    }
}
if(! function_exists('time_ago')) {
function time_ago($time_ago)
{
    $time_ago     = strtotime($time_ago);
    $cur_time     = time();
    $time_elapsed = $cur_time - $time_ago;
    $seconds      = $time_elapsed;
    $minutes      = round($time_elapsed / 60);
    $hours        = round($time_elapsed / 3600);
    $days         = round($time_elapsed / 86400);
    $weeks        = round($time_elapsed / 604800);
    $months       = round($time_elapsed / 2600640);
    $years        = round($time_elapsed / 31207680);
    // Seconds
    if ($seconds <= 60) {
        return lang('time_ago_just_now');
    }
    //Minutes
    else if ($minutes <= 60) {
        if ($minutes == 1) {
            return lang('time_ago_minute');
        } else {
            return lang('time_ago_minutes', $minutes);
        }
    }
    //Hours
    else if ($hours <= 24) {
        if ($hours == 1) {
            return lang('time_ago_hour');
        } else {
            return lang('time_ago_hours', $hours);
        }
    }
    //Days
    else if ($days <= 7) {
        if ($days == 1) {
            return lang('time_ago_yesterday');
        } else {
            return lang('time_ago_days', $days);
        }
    }
    //Weeks
    else if ($weeks <= 4.3) {
        if ($weeks == 1) {
            return lang('time_ago_week');
        } else {
            return lang('time_ago_weeks', $weeks);
        }
    }
    //Months
    else if ($months <= 12) {
        if ($months == 1) {
            return lang('time_ago_month');
        } else {
            return lang('time_ago_months', $months);
        }
    }
    //Years
    else {
        if ($years == 1) {
            return lang('time_ago_year');
        } else {
            return lang('time_ago_years', $years);
        }
    }
}
}