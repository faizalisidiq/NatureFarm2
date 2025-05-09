<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    protected $table = 'customers';
    protected $fillable = [
        'nama',
        'email',
        'password',
        'no_hp',
    ];

    public function transaksiHewan()
    {
        return $this->hasMany(TransaksiHewan::class);
    }
}
