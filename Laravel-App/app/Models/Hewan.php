<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Hewan extends Model
{
    protected $fillable = [
        'nama_hewan',
        'jenis_kelamin',
        'deskripsi',
        'stok',
        'status',
        'gambar',
    ];
}
