<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Artikel extends Model
{
    protected $fillable = [
        'judul_artikel',
        'isi_artikel',
        'gambar',
    ];
}