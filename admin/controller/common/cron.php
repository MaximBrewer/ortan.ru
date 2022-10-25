<?php
class ControllerCommonCron extends Controller
{
    public function index()
    {
        $this->load->model('catalog/ocfilter');
        $this->model_catalog_ocfilter->copyFilters([
            "copy_type" => "checkbox",
            "copy_status" => 1,
            "copy_attribute" => 0,
            "copy_filter" => 0,
            "copy_option" => 1,
            "copy_truncate" => 1,
            "copy_category" => 1,
        ]);
    }
}
