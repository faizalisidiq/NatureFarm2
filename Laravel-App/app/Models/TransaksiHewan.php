<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TransaksiHewan extends Model
{
    protected $table = 'transaksi_hewans';
    protected $fillable = [
        'id_customer',
        'id_hewan',
        'harga',
        'status',
    ];
    public function customer()
    {
        return $this->belongsTo(Customer::class, 'id_customer');
    }
    public function hewan()
    {
        return $this->belongsTo(Hewan::class, 'id_hewan');
    }
}
