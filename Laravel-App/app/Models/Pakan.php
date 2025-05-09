<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pakan extends Model
{
    protected $fillable = [
        'nama_pakan',
        'deskripsi',
        'stok',
        'status',
        'gambar',
    ];
}