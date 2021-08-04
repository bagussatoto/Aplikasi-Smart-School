<?php
include_once APPPATH . '/third_party/tcpdf/tcpdf.php';

class Tcpdf_gen extends TCPDF
{
    function __construct()
    {
        parent::__construct();
    }
}